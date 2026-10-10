package org.jsp.VidyaSetu.service;

import java.util.List;
import java.util.Optional;

import org.jsp.VidyaSetu.dto.Student;
import org.jsp.VidyaSetu.repository.StudentRepo;
import org.jsp.VidyaSetu.util.PasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentService {

    @Autowired
    private StudentRepo sr;
    
    public void registration(Student s) {
        // Encrypt password before saving
        String encryptedPassword = PasswordUtil.encryptPassword(s.getPassword());
        s.setPassword(encryptedPassword);
        sr.save(s);
    }
    
    public List<Student> getallstudents() {
        return sr.findAll();
    }
    
    public void delete(Long id) {
        if(sr.existsById(id)) {
            sr.deleteById(id);
        } else {
            throw new RuntimeException("Id not found");
        }
    }
    
    public Optional<Student> getStudentById(Long id) {
        return sr.findById(id);
    }
    
    public void updateStudent(Student s) {
        // Get existing student to preserve password if not changed
        if (s.getId() != null) {
            Optional<Student> existingStudent = sr.findById(s.getId());
            if (existingStudent.isPresent()) {
                // If password is empty or null, keep the old password
                if (s.getPassword() == null || s.getPassword().trim().isEmpty()) {
                    s.setPassword(existingStudent.get().getPassword());
                } else {
                    // Encrypt new password
                    String encryptedPassword = PasswordUtil.encryptPassword(s.getPassword());
                    s.setPassword(encryptedPassword);
                }
            }
        }
        sr.save(s);
    }
    
    // NEW METHOD: Authenticate student
    public Optional<Student> authenticate(String email, String plainPassword) {
        Optional<Student> studentOptional = sr.findByEmail(email);
        
        if (studentOptional.isPresent()) {
            Student student = studentOptional.get();
            // Check if password matches
            if (PasswordUtil.checkPassword(plainPassword, student.getPassword())) {
                return Optional.of(student);
            }
        }
        return Optional.empty();
    }
    
    // NEW METHOD: Find student by email
    public Optional<Student> findByEmail(String email) {
        return sr.findByEmail(email);
    }
    
    // NEW METHOD: Check if email exists
    public boolean emailExists(String email) {
        return sr.existsByEmail(email);
    }
}