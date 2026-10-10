package org.jsp.VidyaSetu.service;

import org.jsp.VidyaSetu.dto.Admin;
import org.jsp.VidyaSetu.repository.AdminRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService {
    
    @Autowired
    private AdminRepo adminRepository;
    
    public Admin findByEmail(String email) {
        return adminRepository.findByEmail(email);
    }
    
    public void save(Admin admin) {
        adminRepository.save(admin);
    }
    
    public long getTotalAdmins() {
        return adminRepository.count();
    }
}