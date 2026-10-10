package org.jsp.VidyaSetu.service;

import org.jsp.VidyaSetu.dto.Course;
import org.jsp.VidyaSetu.repository.CourseRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CourseService {
    
    @Autowired
    private CourseRepo courseRepo;
    
    public Course saveCourse(Course course) {
        return courseRepo.save(course);
    }
    
    public List<Course> getAllCourses() {
        return courseRepo.findAllSorted();
    }
    
    public List<Course> getCoursesByCategory(String category) {
        return courseRepo.findByCategory(category);
    }
    
    public Course getCourseById(Long id) {
        return courseRepo.findById(id).orElse(null);
    }
    
    public void deleteCourse(Long id) {
        courseRepo.deleteById(id);
    }
    
    public Course updateCourse(Course course) {
        return courseRepo.save(course);
    }
    
    public List<Course> searchCourses(String keyword) {
        return courseRepo.findAll().stream()
            .filter(c -> c.getCourseName().toLowerCase().contains(keyword.toLowerCase()) ||
                        c.getDescription().toLowerCase().contains(keyword.toLowerCase()) ||
                        c.getCategory().toLowerCase().contains(keyword.toLowerCase()))
            .toList();
    }
}