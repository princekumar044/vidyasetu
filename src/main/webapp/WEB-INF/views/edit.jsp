<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle" value="Edit Profile - Student Portal" scope="request"/>
<%@include file="header.jsp" %>

<div class="row justify-content-center">
    <div class="col-md-8 col-lg-6">
        <div class="professional-card">
            <div class="card-header text-center">
                <h3><i class="fas fa-user-edit"></i> Edit Student Profile</h3>
            </div>
            <div class="card-body p-5">
                <form action="/update/${student.id}" method="post">
                    <div class="text-center mb-4">
                        <div class="avatar-circle mx-auto mb-3" 
                             style="width: 80px; height: 80px; background: linear-gradient(135deg, #3498db, #2980b9); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 2rem; font-weight: bold;">
                            ${student.fullname.charAt(0)}
                        </div>
                        <h5>Editing: ${student.fullname}</h5>
                        <p class="text-muted">Student ID: ${student.id}</p>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-12 mb-4">
                            <label class="form-label fw-bold">Full Name</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                <input type="text" name="fullname" value="${student.fullname}" 
                                       class="form-control form-control-pro" required>
                            </div>
                        </div>
                        
                        <div class="col-md-12 mb-4">
                            <label class="form-label fw-bold">Email Address</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                <input type="email" name="email" value="${student.email}" 
                                       class="form-control form-control-pro" required>
                            </div>
                        </div>
                        
                        <div class="col-md-12 mb-4">
                            <label class="form-label fw-bold">Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                <input type="text" name="password" value="${student.password}" 
                                       class="form-control form-control-pro" required>
                            </div>
                        </div>
                        
                        <div class="col-md-12 mb-4">
                            <label class="form-label fw-bold">Address</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                                <textarea name="address" class="form-control form-control-pro" 
                                          rows="3" required>${student.address}</textarea>
                            </div>
                        </div>
                        
                        <div class="col-md-12 text-center mt-4">
                            <button type="submit" class="btn btn-success-custom btn-lg me-3">
                                <i class="fas fa-save"></i> Update Profile
                            </button>
                            <a href="/viewdata" class="btn btn-secondary btn-lg">
                                <i class="fas fa-times"></i> Cancel
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>