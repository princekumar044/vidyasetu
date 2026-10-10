<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="${sessionScope.darkMode ? 'dark' : 'light'}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Event Calendar</title>
    
    <!-- FullCalendar CSS -->
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css" rel="stylesheet">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    <!-- Custom Styles -->
    <style>
        /* CSS VARIABLES FOR DARK/LIGHT MODE - MATCHING ENROLLMENTS PAGE */
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
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        
        /* Admin Navigation - EXACT MATCH FROM ENROLLMENTS PAGE */
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
        
        /* Card Styles */
        .card {
            background-color: var(--card-bg);
            border-color: var(--border-color);
            color: var(--text-color);
            border-radius: 10px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            margin-bottom: 20px;
            transition: background-color 0.3s, color 0.3s, border-color 0.3s;
        }
        
        .card-header {
            background-color: var(--card-bg);
            border-bottom-color: var(--border-color);
            color: var(--text-color);
            font-weight: 700;
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
        
        /* Calendar Container */
        #calendar {
            background-color: var(--card-bg);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            color: var(--text-color);
            min-height: 500px;
        }
        
        [data-bs-theme="dark"] #calendar {
            box-shadow: 0 0.15rem 1.75rem 0 rgba(0, 0, 0, 0.3);
        }
        
        /* Event Type Badges */
        .event-type-badge {
            display: inline-block;
            padding: 0.25em 0.6em;
            font-size: 75%;
            font-weight: 700;
            border-radius: 10rem;
            margin-right: 5px;
        }
        
        .class-badge { background-color: #4e73df; color: white; }
        .exam-badge { background-color: #e74a3b; color: white; }
        .holiday-badge { background-color: #1cc88a; color: white; }
        .meeting-badge { background-color: #f6c23e; color: white; }
        .workshop-badge { background-color: #6f42c1; color: white; }
        .deadline-badge { background-color: #fd7e14; color: white; }
        .other-badge { background-color: #858796; color: white; }
        
        /* Stats Cards */
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
            background: linear-gradient(135deg, #4e73df, #2e59d9); 
        }
        .stats-2 { 
            background: linear-gradient(135deg, #e74a3b, #d52a1e); 
        }
        .stats-3 { 
            background: linear-gradient(135deg, #1cc88a, #17a673); 
        }
        .stats-4 { 
            background: linear-gradient(135deg, #f6c23e, #f4b619); 
        }
        .stats-5 { 
            background: linear-gradient(135deg, #6f42c1, #59339c); 
        }
        .stats-6 { 
            background: linear-gradient(135deg, #fd7e14, #e96b00); 
        }
        .stats-7 { 
            background: linear-gradient(135deg, #858796, #6c6e7e); 
        }
        
        /* Buttons */
        .btn-add-event {
            background: linear-gradient(135deg, var(--primary-color), #2980b9);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-add-event:hover {
            background: linear-gradient(135deg, #2980b9, var(--primary-color));
            color: white;
            transform: translateY(-2px);
        }
        
        /* Modal Styles */
        .modal-content {
            background-color: var(--card-bg);
            color: var(--text-color);
        }
        
        .modal-header {
            background: linear-gradient(135deg, var(--primary-color), #2980b9);
            color: white;
        }
        
        .modal-body {
            background-color: var(--card-bg);
        }
        
        .modal-footer {
            background-color: var(--card-bg);
            border-top: 1px solid var(--border-color);
        }
        
        /* Form Controls */
        .form-control, .form-select {
            background-color: var(--card-bg);
            color: var(--text-color);
            border: 1px solid var(--border-color);
            transition: background-color 0.3s, color 0.3s, border-color 0.3s;
        }
        
        .form-control:focus, .form-select:focus {
            background-color: var(--card-bg);
            color: var(--text-color);
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
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
        
        /* Upcoming Events */
        .upcoming-events {
            max-height: 300px;
            overflow-y: auto;
        }
        
        .upcoming-event-item {
            padding: 10px;
            border-left: 3px solid var(--primary-color);
            background: rgba(52, 152, 219, 0.05);
            margin-bottom: 8px;
            border-radius: 3px;
            transition: background-color 0.3s;
        }
        
        [data-bs-theme="dark"] .upcoming-event-item {
            background: rgba(52, 152, 219, 0.1);
        }
        
        .upcoming-event-item:hover {
            background: rgba(52, 152, 219, 0.1);
        }
        
        /* Event Time */
        .event-time {
            font-size: 0.8rem;
            color: var(--muted-text);
        }
        
        /* Loading Spinner */
        .spinner-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 9999;
            justify-content: center;
            align-items: center;
        }
        
        .spinner {
            width: 50px;
            height: 50px;
            border: 5px solid #f3f3f3;
            border-top: 5px solid var(--primary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        /* Dark Mode Toggle Button */
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
        
        /* Today highlight */
        .fc-day-today {
            background-color: rgba(52, 152, 219, 0.1) !important;
        }
        
        /* Quick Stats */
        .quick-stats {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .stat-card {
            flex: 1;
            min-width: 200px;
            background: var(--card-bg);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            text-align: center;
            color: var(--text-color);
            border-left: 4px solid var(--primary-color);
        }
        
        [data-bs-theme="dark"] .stat-card {
            box-shadow: 0 0.15rem 1.75rem 0 rgba(0, 0, 0, 0.3);
        }
        
        .stat-card i {
            font-size: 2rem;
            margin-bottom: 10px;
            color: var(--primary-color);
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            display: block;
            color: var(--text-color);
        }
        
        .stat-label {
            color: var(--muted-text);
            font-size: 0.9rem;
        }
        
        /* FullCalendar Dark Mode */
        [data-bs-theme="dark"] .fc {
            background-color: var(--card-bg);
            color: var(--text-color);
        }
        
        [data-bs-theme="dark"] .fc-theme-standard td,
        [data-bs-theme="dark"] .fc-theme-standard th {
            border-color: rgba(255, 255, 255, 0.2);
        }
        
        [data-bs-theme="dark"] .fc-col-header-cell {
            background-color: rgba(0, 0, 0, 0.1);
            color: var(--text-color);
        }
        
        [data-bs-theme="dark"] .fc-daygrid-day {
            background-color: var(--card-bg);
        }
        
        [data-bs-theme="dark"] .fc-daygrid-day.fc-day-today {
            background-color: rgba(52, 152, 219, 0.2) !important;
        }
        
        [data-bs-theme="dark"] .fc-button {
            background-color: #444 !important;
            border-color: #555 !important;
            color: #fff !important;
        }
        
        [data-bs-theme="dark"] .fc-button:hover {
            background-color: #555 !important;
            border-color: #666 !important;
        }
        
        [data-bs-theme="dark"] .fc-button-primary {
            background-color: var(--primary-color) !important;
            border-color: var(--primary-color) !important;
        }
        
        [data-bs-theme="dark"] .fc-button-primary:hover {
            background-color: #2980b9 !important;
            border-color: #2980b9 !important;
        }
        
        /* ===== RESPONSIVE STYLES ===== */
        
        @media (max-width: 768px) {
            .admin-nav {
                min-height: auto;
                max-height: 60px;
                overflow: hidden;
                transition: max-height 0.3s ease;
            }
            
            .admin-nav.expanded {
                max-height: 1000px;
            }
            
            .main-content {
                padding: 15px;
            }
            
            .quick-stats {
                flex-direction: column;
            }
            
            .stat-card {
                min-width: 100%;
            }
            
            #calendar {
                padding: 15px;
                min-height: 400px;
            }
            
            .fc-toolbar {
                flex-direction: column;
                gap: 10px;
            }
            
            .fc-toolbar .fc-left,
            .fc-toolbar .fc-center,
            .fc-toolbar .fc-right {
                width: 100%;
                text-align: center;
                margin-bottom: 10px;
            }
            
            .stats-card {
                margin-bottom: 10px;
            }
        }
        
        @media (max-width: 576px) {
            .stat-number {
                font-size: 1.5rem;
            }
            
            .stat-card i {
                font-size: 1.5rem;
            }
            
            .btn-add-event {
                padding: 8px 16px;
                font-size: 0.9rem;
            }
            
            .form-control, .form-select {
                font-size: 16px;
                padding: 12px;
            }
        }
        
        /* Ensure calendar events are readable on mobile */
        .fc-event {
            font-size: 0.75rem;
            padding: 2px 4px;
            margin: 1px;
        }
        
        @media (max-width: 768px) {
            .fc-event {
                font-size: 0.7rem;
                padding: 1px 2px;
            }
            
            .fc-daygrid-day-number {
                font-size: 0.8rem;
            }
            
            .fc-col-header-cell {
                font-size: 0.8rem;
                padding: 5px 2px;
            }
        }
    </style>
</head>
<body>
    <!-- Admin Header - SAME AS ENROLLMENTS PAGE -->
    <nav class="navbar navbar-dark" style="background: var(--navbar-bg);">
        <div class="container-fluid">
            <a class="navbar-brand" href="/admin/dashboard">
                <i class="fas fa-user-shield me-2"></i> Admin Panel
            </a>
            <div class="d-flex align-items-center">
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
            <!-- Sidebar Navigation - EXACT MATCH TO ENROLLMENTS PAGE -->
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
                            <a class="nav-link" href="/admin/enrollments">
                                <i class="fas fa-user-graduate me-2"></i> Enrollments
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="/admin/calendar">
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
                </c:if>
                
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        <i class="fas fa-exclamation-circle me-2"></i> ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Page Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3><i class="fas fa-calendar-alt me-2"></i> Event Calendar Management</h3>
                    <div>
                        <button class="btn btn-add-event" data-bs-toggle="modal" data-bs-target="#addEventModal">
                            <i class="fas fa-plus me-2"></i> Add New Event
                        </button>
                    </div>
                </div>

                <!-- Statistics Cards - ALL 7 EVENT TYPES -->
                <div class="row mb-4">
                    <div class="col-md-3 col-sm-6">
                        <div class="stats-card stats-1">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">Classes</h5>
                                    <h2 class="mb-0" id="classCount">0</h2>
                                </div>
                                <i class="fas fa-chalkboard-teacher fa-2x opacity-75"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="stats-card stats-2">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">Exams</h5>
                                    <h2 class="mb-0" id="examCount">0</h2>
                                </div>
                                <i class="fas fa-file-alt fa-2x opacity-75"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="stats-card stats-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">Holidays</h5>
                                    <h2 class="mb-0" id="holidayCount">0</h2>
                                </div>
                                <i class="fas fa-umbrella-beach fa-2x opacity-75"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="stats-card stats-4">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">Meetings</h5>
                                    <h2 class="mb-0" id="meetingCount">0</h2>
                                </div>
                                <i class="fas fa-users fa-2x opacity-75"></i>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Second Row of Stats Cards -->
                <div class="row mb-4">
                    <div class="col-md-3 col-sm-6">
                        <div class="stats-card stats-5">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">Workshops</h5>
                                    <h2 class="mb-0" id="workshopCount">0</h2>
                                </div>
                                <i class="fas fa-tools fa-2x opacity-75"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="stats-card stats-6">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">Deadlines</h5>
                                    <h2 class="mb-0" id="deadlineCount">0</h2>
                                </div>
                                <i class="fas fa-hourglass-end fa-2x opacity-75"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="stats-card stats-7">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">Other Events</h5>
                                    <h2 class="mb-0" id="otherCount">0</h2>
                                </div>
                                <i class="fas fa-calendar-plus fa-2x opacity-75"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="stats-card" style="background: linear-gradient(135deg, var(--primary-color), #2980b9);">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">Total Events</h5>
                                    <h2 class="mb-0" id="totalCount">0</h2>
                                </div>
                                <i class="fas fa-calendar-check fa-2x opacity-75"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <!-- Calendar Section -->
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h5 class="mb-0"><i class="fas fa-calendar me-2"></i> Calendar</h5>
                                    <div class="btn-group" role="group">
                                        <button class="btn btn-sm btn-outline-primary" onclick="goToToday()">
                                            <i class="fas fa-calendar-day me-1"></i> Today
                                        </button>
                                        <button class="btn btn-sm btn-outline-secondary" onclick="refreshCalendar()">
                                            <i class="fas fa-sync-alt me-1"></i> Refresh
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <div id="calendar"></div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Sidebar Section -->
                    <div class="col-lg-4">
                        <!-- Add New Event Card -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    <i class="fas fa-plus-circle me-2"></i> Add New Event
                                </h5>
                            </div>
                            <div class="card-body">
                                <p class="text-muted">Click the button above to add new events or double-click on calendar dates.</p>
                                <div class="d-grid">
                                    <button class="btn btn-add-event" data-bs-toggle="modal" data-bs-target="#addEventModal">
                                        <i class="fas fa-plus me-2"></i> Create Event
                                    </button>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Upcoming Events -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    <i class="fas fa-clock me-2"></i> Upcoming Events (7 Days)
                                </h5>
                            </div>
                            <div class="card-body">
                                <div id="upcomingEvents" class="upcoming-events">
                                    <div class="text-center py-3">
                                        <div class="spinner-border text-primary" role="status">
                                            <span class="visually-hidden">Loading...</span>
                                        </div>
                                        <p class="mt-2 text-muted">Loading events...</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Event Types Legend -->
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    <i class="fas fa-tags me-2"></i> Event Types
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-2">
                                    <span class="event-type-badge class-badge">Class</span>
                                    <small class="text-muted">Regular classes</small>
                                </div>
                                <div class="mb-2">
                                    <span class="event-type-badge exam-badge">Exam</span>
                                    <small class="text-muted">Examinations</small>
                                </div>
                                <div class="mb-2">
                                    <span class="event-type-badge holiday-badge">Holiday</span>
                                    <small class="text-muted">Holidays & breaks</small>
                                </div>
                                <div class="mb-2">
                                    <span class="event-type-badge meeting-badge">Meeting</span>
                                    <small class="text-muted">Meetings</small>
                                </div>
                                <div class="mb-2">
                                    <span class="event-type-badge workshop-badge">Workshop</span>
                                    <small class="text-muted">Workshops & seminars</small>
                                </div>
                                <div class="mb-2">
                                    <span class="event-type-badge deadline-badge">Deadline</span>
                                    <small class="text-muted">Submission deadlines</small>
                                </div>
                                <div class="mb-2">
                                    <span class="event-type-badge other-badge">Other</span>
                                    <small class="text-muted">Other events</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Add Event Modal -->
    <div class="modal fade" id="addEventModal" tabindex="-1" aria-labelledby="addEventModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addEventModalLabel">
                        <i class="fas fa-calendar-plus me-2"></i> Add New Event
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="eventForm" action="/api/events" method="POST" onsubmit="return saveEvent(event)">
                    <div class="modal-body">
                        <input type="hidden" id="eventId" name="eventId">
                        <input type="hidden" id="eventAction" name="action" value="add">
                        
                        <div class="row">
                            <div class="col-md-6">
                                <!-- Event Title -->
                                <div class="mb-3">
                                    <label for="eventTitle" class="form-label">
                                        <strong>Event Title *</strong>
                                    </label>
                                    <input type="text" class="form-control" id="eventTitle" name="title" 
                                           placeholder="Enter event title" required>
                                </div>
                                
                                <!-- Event Date -->
                                <div class="mb-3">
                                    <label for="eventDate" class="form-label">
                                        <strong>Date *</strong>
                                    </label>
                                    <input type="date" class="form-control" id="eventDate" name="eventDate" required>
                                </div>
                                
                                <!-- Event Type -->
                                <div class="mb-3">
                                    <label for="eventType" class="form-label">
                                        <strong>Event Type</strong>
                                    </label>
                                    <select class="form-control" id="eventType" name="eventType" required onchange="updateColorByEventType()">
                                        <option value="">Select Event Type</option>
                                        <option value="CLASS">Class</option>
                                        <option value="EXAM">Exam</option>
                                        <option value="HOLIDAY">Holiday</option>
                                        <option value="MEETING">Meeting</option>
                                        <option value="WORKSHOP">Workshop</option>
                                        <option value="DEADLINE">Deadline</option>
                                        <option value="OTHER">Other</option>
                                    </select>
                                </div>
                                
                                <!-- Event Time -->
                                <div class="mb-3">
                                    <label for="eventTime" class="form-label">
                                        <strong>Time (Optional)</strong>
                                    </label>
                                    <input type="time" class="form-control" id="eventTime" name="eventTime">
                                    <small class="text-muted">Leave empty for all-day events</small>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <!-- Description -->
                                <div class="mb-3">
                                    <label for="eventDescription" class="form-label">
                                        <strong>Description</strong>
                                    </label>
                                    <textarea class="form-control" id="eventDescription" name="description" 
                                              rows="3" placeholder="Enter event description"></textarea>
                                </div>
                                
                                <!-- Location -->
                                <div class="mb-3">
                                    <label for="eventLocation" class="form-label">
                                        <strong>Location</strong>
                                    </label>
                                    <input type="text" class="form-control" id="eventLocation" name="location" 
                                           placeholder="Enter location (e.g., Room 101)">
                                </div>
                                
                                <!-- Event Color -->
                                <div class="mb-3">
                                    <label for="eventColor" class="form-label">
                                        <strong>Event Color</strong>
                                    </label>
                                    <input type="color" class="form-control form-control-color" id="eventColor" 
                                           name="color" value="#3498db" title="Choose event color" style="width: 60px; height: 38px;">
                                </div>
                                
                                <!-- Course Selection -->
                                <div class="mb-3">
                                    <label for="eventCourse" class="form-label">
                                        <strong>Course (Optional)</strong>
                                    </label>
                                    <select class="form-control" id="eventCourse" name="courseId">
                                        <option value="">Select Course</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i> Cancel
                        </button>
                        <button type="submit" class="btn btn-add-event" id="saveEventBtn">
                            <i class="fas fa-save me-2"></i> Save Event
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Event Details Modal -->
    <div class="modal fade" id="eventDetailsModal" tabindex="-1" aria-labelledby="eventDetailsModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="eventDetailsModalLabel">Event Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="eventDetailsContent">
                    <!-- Event details will be loaded here -->
                </div>
                <div class="modal-footer">
                    <div class="btn-group w-100">
                        <button type="button" class="btn btn-warning" onclick="editEvent()">
                            <i class="fas fa-edit me-2"></i> Edit
                        </button>
                        <button type="button" class="btn btn-danger" onclick="deleteEvent()">
                            <i class="fas fa-trash me-2"></i> Delete
                        </button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i> Close
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Loading Spinner -->
    <div class="spinner-overlay" id="loadingSpinner">
        <div class="spinner"></div>
    </div>
    
    <!-- Toast Container -->
    <div id="toastContainer" style="position: fixed; top: 20px; right: 20px; z-index: 9999;"></div>

    <!-- Floating Dark Mode Toggle Button -->
    <button class="dark-mode-toggle" onclick="toggleDarkMode()" title="Toggle Dark Mode">
        <i class="fas ${sessionScope.darkMode ? 'fa-sun' : 'fa-moon'} fa-lg"></i>
    </button>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- FullCalendar JS -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <script>
        let calendar;
        let currentEventId = null;
        let allEvents = [];
        
        document.addEventListener('DOMContentLoaded', function() {
            initializeCalendar();
            loadDropdownData();
            loadUpcomingEvents();
            setTodayDate();
            
            const modal = document.getElementById('addEventModal');
            modal.addEventListener('hidden.bs.modal', function () {
                resetEventForm();
            });
            
            document.getElementById('eventType').addEventListener('change', updateColorByEventType);
            
            loadEventStats();
            
            window.addEventListener('resize', function() {
                if (calendar) {
                    setTimeout(() => {
                        calendar.updateSize();
                    }, 300);
                }
            });
        });
        
        // Dark Mode Functions (Same as enrollments page)
        function toggleDarkMode() {
            const htmlElement = document.documentElement;
            const isDarkMode = htmlElement.getAttribute('data-bs-theme') === 'dark';
            const newMode = !isDarkMode;
            
            htmlElement.setAttribute('data-bs-theme', newMode ? 'dark' : 'light');
            
            updateDarkModeIcons(newMode);
            showDarkModeToast(newMode ? 'Dark' : 'Light');
            saveDarkModePreference(newMode);
            localStorage.setItem('darkMode', newMode);
            
            if (calendar) {
                setTimeout(() => {
                    calendar.render();
                }, 100);
            }
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
            
            const toast = new bootstrap.Toast(toastElement.querySelector('.toast'), {
                autohide: true,
                delay: 3000
            });
            toast.show();
            
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
        
        function initializeCalendar() {
            const calendarEl = document.getElementById('calendar');
            
            calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
                },
                themeSystem: 'bootstrap5',
                editable: true,
                selectable: true,
                selectMirror: true,
                dayMaxEvents: true,
                weekends: true,
                navLinks: true,
                businessHours: true,
                eventTimeFormat: {
                    hour: '2-digit',
                    minute: '2-digit',
                    meridiem: true
                },
                handleWindowResize: true,
                windowResizeDelay: 100,
                contentHeight: 'auto',
                aspectRatio: window.innerWidth < 768 ? 1 : 1.5,
                events: function(fetchInfo, successCallback, failureCallback) {
                    $.ajax({
                        url: '/api/calendar/events',
                        type: 'GET',
                        data: {
                            start: fetchInfo.startStr,
                            end: fetchInfo.endStr
                        },
                        success: function(events) {
                            allEvents = events;
                            updateEventStats(events);
                            successCallback(events);
                        },
                        error: function(xhr, status, error) {
                            console.error('Error loading events:', error);
                            failureCallback(error);
                            successCallback([]);
                        }
                    });
                },
                
                eventClick: function(info) {
                    showEventDetails(info.event);
                },
                
                dateClick: function(info) {
                    openAddEventModal(info.dateStr);
                },
                
                eventDrop: function(info) {
                    updateEventDate(info.event);
                },
                
                eventResize: function(info) {
                    updateEventDate(info.event);
                },
                
                loading: function(isLoading) {
                    if (isLoading) {
                        showLoading();
                    } else {
                        hideLoading();
                    }
                },
                
                dayCellClassNames: function(arg) {
                    const today = new Date();
                    const cellDate = arg.date;
                    if (cellDate.getDate() === today.getDate() &&
                        cellDate.getMonth() === today.getMonth() &&
                        cellDate.getFullYear() === today.getFullYear()) {
                        return ['fc-day-today'];
                    }
                    return [];
                },
                
                viewDidMount: function() {
                    if (window.innerWidth < 768) {
                        calendar.setOption('height', window.innerHeight * 0.6);
                    }
                }
            });
            
            calendar.render();
            
            window.addEventListener('resize', function() {
                if (window.innerWidth < 768) {
                    calendar.setOption('height', window.innerHeight * 0.6);
                } else {
                    calendar.setOption('height', 'auto');
                }
                calendar.updateSize();
            });
        }
        
        function updateColorByEventType() {
            const eventType = document.getElementById('eventType').value;
            let color = '#3498db';
            
            switch(eventType) {
                case 'CLASS': color = '#4e73df'; break;
                case 'EXAM': color = '#e74a3b'; break;
                case 'HOLIDAY': color = '#1cc88a'; break;
                case 'MEETING': color = '#f6c23e'; break;
                case 'WORKSHOP': color = '#6f42c1'; break;
                case 'DEADLINE': color = '#fd7e14'; break;
                case 'OTHER': color = '#858796'; break;
            }
            
            document.getElementById('eventColor').value = color;
        }
        
        function loadDropdownData() {
            $.get('/api/courses', function(courses) {
                const courseSelect = $('#eventCourse');
                courseSelect.empty();
                courseSelect.append('<option value="">Select Course</option>');
                if (courses && courses.length > 0) {
                    courses.forEach(function(course) {
                        courseSelect.append('<option value="' + course.id + '">' + course.courseName + ' (' + course.courseCode + ')</option>');
                    });
                }
            }).fail(function() {
                console.log('Failed to load courses');
            });
        }
        
        function loadUpcomingEvents() {
            const apiEndpoints = [
                '/api/events/upcoming',
                '/api/calendar/upcoming',
                '/api/calendar/events?upcoming=true'
            ];
            
            let attempts = 0;
            
            function tryNextEndpoint() {
                if (attempts >= apiEndpoints.length) {
                    $('#upcomingEvents').html(`
                        <div class="text-center py-3">
                            <i class="fas fa-calendar-alt fa-2x text-muted mb-2"></i>
                            <p class="text-muted">No upcoming events found</p>
                        </div>
                    `);
                    return;
                }
                
                const endpoint = apiEndpoints[attempts];
                attempts++;
                
                $.get(endpoint, function(events) {
                    const container = $('#upcomingEvents');
                    container.empty();
                    
                    if (events && events.length > 0) {
                        events.sort((a, b) => new Date(a.start) - new Date(b.start));
                        
                        const today = new Date();
                        const nextWeek = new Date();
                        nextWeek.setDate(today.getDate() + 7);
                        
                        const upcoming = events.filter(event => {
                            const eventDate = new Date(event.start);
                            return eventDate >= today && eventDate <= nextWeek;
                        });
                        
                        if (upcoming.length === 0) {
                            container.html(`
                                <div class="text-center py-3">
                                    <i class="fas fa-calendar-check fa-2x text-success mb-2"></i>
                                    <p class="text-muted">No events in next 7 days</p>
                                </div>
                            `);
                            return;
                        }
                        
                        upcoming.forEach(function(event, index) {
                            if (index >= 5) return;
                            
                            const eventDate = new Date(event.start);
                            const timeStr = event.allDay ? 'All Day' : formatTime(eventDate);
                            const eventType = event.eventType || event.extendedProps?.eventType || 'Event';
                            
                            let locationHtml = '';
                            if (event.extendedProps?.location || event.location) {
                                const location = event.extendedProps?.location || event.location;
                                locationHtml = '<small><i class="fas fa-map-marker-alt me-1"></i>' + location + '</small>';
                            }
                            
                            const eventHtml = '<div class="upcoming-event-item">' +
                                '<div class="d-flex justify-content-between align-items-start">' +
                                    '<div>' +
                                        '<h6 class="mb-1">' + event.title + '</h6>' +
                                        '<small class="text-muted">' + eventType + '</small>' +
                                    '</div>' +
                                    '<span class="badge bg-' + getEventColorClass(eventType) + '">' + eventType + '</span>' +
                                '</div>' +
                                '<div class="mt-2">' +
                                    '<small><i class="far fa-calendar me-1"></i>' + formatDate(eventDate) + '</small>' +
                                    '<small class="ms-3"><i class="far fa-clock me-1"></i>' + timeStr + '</small>' +
                                '</div>' +
                                locationHtml +
                            '</div>';
                            
                            container.append(eventHtml);
                        });
                    } else {
                        container.html(`
                            <div class="text-center py-3">
                                <i class="fas fa-calendar-plus fa-2x text-primary mb-2"></i>
                                <p class="text-muted">No upcoming events</p>
                            </div>
                        `);
                    }
                    
                    if (events && events.length > 0) {
                        updateEventStats(events);
                    }
                }).fail(function() {
                    tryNextEndpoint();
                });
            }
            
            tryNextEndpoint();
        }
        
        function loadEventStats() {
            $.get('/api/events/stats', function(stats) {
                if (stats) {
                    $('#classCount').text(stats.classCount || 0);
                    $('#examCount').text(stats.examCount || 0);
                    $('#holidayCount').text(stats.holidayCount || 0);
                    $('#meetingCount').text(stats.meetingCount || 0);
                    $('#workshopCount').text(stats.workshopCount || 0);
                    $('#deadlineCount').text(stats.deadlineCount || 0);
                    $('#otherCount').text(stats.otherCount || 0);
                    
                    // Calculate total
                    const total = (stats.classCount || 0) + (stats.examCount || 0) + 
                                 (stats.holidayCount || 0) + (stats.meetingCount || 0) + 
                                 (stats.workshopCount || 0) + (stats.deadlineCount || 0) + 
                                 (stats.otherCount || 0);
                    $('#totalCount').text(total);
                }
            }).fail(function() {
                updateEventStats(allEvents);
            });
        }
        
        function updateEventStats(events) {
            const counts = {
                CLASS: 0,
                EXAM: 0,
                HOLIDAY: 0,
                MEETING: 0,
                WORKSHOP: 0,
                DEADLINE: 0,
                OTHER: 0
            };
            
            if (events && events.length > 0) {
                events.forEach(function(event) {
                    const type = event.eventType ? event.eventType.toUpperCase() : '';
                    if (counts.hasOwnProperty(type)) {
                        counts[type]++;
                    } else if (type) {
                        counts.OTHER++;
                    }
                });
            }
            
            $('#classCount').text(counts.CLASS);
            $('#examCount').text(counts.EXAM);
            $('#holidayCount').text(counts.HOLIDAY);
            $('#meetingCount').text(counts.MEETING);
            $('#workshopCount').text(counts.WORKSHOP);
            $('#deadlineCount').text(counts.DEADLINE);
            $('#otherCount').text(counts.OTHER);
            
            // Calculate total
            const total = counts.CLASS + counts.EXAM + counts.HOLIDAY + counts.MEETING + 
                          counts.WORKSHOP + counts.DEADLINE + counts.OTHER;
            $('#totalCount').text(total);
        }
        
        function setTodayDate() {
            const today = new Date();
            const formattedDate = today.toISOString().split('T')[0];
            $('#eventDate').val(formattedDate);
            $('#eventTime').val('09:00');
        }
        
        function goToToday() {
            calendar.today();
            showToast('Navigated to today\'s date', 'info');
        }
        
        function openAddEventModal(dateStr) {
            resetEventForm();
            
            if (dateStr) {
                $('#eventDate').val(dateStr);
            } else {
                setTodayDate();
            }
            
            const modal = new bootstrap.Modal(document.getElementById('addEventModal'));
            modal.show();
        }
        
        function resetEventForm() {
            document.getElementById('eventForm').reset();
            $('#eventId').val('');
            $('#eventAction').val('add');
            $('#saveEventBtn').html('<i class="fas fa-save me-2"></i>Save Event');
            $('#addEventModalLabel').html('<i class="fas fa-calendar-plus me-2"></i>Add New Event');
            
            $('#eventType').prop('selectedIndex', 0);
            $('#eventCourse').prop('selectedIndex', 0);
            document.getElementById('eventColor').value = '#3498db';
            
            setTodayDate();
        }
        
        function saveEvent(e) {
            e.preventDefault();
            
            const isUpdate = $('#eventId').val() !== '';
            const title = $('#eventTitle').val().trim();
            const date = $('#eventDate').val();
            
            if (!title) {
                showToast('Please enter event title', 'warning');
                return false;
            }
            
            if (!date) {
                showToast('Please select event date', 'warning');
                return false;
            }
            
            showLoading();
            
            const formData = {
                title: title,
                eventDate: date,
                eventType: $('#eventType').val(),
                description: $('#eventDescription').val() || '',
                location: $('#eventLocation').val() || '',
                color: $('#eventColor').val(),
                createdBy: 'Admin'
            };
            
            const eventTime = $('#eventTime').val();
            if (eventTime) {
                formData.eventTime = eventTime;
            }
            
            const courseId = $('#eventCourse').val();
            if (courseId) {
                formData.courseId = courseId;
            }
            
            const urlEncodedData = Object.keys(formData)
                .map(key => encodeURIComponent(key) + '=' + encodeURIComponent(formData[key]))
                .join('&');
            
            const url = isUpdate ? '/api/events/' + $('#eventId').val() : '/api/events';
            const method = isUpdate ? 'PUT' : 'POST';
            
            $.ajax({
                url: url,
                type: method,
                data: urlEncodedData,
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                success: function(response) {
                    hideLoading();
                    
                    if (response && response.success) {
                        showToast('Event saved successfully!', 'success');
                        
                        const modal = bootstrap.Modal.getInstance(document.getElementById('addEventModal'));
                        modal.hide();
                        
                        resetEventForm();
                        calendar.refetchEvents();
                        setTimeout(loadUpcomingEvents, 500);
                        setTimeout(loadEventStats, 500);
                    } else {
                        showToast('Error: ' + (response ? response.message : 'Unknown error'), 'danger');
                    }
                },
                error: function(xhr, status, error) {
                    hideLoading();
                    console.error('Save error:', xhr.responseText);
                    saveEventFallback();
                }
            });
            
            return false;
        }
        
        function saveEventFallback() {
            const form = document.getElementById('eventForm');
            
            if (!document.getElementById('eventTime').value) {
                document.getElementById('eventTime').value = '00:00';
            }
            
            form.submit();
        }
        
        function showEventDetails(event) {
            currentEventId = event.id;
            
            const eventData = event.extendedProps;
            const startDate = event.start;
            
            let detailsHtml = '<h4>' + event.title + '</h4>' +
                '<div class="event-details mt-3">' +
                '<p><strong>Type:</strong> <span class="badge bg-' + getEventColorClass(eventData.eventType) + '">' + (eventData.eventType || 'Event') + '</span></p>' +
                '<p><strong>Date:</strong> ' + formatDate(startDate) + '</p>';
            
            if (eventData.eventTime) {
                detailsHtml += '<p><strong>Time:</strong> ' + eventData.eventTime + '</p>';
            } else if (!event.allDay && startDate) {
                detailsHtml += '<p><strong>Time:</strong> ' + formatTime(startDate);
                if (event.end) {
                    detailsHtml += ' to ' + formatTime(event.end);
                }
                detailsHtml += '</p>';
            } else {
                detailsHtml += '<p><strong>Time:</strong> All Day</p>';
            }
            
            if (eventData.location) {
                detailsHtml += '<p><strong>Location:</strong> ' + eventData.location + '</p>';
            }
            
            if (eventData.description) {
                detailsHtml += '<p><strong>Description:</strong> ' + eventData.description + '</p>';
            }
            
            if (eventData.courseName) {
                detailsHtml += '<p><strong>Course:</strong> ' + eventData.courseName + ' (' + eventData.courseCode + ')</p>';
            }
            
            detailsHtml += '<p><strong>Created by:</strong> ' + (eventData.createdBy || 'Admin') + '</p>' +
                '</div>';
            
            $('#eventDetailsContent').html(detailsHtml);
            
            const modal = new bootstrap.Modal(document.getElementById('eventDetailsModal'));
            modal.show();
        }
        
        function editEvent() {
            if (!currentEventId) return;
            
            const detailsModal = bootstrap.Modal.getInstance(document.getElementById('eventDetailsModal'));
            detailsModal.hide();
            
            $.get('/api/events/' + currentEventId, function(event) {
                $('#eventId').val(event.id);
                $('#eventAction').val('edit');
                $('#eventTitle').val(event.title);
                $('#eventDescription').val(event.extendedProps?.description || '');
                $('#eventLocation').val(event.extendedProps?.location || '');
                document.getElementById('eventColor').value = event.color || '#3498db';
                
                const startDate = new Date(event.start);
                const eventDate = startDate.toISOString().split('T')[0];
                $('#eventDate').val(eventDate);
                
                if (!event.allDay) {
                    const hours = startDate.getHours().toString().padStart(2, '0');
                    const minutes = startDate.getMinutes().toString().padStart(2, '0');
                    $('#eventTime').val(hours + ':' + minutes);
                } else {
                    $('#eventTime').val('');
                }
                
                $('#eventType').val(event.eventType || event.extendedProps?.eventType);
                
                if (event.extendedProps?.courseId) {
                    $('#eventCourse').val(event.extendedProps.courseId);
                }
                
                $('#addEventModalLabel').html('<i class="fas fa-edit me-2"></i>Edit Event');
                $('#saveEventBtn').html('<i class="fas fa-save me-2"></i>Update Event');
                
                const modal = new bootstrap.Modal(document.getElementById('addEventModal'));
                modal.show();
            });
        }
        
        function deleteEvent() {
            if (!currentEventId) return;
            
            if (confirm('Are you sure you want to delete this event?')) {
                showLoading();
                
                $.ajax({
                    url: '/api/events/' + currentEventId,
                    type: 'DELETE',
                    success: function(response) {
                        hideLoading();
                        
                        if (response && response.success) {
                            showToast('Event deleted successfully!', 'success');
                            
                            const detailsModal = bootstrap.Modal.getInstance(document.getElementById('eventDetailsModal'));
                            detailsModal.hide();
                            
                            calendar.refetchEvents();
                            setTimeout(loadUpcomingEvents, 500);
                            setTimeout(loadEventStats, 500);
                        } else {
                            showToast('Error: ' + (response ? response.message : 'Unknown error'), 'danger');
                        }
                    },
                    error: function(xhr, status, error) {
                        hideLoading();
                        showToast('Error deleting event: ' + error, 'danger');
                    }
                });
            }
        }
        
        function updateEventDate(event) {
            const eventId = event.id;
            const startDate = event.start;
            
            const updateData = {
                eventDate: startDate.toISOString().split('T')[0]
            };
            
            if (!event.allDay) {
                updateData.startTime = formatTime24(startDate);
            }
            
            const urlEncodedData = Object.keys(updateData)
                .map(key => encodeURIComponent(key) + '=' + encodeURIComponent(updateData[key]))
                .join('&');
            
            $.ajax({
                url: '/api/events/' + eventId,
                type: 'PUT',
                data: urlEncodedData,
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                success: function(response) {
                    if (response && !response.success) {
                        showToast('Error updating event: ' + response.message, 'danger');
                        calendar.refetchEvents();
                    } else {
                        showToast('Event updated successfully', 'success');
                    }
                },
                error: function() {
                    showToast('Error updating event', 'danger');
                    calendar.refetchEvents();
                }
            });
        }
        
        function refreshCalendar() {
            showLoading();
            calendar.refetchEvents();
            loadUpcomingEvents();
            loadEventStats();
            setTimeout(hideLoading, 500);
            showToast('Calendar refreshed', 'info');
        }
        
        function formatTime24(date) {
            if (!date) return '';
            const hours = date.getHours().toString().padStart(2, '0');
            const minutes = date.getMinutes().toString().padStart(2, '0');
            return hours + ':' + minutes;
        }
        
        function formatDate(date) {
            if (!date) return 'N/A';
            return date.toLocaleDateString('en-US', { 
                weekday: 'short', 
                year: 'numeric', 
                month: 'short', 
                day: 'numeric' 
            });
        }
        
        function formatTime(date) {
            if (!date) return 'N/A';
            return date.toLocaleTimeString('en-US', { 
                hour: '2-digit', 
                minute: '2-digit',
                hour12: true 
            });
        }
        
        function getEventColorClass(eventType) {
            const type = eventType ? eventType.toUpperCase() : '';
            switch(type) {
                case 'CLASS': return 'primary';
                case 'EXAM': return 'danger';
                case 'HOLIDAY': return 'success';
                case 'MEETING': return 'warning';
                case 'WORKSHOP': return 'info';
                case 'DEADLINE': return 'orange';
                default: return 'secondary';
            }
        }
        
        function showLoading() {
            document.getElementById('loadingSpinner').style.display = 'flex';
        }
        
        function hideLoading() {
            document.getElementById('loadingSpinner').style.display = 'none';
        }
        
        function showToast(message, type) {
            const toastId = 'toast-' + Date.now();
            const toastHtml = '<div id="' + toastId + '" class="toast align-items-center text-white bg-' + type + ' border-0" role="alert" aria-live="assertive" aria-atomic="true">' +
                '<div class="d-flex">' +
                    '<div class="toast-body">' +
                        '<i class="fas ' + getToastIcon(type) + ' me-2"></i>' +
                        message +
                    '</div>' +
                    '<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>' +
                '</div>' +
            '</div>';
            
            $('#toastContainer').append(toastHtml);
            const toastElement = document.getElementById(toastId);
            const toast = new bootstrap.Toast(toastElement, { delay: 3000 });
            toast.show();
            
            toastElement.addEventListener('hidden.bs.toast', function () {
                toastElement.remove();
            });
        }
        
        function getToastIcon(type) {
            switch(type) {
                case 'success': return 'fa-check-circle';
                case 'danger': return 'fa-exclamation-circle';
                case 'warning': return 'fa-exclamation-triangle';
                case 'info': return 'fa-info-circle';
                default: return 'fa-bell';
            }
        }
    </script>
</body>
</html>