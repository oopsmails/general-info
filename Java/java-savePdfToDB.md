# Java: Save PDF File into DB

## Java

```
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

public class ConvertToHexStringExample {

    public static void main(String[] args) {
        String filePath = "path/to/your/file.pdf"; // Replace with the actual path to your PDF file

        try (InputStream inputStream = new FileInputStream(filePath)) {
            String hexString = convertToHexString(inputStream);
            System.out.println(hexString); // Print or use the hexString in your SQL script
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String convertToHexString(InputStream inputStream) throws IOException {
        StringBuilder hexString = new StringBuilder();
        int value;

        while ((value = inputStream.read()) != -1) {
            String hex = Integer.toHexString(value);
            if (hex.length() < 2) {
                hexString.append('0');
            }
            hexString.append(hex);
        }

        return hexString.toString();
    }
}


INSERT INTO PdfFiles (id, pdfData)
VALUES (1, 0x...); -- Replace ... with the hexadecimal string

```
