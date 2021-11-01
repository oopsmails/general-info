
# Knowledges: Testing Jmeter

- Ref:

https://www.youtube.com/watch?v=mXGcBvWYl-U  

https://dzone.com/articles/how-to-run-jmeter-test-plan-via-docker

https://loadfocus.com/blog/tech/2016/05/how-to-use-user-defined-variables-in-apache-jmeter/




## Concepts

### Performance Testing

Load Testing
Stress Testing
- 



$jmeter -n -t testPlan.jmx - l log.jtl -H 127.0.0.1 -P 8000


## Jmeter



Chrome, Record a test plan using Blazemete extension

Make sure you are logged in (through SSO or any other account) else you won’t be able to download the ‘.jmx’ file.

add "Listener", "View Result Tree"

Myfirst-01-workingon.jmx

if error

- try the line direccly


View Result Tree
select one sample ... url, for example, login, 
in "Parameters"

passowrd, right click, "Replace values with variables"

password	${password}	true	text/plain	true
email	${email}	true	text/plain	true


Test Plan, Add, Config Element, User Defined Variables








