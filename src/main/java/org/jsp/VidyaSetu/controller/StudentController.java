package org.jsp.VidyaSetu.controller;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.jsp.VidyaSetu.dto.Course;
import org.jsp.VidyaSetu.dto.Enrollment;
import org.jsp.VidyaSetu.dto.Student;
import org.jsp.VidyaSetu.service.CourseService;
import org.jsp.VidyaSetu.service.EnrollmentService;
import org.jsp.VidyaSetu.service.StudentService;
import org.jsp.VidyaSetu.util.PasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

@Controller
public class StudentController {

    @Autowired
    private StudentService studentService;
    
    @Autowired
    private CourseService courseService;
    
    @Autowired
    private EnrollmentService enrollmentService;
    
    @GetMapping("/")
    public String home() {
        return "home";
    }
    
    @GetMapping("/register")
    public String register() {
        return "register";
    }
    
    @GetMapping("/viewdata")
    public String viewdata(Model m) {
        List<Student> list = studentService.getallstudents();
        m.addAttribute("list", list);
        return "viewdata";
    }
        
    @GetMapping("/login")
    public String login() {
        return "login";    
    }
    
    @PostMapping("/login")
    public String login(@RequestParam String email, 
                        @RequestParam String password, 
                        HttpSession session, 
                        Model model) {
        
        System.out.println("Login attempt for email: " + email);
        
        // Use the new authenticate method
        Optional<Student> student = studentService.authenticate(email, password);
        
        if(student.isPresent()) {
            // Store student in session
            session.setAttribute("loggedInStudent", student.get());
            session.setAttribute("student", student.get());
            
            System.out.println("Login successful: " + student.get().getFullname());
            System.out.println("Student ID: " + student.get().getId());
            
            // Set success message
            session.setAttribute("successMessage", "Welcome back, " + student.get().getFullname() + "!");
            
            return "redirect:/";
        } else {
            model.addAttribute("error", "Invalid email or password");
            System.out.println("Login failed for: " + email);
            return "login";
        }
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        Student loggedInStudent = (Student) session.getAttribute("loggedInStudent");
        
        if (loggedInStudent != null && "ADMIN".equals(loggedInStudent.getRole())) {
            // If admin is logged in, redirect to admin login
            session.invalidate();
            return "redirect:/admin/login";
        } else {
            // Regular student logout
            session.invalidate();
            return "redirect:/";
        }
    }
    
    @PostMapping("/saveform")
    public String saveForm(@ModelAttribute Student s) {
        // Set default role as STUDENT for new registrations
        if (s.getRole() == null || s.getRole().isEmpty()) {
            s.setRole("STUDENT");
        }
        studentService.registration(s);
        return "redirect:/viewdata";
    }
    
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        try {
            studentService.delete(id);
        } catch(Exception e) {
            System.out.println(e);
        }
        return "redirect:/viewdata";
    }
    
    @GetMapping("/profileedit/{id}")
    public String profileedit(@PathVariable Long id, Model m) {
        Optional<Student> s = studentService.getStudentById(id);
        if(s.isPresent()) {
            m.addAttribute("student", s.get());
            return "edit";
        }
        return "redirect:/viewdata";
    }
    
    @PostMapping("/update/{id}")
    public String updateStudent(@PathVariable Long id, @ModelAttribute Student s) {
        s.setId(id);
        // Preserve role if not provided
        if (s.getRole() == null || s.getRole().isEmpty()) {
            Optional<Student> existingStudent = studentService.getStudentById(id);
            if (existingStudent.isPresent()) {
                s.setRole(existingStudent.get().getRole());
            } else {
                s.setRole("STUDENT");
            }
        }
        studentService.updateStudent(s);
        return "redirect:/viewdata";
    }
    
    @GetMapping("/courses")
    public String courses(Model model) {
        List<Course> courses = courseService.getAllCourses();
        model.addAttribute("courses", courses);
        return "courses";
    }
    
    @GetMapping("/course/{id}")
    public String courseDetails(@PathVariable Long id, Model model, HttpSession session) {
        Course course = courseService.getCourseById(id);
        model.addAttribute("course", course);
        
        Student loggedInStudent = (Student) session.getAttribute("loggedInStudent");
        if (loggedInStudent != null) {
            boolean isEnrolled = enrollmentService.isEnrolled(loggedInStudent.getId(), id);
            model.addAttribute("isEnrolled", isEnrolled);
        }
        
        Long enrollmentCount = enrollmentService.getEnrollmentCount(id);
        model.addAttribute("enrollmentCount", enrollmentCount);
        
        return "course-details";
    }
    
    @PostMapping("/enroll/{courseId}")
    public String enrollCourse(@PathVariable Long courseId, HttpSession session) {
        Student loggedInStudent = (Student) session.getAttribute("loggedInStudent");
        if (loggedInStudent == null) {
            return "redirect:/login";
        }
        
        try {
            enrollmentService.enrollStudent(loggedInStudent.getId(), courseId);
            session.setAttribute("successMessage", "Successfully enrolled in course!");
        } catch (Exception e) {
            session.setAttribute("errorMessage", e.getMessage());
            e.printStackTrace(); // Add this for debugging
        }
        
        return "redirect:/course/" + courseId;
    }
    
    @GetMapping("/my-courses")
    public String myCourses(Model model, HttpSession session) {
        Student loggedInStudent = (Student) session.getAttribute("loggedInStudent");
        System.out.println("my-courses - Session student: " + loggedInStudent);
        
        if (loggedInStudent == null) {
            System.out.println("Redirecting to login - no student in session");
            return "redirect:/login";
        }
        
        System.out.println("Fetching enrollments for student ID: " + loggedInStudent.getId());
        List<Enrollment> enrollments = enrollmentService.getEnrollmentsByStudent(loggedInStudent.getId());
        System.out.println("Found " + enrollments.size() + " enrollments");
        
        model.addAttribute("enrollments", enrollments);
        
        // Also add student to model for the view
        model.addAttribute("student", loggedInStudent);
        
        return "my-courses";
    }
    
    @PostMapping("/unenroll/{enrollmentId}")
    public String unenroll(@PathVariable Long enrollmentId, HttpSession session) {
        enrollmentService.unenrollStudent(enrollmentId);
        session.setAttribute("successMessage", "Successfully unenrolled from course!");
        return "redirect:/my-courses";
    }
    
    @GetMapping("/search-courses")
    public String searchCourses(@RequestParam String keyword, Model model) {
        List<Course> courses = courseService.searchCourses(keyword);
        model.addAttribute("courses", courses);
        model.addAttribute("searchKeyword", keyword);
        return "courses";
    }
    
}