<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="${sessionScope.darkMode ? 'dark' : 'light'}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${pageTitle}" default="Student Portal" /></title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    <!-- Custom CSS -->
    <style>
        /* ===== IMPROVED NAVIGATION ===== */
        :root {
            /* Light Theme Variables */
            --light-bg: #f8f9fa;
            --light-card: #ffffff;
            --light-text: #212529;
            --light-border: #dee2e6;
            --light-primary: #3498db;
            --light-secondary: #6c757d;
            --light-sidebar: #2c3e50;
            --light-sidebar-text: #ffffff;
            --light-success: #27ae60;
            --light-danger: #e74c3c;
        }
        
        [data-bs-theme="dark"] {
            /* Dark Theme Variables */
            --light-bg: #121212;
            --light-card: #1e1e1e;
            --light-text: #e9ecef;
            --light-border: #343a40;
            --light-primary: #3498db;
            --light-secondary: #adb5bd;
            --light-sidebar: #0d1117;
            --light-sidebar-text: #e9ecef;
            --light-success: #27ae60;
            --light-danger: #e74c3c;
        }
        
        body {
            background-color: var(--light-bg);
            color: var(--light-text);
            transition: background-color 0.3s, color 0.3s;
        }
        
        .navbar {
            background: linear-gradient(135deg, var(--light-sidebar), #1a2530) !important;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 12px 0;
        }
        
        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            color: var(--light-sidebar-text) !important;
            transition: all 0.3s ease;
        }
        
        .navbar-brand:hover {
            transform: translateY(-2px);
            color: var(--light-primary) !important;
        }
        
        .nav-link {
            color: rgba(255, 255, 255, 0.85) !important;
            font-weight: 500;
            padding: 10px 18px !important;
            margin: 0 3px;
            border-radius: 6px;
            transition: all 0.3s ease;
            position: relative;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .nav-link:hover {
            color: white !important;
            background: rgba(52, 152, 219, 0.2);
            transform: translateY(-2px);
        }
        
        .nav-link.active {
            background: var(--light-primary) !important;
            color: white !important;
            box-shadow: 0 4px 8px rgba(52, 152, 219, 0.3);
        }
        
        .nav-link.disabled {
            color: #ecf0f1 !important;
            background: transparent !important;
            opacity: 0.9;
        }
        
        .nav-link.disabled:hover {
            transform: none;
            cursor: default;
        }
        
        /* Admin specific styling */
        .nav-link .text-warning {
            color: #ffc107 !important;
            font-weight: 600;
        }
        
        .admin-badge {
            background: linear-gradient(135deg, #ffc107, #ff9800);
            color: #212529 !important;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 700;
            margin-left: 5px;
        }
        
        /* Professional card styling */
        .professional-card {
            border: none !important;
            border-radius: 12px !important;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08) !important;
            margin-bottom: 25px !important;
            background: var(--light-card) !important;
            transition: all 0.3s ease;
            overflow: hidden;
            color: var(--light-text);
        }
        
        .professional-card:hover {
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12) !important;
            transform: translateY(-5px);
        }
        
        .card-header {
            background: linear-gradient(135deg, var(--light-sidebar), var(--light-primary)) !important;
            color: var(--light-sidebar-text) !important;
            border-bottom: none !important;
            border-radius: 12px 12px 0 0 !important;
            padding: 20px 25px !important;
            font-weight: 600;
        }
        
        /* Button Styling */
        .btn-success-custom {
            background: linear-gradient(135deg, var(--light-success), #2ecc71) !important;
            border: none !important;
            color: white !important;
            padding: 12px 28px !important;
            border-radius: 8px !important;
            font-weight: 600 !important;
            transition: all 0.3s ease !important;
            box-shadow: 0 4px 6px rgba(39, 174, 96, 0.2);
        }
        
        .btn-success-custom:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(39, 174, 96, 0.3);
        }
        
        .btn-primary-custom {
            background: linear-gradient(135deg, var(--light-primary), #2980b9) !important;
            border: none !important;
            color: white !important;
            padding: 10px 24px !important;
            border-radius: 8px !important;
            transition: all 0.3s ease !important;
            box-shadow: 0 4px 6px rgba(52, 152, 219, 0.2);
        }
        
        .btn-primary-custom:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(52, 152, 219, 0.3);
            background: linear-gradient(135deg, #2980b9, var(--light-primary)) !important;
        }
        
        .btn-danger-custom {
            background: linear-gradient(135deg, var(--light-danger), #c0392b) !important;
            border: none !important;
            color: white !important;
            padding: 10px 24px !important;
            border-radius: 8px !important;
            transition: all 0.3s ease !important;
            box-shadow: 0 4px 6px rgba(231, 76, 60, 0.2);
        }
        
        .btn-danger-custom:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(231, 76, 60, 0.3);
        }
        
        /* Table Styling */
        .professional-table {
            width: 100% !important;
            border-collapse: separate !important;
            border-spacing: 0 !important;
            border-radius: 10px !important;
            overflow: hidden !important;
            color: var(--light-text) !important;
        }
        
        .professional-table thead {
            background: linear-gradient(135deg, var(--light-bg), #e9ecef) !important;
            color: var(--light-text);
        }
        
        .professional-table th {
            border: none !important;
            padding: 16px 12px !important;
            font-weight: 600 !important;
            color: var(--light-text);
            border-bottom: 2px solid var(--light-border) !important;
        }
        
        .professional-table td {
            padding: 14px 12px !important;
            border-bottom: 1px solid var(--light-border) !important;
            vertical-align: middle !important;
        }
        
        .professional-table tbody tr {
            transition: all 0.2s ease;
        }
        
        .professional-table tbody tr:hover {
            background-color: rgba(52, 152, 219, 0.1) !important;
            transform: scale(1.002);
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
        }
        
        /* Form Styling */
        .form-control-pro {
            background-color: var(--light-card);
            color: var(--light-text);
            border: 1px solid var(--light-border) !important;
            border-radius: 8px !important;
            padding: 12px 16px !important;
            transition: all 0.3s ease !important;
            font-size: 16px;
        }
        
        .form-control-pro:focus {
            background-color: var(--light-card);
            color: var(--light-text);
            border-color: var(--light-primary) !important;
            box-shadow: 0 0 0 0.3rem rgba(52, 152, 219, 0.15) !important;
            transform: translateY(-2px);
        }
        
        /* Badge Styling */
        .course-badge {
            display: inline-block;
            padding: 6px 14px;
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            color: #1565c0;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .course-badge:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 8px rgba(21, 101, 192, 0.2);
        }
        
        /* Footer Styling */
        .professional-footer {
            background: linear-gradient(135deg, var(--light-sidebar), #1a2530) !important;
            color: var(--light-sidebar-text) !important;
            padding: 50px 0 30px !important;
            margin-top: 70px !important;
            position: relative;
        }
        
        .professional-footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--light-primary), var(--light-success));
        }
        
        .professional-footer a {
            color: #bdc3c7 !important;
            text-decoration: none !important;
            transition: all 0.3s ease !important;
        }
        
        .professional-footer a:hover {
            color: white !important;
            padding-left: 5px;
        }
        
        /* Alert Styling */
        .alert-professional {
            border: none !important;
            border-radius: 10px !important;
            padding: 16px 20px !important;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            background-color: var(--light-card);
            color: var(--light-text);
            border: 1px solid var(--light-border);
        }
        
        .alert-success {
            border-color: var(--light-success) !important;
        }
        
        .alert-danger {
            border-color: var(--light-danger) !important;
        }
        
        /* Stats Card */
        .stats-card {
            background: var(--light-card);
            border-radius: 12px;
            padding: 25px 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.06);
            transition: all 0.3s ease;
            text-align: center;
            height: 100%;
            border: 1px solid var(--light-border);
            color: var(--light-text);
        }
        
        .stats-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        .stats-card i {
            margin-bottom: 15px;
            font-size: 2.5rem;
        }
        
        .stats-card h4 {
            font-weight: 700;
            color: var(--light-text);
            margin-bottom: 5px;
        }
        
        /* Avatar Circle */
        .avatar-circle {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--light-primary), #2980b9);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.2rem;
            box-shadow: 0 4px 8px rgba(52, 152, 219, 0.3);
        }
        
        /* Input Group Enhancement */
        .input-group-text {
            background: linear-gradient(135deg, var(--light-bg), #e9ecef) !important;
            border: 1px solid var(--light-border) !important;
            color: var(--light-primary) !important;
            font-weight: 600;
        }
        
        /* Page Container */
        .page-container {
            min-height: calc(100vh - 200px);
            padding-bottom: 50px;
        }
        
        /* Floating Dark Mode Toggle Button - REMOVED FROM HEADER */
        .dark-mode-toggle-btn {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: var(--light-primary);
            color: white;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: all 0.3s;
        }
        
        .dark-mode-toggle-btn:hover {
            transform: scale(1.1);
        }
        
        /* Toast Notification for Dark Mode */
        .dark-mode-toast {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            min-width: 250px;
            display: none;
        }
        
        .toast {
            background-color: var(--light-card);
            color: var(--light-text);
            border: 1px solid var(--light-border);
        }
        
        /* Smooth transitions */
        .professional-card, .navbar, .table, .alert, .form-control, .form-select {
            transition: background-color 0.3s, color 0.3s, border-color 0.3s;
        }
        
        /* Responsive Fixes */
        @media (max-width: 768px) {
            .navbar-nav {
                padding-top: 15px;
            }
            
            .nav-link {
                padding: 12px 15px !important;
                margin: 3px 0;
            }
            
            .professional-card {
                margin: 10px !important;
            }
            
            .container {
                padding-left: 15px !important;
                padding-right: 15px !important;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-graduation-cap me-2"></i> VidyaSetu 
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <!-- DARK MODE TOGGLE REMOVED FROM HERE -->
                    
                    <li class="nav-item">
                        <a class="nav-link ${pageContext.request.requestURI.endsWith('home.jsp') ? 'active' : ''}" href="/">
                            <i class="fas fa-home"></i> Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${pageContext.request.requestURI.contains('courses') || pageContext.request.requestURI.contains('course-details') ? 'active' : ''}" href="/courses">
                            <i class="fas fa-book"></i> Courses
                        </a>
                    </li>
                    
                    <c:choose>
                        <c:when test="${not empty sessionScope.loggedInStudent}">
                            <!-- Check if logged in user is ADMIN -->
                            <c:if test="${sessionScope.loggedInStudent.role == 'ADMIN'}">
                                <li class="nav-item">
                                    <a class="nav-link ${pageContext.request.requestURI.contains('admin') ? 'active' : ''}" href="/admin/dashboard">
                                        <i class="fas fa-user-shield"></i> Admin Panel
                                    </a>
                                </li>
                            </c:if>
                            
                            <c:if test="${sessionScope.loggedInStudent.role != 'ADMIN'}">
                                <li class="nav-item">
                                    <a class="nav-link ${pageContext.request.requestURI.contains('my-courses') ? 'active' : ''}" href="/my-courses">
                                        <i class="fas fa-user-graduate"></i> My Courses
                                    </a>
                                </li>
                            </c:if>
                            
                            <li class="nav-item">
                                <span class="nav-link disabled">
                                    <i class="fas fa-user me-1"></i> 
                                    <c:choose>
                                        <c:when test="${sessionScope.loggedInStudent.role == 'ADMIN'}">
                                            <span class="text-warning">Admin: ${sessionScope.loggedInStudent.fullname}</span>
                                        </c:when>
                                        <c:otherwise>
                                            Welcome, ${sessionScope.loggedInStudent.fullname}
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </li>
                            
                            <li class="nav-item">
                                <c:choose>
                                    <c:when test="${sessionScope.loggedInStudent.role == 'ADMIN'}">
                                        <a class="nav-link" href="/admin/logout">
                                            <i class="fas fa-sign-out-alt"></i> Admin Logout
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="nav-link" href="/logout">
                                            <i class="fas fa-sign-out-alt"></i> Logout
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                        </c:when>
                        
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link ${pageContext.request.requestURI.endsWith('register.jsp') ? 'active' : ''}" href="/register">
                                    <i class="fas fa-user-plus"></i> Register
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link ${pageContext.request.requestURI.endsWith('login.jsp') ? 'active' : ''}" href="/login">
                                    <i class="fas fa-sign-in-alt"></i> Student Login
                                </a>
                            </li>
                            <!-- Add Admin Login Link -->
                            <li class="nav-item">
                                <a class="nav-link ${pageContext.request.requestURI.endsWith('admin-login.jsp') ? 'active' : ''}" href="/admin/login">
                                    <i class="fas fa-user-shield"></i> Admin Login
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
    
    <!-- Add padding for fixed navbar -->
    <div style="padding-top: 76px;"></div>
    
    <!-- Toast Notification for Dark Mode -->
    <div id="darkModeToast" class="dark-mode-toast">
        <div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <i class="fas fa-palette me-2"></i>
                <strong class="me-auto">Theme Changed</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body" id="toastMessage">
                Switched to Dark Mode
            </div>
        </div>
    </div>
    
    <!-- Messages Display -->
    <div class="container mt-3">
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-professional alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i> ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-professional alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i> ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="errorMessage" scope="session"/>
        </c:if>
    </div>
    
    <div class="container page-container">