<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle" value="Student Register - VidyaSetu " scope="request"/>
<%@include file="header.jsp" %>

<div class="row justify-content-center">
    <div class="col-md-8 col-lg-6">
        <div class="professional-card">
            <div class="card-header text-center">
                <h3><i class="fas fa-user-plus"></i> Student Registration</h3>
            </div>
            <div class="card-body p-5">
                <form action="/saveform" method="post">
                    <div class="row">
                        <div class="col-md-12 mb-4">
                            <label class="form-label fw-bold">Full Name</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                <input type="text" name="fullname" placeholder="Enter your full name" 
                                       class="form-control form-control-pro" required>
                            </div>
                        </div>
                        
                        <div class="col-md-12 mb-4">
                            <label class="form-label fw-bold">Email Address</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                <input type="email" name="email" placeholder="Enter your email" 
                                       class="form-control form-control-pro" required>
                            </div>
                            <small class="form-text text-muted">This will be your login email</small>
                        </div>
                        
                        <div class="col-md-12 mb-4">
                            <label class="form-label fw-bold">Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                <input type="password" name="password" placeholder="Create a password" 
                                       class="form-control form-control-pro" required>
                            </div>
                        </div>
                        
                        <div class="col-md-12 mb-4">
                            <label class="form-label fw-bold">Address</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                                <textarea name="address" placeholder="Enter your address" 
                                          class="form-control form-control-pro" rows="3" required></textarea>
                            </div>
                        </div>
                        
                        <div class="col-md-12 text-center mt-4">
                            <button type="submit" class="btn btn-success-custom btn-lg me-3">
                                <i class="fas fa-user-plus"></i> Register Now
                            </button>
                            <a href="/" class="btn btn-secondary btn-lg">
                                <i class="fas fa-home"></i> Back to Home
                            </a>
                        </div>
                    </div>
                </form>
                
                <div class="text-center mt-5">
                    <p>Already have an account? <a href="/login" class="fw-bold">Login here</a></p>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>