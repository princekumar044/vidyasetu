<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="Manage Enrollments - Admin Panel" scope="request"/>

<%-- Calculate statistics safely --%>
<c:set var="totalRevenue" value="0" />
<c:set var="activeCount" value="0" />
<c:set var="completedCount" value="0" />
<c:set var="cancelledCount" value="0" />

<c:if test="${not empty enrollments}">
    <c:forEach var="enrollment" items="${enrollments}">
        <%-- Count by status --%>
        <c:if test="${enrollment.status == 'ACTIVE'}">
            <c:set var="activeCount" value="${activeCount + 1}" />
        </c:if>
        <c:if test="${enrollment.status == 'COMPLETED'}">
            <c:set var="completedCount" value="${completedCount + 1}" />
        </c:if>
        <c:if test="${enrollment.status == 'CANCELLED'}">
            <c:set var="cancelledCount" value="${cancelledCount + 1}" />
        </c:if>
        
        <%-- Calculate total revenue safely --%>
        <c:if test="${enrollment.course != null and enrollment.course.price != null}">
            <c:set var="totalRevenue" value="${totalRevenue + enrollment.course.price}" />
        </c:if>
    </c:forEach>
</c:if>

<!DOCTYPE html>
<html lang="en" data-bs-theme="${sessionScope.darkMode ? 'dark' : 'light'}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        /* CSS VARIABLES FOR DARK/LIGHT MODE */
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --success-color: #27ae60;
            --warning-color: #f39c12;
            --danger-color: #e74c3c;
            --info-color: #1abc9c;
            
            /* Light Theme Variables */
            --bg-color: #f8f9fc;
            --card-bg: #ffffff;
            --text-color: #212529;
            --border-color: #e3e6f0;
            --muted-text: #6c757d;
            --sidebar-bg: linear-gradient(135deg, #2c3e50, #1a2530);
            --sidebar-text: #ecf0f1;
            --navbar-bg: linear-gradient(135deg, #1a2530, #2c3e50);
            --navbar-text: #ffffff;
        }
        
        [data-bs-theme="dark"] {
            /* Dark Theme Variables */
            --bg-color: #121212;
            --card-bg: #1e1e1e;
            --text-color: #e9ecef;
            --border-color: #343a40;
            --muted-text: #adb5bd;
            --sidebar-bg: linear-gradient(135deg, #0d1117, #1a202c);
            --sidebar-text: #e2e8f0;
            --navbar-bg: linear-gradient(135deg, #0d1117, #1a2530);
            --navbar-text: #ffffff;
        }
        
        /* Global Styles */
        body {
            background-color: var(--bg-color);
            color: var(--text-color);
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        
        /* Admin Navigation */
        .admin-nav {
            background: var(--sidebar-bg);
            min-height: 100vh;
            padding: 0;
            color: var(--sidebar-text);
        }
        
        .admin-nav .nav-link {
            color: var(--sidebar-text) !important;
            padding: 15px 20px;
            border-left: 4px solid transparent;
            transition: all 0.3s;
        }
        
        .admin-nav .nav-link:hover {
            background: rgba(52, 152, 219, 0.2);
            border-left: 4px solid var(--primary-color);
            color: white !important;
        }
        
        .admin-nav .nav-link.active {
            background: rgba(52, 152, 219, 0.3);
            border-left: 4px solid var(--primary-color);
            color: white !important;
        }
        
        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        
        .status-active {
            background: linear-gradient(135deg, var(--success-color), #2ecc71);
            color: white;
        }
        
        .status-completed {
            background: linear-gradient(135deg, var(--primary-color), #2980b9);
            color: white;
        }
        
        .status-cancelled {
            background: linear-gradient(135deg, var(--danger-color), #c0392b);
            color: white;
        }
        
        .stats-card {
            border-radius: 10px;
            padding: 15px;
            color: white;
            margin-bottom: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        
        .stats-card:hover {
            transform: translateY(-3px);
        }
        
        .stats-1 { 
            background: linear-gradient(135deg, var(--primary-color), #2980b9); 
        }
        .stats-2 { 
            background: linear-gradient(135deg, var(--success-color), #27ae60); 
        }
        .stats-3 { 
            background: linear-gradient(135deg, #9b59b6, #8e44ad); 
        }
        .stats-4 { 
            background: linear-gradient(135deg, var(--danger-color), #c0392b); 
        }
        
        .filter-badge {
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .filter-badge:hover {
            transform: scale(1.05);
        }
        
        .filter-badge.active {
            transform: scale(1.1);
            box-shadow: 0 0 0 2px var(--primary-color);
        }
        
        /* Table Styles */
        .table {
            color: var(--text-color);
        }
        
        .table-dark {
            background: var(--secondary-color) !important;
        }
        
        .table-hover tbody tr:hover {
            background-color: rgba(52, 152, 219, 0.1);
        }
        
        /* Card Styles */
        .card {
            background-color: var(--card-bg);
            border-color: var(--border-color);
            color: var(--text-color);
        }
        
        .card-header {
            background-color: var(--card-bg);
            border-bottom-color: var(--border-color);
            color: var(--text-color);
        }
        
        /* Avatar */
        .avatar-circle {
            width: 32px;
            height: 32px;
            background: linear-gradient(135deg, var(--primary-color), #2980b9);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 0.9rem;
            flex-shrink: 0;
        }
        
        /* Dark Mode Toggle Components */
        .dark-mode-toggle {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: var(--primary-color);
            color: white;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: all 0.3s;
        }
        
        .dark-mode-toggle:hover {
            transform: scale(1.1);
        }
        
        /* Toast Notification */
        .dark-mode-toast {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            min-width: 250px;
            display: none;
        }
        
        .toast {
            background-color: var(--card-bg);
            color: var(--text-color);
            border: 1px solid var(--border-color);
        }
        
        /* Alerts */
        .alert {
            background-color: var(--card-bg);
            color: var(--text-color);
            border: 1px solid var(--border-color);
        }
        
        .alert-success {
            border-color: var(--success-color);
        }
        
        .alert-danger {
            border-color: var(--danger-color);
        }
        
        /* Buttons */
        .btn-outline-light {
            color: var(--navbar-text);
            border-color: var(--navbar-text);
        }
        
        .btn-outline-light:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
        }
        
        /* Smooth transitions */
        .card, .navbar, .table, .alert, .form-control, .form-select {
            transition: background-color 0.3s, color 0.3s, border-color 0.3s;
        }
    </style>
</head>
<body>
    <!-- Admin Header -->
    <nav class="navbar navbar-dark" style="background: var(--navbar-bg);">
        <div class="container-fluid">
            <a class="navbar-brand" href="/admin/dashboard">
                <i class="fas fa-user-shield me-2"></i> Admin Panel
            </a>
            <div class="d-flex align-items-center">
                <!-- REMOVED: Dark Mode Toggle from navbar -->
                
                <span class="navbar-text text-light me-3">
                    <i class="fas fa-user me-1"></i> 
                    <c:if test="${not empty admin}">${admin.fullname}</c:if>
                    <c:if test="${empty admin}">Admin</c:if>
                </span>
                <a href="/admin/logout" class="btn btn-outline-light btn-sm">
                    <i class="fas fa-sign-out-alt me-1"></i> Logout
                </a>
            </div>
        </div>
    </nav>

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

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar Navigation -->
            <div class="col-md-3 col-lg-2 px-0 admin-nav">
                <div class="p-3">
                    <h5 class="text-light mb-4"><i class="fas fa-tachometer-alt me-2"></i> Dashboard</h5>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="/admin/dashboard">
                                <i class="fas fa-chart-bar me-2"></i> Overview
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/admin/students">
                                <i class="fas fa-users me-2"></i> Students
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/admin/courses">
                                <i class="fas fa-book me-2"></i> Courses
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="/admin/enrollments">
                                <i class="fas fa-user-graduate me-2"></i> Enrollments
                            </a>
                        </li>
                        <!-- CALENDAR MENU ITEM ADDED HERE -->
                        <li class="nav-item">
                            <a class="nav-link" href="/admin/calendar">
                                <i class="fas fa-calendar-alt me-2"></i> Event Calendar
                            </a>
                        </li>
                        <!-- END CALENDAR MENU ITEM -->
                        <li class="nav-item">
                            <a class="nav-link" href="/admin/add-course">
                                <i class="fas fa-plus-circle me-2"></i> Add Course
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/">
                                <i class="fas fa-external-link-alt me-2"></i> View Site
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 p-4">
                <!-- Messages -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show">
                        <i class="fas fa-check-circle me-2"></i> ${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        <i class="fas fa-exclamation-circle me-2"></i> ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Page Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3><i class="fas fa-user-graduate me-2"></i> Enrollment Management</h3>
                    <div>
                        <span class="badge bg-primary fs-6 p-2">
                            <i class="fas fa-list-alt me-1"></i> 
                            Total: <c:out value="${enrollments != null ? enrollments.size() : 0}"/> Enrollments
                        </span>
                    </div>
                </div>

                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="stats-card stats-1">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">Total</h5>
                                    <h2 class="mb-0">
                                        <c:out value="${enrollments != null ? enrollments.size() : 0}"/>
                                    </h2>
                                </div>
                                <i class="fas fa-graduation-cap fa-2x opacity-75"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card stats-2">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">Active</h5>
                                    <h2 class="mb-0">${activeCount}</h2>
                                </div>
                                <i class="fas fa-check-circle fa-2x opacity-75"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card stats-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">Revenue</h5>
                                    <h4 class="mb-0">
                                        ₹<fmt:formatNumber value="${totalRevenue}" maxFractionDigits="0"/>
                                    </h4>
                                </div>
                                <i class="fas fa-rupee-sign fa-2x opacity-75"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card stats-4">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">Status</h5>
                                    <h4 class="mb-0">
                                        <c:choose>
                                            <c:when test="${enrollments != null and enrollments.size() > 0}">
                                                ${activeCount} Active
                                            </c:when>
                                            <c:otherwise>0 Active</c:otherwise>
                                        </c:choose>
                                    </h4>
                                </div>
                                <i class="fas fa-chart-line fa-2x opacity-75"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Enrollment Table -->
                <div class="card">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="mb-0"><i class="fas fa-list me-2"></i> All Enrollments</h5>
                            <div>
                                <a href="/admin/dashboard" class="btn btn-secondary btn-sm">
                                    <i class="fas fa-arrow-left me-1"></i> Dashboard
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty enrollments}">
                                <!-- Filter Badges -->
                                <div class="mb-3">
                                    <span class="badge bg-secondary filter-badge me-2 mb-2" onclick="filterTable('all')">
                                        All (${enrollments.size()})
                                    </span>
                                    <span class="badge bg-success filter-badge me-2 mb-2" onclick="filterTable('ACTIVE')">
                                        Active (${activeCount})
                                    </span>
                                    <span class="badge bg-info filter-badge me-2 mb-2" onclick="filterTable('COMPLETED')">
                                        Completed (${completedCount})
                                    </span>
                                    <span class="badge bg-danger filter-badge me-2 mb-2" onclick="filterTable('CANCELLED')">
                                        Cancelled (${cancelledCount})
                                    </span>
                                </div>
                                
                                <div class="table-responsive">
                                    <table class="table table-hover" id="enrollmentsTable">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>#</th>
                                                <th>Student</th>
                                                <th>Course</th>
                                                <th>Enrollment Date</th>
                                                <th>Price</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="enrollment" items="${enrollments}" varStatus="status">
                                                <tr class="enrollment-row" data-status="${enrollment.status}">
                                                    <td>${status.index + 1}</td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <div class="avatar-circle me-2">
                                                                <c:choose>
                                                                    <c:when test="${not empty enrollment.student and not empty enrollment.student.fullname}">
                                                                        ${enrollment.student.fullname.charAt(0)}
                                                                    </c:when>
                                                                    <c:otherwise>S</c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <div>
                                                                <strong>
                                                                    <c:choose>
                                                                        <c:when test="${not empty enrollment.student and not empty enrollment.student.fullname}">
                                                                            ${enrollment.student.fullname}
                                                                        </c:when>
                                                                        <c:otherwise>Unknown Student</c:otherwise>
                                                                    </c:choose>
                                                                </strong>
                                                                <div class="text-muted small">
                                                                    <c:choose>
                                                                        <c:when test="${not empty enrollment.student and not empty enrollment.student.email}">
                                                                            ${enrollment.student.email}
                                                                        </c:when>
                                                                        <c:otherwise>No email</c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <strong>
                                                            <c:choose>
                                                                <c:when test="${not empty enrollment.course and not empty enrollment.course.courseName}">
                                                                    ${enrollment.course.courseName}
                                                                </c:when>
                                                                <c:otherwise>Unknown Course</c:otherwise>
                                                            </c:choose>
                                                        </strong>
                                                        <div class="text-muted small">
                                                            <c:choose>
                                                                <c:when test="${not empty enrollment.course}">
                                                                    ${enrollment.course.courseCode} | ${enrollment.course.category}
                                                                </c:when>
                                                                <c:otherwise>No details</c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty enrollment.enrolledDate}">
                                                                ${enrollment.enrolledDate}
                                                            </c:when>
                                                            <c:otherwise>
                                                                Not Available
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="fw-bold text-success">
                                                        <c:choose>
                                                            <c:when test="${not empty enrollment.course and not empty enrollment.course.price}">
                                                                ₹${enrollment.course.price}
                                                            </c:when>
                                                            <c:otherwise>
                                                                ₹0
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${enrollment.status == 'ACTIVE'}">
                                                                <span class="status-badge status-active">
                                                                    <i class="fas fa-play-circle me-1"></i> ACTIVE
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${enrollment.status == 'COMPLETED'}">
                                                                <span class="status-badge status-completed">
                                                                    <i class="fas fa-check-circle me-1"></i> COMPLETED
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${enrollment.status == 'CANCELLED'}">
                                                                <span class="status-badge status-cancelled">
                                                                    <i class="fas fa-times-circle me-1"></i> CANCELLED
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-secondary">${enrollment.status}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="fas fa-user-graduate fa-4x text-muted mb-3"></i>
                                    <h4 class="text-muted">No Enrollments Found</h4>
                                    <p class="text-muted">There are no course enrollments in the system yet.</p>
                                    <a href="/admin/courses" class="btn btn-primary">
                                        <i class="fas fa-book me-2"></i> View Courses
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Floating Dark Mode Toggle Button -->
    <button class="dark-mode-toggle" onclick="toggleDarkMode()" title="Toggle Dark Mode">
        <i class="fas ${sessionScope.darkMode ? 'fa-sun' : 'fa-moon'} fa-lg"></i>
    </button>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // Dark Mode Toggle Function
        function toggleDarkMode() {
            const htmlElement = document.documentElement;
            const isDarkMode = htmlElement.getAttribute('data-bs-theme') === 'dark';
            const newMode = !isDarkMode;
            
            // Update HTML attribute
            htmlElement.setAttribute('data-bs-theme', newMode ? 'dark' : 'light');
            
            // Update icons
            updateDarkModeIcons(newMode);
            
            // Show toast notification
            showDarkModeToast(newMode ? 'Dark' : 'Light');
            
            // Save preference to server
            saveDarkModePreference(newMode);
            
            // Save to localStorage
            localStorage.setItem('darkMode', newMode);
        }
        
        function updateDarkModeIcons(isDarkMode) {
            const icons = document.querySelectorAll('.fa-moon, .fa-sun');
            icons.forEach(icon => {
                if (isDarkMode) {
                    icon.classList.remove('fa-moon');
                    icon.classList.add('fa-sun');
                } else {
                    icon.classList.remove('fa-sun');
                    icon.classList.add('fa-moon');
                }
            });
        }
        
        function showDarkModeToast(mode) {
            const toastElement = document.getElementById('darkModeToast');
            const toastMessage = document.getElementById('toastMessage');
            
            toastMessage.textContent = `Switched to ${mode} Mode`;
            toastElement.style.display = 'block';
            
            // Initialize Bootstrap toast
            const toast = new bootstrap.Toast(toastElement.querySelector('.toast'), {
                autohide: true,
                delay: 3000
            });
            toast.show();
            
            // Hide after animation
            setTimeout(() => {
                toastElement.style.display = 'none';
            }, 3500);
        }
        
        function saveDarkModePreference(isDarkMode) {
            $.ajax({
                url: '/api/settings/dark-mode',
                type: 'POST',
                data: { 
                    darkMode: isDarkMode
                },
                success: function(response) {
                    console.log('Dark mode preference saved:', isDarkMode);
                },
                error: function(xhr, status, error) {
                    console.error('Failed to save dark mode preference:', error);
                    localStorage.setItem('darkMode', isDarkMode);
                }
            });
        }
        
        // Filter table by status
        function filterTable(status) {
            const rows = document.querySelectorAll('.enrollment-row');
            rows.forEach(row => {
                if (status === 'all' || row.getAttribute('data-status') === status) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
            
            // Update active filter badge
            document.querySelectorAll('.filter-badge').forEach(badge => {
                badge.classList.remove('active');
            });
            if (event && event.target) {
                event.target.classList.add('active');
            }
        }
        
        // Initialize dark mode on page load
        document.addEventListener('DOMContentLoaded', function() {
            // Check localStorage first
            const savedMode = localStorage.getItem('darkMode');
            const sessionMode = ${sessionScope.darkMode ? 'true' : 'false'};
            
            let darkMode = false;
            
            if (savedMode !== null) {
                darkMode = savedMode === 'true';
            } else if (sessionMode) {
                darkMode = sessionMode;
            } else {
                // Check system preference
                const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
                darkMode = prefersDark;
            }
            
            // Apply mode if different from current
            const currentMode = document.documentElement.getAttribute('data-bs-theme') === 'dark';
            if (darkMode !== currentMode) {
                document.documentElement.setAttribute('data-bs-theme', darkMode ? 'dark' : 'light');
                updateDarkModeIcons(darkMode);
            }
            
            // Make filter badges clickable
            document.querySelectorAll('.filter-badge').forEach(badge => {
                badge.style.cursor = 'pointer';
            });
            
            // Listen for system preference changes (only if no user preference saved)
            window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', event => {
                if (!localStorage.getItem('darkMode')) {
                    const newMode = event.matches;
                    document.documentElement.setAttribute('data-bs-theme', newMode ? 'dark' : 'light');
                    updateDarkModeIcons(newMode);
                }
            });
        });
    </script>
</body>
</html>