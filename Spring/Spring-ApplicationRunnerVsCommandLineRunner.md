# Spring-ApplicationRunnerVsCommandLineRunner

- Ref:

https://stackoverflow.com/questions/59328583/when-and-why-do-we-need-applicationrunner-and-runner-interface

**These runners are used to run the logic on application startup**, for example spring boot has ApplicationRunner(Functional Interface) with run method

ApplicationRunner run() will get execute, just after applicationcontext is created and before spring boot application startup.

ApplicationRunner takes ApplicationArgument which has convenient methods like getOptionNames(), getOptionValues() and getSourceArgs().

And CommandLineRunner is also a Functional interface with run method

CommandLineRunner run() will get execute, just after applicationcontext is created and before spring boot application starts up.

It accepts the argument, which are passed at time of server startup.

Both of them provides the same functionality and the only difference between CommandLineRunner and ApplicationRunner is CommandLineRunner.run() accepts String array[] whereas ApplicationRunner.run() accepts ApplicationArguments as argument. you can find more information with example here
