<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="Manage Students - Admin Panel" scope="request"/>

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
        
        .role-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        
        .role-admin {
            background: linear-gradient(135deg, var(--warning-color), #ff9800);
            color: #212529;
        }
        
        .role-student {
            background: linear-gradient(135deg, var(--primary-color), #2980b9);
            color: white;
        }
        
        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
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
        
        /* Stats Cards */
        .stat-card {
            border-radius: 10px;
            padding: 20px;
            color: white;
            margin-bottom: 20px;
            transition: transform 0.3s;
            border: none;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
        }
        
        .stat-card.students {
            background: linear-gradient(135deg, var(--primary-color), #2980b9);
        }
        
        .stat-card.admins {
            background: linear-gradient(135deg, var(--warning-color), #e67e22);
        }
        
        .stat-card.total {
            background: linear-gradient(135deg, var(--success-color), #219653);
        }
        
        /* Avatar */
        .avatar-circle {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--primary-color), #2980b9);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
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
    <!-- Admin Header WITHOUT Dark Mode Toggle -->
    <nav class="navbar navbar-dark" style="background: var(--navbar-bg);">
        <div class="container-fluid">
            <a class="navbar-brand" href="/admin/dashboard">
                <i class="fas fa-user-shield me-2"></i> Admin Panel
            </a>
            <div class="d-flex align-items-center">
                <span class="navbar-text text-light me-3">
                    <i class="fas fa-user me-1"></i> ${admin.fullname}
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
                            <a class="nav-link active" href="/admin/students">
                                <i class="fas fa-users me-2"></i> Students
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/admin/courses">
                                <i class="fas fa-book me-2"></i> Courses
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/admin/enrollments">
                                <i class="fas fa-user-graduate me-2"></i> Enrollments
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/admin/calendar">
                                <i class="fas fa-calendar-alt me-2"></i> Event Calendar
                            </a>
                        </li>
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
                    <c:remove var="successMessage" scope="session"/>
                </c:if>
                
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        <i class="fas fa-exclamation-circle me-2"></i> ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="errorMessage" scope="session"/>
                </c:if>

                <!-- Page Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3><i class="fas fa-users me-2"></i> VidyaSetu </h3>
                    <div>
                        <span class="badge bg-primary fs-6 p-2">
                            <i class="fas fa-user-graduate me-1"></i> Total: ${students.size()} Students
                        </span>
                    </div>
                </div>

                <!-- Students Table -->
                <div class="card">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="mb-0"><i class="fas fa-list me-2"></i> All Students</h5>
                            <a href="/admin/dashboard" class="btn btn-secondary btn-sm">
                                <i class="fas fa-arrow-left me-1"></i> Back to Dashboard
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty students}">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>#</th>
                                            <th>Student</th>
                                            <th>Email</th>
                                            <th>Address</th>
                                            <th>Role</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="student" items="${students}" varStatus="status">
                                            <tr>
                                                <td>${status.index + 1}</td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="avatar-circle me-3">
                                                            ${student.fullname.charAt(0)}
                                                        </div>
                                                        <div>
                                                            <strong>${student.fullname}</strong>
                                                            <div class="text-muted small">ID: ${student.id}</div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>${student.email}</td>
                                                <td class="text-truncate" style="max-width: 200px;">${student.address}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${student.role == 'ADMIN'}">
                                                            <span class="role-badge role-admin">
                                                                <i class="fas fa-user-shield me-1"></i> ADMIN
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="role-badge role-student">
                                                                <i class="fas fa-user-graduate me-1"></i> STUDENT
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <div class="action-buttons">
                                                        <a href="/admin/students/edit/${student.id}" 
                                                           class="btn btn-warning btn-sm">
                                                            <i class="fas fa-edit"></i> Edit
                                                        </a>
                                                        <c:if test="${student.role != 'ADMIN'}">
                                                            <a href="/admin/students/delete/${student.id}" 
                                                               class="btn btn-danger btn-sm"
                                                               onclick="return confirm('Are you sure you want to delete ${student.fullname}?')">
                                                                <i class="fas fa-trash"></i> Delete
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${student.role == 'STUDENT'}">
                                                            <a href="/admin/enrollments?studentId=${student.id}" 
                                                               class="btn btn-info btn-sm">
                                                                <i class="fas fa-book"></i> Enrollments
                                                            </a>
                                                        </c:if>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            
                            <!-- Statistics -->
                            <div class="row mt-4">
                                <div class="col-md-4">
                                    <div class="stat-card students">
                                        <div class="card-body">
                                            <h5 class="card-title">
                                                <i class="fas fa-user-graduate me-2"></i> Students
                                            </h5>
                                            <h2 class="card-text">
                                                ${students.stream().filter(s -> s.role == 'STUDENT').count()}
                                            </h2>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="stat-card admins">
                                        <div class="card-body">
                                            <h5 class="card-title">
                                                <i class="fas fa-user-shield me-2"></i> Admins
                                            </h5>
                                            <h2 class="card-text">
                                                ${students.stream().filter(s -> s.role == 'ADMIN').count()}
                                            </h2>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="stat-card total">
                                        <div class="card-body">
                                            <h5 class="card-title">
                                                <i class="fas fa-users me-2"></i> Total Users
                                            </h5>
                                            <h2 class="card-text">${students.size()}</h2>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        
                        <c:if test="${empty students}">
                            <div class="text-center py-5">
                                <i class="fas fa-users-slash fa-4x text-muted mb-3"></i>
                                <h4 class="text-muted">No Students Found</h4>
                                <p class="text-muted">There are no registered students in the system.</p>
                            </div>
                        </c:if>
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
        // Dark Mode Toggle Function - FIXED: Removed server-side saving
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
            
            // Save to localStorage only (removed server-side saving)
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