import java.awt.AWTException;
import java.awt.Dimension;
import java.awt.Robot;
import java.awt.Toolkit;
import java.util.Random;

public class MainMouseEvents {
    public static void main(String[] args) {
        try {
            // Get mode from user input
            int mode = getModeFromInput(args);
            long millis = getMillisForMode(mode);
            int pixel = getPixelForMode(mode);

            // System.out.println("Running in mode " + mode + " with " + millis + " millis and " + pixel + " pixels");

            while (true) {
                slightlyMouseMove(millis, pixel);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static int getModeFromInput(String[] args) {
        if (args == null || args.length == 0) {
            System.out.println("No mode provided. Using default mode 1.");
            return 1;
        }

        try {
            int mode = Integer.parseInt(args[0]);
            if (mode >= 1 && mode <= 3) {
                return mode;
            } else {
                System.out.println("Invalid mode: " + mode + ". Using default mode 1.");
                return 1;
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid input: '" + args[0] + "' is not a valid mode. Using default mode 1.");
            return 1;
        }
    }

    private static long getMillisForMode(int mode) {
        if (mode == 3) {
            Random random = new Random();
            // Random between 5000 (5 seconds) and 120000 (2 minutes)
            return random.nextInt(115001) + 5000; // 120000 - 5000 + 1 = 115001
            //return random.nextInt(1000) + 5000; // 120000 - 5000 + 1 = 115001
        }
        return mode == 2 ? 60000 : 30000;
    }

    private static int getPixelForMode(int mode) {
        if (mode == 3) {
            Random random = new Random();
            // Random between 50 and 180 inclusive
            return random.nextInt(131) + 50; // 180 - 50 + 1 = 131
        }
        return mode == 2 ? 50 : 1;
    }

    public static void slightlyMouseMove(long millis, int pixel) throws AWTException, InterruptedException {
        Robot robot = new Robot();
        Random random = new Random();

        // Get screen dimensions
        Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
        int centerX = screenSize.width / 2;
        int centerY = screenSize.height / 2;

        // Move to random position from center
        int randomX1 = random.nextInt(pixel * 2 + 1) - pixel; // -pixel to +pixel
        int randomY1 = random.nextInt(pixel * 2 + 1) - pixel; // -pixel to +pixel
        int targetX1 = Math.max(0, Math.min(screenSize.width - 1, centerX + randomX1));
        int targetY1 = Math.max(0, Math.min(screenSize.height - 1, centerY + randomY1));
        robot.mouseMove(targetX1, targetY1);

        // Delay
        if (millis > 60000) {
            Thread.sleep(millis);
        } else {
            robot.delay((int) millis);
        }

        // Move additional random pixels with random direction from current position
        int randomX2 = random.nextInt(pixel * 2 + 1) - pixel; // -pixel to +pixel
        int randomY2 = random.nextInt(pixel * 2 + 1) - pixel; // -pixel to +pixel
        int targetX2 = Math.max(0, Math.min(screenSize.width - 1, targetX1 + randomX2));
        int targetY2 = Math.max(0, Math.min(screenSize.height - 1, targetY1 + randomY2));
        robot.mouseMove(targetX2, targetY2);

        // Delay
        if (millis > 60000) {
            Thread.sleep(millis);
        } else {
            robot.delay((int) millis);
        }

        // Go back to center
        robot.mouseMove(centerX, centerY);

        // Delay before next cycle
        if (millis > 60000) {
            Thread.sleep(millis);
        } else {
            robot.delay((int) millis);
        }
    }
}
