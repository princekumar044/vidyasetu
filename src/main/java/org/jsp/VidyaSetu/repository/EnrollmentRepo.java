package org.jsp.VidyaSetu.repository;

import org.jsp.VidyaSetu.dto.Course;
import org.jsp.VidyaSetu.dto.Enrollment;
import org.jsp.VidyaSetu.dto.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;

public interface EnrollmentRepo extends JpaRepository<Enrollment, Long> {
    boolean existsByStudentAndCourse(Student student, Course course);
    List<Enrollment> findByStudent(Student student);
    List<Enrollment> findByCourse(Course course);
    
    @Query("SELECT e FROM Enrollment e WHERE e.student.id = ?1")
    List<Enrollment> findByStudentId(Long studentId);
    
    @Query("SELECT COUNT(e) FROM Enrollment e WHERE e.course.id = ?1")
    Long countByCourseId(Long courseId);
    
    // findAll() method is already provided by JpaRepository
}