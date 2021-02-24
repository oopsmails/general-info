package com.oopsmails.springboot.app.all.javageneric;

import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.MouseEvent;

public class MainMouseEvents {
    private static Robot robot = null;

    public static void main(String[] args) {
        try {
            robot = new Robot();
        } catch (AWTException e) {
            e.printStackTrace();
        }
        while (true) {
            klick(650, 550, 30000); // in ms!
        }
    }

    public static void klick(int x, int y, int delay) {
        // robot.mouseMove(x, y);
        robot.delay(delay);
        robot.mousePress(MouseEvent.BUTTON3_DOWN_MASK);
        robot.mouseRelease(MouseEvent.BUTTON3_DOWN_MASK);
    }
}
