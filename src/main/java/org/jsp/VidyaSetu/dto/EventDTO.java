package org.jsp.VidyaSetu.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class EventDTO {
    private Long id;
    private String title;
    private String start;
    private String end;
    private String description;
    private String color;
    private String eventType;
    private String courseName;
    private String location;
    private String eventTime;
    private String recurrence;
    private String teacherName;
    private String courseCode;
    
    @JsonProperty("allDay")
    private Boolean allDay = false;
    
    private String backgroundColor;
    private String borderColor;
    private String textColor = "#ffffff";
    
    // Add extendedProps for FullCalendar
    private Map<String, Object> extendedProps;
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getStart() {
        return start;
    }
    
    public void setStart(String start) {
        this.start = start;
    }
    
    public String getEnd() {
        return end;
    }
    
    public void setEnd(String end) {
        this.end = end;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getColor() {
        return color;
    }
    
    public void setColor(String color) {
        this.color = color;
        // Also set background and border colors for FullCalendar
        if (color != null) {
            this.backgroundColor = color;
            this.borderColor = color;
        }
    }
    
    public String getEventType() {
        return eventType;
    }
    
    public void setEventType(String eventType) {
        this.eventType = eventType;
    }
    
    public String getCourseName() {
        return courseName;
    }
    
    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }
    
    public String getLocation() {
        return location;
    }
    
    public void setLocation(String location) {
        this.location = location;
    }
    
    public String getEventTime() {
        return eventTime;
    }
    
    public void setEventTime(String eventTime) {
        this.eventTime = eventTime;
    }
    
    // Helper method to set eventTime from LocalTime
    public void setEventTime(LocalTime time) {
        if (time != null) {
            this.eventTime = time.format(DateTimeFormatter.ofPattern("hh:mm a"));
        }
    }
    
    public String getRecurrence() {
        return recurrence;
    }
    
    public void setRecurrence(String recurrence) {
        this.recurrence = recurrence;
    }
    
    public String getTeacherName() {
        return teacherName;
    }
    
    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }
    
    public String getCourseCode() {
        return courseCode;
    }
    
    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }
    
    public Boolean getAllDay() {
        return allDay;
    }
    
    public void setAllDay(Boolean allDay) {
        this.allDay = allDay;
    }
    
    public void setAllDay(boolean allDay) {
        this.allDay = allDay;
    }
    
    public String getBackgroundColor() {
        return backgroundColor != null ? backgroundColor : color;
    }
    
    public void setBackgroundColor(String backgroundColor) {
        this.backgroundColor = backgroundColor;
    }
    
    public String getBorderColor() {
        return borderColor != null ? borderColor : color;
    }
    
    public void setBorderColor(String borderColor) {
        this.borderColor = borderColor;
    }
    
    public String getTextColor() {
        return textColor;
    }
    
    public void setTextColor(String textColor) {
        this.textColor = textColor;
    }
    
    public Map<String, Object> getExtendedProps() {
        return extendedProps;
    }
    
    public void setExtendedProps(Map<String, Object> extendedProps) {
        this.extendedProps = extendedProps;
    }
    
    // Additional helper methods for FullCalendar
    public boolean isAllDay() {
        return Boolean.TRUE.equals(allDay);
    }
    
    // Method to create proper FullCalendar event object
    public String toFullCalendarJson() {
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"id\":").append(id).append(",");
        json.append("\"title\":\"").append(escapeJson(title)).append("\",");
        json.append("\"start\":\"").append(start).append("\",");
        
        if (end != null) {
            json.append("\"end\":\"").append(end).append("\",");
        }
        
        if (allDay != null) {
            json.append("\"allDay\":").append(allDay).append(",");
        }
        
        json.append("\"color\":\"").append(color).append("\",");
        json.append("\"backgroundColor\":\"").append(getBackgroundColor()).append("\",");
        json.append("\"borderColor\":\"").append(getBorderColor()).append("\",");
        json.append("\"textColor\":\"").append(textColor).append("\",");
        json.append("\"extendedProps\":{");
        json.append("\"description\":\"").append(escapeJson(description)).append("\",");
        json.append("\"eventType\":\"").append(eventType).append("\",");
        json.append("\"location\":\"").append(escapeJson(location)).append("\",");
        json.append("\"eventTime\":\"").append(eventTime).append("\",");
        json.append("\"recurrence\":\"").append(recurrence != null ? recurrence : "").append("\",");
        json.append("\"courseName\":\"").append(escapeJson(courseName)).append("\",");
        json.append("\"courseCode\":\"").append(escapeJson(courseCode)).append("\",");
        json.append("\"teacherName\":\"").append(escapeJson(teacherName)).append("\"");
        json.append("}");
        json.append("}");
        
        return json.toString();
    }
    
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
    
    @Override
    public String toString() {
        return "EventDTO{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", start='" + start + '\'' +
                ", end='" + end + '\'' +
                ", eventType='" + eventType + '\'' +
                ", color='" + color + '\'' +
                '}';
    }
}