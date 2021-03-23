
# Two Phase Commit

## Concepts

- Supporting 2-phase commit transactions, when using Spring as transaction manager for 2PC, you would need to use **JtaTransactionManager** which would internally use the actual JTA transaction manager provided typically by JTA containers ( all EE compliant servers) or using standalone transaction managers such as **Bitrionix** or **Atomikos**. For a sample example take a look here.

- When it comes to 2PC, Spring does not have actual capability to global transactions (aka XA transactions). This capability has already been perfected by external JTA transaction manager and Spring does not intend to reinvent the wheel. If your application is not running on EE server, you would need to use external TM's




## Examples:

- https://github.com/nielspeter/atomikos-jta-jpa-jms-example

atomikos-jta-jpa-jms-example-master.zip

