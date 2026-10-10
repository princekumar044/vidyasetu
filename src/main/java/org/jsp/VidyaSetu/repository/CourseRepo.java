package org.jsp.VidyaSetu.repository;

import org.jsp.VidyaSetu.dto.Course;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;

public interface CourseRepo extends JpaRepository<Course, Long> {
    
    @Query("SELECT c FROM Course c ORDER BY c.id")
    List<Course> findAllSorted();
    
    List<Course> findByCategory(String category);
}