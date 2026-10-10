package org.jsp.VidyaSetu.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class BaseController {
    
    @ModelAttribute
    public void addCommonAttributes(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        
        // Set dark mode attribute
        Boolean darkMode = (Boolean) session.getAttribute("darkMode");
        if (darkMode == null) {
            darkMode = false;
            session.setAttribute("darkMode", darkMode);
        }
        model.addAttribute("darkMode", darkMode);
        
        // Set other common attributes
        model.addAttribute("contextPath", request.getContextPath());
        
        // You can add more common attributes here
        if (session.getAttribute("loggedInAdmin") != null) {
            model.addAttribute("isAdmin", true);
        } else if (session.getAttribute("loggedInUser") != null) {
            model.addAttribute("isUser", true);
        }
    }
}