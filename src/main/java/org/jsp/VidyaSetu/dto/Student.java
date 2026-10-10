package org.jsp.VidyaSetu.dto;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name="student")
public class Student {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column
    private String fullname;
    
    @Column(unique = true)
    private String email;
    
    @Column
    private String password;
    
    @Column
    private String address;
    
    @Column
    private String role = "STUDENT"; // Default role is STUDENT
    
    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "Student [id=" + id + ", fullname=" + fullname + ", email=" + email + ", password=" + password
                + ", address=" + address + ", role=" + role + "]";
    }
}