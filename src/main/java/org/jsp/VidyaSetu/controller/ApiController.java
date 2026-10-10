package org.jsp.VidyaSetu.controller;

import org.jsp.VidyaSetu.dto.*;
import org.jsp.VidyaSetu.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api")
// FIXED: Remove @CrossOrigin annotation - CORS is handled in WebConfig
public class ApiController {
    
    @Autowired
    private StudentService studentService;
    
    @Autowired
    private CourseService courseService;
    
    @Autowired
    private EventService eventService;
    
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("HH:mm");
    private static final DateTimeFormatter DISPLAY_TIME_FORMATTER = DateTimeFormatter.ofPattern("hh:mm a");
    
    // ===================== DEBUG ENDPOINTS =====================
    
    @GetMapping("/debug/roles")
    public ResponseEntity<Map<String, Object>> debugRoles() {
        Map<String, Object> response = new HashMap<>();
        
        List<Student> allUsers = studentService.getallstudents();
        
        List<Map<String, Object>> users = new ArrayList<>();
        for (Student user : allUsers) {
            Map<String, Object> userMap = new HashMap<>();
            userMap.put("id", user.getId());
            userMap.put("name", user.getFullname());
            userMap.put("email", user.getEmail());
            userMap.put("role", user.getRole());
            userMap.put("isTeacher", "TEACHER".equalsIgnoreCase(user.getRole()));
            users.add(userMap);
        }
        
        long teacherCount = allUsers.stream()
            .filter(u -> "TEACHER".equalsIgnoreCase(u.getRole()))
            .count();
        
        response.put("totalUsers", allUsers.size());
        response.put("teacherCount", teacherCount);
        response.put("users", users);
        
        return ResponseEntity.ok(response);
    }
    
    // ===================== EVENT ENDPOINTS =====================
    
    @GetMapping("/events")
    public ResponseEntity<List<EventDTO>> getAllEvents() {
        List<Event> events = eventService.getAllEvents();
        List<EventDTO> eventDTOs = events.stream()
                .map(this::convertToCalendarDTO)
                .collect(Collectors.toList());
        
        System.out.println("Returning " + eventDTOs.size() + " events");
        return ResponseEntity.ok(eventDTOs);
    }
    
    @GetMapping("/events/upcoming")
    public ResponseEntity<List<EventDTO>> getUpcomingEvents() {
        LocalDate today = LocalDate.now();
        LocalDate weekEnd = today.plusDays(7);
        List<Event> events = eventService.getEventsByDateRange(today, weekEnd);
        List<EventDTO> eventDTOs = events.stream()
                .map(this::convertToCalendarDTO)
                .collect(Collectors.toList());
        
        System.out.println("Returning " + eventDTOs.size() + " upcoming events");
        return ResponseEntity.ok(eventDTOs);
    }
    
    @GetMapping("/events/{id}")
    public ResponseEntity<?> getEventById(@PathVariable Long id) {
        try {
            Event event = eventService.getEventById(id);
            return ResponseEntity.ok(convertToCalendarDTO(event));
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("message", "Event not found: " + e.getMessage());
            return ResponseEntity.status(404).body(error);
        }
    }
    
