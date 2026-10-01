package com.webst5.util;

import java.util.Random;

public class OTPUtil_24110159 {
    public static String generate() {
        return String.valueOf(100000 + new Random().nextInt(900000));
    }
}
