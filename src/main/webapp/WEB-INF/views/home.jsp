<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle" value="Home - VidyaSetu " scope="request"/>
<%@include file="header.jsp"%>

<!-- Hero Section -->
<div class="professional-card">
    <div class="card-header text-center">
        <h2><i class="fas fa-university"></i> Welcome to VidyaSetu - "Where Learning Meets Opportunity"</h2>
    </div>
    <div class="card-body p-5 text-center">
        <h3 class="mb-4">Streamlined VidyaSetu</h3>
        <p class="lead mb-4">Manage student records efficiently with our professional portal</p>
        
        <div class="row mt-5">
            <div class="col-md-4 mb-4">
                <div class="professional-card h-100">
                    <div class="card-body text-center p-4">
                        <i class="fas fa-user-plus fa-3x mb-3" style="color: #3498db;"></i>
                        <h4>Easy Registration</h4>
                        <p>Quick and simple student registration process</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="professional-card h-100">
                    <div class="card-body text-center p-4">
                        <i class="fas fa-database fa-3x mb-3" style="color: #27ae60;"></i>
                        <h4>Data Management</h4>
                        <p>Efficiently manage and view all student records</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="professional-card h-100">
                    <div class="card-body text-center p-4">
                        <i class="fas fa-shield-alt fa-3x mb-3" style="color: #e74c3c;"></i>
                        <h4>Secure Access</h4>
                        <p>Protected login system for authorized users</p>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="mt-4">
            <c:if test="${empty sessionScope.loggedInStudent}">
                <a href="/register" class="btn btn-success-custom btn-lg me-3">
                    <i class="fas fa-user-plus"></i> Get Started
                </a>
                <a href="/login" class="btn btn-primary-custom btn-lg">
                    <i class="fas fa-sign-in-alt"></i> Login
                </a>
            </c:if>
            <c:if test="${not empty sessionScope.loggedInStudent}">
                <a href="/viewdata" class="btn btn-primary-custom btn-lg me-3">
                    <i class="fas fa-users"></i> View Students
                </a>
                <a href="/courses" class="btn btn-success-custom btn-lg me-3">
                    <i class="fas fa-book"></i> Browse Courses
                </a>
                <a href="/logout" class="btn btn-danger-custom btn-lg">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </c:if>
        </div>
    </div>
</div>

<%@include file="footer.jsp"%>