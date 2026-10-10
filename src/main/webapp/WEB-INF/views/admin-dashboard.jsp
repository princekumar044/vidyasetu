<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="Admin Dashboard" scope="request"/>

<!DOCTYPE html>
<html lang="en" data-bs-theme="${sessionScope.darkMode ? 'dark' : 'light'}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
            --welcome-bg: linear-gradient(135deg, #3498db, #2980b9);
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
            --welcome-bg: linear-gradient(135deg, #2563eb, #1d4ed8);
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
            transition: background 0.3s ease;
        }
        
        .admin-nav .nav-link {
            color: var(--sidebar-text) !important;
            padding: 15px 20px;
            border-left: 4px solid transparent;
            transition: all 0.3s;
        }
        
        .admin-nav .nav-link:hover,
        .admin-nav .nav-link.active {
            background: rgba(52, 152, 219, 0.2);
            border-left: 4px solid var(--primary-color);
            color: white !important;
        }
        
        /* Stat Cards */
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
        
        .stat-card.total-students {
            background: linear-gradient(135deg, var(--primary-color), #2980b9);
        }
        
        .stat-card.total-courses {
            background: linear-gradient(135deg, var(--success-color), #219653);
        }
        
        .stat-card.active-enrollments {
            background: linear-gradient(135deg, var(--warning-color), #e67e22);
        }
        
        .stat-card.total-revenue {
            background: linear-gradient(135deg, var(--danger-color), #c0392b);
        }
        
        .stat-card i {
            font-size: 2.5rem;
            opacity: 0.8;
        }
        
        .stat-number {
            font-size: 2.2rem;
            font-weight: bold;
            margin: 10px 0;
        }
        
        .stat-label {
            font-size: 0.9rem;
            opacity: 0.9;
        }
        
        /* Quick Action Cards */
        .quick-action-card {
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s;
            background: var(--card-bg);
            margin-bottom: 20px;
            color: var(--text-color);
        }
        
        .quick-action-card:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transform: translateY(-3px);
            border-color: var(--primary-color);
        }
        
        .quick-action-card i {
            font-size: 2rem;
            color: var(--primary-color);
            margin-bottom: 15px;
        }
        
        .quick-action-card h5 {
            color: var(--text-color);
            margin-bottom: 10px;
        }
        
        .quick-action-card p {
            color: var(--muted-text);
            font-size: 0.9rem;
        }
        
        /* Recent Activity */
        .recent-activity {
            background: var(--card-bg);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border: 1px solid var(--border-color);
        }
        
        .activity-item {
            padding: 15px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            align-items: center;
        }
        
        .activity-item:last-child {
            border-bottom: none;
        }
        
        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: white;
        }
        
        .activity-icon.student {
            background: var(--primary-color);
        }
        
        .activity-icon.course {
            background: var(--success-color);
        }
        
        .activity-icon.enrollment {
            background: var(--warning-color);
        }
        
        .activity-icon.payment {
            background: var(--danger-color);
        }
        
        .activity-details h6 {
            margin: 0;
            color: var(--text-color);
        }
        
        .activity-details p {
            margin: 5px 0 0 0;
            color: var(--muted-text);
            font-size: 0.9rem;
        }
        
        .activity-time {
            color: var(--muted-text);
            font-size: 0.8rem;
            margin-left: auto;
        }
        
        /* Charts */
        .chart-container {
            background: var(--card-bg);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border: 1px solid var(--border-color);
        }
        
        .section-title {
            color: var(--text-color);
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 10px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .section-title small {
            color: var(--muted-text);
        }
        
        /* Welcome Card */
        .welcome-card {
            background: var(--welcome-bg);
            color: white;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 30px;
        }
        
        .welcome-card h3 {
            margin-bottom: 10px;
        }
        
        .welcome-card p {
            opacity: 0.9;
            margin-bottom: 0;
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
        
        /* Navbar */
        .navbar {
            background: var(--navbar-bg) !important;
            color: var(--navbar-text);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .navbar-text {
            color: var(--navbar-text) !important;
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
        
        /* Smooth transitions for all elements */
        .card, .navbar, .form-control, .form-select, .table, .modal-content,
        .btn, .alert, .list-group-item {
            transition: background-color 0.3s, color 0.3s, border-color 0.3s;
        }
        
        /* Form elements */
        .form-control, .form-select {
            background-color: var(--card-bg);
            color: var(--text-color);
            border-color: var(--border-color);
        }
        
        .form-control:focus, .form-select:focus {
            background-color: var(--card-bg);
            color: var(--text-color);
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
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
        
        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            color: white;
        }
    </style>
</head>
<body>
    <!-- Admin Header -->
    <nav class="navbar navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="/admin/dashboard">
                <i class="fas fa-user-shield me-2"></i> Admin Panel
            </a>
            <div class="d-flex align-items-center">
                <!-- REMOVED: Dark Mode Toggle from navbar -->
                
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
                    <h5 class="mb-4"><i class="fas fa-tachometer-alt me-2"></i> Dashboard</h5>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active" href="/admin/dashboard">
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

                <!-- Welcome Card -->
                <div class="welcome-card">
                    <h3><i class="fas fa-graduation-cap me-2"></i> Welcome to VidyaSetu - "Where Learning Meets Opportunity"</h3>
                    <p>Hello, ${admin.fullname}! Here's what's happening with your portal today.</p>
                </div>

                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-md-12">
                        <h4 class="section-title">
                            <span><i class="fas fa-chart-line me-2"></i> Dashboard Overview</span>
                            <small class="text-muted">Last updated: Today</small>
                        </h4>
                    </div>
                    
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card total-students">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <div class="stat-number">${totalStudents}</div>
                                    <div class="stat-label">Total Students</div>
                                </div>
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="mt-3">
                                <small><i class="fas fa-arrow-up me-1"></i> 12% increase from last month</small>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card total-courses">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <div class="stat-number">${totalCourses}</div>
                                    <div class="stat-label">Total Courses</div>
                                </div>
                                <i class="fas fa-book"></i>
                            </div>
                            <div class="mt-3">
                                <small><i class="fas fa-arrow-up me-1"></i> 3 new courses this month</small>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card active-enrollments">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <div class="stat-number">${activeEnrollments}</div>
                                    <div class="stat-label">Active Enrollments</div>
                                </div>
                                <i class="fas fa-user-graduate"></i>
                            </div>
                            <div class="mt-3">
                                <small><i class="fas fa-arrow-up me-1"></i> 8% increase from last week</small>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card total-revenue">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <div class="stat-number">₹<fmt:formatNumber value="${totalRevenue}" maxFractionDigits="0"/></div>
                                    <div class="stat-label">Total Revenue</div>
                                </div>
                                <i class="fas fa-rupee-sign"></i>
                            </div>
                            <div class="mt-3">
                                <small><i class="fas fa-arrow-up me-1"></i> 15% increase from last month</small>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts and Quick Actions -->
                <div class="row">
                    <!-- Left Column: Charts -->
                    <div class="col-lg-8">
                        <!-- Enrollment Chart -->
                        <div class="chart-container">
                            <h5 class="section-title">
                                <span><i class="fas fa-chart-bar me-2"></i> Enrollment Trends</span>
                                <small class="text-muted">Last 6 months</small>
                            </h5>
                            <canvas id="enrollmentChart" height="250"></canvas>
                        </div>
                        
                        <!-- Course Popularity Chart -->
                        <div class="chart-container">
                            <h5 class="section-title">
                                <span><i class="fas fa-star me-2"></i> Course Popularity</span>
                                <small class="text-muted">Top 5 courses by enrollment</small>
                            </h5>
                            <canvas id="courseChart" height="250"></canvas>
                        </div>
                    </div>
                    
                    <!-- Right Column: Quick Actions & Recent Activity -->
                    <div class="col-lg-4">
                        <!-- Quick Actions -->
                        <div class="recent-activity">
                            <h5 class="section-title">
                                <span><i class="fas fa-bolt me-2"></i> Quick Actions</span>
                            </h5>
                            <div class="row">
                                <div class="col-6 mb-3">
                                    <a href="/admin/add-course" class="text-decoration-none">
                                        <div class="quick-action-card">
                                            <i class="fas fa-plus-circle"></i>
                                            <h5>Add Course</h5>
                                            <p>Create new course</p>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-6 mb-3">
                                    <a href="/admin/students" class="text-decoration-none">
                                        <div class="quick-action-card">
                                            <i class="fas fa-user-plus"></i>
                                            <h5>Add Student</h5>
                                            <p>Register new student</p>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-6 mb-3">
                                    <a href="/admin/enrollments" class="text-decoration-none">
                                        <div class="quick-action-card">
                                            <i class="fas fa-user-check"></i>
                                            <h5>Manage Enrollments</h5>
                                            <p>View all enrollments</p>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-6 mb-3">
                                    <a href="/admin/calendar" class="text-decoration-none">
                                        <div class="quick-action-card">
                                            <i class="fas fa-calendar-alt"></i>
                                            <h5>Event Calendar</h5>
                                            <p>Manage events</p>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Recent Activity -->
                        <div class="recent-activity mt-4">
                            <h5 class="section-title">
                                <span><i class="fas fa-history me-2"></i> Recent Activity</span>
                                <a href="#" class="btn btn-sm btn-outline-primary">View All</a>
                            </h5>
                            <div id="activityList">
                                <!-- Activity items will be populated here -->
                                <div class="activity-item">
                                    <div class="activity-icon student">
                                        <i class="fas fa-user-plus"></i>
                                    </div>
                                    <div class="activity-details">
                                        <h6>New Student Registered</h6>
                                        <p>John Doe joined the platform</p>
                                    </div>
                                    <div class="activity-time">10 min ago</div>
                                </div>
                                
                                <div class="activity-item">
                                    <div class="activity-icon course">
                                        <i class="fas fa-book"></i>
                                    </div>
                                    <div class="activity-details">
                                        <h6>Course Published</h6>
                                        <p>Web Development Bootcamp is now live</p>
                                    </div>
                                    <div class="activity-time">1 hour ago</div>
                                </div>
                                
                                <div class="activity-item">
                                    <div class="activity-icon enrollment">
                                        <i class="fas fa-user-check"></i>
                                    </div>
                                    <div class="activity-details">
                                        <h6>New Enrollment</h6>
                                        <p>Sarah enrolled in Data Science course</p>
                                    </div>
                                    <div class="activity-time">2 hours ago</div>
                                </div>
                                
                                <div class="activity-item">
                                    <div class="activity-icon payment">
                                        <i class="fas fa-rupee-sign"></i>
                                    </div>
                                    <div class="activity-details">
                                        <h6>Payment Received</h6>
                                        <p>₹4,999 from Michael for Python course</p>
                                    </div>
                                    <div class="activity-time">3 hours ago</div>
                                </div>
                                
                                <div class="activity-item">
                                    <div class="activity-icon student">
                                        <i class="fas fa-user-edit"></i>
                                    </div>
                                    <div class="activity-details">
                                        <h6>Profile Updated</h6>
                                        <p>Student profile information updated</p>
                                    </div>
                                    <div class="activity-time">5 hours ago</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Floating Dark Mode Toggle Button -->
    <button class="dark-mode-toggle" onclick="toggleDarkMode()" title="Toggle Dark Mode">
        <i class="fas ${sessionScope.darkMode ? 'fa-sun' : 'fa-moon'} fa-lg"></i>
    </button>

    <!-- JavaScript Libraries -->
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
            
            // Update charts for dark mode
            updateChartsForDarkMode(newMode);
            
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
                    // Still save to localStorage for fallback
                    localStorage.setItem('darkMode', isDarkMode);
                }
            });
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
                updateChartsForDarkMode(darkMode);
            }
            
            // Initialize charts with correct theme
            initializeCharts(darkMode);
            
            // Listen for system preference changes (only if no user preference saved)
            window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', event => {
                if (!localStorage.getItem('darkMode')) {
                    const newMode = event.matches;
                    document.documentElement.setAttribute('data-bs-theme', newMode ? 'dark' : 'light');
                    updateDarkModeIcons(newMode);
                    updateChartsForDarkMode(newMode);
                }
            });
        });
        
        // Chart Functions
        let enrollmentChart, courseChart;
        
        function initializeCharts(isDarkMode) {
            // Enrollment Chart
            const enrollmentCtx = document.getElementById('enrollmentChart').getContext('2d');
            enrollmentChart = new Chart(enrollmentCtx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                    datasets: [{
                        label: 'Enrollments',
                        data: [65, 78, 90, 85, 110, 135],
                        borderColor: '#3498db',
                        backgroundColor: isDarkMode ? 'rgba(52, 152, 219, 0.2)' : 'rgba(52, 152, 219, 0.1)',
                        borderWidth: 2,
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            labels: {
                                color: isDarkMode ? '#e9ecef' : '#212529'
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: isDarkMode ? 'rgba(255, 255, 255, 0.1)' : 'rgba(0, 0, 0, 0.1)'
                            },
                            ticks: {
                                color: isDarkMode ? '#adb5bd' : '#6c757d'
                            }
                        },
                        x: {
                            grid: {
                                color: isDarkMode ? 'rgba(255, 255, 255, 0.1)' : 'rgba(0, 0, 0, 0.1)'
                            },
                            ticks: {
                                color: isDarkMode ? '#adb5bd' : '#6c757d'
                            }
                        }
                    }
                }
            });
            
            // Course Popularity Chart
            const courseCtx = document.getElementById('courseChart').getContext('2d');
            courseChart = new Chart(courseCtx, {
                type: 'bar',
                data: {
                    labels: ['Web Dev', 'Data Science', 'Python', 'Java', 'Mobile Dev'],
                    datasets: [{
                        label: 'Enrollments',
                        data: [120, 85, 95, 70, 60],
                        backgroundColor: [
                            '#3498db',
                            '#27ae60',
                            '#f39c12',
                            '#e74c3c',
                            '#9b59b6'
                        ],
                        borderColor: [
                            '#2980b9',
                            '#219653',
                            '#e67e22',
                            '#c0392b',
                            '#8e44ad'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: isDarkMode ? 'rgba(255, 255, 255, 0.1)' : 'rgba(0, 0, 0, 0.1)'
                            },
                            ticks: {
                                color: isDarkMode ? '#adb5bd' : '#6c757d'
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            },
                            ticks: {
                                color: isDarkMode ? '#adb5bd' : '#6c757d'
                            }
                        }
                    }
                }
            });
        }
        
        function updateChartsForDarkMode(isDarkMode) {
            if (enrollmentChart) {
                enrollmentChart.options.scales.x.grid.color = isDarkMode ? 'rgba(255, 255, 255, 0.1)' : 'rgba(0, 0, 0, 0.1)';
                enrollmentChart.options.scales.y.grid.color = isDarkMode ? 'rgba(255, 255, 255, 0.1)' : 'rgba(0, 0, 0, 0.1)';
                enrollmentChart.options.scales.x.ticks.color = isDarkMode ? '#adb5bd' : '#6c757d';
                enrollmentChart.options.scales.y.ticks.color = isDarkMode ? '#adb5bd' : '#6c757d';
                enrollmentChart.options.plugins.legend.labels.color = isDarkMode ? '#e9ecef' : '#212529';
                enrollmentChart.data.datasets[0].backgroundColor = isDarkMode ? 
                    'rgba(52, 152, 219, 0.2)' : 'rgba(52, 152, 219, 0.1)';
                enrollmentChart.update();
            }
            
            if (courseChart) {
                courseChart.options.scales.x.ticks.color = isDarkMode ? '#adb5bd' : '#6c757d';
                courseChart.options.scales.y.ticks.color = isDarkMode ? '#adb5bd' : '#6c757d';
                courseChart.options.scales.y.grid.color = isDarkMode ? 'rgba(255, 255, 255, 0.1)' : 'rgba(0, 0, 0, 0.1)';
                courseChart.update();
            }
        }
        
        // Auto-refresh activity every 30 seconds
        function refreshActivity() {
            console.log('Refreshing activity...');
        }
        
        // Set interval for activity refresh (30 seconds)
        setInterval(refreshActivity, 30000);
        
        // Initialize tooltips
        document.addEventListener('DOMContentLoaded', function() {
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });
        });
    </script>
</body>
</html>