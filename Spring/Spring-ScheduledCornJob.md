

## spring after application start


- Below you can find the example patterns from the spring forum:

The pattern is:

second, minute, hour, day, month, weekday
So your answer is:

"0 0 23 * * *" every day mid night
Since the hours starts from 0 to 23 for Quartz configuration

At minute 0 past every 12th hour
0 */12 * * *

0 0 */2 * * ?
(At second :00, at minute :00, every 2 hours starting at 00am, of every day)

* "0 0 * * * *" = the top of every hour of every day.
* "*/10 * * * * *" = every ten seconds.
* "0 0 8-10 * * *" = 8, 9 and 10 o'clock of every day.
* "0 0 8,10 * * *" = 8 and 10 o'clock of every day.
* "0 0/30 8-10 * * *" = 8:00, 8:30, 9:00, 9:30 and 10 o'clock every day.
* "0 0 9-17 * * MON-FRI" = on the hour nine-to-five weekdays
* "0 0 0 25 12 ?" = every Christmas Day at midnight

"* /15 * * * *" = every 15 minutes
"0 0 */2 * * *" = every 2 hours

"*/10 * * * * *" = every 10 seconds


- MainService.java, Using post contruct to trigger right after application startup

```
	@PostConstruct
    public void onAppStartupProcessGet() {
		logger.info("############################# onAppStartupProcessGetAlertProfile() calling cronJobProcessGetAlertProfile()");
		cronJobProcessGet();
    }
	
	@Scheduled(cron = "0 0/5 * * * *") <--------------- 5 mins for testing, "0 0 */2 * * *" = every 2 hours,
	public void onEverydayProcessGet() {
		logger.info("############################# onEverydayProcessGetAlertProfile() calling cronJobProcessGetAlertProfile()");
		cronJobProcessGet();
	}
	
	public void cronJobProcessGet() {
//		logger.info("############################# cronJobProcessGet()");
		
		header.setRequestId("adsfasdf");
		
//		String hierarchyName = "hierarchyName";
//		String categoryName = "categoryName";
		
		ClientInfo clientInfo = processGetClientInfo(header, true);
		logger.info("cronJobProcessGet(), profile = {}", profile == null ? "null" : profile);
	}

```

- if using SpringBoot

```
@EventListener(ApplicationReadyEvent.class)
public void doSomethingAfterStartup() {
    System.out.println("hello world, I have just started up");
}
```

