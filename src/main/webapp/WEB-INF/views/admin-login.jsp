<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle" value="Admin Login - VidyaSetu " scope="request"/>
<%@include file="header.jsp" %>

<div class="row justify-content-center">
    <div class="col-md-6 col-lg-5">
        <div class="professional-card">
            <div class="card-header text-center bg-dark text-white">
                <h3><i class="fas fa-user-shield"></i> Admin Login</h3>
            </div>
            <div class="card-body p-5">
                
                <!-- Display error message if login fails -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-professional">
                        <i class="fas fa-exclamation-triangle me-2"></i> ${error}
                    </div>
                </c:if>
                
                <form action="/admin/login" method="post">
                    <div class="mb-4">
                        <label class="form-label fw-bold">Admin Email</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                            <input type="email" name="email" 
                                   placeholder="Enter admin email" 
                                   class="form-control form-control-pro" required>
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label fw-bold">Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            <input type="password" name="password" 
                                   placeholder="Enter admin password" 
                                   class="form-control form-control-pro" required>
                        </div>
                    </div>
                    
                    <div class="d-grid mt-4">
                        <button type="submit" class="btn btn-dark btn-lg">
                            <i class="fas fa-sign-in-alt"></i> Admin Login
                        </button>
                    </div>
                </form>
                
                <div class="text-center mt-4">
                    <p class="mb-2">Student login? <a href="/login" class="fw-bold">Click here</a></p>
                    <p><a href="/" class="text-decoration-none"><i class="fas fa-arrow-left"></i> Back to Home</a></p>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>