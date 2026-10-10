package org.jsp.VidyaSetu.service;

import org.jsp.VidyaSetu.dto.Course;
import org.jsp.VidyaSetu.dto.Enrollment;
import org.jsp.VidyaSetu.dto.Student;
import org.jsp.VidyaSetu.repository.CourseRepo;
import org.jsp.VidyaSetu.repository.EnrollmentRepo;
import org.jsp.VidyaSetu.repository.StudentRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class EnrollmentService {
    
    @Autowired
    private EnrollmentRepo enrollmentRepo;
    
    @Autowired
    private StudentRepo studentRepo;
    
    @Autowired
    private CourseRepo courseRepo;
    
    @Transactional
    public Enrollment enrollStudent(Long studentId, Long courseId) {
        System.out.println("\n=== ENROLLMENT SERVICE: enrollStudent ===");
        System.out.println("Student ID: " + studentId);
        System.out.println("Course ID: " + courseId);
        
        Student student = studentRepo.findById(studentId)
            .orElseThrow(() -> {
                System.out.println("ERROR: Student not found with ID: " + studentId);
                return new RuntimeException("Student not found");
            });
        
        System.out.println("Found student: " + student.getFullname() + " (ID: " + student.getId() + ")");
        
        Course course = courseRepo.findById(courseId)
            .orElseThrow(() -> {
                System.out.println("ERROR: Course not found with ID: " + courseId);
                return new RuntimeException("Course not found");
            });
        
        System.out.println("Found course: " + course.getCourseName() + " (ID: " + course.getId() + ")");
        
        // Check if already enrolled
        boolean alreadyEnrolled = enrollmentRepo.existsByStudentAndCourse(student, course);
        System.out.println("Already enrolled? " + alreadyEnrolled);
        
        if (alreadyEnrolled) {
            System.out.println("ERROR: Student already enrolled in this course");
            throw new RuntimeException("Student already enrolled in this course");
        }
        
        Enrollment enrollment = new Enrollment(student, course);
        System.out.println("Creating new enrollment...");
        
        Enrollment savedEnrollment = enrollmentRepo.save(enrollment);
        System.out.println("Enrollment saved successfully! ID: " + savedEnrollment.getId());
        System.out.println("=== END ENROLLMENT SERVICE ===\n");
        
        return savedEnrollment;
    }
    
    public List<Enrollment> getEnrollmentsByStudent(Long studentId) {
        System.out.println("\n=== ENROLLMENT SERVICE: getEnrollmentsByStudent ===");
        System.out.println("Student ID: " + studentId);
        
        List<Enrollment> enrollments = enrollmentRepo.findByStudentId(studentId);
        System.out.println("Found " + enrollments.size() + " enrollments for student " + studentId);
        
        enrollments.forEach(enrollment -> {
            System.out.println("  - Enrollment ID: " + enrollment.getId() + 
                             ", Course: " + enrollment.getCourse().getCourseName());
        });
        
        System.out.println("=== END SERVICE ===\n");
        return enrollments;
    }
    
    public List<Enrollment> getEnrollmentsByCourse(Long courseId) {
        Course course = courseRepo.findById(courseId)
            .orElseThrow(() -> new RuntimeException("Course not found"));
        return enrollmentRepo.findByCourse(course);
    }
    
    @Transactional
    public void unenrollStudent(Long enrollmentId) {
        System.out.println("\n=== ENROLLMENT SERVICE: unenrollStudent ===");
        System.out.println("Enrollment ID to delete: " + enrollmentId);
        
        if (enrollmentRepo.existsById(enrollmentId)) {
            enrollmentRepo.deleteById(enrollmentId);
            System.out.println("Enrollment deleted successfully");
        } else {
            System.out.println("ERROR: Enrollment not found with ID: " + enrollmentId);
        }
        
        System.out.println("=== END SERVICE ===\n");
    }
    
    public boolean isEnrolled(Long studentId, Long courseId) {
        System.out.println("\n=== ENROLLMENT SERVICE: isEnrolled ===");
        System.out.println("Checking if student " + studentId + " is enrolled in course " + courseId);
        
        Student student = studentRepo.findById(studentId).orElse(null);
        Course course = courseRepo.findById(courseId).orElse(null);
        
        if (student == null) {
            System.out.println("ERROR: Student not found with ID: " + studentId);
            return false;
        }
        
        if (course == null) {
            System.out.println("ERROR: Course not found with ID: " + courseId);
            return false;
        }
        
        System.out.println("Student found: " + student.getFullname());
        System.out.println("Course found: " + course.getCourseName());
        
        boolean exists = enrollmentRepo.existsByStudentAndCourse(student, course);
        System.out.println("Result: " + (exists ? "ENROLLED" : "NOT ENROLLED"));
        System.out.println("=== END SERVICE ===\n");
        
        return exists;
    }
    
    public Long getEnrollmentCount(Long courseId) {
        System.out.println("\n=== ENROLLMENT SERVICE: getEnrollmentCount ===");
        System.out.println("Course ID: " + courseId);
        
        Long count = enrollmentRepo.countByCourseId(courseId);
        System.out.println("Total enrollments for course " + courseId + ": " + count);
        
        System.out.println("=== END SERVICE ===\n");
        return count;
    }
    
    // NEW METHOD: Get all enrollments
    public List<Enrollment> getAllEnrollments() {
        System.out.println("\n=== ENROLLMENT SERVICE: getAllEnrollments ===");
        
        List<Enrollment> enrollments = enrollmentRepo.findAll();
        System.out.println("Found " + enrollments.size() + " total enrollments");
        
        enrollments.forEach(enrollment -> {
            System.out.println("  - Enrollment ID: " + enrollment.getId() + 
                             ", Student: " + enrollment.getStudent().getFullname() +
                             ", Course: " + enrollment.getCourse().getCourseName());
        });
        
        System.out.println("=== END SERVICE ===\n");
        return enrollments;
    }
    
    // NEW METHOD: Get total count of all enrollments
    public Long getAllEnrollmentsCount() {
        System.out.println("\n=== ENROLLMENT SERVICE: getAllEnrollmentsCount ===");
        
        Long count = enrollmentRepo.count();
        System.out.println("Total enrollments count: " + count);
        
        System.out.println("=== END SERVICE ===\n");
        return count;
    }
}