---
trigger: always_on
---

1. Never directly change the main app ddl
2. Give separate backend sql scripts
3. Give individual page sql if edited from example f111, keep those files in the same example app f111/application/pages folder itself by replacing the same files so that its easier for all. 
4. After the task, give sqlcl command for importing the page/component/script. I am alerady logged in my main folder so example sql code would be @f111/application/user_interfaces.sql 
5. No need to give too much text to read in walkthrough or implementation file, just brief info at end of task done is fine. 
6. Dont give too much text to read in the sqlcl success message....too much to read, just give success or what oracle gives. 
7. NEVER EVER RUN Anything direcly on my oracle server or any server, you give command and i shall do those changes on the server. 
8. No need for tasks and implementation plans for me, if you need create it for yourself. 
9. Check  https://apex-docs-5ka.pages.dev/agent?v=8 for all apex related docs and striclty follow them. 
Check this Javascript api for Oracle apex 24.2 https://docs.oracle.com/en/database/oracle/apex/24.2/aexjs/index.html so that you dont hallucinate or use older ones. 
Check this complete api reference for apex 24.2 https://docs.oracle.com/en/database/oracle/apex/24.2/aeapi/oracle-apex-api-reference.pdf stick to those guidelines only and do not try older stuff. 