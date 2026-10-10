package org.jsp.VidyaSetu.repository;

import org.jsp.VidyaSetu.dto.Admin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AdminRepo extends JpaRepository<Admin, Long> {
    Admin findByEmail(String email);  // This should be defined
}