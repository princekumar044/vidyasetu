// File: SettingsController.java
package org.jsp.VidyaSetu.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/api/settings")
public class SettingsController {
    
    @PostMapping("/dark-mode")
    @ResponseBody
    public String saveDarkModePreference(@RequestParam boolean darkMode, HttpSession session) {
        session.setAttribute("darkMode", darkMode);
        System.out.println("Dark mode preference saved: " + darkMode);
        return "{\"success\": true}";
    }
    
    @GetMapping("/dark-mode")
    @ResponseBody
    public boolean getDarkModePreference(HttpSession session) {
        Boolean darkMode = (Boolean) session.getAttribute("darkMode");
        return darkMode != null ? darkMode : false;
    }
}