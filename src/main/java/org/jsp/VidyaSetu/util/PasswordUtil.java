package org.jsp.VidyaSetu.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class PasswordUtil {
    
    private static final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
    
    public static String encryptPassword(String plainPassword) {
        return encoder.encode(plainPassword);
    }
    
    public static boolean checkPassword(String plainPassword, String encryptedPassword) {
        try {
            return encoder.matches(plainPassword, encryptedPassword);
        } catch (Exception e) {
            System.err.println("Password check error: " + e.getMessage());
            return false;
        }
    }
}