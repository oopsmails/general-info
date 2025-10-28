Skip to content
Chat history

You said:
I am developing a springboot app ... is there a quick way to do ftp function?
ChatGPT said:
Yes 👍 — there are quick and reliable ways to add FTP functionality to a Spring Boot app.
Let’s go over the simplest approaches depending on what you need (upload, download, list files, etc.).

🧩 Option 1: Use Apache Commons Net (recommended for simple FTP)
This is the fastest way to get FTP up and running.

1️⃣ Add dependency
If you use Maven, add this:

<dependency>
    <groupId>commons-net</groupId>
    <artifactId>commons-net</artifactId>
    <version>3.9.0</version>
</dependency>
Or with Gradle:

implementation 'commons-net:commons-net:3.9.0'
2️⃣ Basic FTP utility example
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import java.io.FileInputStream;
import java.io.IOException;

public class FtpService {

    public void uploadFile(String server, int port, String user, String pass,
                           String localFilePath, String remoteFilePath) throws IOException {

        FTPClient ftpClient = new FTPClient();

        try {
            ftpClient.connect(server, port);
            ftpClient.login(user, pass);
            ftpClient.enterLocalPassiveMode();
            ftpClient.setFileType(FTP.BINARY_FILE_TYPE);

            try (FileInputStream inputStream = new FileInputStream(localFilePath)) {
                boolean done = ftpClient.storeFile(remoteFilePath, inputStream);
                if (done) {
                    System.out.println("File uploaded successfully!");
                } else {
                    System.out.println("File upload failed!");
                }
            }

        } finally {
            if (ftpClient.isConnected()) {
                ftpClient.logout();
                ftpClient.disconnect();
            }
        }
    }
}
You can inject this service into your Spring Boot components as a @Service bean.

✅ Works for:
Upload (storeFile)

Download (retrieveFile)

List (listFiles)

Delete (deleteFile)

🧰 Option 2: Use Spring Integration FTP (for robust setups)
If you need scheduled transfers, polling, or auto file sync, use Spring Integration FTP.

Dependency
<dependency>
    <groupId>org.springframework.integration</groupId>
    <artifactId>spring-integration-ftp</artifactId>
</dependency>
Example configuration
@Bean
public SessionFactory<FTPFile> ftpSessionFactory() {
    DefaultFtpSessionFactory factory = new DefaultFtpSessionFactory();
    factory.setHost("ftp.example.com");
    factory.setPort(21);
    factory.setUsername("user");
    factory.setPassword("pass");
    return factory;
}

@Bean
@InboundChannelAdapter(channel = "ftpChannel",
        poller = @Poller(fixedDelay = "5000"))
public MessageSource<InputStream> ftpMessageSource(SessionFactory<FTPFile> factory) {
    FtpInboundFileSynchronizer synchronizer = new FtpInboundFileSynchronizer(factory);
    synchronizer.setRemoteDirectory("/remote/path");
    synchronizer.setDeleteRemoteFiles(false);

    FtpInboundFileSynchronizingMessageSource source =
            new FtpInboundFileSynchronizingMessageSource(synchronizer);
    source.setLocalDirectory(new File("/local/cache"));
    return source;
}
This is more verbose but enterprise-grade — handles reconnection, retries, and message-driven file handling.

🪶 Option 3: For SFTP (secure FTP)
If your server uses SFTP (over SSH) instead of plain FTP, use:

<dependency>
    <groupId>com.jcraft</groupId>
    <artifactId>jsch</artifactId>
    <version>0.1.55</version>
</dependency>
or Spring Integration’s spring-integration-sftp.

Would you like me to give you a minimal ready-to-run Spring Boot @Service class that supports upload/download/list using FTP?
I can tailor it for FTP or SFTP depending on what you need.




No file chosenNo file chosen
ChatGPT can make mistakes. Check important info. See Cookie Preferences.
