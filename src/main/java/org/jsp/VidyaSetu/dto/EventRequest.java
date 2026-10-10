package org.jsp.VidyaSetu.dto;

import java.time.LocalDate;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public class EventRequest {
    
    @NotBlank(message = "Title is required")
    private String title;
    
    private String description;
    
    @NotBlank(message = "Event type is required")
    private String eventType;
    
    @NotNull(message = "Event date is required")
    private LocalDate eventDate;
    
    private String eventTime; // Accepts string like "14:30" or "2:30 PM"
    
    private Long courseId;
    private Long teacherId;
    private String location;
    private String color;
    private String recurrence;
    private String recurrenceEnd;
    
    // Add constructor for convenience
    public EventRequest() {}
    
    public EventRequest(String title, String eventType, LocalDate eventDate) {
        this.title = title;
        this.eventType = eventType;
        this.eventDate = eventDate;
    }
    
    // Getters and setters (keep existing)
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getEventType() { return eventType; }
    public void setEventType(String eventType) { this.eventType = eventType; }
    
    public LocalDate getEventDate() { return eventDate; }
    public void setEventDate(LocalDate eventDate) { this.eventDate = eventDate; }
    
    public String getEventTime() { return eventTime; }
    public void setEventTime(String eventTime) { this.eventTime = eventTime; }
    
    public Long getCourseId() { return courseId; }
    public void setCourseId(Long courseId) { this.courseId = courseId; }
    
    public Long getTeacherId() { return teacherId; }
    public void setTeacherId(Long teacherId) { this.teacherId = teacherId; }
    
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    
    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
    
    public String getRecurrence() { return recurrence; }
    public void setRecurrence(String recurrence) { this.recurrence = recurrence; }
    
    public String getRecurrenceEnd() { return recurrenceEnd; }
    public void setRecurrenceEnd(String recurrenceEnd) { this.recurrenceEnd = recurrenceEnd; }
    
    // Helper method to check if event has time
    public boolean hasTime() {
        return eventTime != null && !eventTime.trim().isEmpty();
    }
    
    @Override
    public String toString() {
        return "EventRequest{" +
                "title='" + title + '\'' +
                ", eventType='" + eventType + '\'' +
                ", eventDate=" + eventDate +
                ", eventTime='" + eventTime + '\'' +
                '}';
    }
}