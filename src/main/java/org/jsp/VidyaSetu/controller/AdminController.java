package org.jsp.VidyaSetu.controller;

import org.jsp.VidyaSetu.dto.*;
import org.jsp.VidyaSetu.service.*;
import org.jsp.VidyaSetu.util.PasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @Autowired
    private StudentService studentService;
    
    @Autowired
    private CourseService courseService;
    
    @Autowired
    private EnrollmentService enrollmentService;
    
    @Autowired
    private AdminService adminService;
    
    @Autowired
    private EventService eventService;
    
    // ===================== ADMIN PAGE ENDPOINTS =====================
    
    @GetMapping("/login")
    public String adminLogin() {
        return "admin-login";
    }
    
    @PostMapping("/login")
    public String adminLogin(@RequestParam String email, 
                            @RequestParam String password, 
                            HttpSession session, 
                            Model model) {
        
        System.out.println("Admin login attempt for email: " + email);
        
        Optional<Student> studentOptional = studentService.findByEmail(email);
        
        if(studentOptional.isPresent()) {
            Student student = studentOptional.get();
            
            // Check if password matches
            if (PasswordUtil.checkPassword(password, student.getPassword())) {
                // Check if user is ADMIN
                if ("ADMIN".equals(student.getRole())) {
                    // Store admin in session
                    session.setAttribute("loggedInAdmin", student);
                    session.setAttribute("loggedInStudent", student); // For compatibility
                    
                    System.out.println("Admin login successful: " + student.getFullname());
                    session.setAttribute("successMessage", "Welcome, Administrator!");
                    
                    return "redirect:/admin/dashboard";
                } else {
                    model.addAttribute("error", "Access denied. Admin privileges required.");
                    System.out.println("Non-admin attempt to access admin login: " + email);
                    return "admin-login";
                }
            }
        }
        
        model.addAttribute("error", "Invalid admin credentials");
        System.out.println("Admin login failed for: " + email);
        return "admin-login";
    }
    
    @GetMapping("/logout")
    public String adminLogout(HttpSession session) {
        session.removeAttribute("loggedInAdmin");
        session.invalidate();
        return "redirect:/admin/login";
    }
    
    @GetMapping("/dashboard")
    public String adminDashboard(HttpSession session, Model model) {
        // Check if admin is logged in
        Student admin = (Student) session.getAttribute("loggedInAdmin");
        
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/admin/login";
        }
        
        // Get statistics for dashboard
        long totalStudents = studentService.getallstudents().stream()
                .filter(s -> "STUDENT".equals(s.getRole()))
                .count();
        
        long totalCourses = courseService.getAllCourses().size();
        
        long totalEnrollments = enrollmentService.getAllEnrollmentsCount();
        
        // Get recent students (last 5)
        List<Student> recentStudents = studentService.getallstudents().stream()
                .filter(s -> "STUDENT".equals(s.getRole()))
                .limit(5)
                .toList();
        
        // Get recent courses (last 5)
        List<Course> recentCourses = courseService.getAllCourses().stream()
                .limit(5)
                .toList();
        
        // Add to model
        model.addAttribute("admin", admin);
        model.addAttribute("totalStudents", totalStudents);
        model.addAttribute("totalCourses", totalCourses);
        model.addAttribute("totalEnrollments", totalEnrollments);
        model.addAttribute("recentStudents", recentStudents);
        model.addAttribute("recentCourses", recentCourses);
        
        return "admin-dashboard";
    }
    
    @GetMapping("/students")
    public String adminStudents(HttpSession session, Model model) {
        // Check if admin is logged in
        Student admin = (Student) session.getAttribute("loggedInAdmin");
        
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/admin/login";
        }
        
        List<Student> students = studentService.getallstudents();
        model.addAttribute("students", students);
        model.addAttribute("admin", admin);
        
        return "admin-students";
    }
    
    @GetMapping("/students/edit/{id}")
    public String editStudentAdmin(@PathVariable Long id, HttpSession session, Model model) {
        // Check if admin is logged in
        Student admin = (Student) session.getAttribute("loggedInAdmin");
        
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/admin/login";
        }
        
        Optional<Student> student = studentService.getStudentById(id);
        if (student.isPresent()) {
            model.addAttribute("student", student.get());
            model.addAttribute("admin", admin);
            return "admin-edit-student";
        }
        
        session.setAttribute("errorMessage", "Student not found!");
        return "redirect:/admin/students";
    }
    
    @PostMapping("/students/update/{id}")
    public String updateStudentAdmin(@PathVariable Long id, 
                                    @ModelAttribute Student s,
                                    HttpSession session) {
        // Check if admin is logged in
        Student admin = (Student) session.getAttribute("loggedInAdmin");
        
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/admin/login";
        }
        
        s.setId(id);
        // Preserve password if empty
        if (s.getPassword() == null || s.getPassword().trim().isEmpty()) {
            Optional<Student> existingStudent = studentService.getStudentById(id);
            if (existingStudent.isPresent()) {
                s.setPassword(existingStudent.get().getPassword());
            }
        } else {
            // Encrypt new password
            s.setPassword(PasswordUtil.encryptPassword(s.getPassword()));
        }
        
        studentService.updateStudent(s);
        
        session.setAttribute("successMessage", "Student updated successfully!");
        return "redirect:/admin/students";
    }
    
    @GetMapping("/students/delete/{id}")
    public String deleteStudentAdmin(@PathVariable Long id, HttpSession session) {
        // Check if admin is logged in
        Student admin = (Student) session.getAttribute("loggedInAdmin");
        
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/admin/login";
        }
        
        try {
            // Prevent deleting self
            Student currentAdmin = (Student) session.getAttribute("loggedInAdmin");
            if (currentAdmin != null && currentAdmin.getId().equals(id)) {
                session.setAttribute("errorMessage", "You cannot delete your own account!");
                return "redirect:/admin/students";
            }
            
            studentService.delete(id);
            session.setAttribute("successMessage", "Student deleted successfully!");
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Error deleting student: " + e.getMessage());
        }
        
        return "redirect:/admin/students";
    }
    
    @GetMapping("/courses")
    public String adminCourses(HttpSession session, Model model) {
        // Check if admin is logged in
        Student admin = (Student) session.getAttribute("loggedInAdmin");
        
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/admin/login";
        }
        
        List<Course> courses = courseService.getAllCourses();
        model.addAttribute("courses", courses);
        model.addAttribute("admin", admin);
        
        return "admin-courses";
    }
    
    @GetMapping("/add-course")
    public String showAddCoursePage(HttpSession session, Model model) {
        // Check if admin is logged in
        Student admin = (Student) session.getAttribute("loggedInAdmin");
        
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/admin/login";
        }
        
        model.addAttribute("admin", admin);
        model.addAttribute("course", new Course()); // Empty course object
        
        return "admin-addcourse";
    }
    
    @PostMapping("/courses/add")
    public String addCourse(
            @RequestParam String courseName,
            @RequestParam String courseCode,
            @RequestParam String description,
            @RequestParam String instructor,
            @RequestParam String duration,
            @RequestParam BigDecimal price,
            @RequestParam String category,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        // Check if admin is logged in
        Student admin = (Student) session.getAttribute("loggedInAdmin");
        
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/admin/login";
        }
        
        try {
            // Create course object
            Course course = new Course();
            course.setCourseName(courseName);
            course.setCourseCode(courseCode);
            course.setDescription(description);
            course.setInstructor(instructor);
            course.setDuration(duration);
            course.setPrice(price);
            course.setCategory(category);
            
            // Save the course
            courseService.saveCourse(course);
            
            redirectAttributes.addFlashAttribute("successMessage", 
                "Course '" + courseName + "' added successfully!");
            return "redirect:/admin/courses";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Error adding course: " + e.getMessage());
            return "redirect:/admin/add-course";
        }
    }
    
    @GetMapping("/courses/edit/{id}")
    public String editCourseAdmin(@PathVariable Long id, HttpSession session, Model model) {
        // Check if admin is logged in
        Student admin = (Student) session.getAttribute("loggedInAdmin");
        
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/admin/login";
        }
        
        Course course = courseService.getCourseById(id);
        if (course != null) {
            model.addAttribute("course", course);
            model.addAttribute("admin", admin);
            return "admin-edit-course";
        }
        
        session.setAttribute("errorMessage", "Course not found!");
        return "redirect:/admin/courses";
    }
    
    @PostMapping("/courses/update/{id}")
    public String updateCourseAdmin(@PathVariable Long id,
                                   @RequestParam String courseName,
                                   @RequestParam String courseCode,
                                   @RequestParam String description,
                                   @RequestParam String instructor,
                                   @RequestParam String duration,
                                   @RequestParam BigDecimal price,
                                   @RequestParam String category,
                                   HttpSession session) {
        // Check if admin is logged in
        Student admin = (Student) session.getAttribute("loggedInAdmin");
        
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/admin/login";
        }
        
        Course course = courseService.getCourseById(id);
        if (course != null) {
            course.setCourseName(courseName);
            course.setCourseCode(courseCode);
            course.setDescription(description);
            course.setInstructor(instructor);
            course.setDuration(duration);
            course.setPrice(price);
            course.setCategory(category);
            
            courseService.saveCourse(course);
            session.setAttribute("successMessage", "Course updated successfully!");
        } else {
            session.setAttribute("errorMessage", "Course not found!");
        }
        
        return "redirect:/admin/courses";
    }
    
    @GetMapping("/courses/delete/{id}")
    public String deleteCourseAdmin(@PathVariable Long id, HttpSession session) {
        // Check if admin is logged in
        Student admin = (Student) session.getAttribute("loggedInAdmin");
        
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/admin/login";
        }
        
        try {
            courseService.deleteCourse(id);
            session.setAttribute("successMessage", "Course deleted successfully!");
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Error deleting course: " + e.getMessage());
        }
        
        return "redirect:/admin/courses";
    }
    
    @GetMapping("/enrollments")
    public String adminEnrollments(HttpSession session, Model model) {
        // Check if admin is logged in
        Student admin = (Student) session.getAttribute("loggedInAdmin");
        
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/admin/login";
        }
        
        // Get all enrollments
        List<Enrollment> enrollments = enrollmentService.getAllEnrollments();
        
        // Calculate statistics
        long activeCount = 0;
        long completedCount = 0;
        long cancelledCount = 0;
        BigDecimal totalRevenue = BigDecimal.ZERO;
        Set<Long> uniqueStudentIds = new HashSet<>();
        Set<Long> uniqueCourseIds = new HashSet<>();
        
        for (Enrollment enrollment : enrollments) {
            // Count by status
            if ("ACTIVE".equals(enrollment.getStatus())) {
                activeCount++;
            } else if ("COMPLETED".equals(enrollment.getStatus())) {
                completedCount++;
            } else if ("CANCELLED".equals(enrollment.getStatus())) {
                cancelledCount++;
            }
            
            // Calculate revenue
            if (enrollment.getCourse() != null && enrollment.getCourse().getPrice() != null) {
                totalRevenue = totalRevenue.add(enrollment.getCourse().getPrice());
            }
            
            // Collect unique IDs
            if (enrollment.getStudent() != null) {
                uniqueStudentIds.add(enrollment.getStudent().getId());
            }
            if (enrollment.getCourse() != null) {
                uniqueCourseIds.add(enrollment.getCourse().getId());
            }
        }
        
        // Calculate average
        double avgPerCourse = 0;
        if (!uniqueCourseIds.isEmpty()) {
            avgPerCourse = (double) enrollments.size() / uniqueCourseIds.size();
        }
        
        // Add to model
        model.addAttribute("enrollments", enrollments);
        model.addAttribute("admin", admin);
        model.addAttribute("activeCount", activeCount);
        model.addAttribute("completedCount", completedCount);
        model.addAttribute("cancelledCount", cancelledCount);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("uniqueStudentCount", uniqueStudentIds.size());
        model.addAttribute("uniqueCourseCount", uniqueCourseIds.size());
        model.addAttribute("avgPerCourse", avgPerCourse);
        
        return "admin-enrollments";
    }
    
    @GetMapping("/calendar")
    public String calendarDashboard(HttpSession session, Model model,
                                   @RequestParam(required = false) Integer year,
                                   @RequestParam(required = false) Integer month) {
        
        // Check admin authentication
        Student admin = (Student) session.getAttribute("loggedInAdmin");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/admin/login";
        }
        
        LocalDate today = LocalDate.now();
        int currentYear = (year != null) ? year : today.getYear();
        int currentMonth = (month != null) ? month : today.getMonthValue();
        
        // Get events for the current month
        List<Event> monthlyEvents = eventService.getEventsForMonth(currentYear, currentMonth);
        
        // Get upcoming events (next 7 days)
        LocalDate weekStart = today;
        LocalDate weekEnd = today.plusDays(7);
        List<Event> upcomingEvents = eventService.getEventsByDateRange(weekStart, weekEnd);
        
        // Get all courses for event creation
        List<Course> courses = courseService.getAllCourses();
        
        // Get teachers (users with TEACHER role)
        List<Student> teachers = studentService.getallstudents().stream()
                .filter(s -> "TEACHER".equals(s.getRole()))
                .collect(Collectors.toList());
        
        model.addAttribute("admin", admin);
        model.addAttribute("currentYear", currentYear);
        model.addAttribute("currentMonth", currentMonth);
        model.addAttribute("monthlyEvents", monthlyEvents);
        model.addAttribute("upcomingEvents", upcomingEvents);
        model.addAttribute("courses", courses);
        model.addAttribute("teachers", teachers);
        model.addAttribute("today", today);
        
        return "admin-calendar";
    }
}