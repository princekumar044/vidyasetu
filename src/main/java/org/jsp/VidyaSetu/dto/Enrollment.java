package org.jsp.VidyaSetu.dto;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Entity
@Table(name = "enrollment")
public class Enrollment {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "student_id", nullable = false)
    private Student student;
    
    @ManyToOne
    @JoinColumn(name = "course_id", nullable = false)
    private Course course;
    
    @Column(name = "enrolled_date")
    private LocalDateTime enrolledDate;
    
    @Column
    private String status = "ACTIVE"; 
    
    public Enrollment() {}
    
    public Enrollment(Student student, Course course) {
        this.student = student;
        this.course = course;
        this.enrolledDate = LocalDateTime.now();
        this.status = "ACTIVE";
    }
    
    // Add this helper method for JSP compatibility
    public Date getEnrolledDateAsDate() {
        if (enrolledDate == null) {
            return null;
        }
        return Date.from(enrolledDate.atZone(ZoneId.systemDefault()).toInstant());
    }
    
    // Optionally, add a formatted string method
    public String getFormattedEnrolledDate() {
        if (enrolledDate == null) {
            return "";
        }
        return enrolledDate.toLocalDate().toString(); // Or use a formatter
    }

    // Getters and Setters
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Student getStudent() {
		return student;
	}

	public void setStudent(Student student) {
		this.student = student;
	}

	public Course getCourse() {
		return course;
	}

	public void setCourse(Course course) {
		this.course = course;
	}

	public LocalDateTime getEnrolledDate() {
		return enrolledDate;
	}

	public void setEnrolledDate(LocalDateTime enrolledDate) {
		this.enrolledDate = enrolledDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}