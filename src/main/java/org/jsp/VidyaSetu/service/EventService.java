package org.jsp.VidyaSetu.service;

import org.jsp.VidyaSetu.dto.Event;
import org.jsp.VidyaSetu.repository.EventRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class EventService {
    
    @Autowired
    private EventRepo eventRepository;
    
    public Event saveEvent(Event event) {
        // Only set createdAt if it's a new event (id is null)
        if (event.getId() == null) {
            event.setCreatedAt(LocalDateTime.now());
        }
        return eventRepository.save(event);
    }
    
    public Event getEventById(Long id) {
        return eventRepository.findById(id).orElse(null);
    }
    
    public List<Event> getAllEvents() {
        return eventRepository.findAll();
    }
    
    public List<Event> getEventsByDateRange(LocalDate startDate, LocalDate endDate) {
        return eventRepository.findByEventDateBetween(startDate, endDate);
    }
    
    public List<Event> getUpcomingEvents() {
        return eventRepository.findUpcomingEvents(LocalDate.now());
    }
    
    public List<Event> getEventsForMonth(int year, int month) {
        return eventRepository.findByMonth(year, month);
    }
    
    public List<Event> getEventsForCourse(Long courseId) {
        return eventRepository.findByCourseId(courseId);
    }
    
    public List<Event> getEventsForTeacher(Long teacherId) {
        return eventRepository.findByTeacherId(teacherId);
    }
    
    public void deleteEvent(Long id) {
        eventRepository.deleteById(id);
    }
}