    @PostMapping(value = "/events", 
                consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
                produces = MediaType.APPLICATION_JSON_VALUE)
    @Transactional
    public ResponseEntity<Map<String, Object>> createEvent(
            @RequestParam String title,
            @RequestParam(required = false) String description,
            @RequestParam String eventType,
            @RequestParam String eventDate,
            @RequestParam(required = false) String eventTime,
            @RequestParam(required = false) Long courseId,
            @RequestParam(required = false) Long teacherId,
            @RequestParam(required = false) String location,
            @RequestParam(required = false) String color,
            @RequestParam(required = false) String recurrence,
            @RequestParam(required = false) String recurrenceEnd,
            HttpSession session) {
        
        System.out.println("\n=== CREATE EVENT REQUEST RECEIVED ===");
        System.out.println("Title: " + title);
        System.out.println("Event Type: " + eventType);
        System.out.println("Event Date: " + eventDate);
        System.out.println("Event Time: " + eventTime);
        System.out.println("Course ID: " + courseId);
        System.out.println("Teacher ID: " + teacherId);
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            // Check admin authentication
            Student admin = (Student) session.getAttribute("loggedInAdmin");
            if (admin == null) {
                admin = (Student) session.getAttribute("admin");
            }
            
            if (admin == null) {
                System.out.println("ERROR: No admin found in session");
                response.put("success", false);
                response.put("message", "Unauthorized - Please login as admin");
                return ResponseEntity.status(401).body(response);
            }
            
            if (!"ADMIN".equals(admin.getRole())) {
                System.out.println("ERROR: User is not admin, role: " + admin.getRole());
                response.put("success", false);
                response.put("message", "Unauthorized - Admin privileges required");
                return ResponseEntity.status(403).body(response);
            }
            
            System.out.println("Admin authenticated: " + admin.getFullname());
            
            // Create new event
            Event event = new Event();
            event.setTitle(title);
            event.setDescription(description);
            event.setEventType(eventType);
            event.setLocation(location);
            
            // Set color
            if (color != null && !color.trim().isEmpty()) {
                event.setColor(color);
            } else {
                event.setColor(getColorByEventType(eventType));
            }
            
            // Set date
            try {
                LocalDate parsedDate = LocalDate.parse(eventDate, DATE_FORMATTER);
                event.setEventDate(parsedDate);
                System.out.println("Parsed date: " + parsedDate);
            } catch (Exception e) {
                System.err.println("Error parsing date: " + e.getMessage());
                response.put("success", false);
                response.put("message", "Invalid date format. Use YYYY-MM-DD");
                return ResponseEntity.badRequest().body(response);
            }
            
            // Set time (optional)
            if (eventTime != null && !eventTime.trim().isEmpty()) {
                try {
                    // Add seconds if not present
                    String timeStr = eventTime.trim();
                    if (timeStr.length() == 5) {
                        timeStr = timeStr + ":00";
                    }
                    LocalTime parsedTime = LocalTime.parse(timeStr);
                    event.setStartTime(parsedTime);
                    System.out.println("Parsed time: " + parsedTime);
                    
                    // Set default end time (1 hour later) if not specified
                    if (event.getEndTime() == null) {
                        event.setEndTime(parsedTime.plusHours(1));
                    }
                } catch (Exception e) {
                    System.err.println("Error parsing time: " + e.getMessage());
                }
            }
            
            // Set recurrence
            if (recurrence != null && !recurrence.trim().isEmpty() && !"NONE".equals(recurrence)) {
                event.setRecurring(true);
                event.setRecurrencePattern(recurrence);
                
                // Set recurrence end date if provided
                if (recurrenceEnd != null && !recurrenceEnd.trim().isEmpty()) {
                    try {
                        LocalDate parsedRecurrenceEnd = LocalDate.parse(recurrenceEnd, DATE_FORMATTER);
                        event.setRecurrenceEndDate(parsedRecurrenceEnd);
                        System.out.println("Parsed recurrence end: " + parsedRecurrenceEnd);
                    } catch (Exception e) {
                        System.err.println("Error parsing recurrence end date: " + e.getMessage());
                    }
                }
            } else {
                event.setRecurring(false);
                event.setRecurrencePattern(null);
            }
            
            // Set course if provided
            if (courseId != null && courseId > 0) {
                try {
                    Course course = courseService.getCourseById(courseId);
                    if (course != null) {
                        event.setCourse(course);
                        System.out.println("Course set: " + course.getCourseName());
                    } else {
                        System.out.println("Warning: Course not found with ID: " + courseId);
                        event.setCourse(null);
                    }
                } catch (Exception e) {
                    System.err.println("Error setting course: " + e.getMessage());
                    event.setCourse(null);
                }
            } else {
                event.setCourse(null);
            }
            
            // Set teacher if provided - FIXED VERSION
            if (teacherId != null && teacherId > 0) {
                try {
                    Optional<Student> teacherOpt = studentService.getStudentById(teacherId);
                    if (teacherOpt.isPresent()) {
                        Student teacher = teacherOpt.get();
                        
                        // DEBUG: Check teacher role
                        System.out.println("Found teacher candidate: " + teacher.getFullname() + 
                                         ", Role: " + teacher.getRole());
                        
                        // Check if user actually has TEACHER role
                        if ("TEACHER".equalsIgnoreCase(teacher.getRole())) {
                            event.setTeacher(teacher);
                            System.out.println("Teacher successfully set: " + teacher.getFullname());
                        } else {
                            System.out.println("WARNING: User ID " + teacherId + " is not a TEACHER. Role: " + teacher.getRole());
                            event.setTeacher(null); // Don't set if not a teacher
                        }
                    } else {
                        System.out.println("WARNING: Teacher not found with ID: " + teacherId);
                        event.setTeacher(null);
                    }
                } catch (Exception e) {
                    System.err.println("Error setting teacher: " + e.getMessage());
                    event.setTeacher(null); // Set to null on error
                }
            } else {
                System.out.println("No teacher ID provided, setting teacher to null");
                event.setTeacher(null);
            }
            
            event.setCreatedBy(admin.getFullname());
            // FIXED: Changed from LocalDate.now() to LocalDateTime.now()
            event.setCreatedAt(LocalDateTime.now());
            
            // Save the event
            System.out.println("Saving event to database...");
            Event savedEvent = eventService.saveEvent(event);
            System.out.println("Event saved with ID: " + savedEvent.getId());
            
            response.put("success", true);
            response.put("message", "Event created successfully");
            response.put("id", savedEvent.getId());
            response.put("title", savedEvent.getTitle());
            response.put("event", convertToCalendarDTO(savedEvent));
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            System.err.println("ERROR creating event: " + e.getMessage());
            e.printStackTrace();
            
            response.put("success", false);
            response.put("message", "Error creating event: " + e.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }
    
    @PutMapping(value = "/events/{id}", 
               consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
               produces = MediaType.APPLICATION_JSON_VALUE)
    @Transactional
    public ResponseEntity<Map<String, Object>> updateEvent(
            @PathVariable Long id,
            @RequestParam String title,
            @RequestParam(required = false) String description,
            @RequestParam String eventType,
            @RequestParam String eventDate,
            @RequestParam(required = false) String eventTime,
            @RequestParam(required = false) Long courseId,
            @RequestParam(required = false) Long teacherId,
            @RequestParam(required = false) String location,
            @RequestParam(required = false) String color,
            @RequestParam(required = false) String recurrence,
            @RequestParam(required = false) String recurrenceEnd,
            HttpSession session) {
        
        System.out.println("\n=== UPDATE EVENT REQUEST RECEIVED ===");
        System.out.println("Event ID: " + id);
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            // Check admin authentication
            Student admin = (Student) session.getAttribute("loggedInAdmin");
            if (admin == null) {
                response.put("success", false);
                response.put("message", "Unauthorized");
                return ResponseEntity.status(401).body(response);
            }
            
            // Get existing event
            Event event = eventService.getEventById(id);
            
            // Update fields
            event.setTitle(title);
            event.setDescription(description);
            event.setEventType(eventType);
            event.setLocation(location);
            
            if (color != null && !color.trim().isEmpty()) {
                event.setColor(color);
            } else {
                event.setColor(getColorByEventType(eventType));
            }
            
            // Update date
            try {
                LocalDate parsedDate = LocalDate.parse(eventDate, DATE_FORMATTER);
                event.setEventDate(parsedDate);
            } catch (Exception e) {
                System.err.println("Error parsing date: " + e.getMessage());
            }
            
            // Update time
            if (eventTime != null && !eventTime.trim().isEmpty()) {
                try {
                    String timeStr = eventTime.trim();
                    if (timeStr.length() == 5) {
                        timeStr = timeStr + ":00";
                    }
                    LocalTime parsedTime = LocalTime.parse(timeStr);
                    event.setStartTime(parsedTime);
                    
                    // Update end time if not specified
                    if (event.getEndTime() == null) {
                        event.setEndTime(parsedTime.plusHours(1));
                    }
                } catch (Exception e) {
                    System.err.println("Error parsing time: " + e.getMessage());
                }
            } else {
                // If no time provided, clear time fields for all-day event
                event.setStartTime(null);
                event.setEndTime(null);
            }
            
            // Update recurrence
            if (recurrence != null && !recurrence.trim().isEmpty() && !"NONE".equals(recurrence)) {
                event.setRecurring(true);
                event.setRecurrencePattern(recurrence);
                
                if (recurrenceEnd != null && !recurrenceEnd.trim().isEmpty()) {
                    try {
                        LocalDate parsedRecurrenceEnd = LocalDate.parse(recurrenceEnd, DATE_FORMATTER);
                        event.setRecurrenceEndDate(parsedRecurrenceEnd);
                    } catch (Exception e) {
                        System.err.println("Error parsing recurrence end date: " + e.getMessage());
                    }
                }
            } else {
                event.setRecurring(false);
                event.setRecurrencePattern(null);
                event.setRecurrenceEndDate(null);
            }
            
            // Update course
            if (courseId != null && courseId > 0) {
                try {
                    Course course = courseService.getCourseById(courseId);
                    event.setCourse(course);
                } catch (Exception e) {
                    System.err.println("Error setting course: " + e.getMessage());
                    event.setCourse(null);
                }
            } else {
                event.setCourse(null);
            }
            
            // Update teacher - FIXED VERSION
            if (teacherId != null && teacherId > 0) {
                try {
                    Optional<Student> teacherOpt = studentService.getStudentById(teacherId);
                    if (teacherOpt.isPresent()) {
                        Student teacher = teacherOpt.get();
                        
                        // Check if user actually has TEACHER role
                        if ("TEACHER".equalsIgnoreCase(teacher.getRole())) {
                            event.setTeacher(teacher);
                            System.out.println("Teacher updated: " + teacher.getFullname());
                        } else {
                            System.out.println("WARNING: User ID " + teacherId + " is not a TEACHER. Role: " + teacher.getRole());
                            event.setTeacher(null);
                        }
                    } else {
                        System.out.println("WARNING: Teacher not found with ID: " + teacherId);
                        event.setTeacher(null);
                    }
                } catch (Exception e) {
                    System.err.println("Error setting teacher: " + e.getMessage());
                    event.setTeacher(null);
                }
            } else {
                event.setTeacher(null);
            }
            
            // FIXED: Changed from LocalDate.now() to LocalDateTime.now()
            event.setUpdatedAt(LocalDateTime.now());
            
            // Save updated event
            Event updatedEvent = eventService.saveEvent(event);
            
            response.put("success", true);
            response.put("message", "Event updated successfully");
            response.put("id", updatedEvent.getId());
            response.put("event", convertToCalendarDTO(updatedEvent));
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            System.err.println("ERROR updating event: " + e.getMessage());
            e.printStackTrace();
            
            response.put("success", false);
            response.put("message", "Error updating event: " + e.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }
    
    @DeleteMapping("/events/{id}")
    @Transactional
    public ResponseEntity<Map<String, Object>> deleteEvent(@PathVariable Long id, HttpSession session) {
        System.out.println("\n=== DELETE EVENT REQUEST ===");
        System.out.println("Deleting event ID: " + id);
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            // Check admin authentication
            Student admin = (Student) session.getAttribute("loggedInAdmin");
            if (admin == null) {
                response.put("success", false);
                response.put("message", "Unauthorized");
                return ResponseEntity.status(401).body(response);
            }
            
            eventService.deleteEvent(id);
            
            response.put("success", true);
            response.put("message", "Event deleted successfully");
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            System.err.println("ERROR deleting event: " + e.getMessage());
            e.printStackTrace();
            
            response.put("success", false);
            response.put("message", "Error deleting event: " + e.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }
    
    // ADD THIS NEW ENDPOINT - EVENT STATS
    @GetMapping("/events/stats")
    public ResponseEntity<Map<String, Object>> getEventStats() {
        try {
            List<Event> allEvents = eventService.getAllEvents();
            
            Map<String, Object> stats = new HashMap<>();
            stats.put("total", allEvents.size());
            
            // Count events by type
            long classCount = allEvents.stream()
                    .filter(e -> e.getEventType() != null && "CLASS".equalsIgnoreCase(e.getEventType()))
                    .count();
            long examCount = allEvents.stream()
                    .filter(e -> e.getEventType() != null && "EXAM".equalsIgnoreCase(e.getEventType()))
                    .count();
            long holidayCount = allEvents.stream()
                    .filter(e -> e.getEventType() != null && "HOLIDAY".equalsIgnoreCase(e.getEventType()))
                    .count();
            long meetingCount = allEvents.stream()
                    .filter(e -> e.getEventType() != null && "MEETING".equalsIgnoreCase(e.getEventType()))
                    .count();
            long workshopCount = allEvents.stream()
                    .filter(e -> e.getEventType() != null && "WORKSHOP".equalsIgnoreCase(e.getEventType()))
                    .count();
            long deadlineCount = allEvents.stream()
                    .filter(e -> e.getEventType() != null && "DEADLINE".equalsIgnoreCase(e.getEventType()))
                    .count();
            
            stats.put("classCount", classCount);
            stats.put("examCount", examCount);
            stats.put("holidayCount", holidayCount);
            stats.put("meetingCount", meetingCount);
            stats.put("workshopCount", workshopCount);
            stats.put("deadlineCount", deadlineCount);
            
            return ResponseEntity.ok(stats);
            
        } catch (Exception e) {
            System.err.println("Error getting event stats: " + e.getMessage());
            Map<String, Object> error = new HashMap<>();
            error.put("error", "Failed to get event statistics");
            error.put("message", e.getMessage());
            return ResponseEntity.status(500).body(error);
        }
    }
    
    @GetMapping("/courses")
    public ResponseEntity<List<Map<String, Object>>> getAllCourses() {
        List<Course> courses = courseService.getAllCourses();
        List<Map<String, Object>> courseList = courses.stream()
                .map(course -> {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", course.getId());
                    map.put("courseName", course.getCourseName());
                    map.put("courseCode", course.getCourseCode());
                    map.put("instructor", course.getInstructor());
                    map.put("category", course.getCategory());
                    return map;
                })
                .collect(Collectors.toList());
        
        System.out.println("Returning " + courseList.size() + " courses");
        return ResponseEntity.ok(courseList);
    }
    
    @GetMapping("/teachers")
    public ResponseEntity<List<Map<String, Object>>> getAllTeachers() {
        // First get all students, then filter those with TEACHER role
        List<Student> allStudents = studentService.getallstudents();
        System.out.println("Total students: " + allStudents.size());
        
        // DEBUG: Print all roles
        System.out.println("=== ALL ROLES ===");
        for (Student s : allStudents) {
            System.out.println(s.getFullname() + ": " + s.getRole());
        }
        
        List<Student> teachers = allStudents.stream()
                .filter(s -> s.getRole() != null && 
                            ("TEACHER".equalsIgnoreCase(s.getRole()) || 
                             "TEACHER".equals(s.getRole()))) // Check both cases
                .collect(Collectors.toList());
        
        System.out.println("Teachers found: " + teachers.size());
        
        if (teachers.isEmpty()) {
            System.out.println("WARNING: No teachers found in database!");
            System.out.println("Available roles:");
            allStudents.stream()
                .map(s -> s.getRole())
                .distinct()
                .forEach(role -> System.out.println("- " + role));
        }
        
        List<Map<String, Object>> teacherList = teachers.stream()
                .map(teacher -> {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", teacher.getId());
                    map.put("fullname", teacher.getFullname());
                    map.put("email", teacher.getEmail());
                    map.put("role", teacher.getRole()); // Show role for debugging
                    return map;
                })
                .collect(Collectors.toList());
        
        return ResponseEntity.ok(teacherList);
    }
    
    @GetMapping("/calendar/events")
    public ResponseEntity<List<EventDTO>> getCalendarEvents(
            @RequestParam String start,
            @RequestParam String end,
            HttpSession session) {
        
        System.out.println("Calendar events request: start=" + start + ", end=" + end);
        
        try {
            LocalDate startDate;
            LocalDate endDate;
            
            // Handle date formats with timezone offset
            if (start.contains("T")) {
                // Extract just the date part before 'T'
                start = start.substring(0, start.indexOf('T'));
            }
            if (end.contains("T")) {
                // Extract just the date part before 'T'
                end = end.substring(0, end.indexOf('T'));
            }
            
            // Parse dates
            startDate = LocalDate.parse(start);
            endDate = LocalDate.parse(end);
            
            System.out.println("Parsed dates: " + startDate + " to " + endDate);
            
            List<Event> events = eventService.getEventsByDateRange(startDate, endDate);
            List<EventDTO> eventDTOs = events.stream()
                    .map(this::convertToCalendarDTO)
                    .collect(Collectors.toList());
            
            System.out.println("Returning " + eventDTOs.size() + " events for calendar");
            return ResponseEntity.ok(eventDTOs);
            
        } catch (Exception e) {
            System.err.println("Error getting calendar events: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.ok(List.of());
        }
    }
    
    // ===================== HELPER METHODS =====================
    
    private EventDTO convertToCalendarDTO(Event event) {
        EventDTO dto = new EventDTO();
        dto.setId(event.getId());
        dto.setTitle(event.getTitle());
        dto.setDescription(event.getDescription());
        dto.setEventType(event.getEventType());
        dto.setLocation(event.getLocation());
        dto.setColor(event.getColor() != null ? event.getColor() : getColorByEventType(event.getEventType()));
        dto.setRecurrence(event.getRecurrencePattern());
        
        // Set display time
        if (event.getStartTime() != null) {
            dto.setEventTime(event.getStartTime().format(DISPLAY_TIME_FORMATTER));
        }
        
        // Set date and time for FullCalendar
        if (event.getEventDate() != null) {
            if (event.getStartTime() != null) {
                // Format for FullCalendar: "YYYY-MM-DDTHH:mm:ss"
                String startStr = event.getEventDate() + "T" + event.getStartTime();
                dto.setStart(startStr);
                
                // Set end time
                if (event.getEndTime() != null) {
                    dto.setEnd(event.getEventDate() + "T" + event.getEndTime());
                } else {
                    // Default to 1 hour after start
                    dto.setEnd(event.getEventDate() + "T" + event.getStartTime().plusHours(1));
                }
                dto.setAllDay(false);
            } else {
                // All-day event
                dto.setStart(event.getEventDate().toString());
                // For all-day events in FullCalendar, end date should be exclusive
                // So add 1 day to the end date
                dto.setEnd(event.getEventDate().plusDays(1).toString());
                dto.setAllDay(true);
            }
        }
        
        // Set course info
        if (event.getCourse() != null) {
            dto.setCourseName(event.getCourse().getCourseName());
            dto.setCourseCode(event.getCourse().getCourseCode());
        }
        
        // Set teacher info
        if (event.getTeacher() != null) {
            dto.setTeacherName(event.getTeacher().getFullname());
        }
        
        // Set extended properties for FullCalendar
        Map<String, Object> extendedProps = new HashMap<>();
        extendedProps.put("description", event.getDescription());
        extendedProps.put("eventType", event.getEventType());
        extendedProps.put("location", event.getLocation());
        extendedProps.put("eventTime", dto.getEventTime());
        extendedProps.put("recurrence", event.getRecurrencePattern());
        extendedProps.put("courseName", dto.getCourseName());
        extendedProps.put("courseCode", dto.getCourseCode());
        extendedProps.put("teacherName", dto.getTeacherName());
        extendedProps.put("createdBy", event.getCreatedBy());
        
        // Set extended props to DTO
        dto.setExtendedProps(extendedProps);
        
        return dto;
    }
    
    private String getColorByEventType(String eventType) {
        if (eventType == null) return "#95a5a6";
        
        switch (eventType.toUpperCase()) {
            case "CLASS": return "#4e73df"; // Blue
            case "EXAM": return "#e74a3b"; // Red
            case "HOLIDAY": return "#1cc88a"; // Green
            case "MEETING": return "#f6c23e"; // Yellow
            case "OTHER": return "#858796"; // Gray
            case "WORKSHOP": return "#6f42c1"; // Purple
            case "DEADLINE": return "#fd7e14"; // Orange
            default: return "#95a5a6"; // Default gray
        }
    }
}