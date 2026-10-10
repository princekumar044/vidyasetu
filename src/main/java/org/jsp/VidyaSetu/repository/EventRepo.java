package org.jsp.VidyaSetu.repository;

import org.jsp.VidyaSetu.dto.Event;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.time.LocalDate;
import java.util.List;

public interface EventRepo extends JpaRepository<Event, Long> {
    
    // Find events by date range
    List<Event> findByEventDateBetween(LocalDate startDate, LocalDate endDate);
    
    // Find events by course
    List<Event> findByCourseId(Long courseId);
    
    // Find events by teacher
    List<Event> findByTeacherId(Long teacherId);
    
    // Find events by type
    List<Event> findByEventType(String eventType);
    
    // Find upcoming events
    @Query("SELECT e FROM Event e WHERE e.eventDate >= :today ORDER BY e.eventDate, e.startTime")
    List<Event> findUpcomingEvents(@Param("today") LocalDate today);
    
    // Find events for a specific month
    @Query("SELECT e FROM Event e WHERE YEAR(e.eventDate) = :year AND MONTH(e.eventDate) = :month")
    List<Event> findByMonth(@Param("year") int year, @Param("month") int month);
    
    // Find events for today
    @Query("SELECT e FROM Event e WHERE e.eventDate = :today")
    List<Event> findTodayEvents(@Param("today") LocalDate today);
}