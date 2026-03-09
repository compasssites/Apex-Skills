#!/usr/bin/env python3

from __future__ import annotations

import re
import sys
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parent.parent
SKILLS_DIR = REPO_ROOT / "skills"
NAME_RE = re.compile(r"^[a-z0-9-]{1,63}$")
HEX_RE = re.compile(r"^#[0-9A-Fa-f]{6}$")


def read_lines(path: Path) -> list[str]:
    return path.read_text(encoding="utf-8").splitlines()


def parse_frontmatter(path: Path) -> dict[str, str]:
    lines = read_lines(path)
    if len(lines) < 4 or lines[0] != "---":
        raise ValueError("missing YAML frontmatter start")
    try:
        end = lines[1:].index("---") + 1
    except ValueError as exc:
        raise ValueError("missing YAML frontmatter end") from exc

    data: dict[str, str] = {}
    for line in lines[1:end]:
        if not line.strip():
            continue
        if ":" not in line:
            raise ValueError(f"invalid frontmatter line: {line}")
        key, value = line.split(":", 1)
        data[key.strip()] = value.strip()
    return data


def validate_skill(skill_dir: Path) -> list[str]:
    errors: list[str] = []
    skill_name = skill_dir.name
    if not NAME_RE.match(skill_name):
        errors.append(f"{skill_name}: invalid folder name")

    skill_md = skill_dir / "SKILL.md"
    if not skill_md.exists():
        errors.append(f"{skill_name}: missing SKILL.md")
        return errors

    try:
        frontmatter = parse_frontmatter(skill_md)
    except ValueError as exc:
        errors.append(f"{skill_name}: {exc}")
        return errors

    if set(frontmatter) != {"name", "description"}:
        errors.append(
            f"{skill_name}: frontmatter keys must be exactly name and description"
        )
    if frontmatter.get("name") != skill_name:
        errors.append(f"{skill_name}: frontmatter name does not match folder name")

    description = frontmatter.get("description", "")
    if len(description) < 40:
        errors.append(f"{skill_name}: description is too short")
    if "[TODO" in skill_md.read_text(encoding="utf-8"):
        errors.append(f"{skill_name}: unresolved TODO in SKILL.md")

    openai_yaml = skill_dir / "agents" / "openai.yaml"
    if not openai_yaml.exists():
        errors.append(f"{skill_name}: missing agents/openai.yaml")
    else:
        openai_text = openai_yaml.read_text(encoding="utf-8")
        for required in ("display_name:", "short_description:", "default_prompt:"):
            if required not in openai_text:
                errors.append(f"{skill_name}: openai.yaml missing {required}")
        if f"${skill_name}" not in openai_text:
            errors.append(f"{skill_name}: default_prompt must mention ${skill_name}")

        for key in ("icon_small", "icon_large"):
            match = re.search(rf'{key}:\s+"([^"]+)"', openai_text)
            if match:
                asset_path = skill_dir / match.group(1).removeprefix("./")
                if not asset_path.exists():
                    errors.append(f"{skill_name}: {key} path does not exist")

        color_match = re.search(r'brand_color:\s+"([^"]+)"', openai_text)
        if color_match and not HEX_RE.match(color_match.group(1)):
            errors.append(f"{skill_name}: brand_color is not a valid hex color")

    return errors


def main() -> int:
    if not SKILLS_DIR.is_dir():
        print("skills directory not found", file=sys.stderr)
        return 1

    all_errors: list[str] = []
    for skill_dir in sorted(path for path in SKILLS_DIR.iterdir() if path.is_dir()):
        all_errors.extend(validate_skill(skill_dir))

    if all_errors:
        for error in all_errors:
            print(error)
        return 1

    print("All skills passed local validation.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
