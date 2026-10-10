package org.jsp.VidyaSetu.dto; // or .entity if you moved it

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "course")
public class Course {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "course_name", nullable = false)
    private String courseName;
    
    @Column(name = "course_code", unique = true, nullable = false)
    private String courseCode;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    
    private String instructor;
    
    private String duration;
    
    @Column(precision = 10, scale = 2)
    private BigDecimal price;
    
    private String category;
    
    @Column(name = "status")
    private String status; // Added status field
    
    // REMOVE this payment relationship
    // @OneToMany(mappedBy = "course", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    // private List<PaymentRecord> payments;

    public Course() {}
    
    public Course(String courseName, String courseCode, String description, 
                  String instructor, String duration, BigDecimal price, String category) {
        this.courseName = courseName;
        this.courseCode = courseCode;
        this.description = description;
        this.instructor = instructor;
        this.duration = duration;
        this.price = price;
        this.category = category;
    }
    
    // Constructor with status parameter
    public Course(String courseName, String courseCode, String description, 
                  String instructor, String duration, BigDecimal price, 
                  String category, String status) {
        this.courseName = courseName;
        this.courseCode = courseCode;
        this.description = description;
        this.instructor = instructor;
        this.duration = duration;
        this.price = price;
        this.category = category;
        this.status = status;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getCourseCode() {
        return courseCode;
    }

    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getInstructor() {
        return instructor;
    }

    public void setInstructor(String instructor) {
        this.instructor = instructor;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    // Status getter and setter
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    // REMOVE payment getters and setters
    // public List<PaymentRecord> getPayments() {
    //     return payments;
    // }
    //
    // public void setPayments(List<PaymentRecord> payments) {
    //     this.payments = payments;
    // }
    
    @Override
    public String toString() {
        return "Course [id=" + id + ", courseName=" + courseName + ", courseCode=" + courseCode 
                + ", instructor=" + instructor + ", duration=" + duration + ", price=" + price 
                + ", category=" + category + ", status=" + status + "]";
    }
}