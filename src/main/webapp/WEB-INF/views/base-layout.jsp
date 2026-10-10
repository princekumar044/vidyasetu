<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="${sessionScope.darkMode ? 'dark' : 'light'}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${not empty pageTitle ? pageTitle : 'Student Portal'}"/></title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    
    <!-- Page-specific CSS -->
    <c:if test="${not empty pageCss}">
        <link href="${pageContext.request.contextPath}/css/${pageCss}" rel="stylesheet">
    </c:if>
    
    <!-- Dark Mode CSS -->
    <style>
        /* CSS Variables for Themes */
        :root {
            /* Light Theme */
            --bg-primary: #f8f9fa;
            --bg-secondary: #ffffff;
            --bg-sidebar: #2c3e50;
            --text-primary: #212529;
            --text-secondary: #6c757d;
            --text-sidebar: #ffffff;
            --border-color: #dee2e6;
            --shadow-color: rgba(0, 0, 0, 0.1);
            --card-bg: #ffffff;
            --input-bg: #ffffff;
            --table-bg: #ffffff;
            --table-striped: #f8f9fa;
            --modal-bg: #ffffff;
            --btn-primary: #4e73df;
            --btn-hover: #3a56c4;
            --danger-color: #e74a3b;
            --success-color: #1cc88a;
            --warning-color: #f6c23e;
            --info-color: #36b9cc;
        }
        
        [data-bs-theme="dark"] {
            /* Dark Theme */
            --bg-primary: #121212;
            --bg-secondary: #1e1e1e;
            --bg-sidebar: #0d1117;
            --text-primary: #e9ecef;
            --text-secondary: #adb5bd;
            --text-sidebar: #e9ecef;
            --border-color: #343a40;
            --shadow-color: rgba(0, 0, 0, 0.3);
            --card-bg: #1e1e1e;
            --input-bg: #2d2d2d;
            --table-bg: #1e1e1e;
            --table-striped: #252525;
            --modal-bg: #1e1e1e;
            --btn-primary: #4e73df;
            --btn-hover: #3a56c4;
            --danger-color: #dc3545;
            --success-color: #198754;
            --warning-color: #ffc107;
            --info-color: #0dcaf0;
        }
        
        /* Apply CSS Variables */
        body {
            background-color: var(--bg-primary);
            color: var(--text-primary);
            transition: background-color 0.3s, color 0.3s;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .card, .modal-content, .dropdown-menu, .toast {
            background-color: var(--card-bg);
            color: var(--text-primary);
            border-color: var(--border-color);
            transition: background-color 0.3s, color 0.3s, border-color 0.3s;
        }
        
        .form-control, .form-select, .form-control:focus, .form-select:focus {
            background-color: var(--input-bg);
            color: var(--text-primary);
            border-color: var(--border-color);
            transition: all 0.3s;
        }
        
        .table {
            color: var(--text-primary);
            --bs-table-bg: transparent;
            --bs-table-striped-bg: var(--table-striped);
            --bs-table-hover-bg: rgba(255, 255, 255, 0.075);
        }
        
        .navbar, .footer {
            background-color: var(--bg-secondary) !important;
            border-color: var(--border-color);
        }
        
        .sidebar {
            background-color: var(--bg-sidebar);
            color: var(--text-sidebar);
        }
        
        .btn-primary {
            background-color: var(--btn-primary);
            border-color: var(--btn-primary);
        }
        
        .btn-primary:hover {
            background-color: var(--btn-hover);
            border-color: var(--btn-hover);
        }
        
        .text-danger { color: var(--danger-color) !important; }
        .text-success { color: var(--success-color) !important; }
        .text-warning { color: var(--warning-color) !important; }
        .text-info { color: var(--info-color) !important; }
        
        .bg-danger { background-color: var(--danger-color) !important; }
        .bg-success { background-color: var(--success-color) !important; }
        .bg-warning { background-color: var(--warning-color) !important; }
        .bg-info { background-color: var(--info-color) !important; }
        
        /* Smooth transitions for all elements */
        * {
            transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease, box-shadow 0.3s ease;
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
            background: var(--btn-primary);
            color: white;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 4px 12px var(--shadow-color);
            transition: all 0.3s;
        }
        
        .dark-mode-toggle:hover {
            transform: scale(1.1);
            box-shadow: 0 6px 16px var(--shadow-color);
        }
        
        .dark-mode-toggle i {
            font-size: 1.2rem;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-light shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="/">
                <i class="fas fa-university me-2"></i>Student Portal
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <!-- REMOVED: Dark Mode Toggle in Navbar -->
                    
                    <!-- User Menu -->
                    <c:choose>
                        <c:when test="${not empty sessionScope.loggedInAdmin}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" 
                                   id="userDropdown" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user-circle fa-lg me-2"></i>
                                    <div class="d-none d-md-block">
                                        <div class="fw-bold">${sessionScope.loggedInAdmin.fullname}</div>
                                        <small class="text-muted">Admin</small>
                                    </div>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="/admin/dashboard">
                                        <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                                    </a></li>
                                    <li><a class="dropdown-item" href="/admin/profile">
                                        <i class="fas fa-user me-2"></i>Profile
                                    </a></li>
                                    <li><a class="dropdown-item" href="/admin/settings">
                                        <i class="fas fa-cog me-2"></i>Settings
                                    </a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="/logout">
                                        <i class="fas fa-sign-out-alt me-2"></i>Logout
                                    </a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:when test="${not empty sessionScope.loggedInUser}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" 
                                   id="userDropdown" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user-circle fa-lg me-2"></i>
                                    <div class="d-none d-md-block">
                                        <div class="fw-bold">${sessionScope.loggedInUser.fullname}</div>
                                        <small class="text-muted">${sessionScope.loggedInUser.role}</small>
                                    </div>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="/student/dashboard">
                                        <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                                    </a></li>
                                    <li><a class="dropdown-item" href="/student/profile">
                                        <i class="fas fa-user me-2"></i>My Profile
                                    </a></li>
                                    <li><a class="dropdown-item" href="/student/courses">
                                        <i class="fas fa-book me-2"></i>My Courses
                                    </a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="/logout">
                                        <i class="fas fa-sign-out-alt me-2"></i>Logout
                                    </a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="btn btn-outline-primary me-2" href="/login">
                                    <i class="fas fa-sign-in-alt me-2"></i>Login
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-primary" href="/register">
                                    <i class="fas fa-user-plus me-2"></i>Register
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container-fluid mt-3">
        <div class="row">
            <!-- Sidebar (only for authenticated users) -->
            <c:if test="${not empty sessionScope.loggedInAdmin or not empty sessionScope.loggedInUser}">
                <div class="col-md-3 col-lg-2 d-none d-md-block sidebar p-0" style="min-height: calc(100vh - 76px);">
                    <div class="p-3">
                        <h5 class="mb-3">
                            <i class="fas fa-bars me-2"></i>Menu
                        </h5>
                        <nav class="nav flex-column">
                            <c:choose>
                                <c:when test="${not empty sessionScope.loggedInAdmin}">
                                    <!-- Admin Menu -->
                                    <a class="nav-link ${pageContext.request.requestURI.contains('/admin/dashboard') ? 'active' : ''}" 
                                       href="/admin/dashboard">
                                        <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                                    </a>
                                    <a class="nav-link ${pageContext.request.requestURI.contains('/admin/students') ? 'active' : ''}" 
                                       href="/admin/students">
                                        <i class="fas fa-users me-2"></i>Students
                                    </a>
                                    <a class="nav-link ${pageContext.request.requestURI.contains('/admin/courses') ? 'active' : ''}" 
                                       href="/admin/courses">
                                        <i class="fas fa-book me-2"></i>Courses
                                    </a>
                                    <a class="nav-link ${pageContext.request.requestURI.contains('/admin/calendar') ? 'active' : ''}" 
                                       href="/admin/calendar">
                                        <i class="fas fa-calendar-alt me-2"></i>Event Calendar
                                    </a>
                                    <a class="nav-link ${pageContext.request.requestURI.contains('/admin/enrollments') ? 'active' : ''}" 
                                       href="/admin/enrollments">
                                        <i class="fas fa-clipboard-list me-2"></i>Enrollments
                                    </a>
                                    <a class="nav-link ${pageContext.request.requestURI.contains('/admin/add-course') ? 'active' : ''}" 
                                       href="/admin/add-course">
                                        <i class="fas fa-plus-circle me-2"></i>Add Course
                                    </a>
                                    <div class="mt-3 pt-3 border-top border-secondary">
                                        <a class="nav-link" href="/">
                                            <i class="fas fa-external-link-alt me-2"></i>View Public Site
                                        </a>
                                    </div>
                                </c:when>
                                <c:when test="${not empty sessionScope.loggedInUser}">
                                    <!-- Student/Teacher Menu -->
                                    <a class="nav-link ${pageContext.request.requestURI.contains('/student/dashboard') ? 'active' : ''}" 
                                       href="/student/dashboard">
                                        <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                                    </a>
                                    <a class="nav-link ${pageContext.request.requestURI.contains('/student/courses') ? 'active' : ''}" 
                                       href="/student/courses">
                                        <i class="fas fa-book me-2"></i>My Courses
                                    </a>
                                    <a class="nav-link ${pageContext.request.requestURI.contains('/student/grades') ? 'active' : ''}" 
                                       href="/student/grades">
                                        <i class="fas fa-chart-line me-2"></i>Grades
                                    </a>
                                    <a class="nav-link ${pageContext.request.requestURI.contains('/student/calendar') ? 'active' : ''}" 
                                       href="/student/calendar">
                                        <i class="fas fa-calendar-alt me-2"></i>Schedule
                                    </a>
                                    <a class="nav-link ${pageContext.request.requestURI.contains('/student/assignments') ? 'active' : ''}" 
                                       href="/student/assignments">
                                        <i class="fas fa-tasks me-2"></i>Assignments
                                    </a>
                                    <a class="nav-link ${pageContext.request.requestURI.contains('/student/messages') ? 'active' : ''}" 
                                       href="/student/messages">
                                        <i class="fas fa-envelope me-2"></i>Messages
                                    </a>
                                </c:when>
                            </c:choose>
                        </nav>
                    </div>
                </div>
                
                <!-- Main Content Area with sidebar -->
                <div class="col-md-9 col-lg-10 ms-sm-auto p-3">
                    <jsp:include page="${contentPage}" />
                </div>
            </c:if>
            
            <!-- Main Content Area without sidebar (for public pages) -->
            <c:if test="${empty sessionScope.loggedInAdmin and empty sessionScope.loggedInUser}">
                <div class="col-12 p-3">
                    <jsp:include page="${contentPage}" />
                </div>
            </c:if>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer mt-auto py-3 border-top">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6">
                    <span class="text-muted">&copy; 2024 Student Portal. All rights reserved.</span>
                </div>
                <div class="col-md-6 text-end">
                    <a href="/about" class="text-muted me-3">About</a>
                    <a href="/contact" class="text-muted me-3">Contact</a>
                    <a href="/privacy" class="text-muted">Privacy Policy</a>
                </div>
            </div>
        </div>
    </footer>

    <!-- Floating Dark Mode Toggle -->
    <button class="dark-mode-toggle" onclick="toggleDarkMode()" title="Toggle Dark Mode">
        <i class="fas ${sessionScope.darkMode ? 'fa-sun' : 'fa-moon'}"></i>
    </button>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- Dark Mode Script - FIXED: Removed server-side AJAX calls -->
    <script>
        // Dark Mode Toggle Function
        function toggleDarkMode() {
            const html = document.documentElement;
            const isDarkMode = html.getAttribute('data-bs-theme') === 'dark';
            const newMode = !isDarkMode;
            
            // Update HTML attribute
            html.setAttribute('data-bs-theme', newMode ? 'dark' : 'light');
            
            // Update all icons
            updateDarkModeIcons(newMode);
            
            // Save to localStorage only (removed server-side saving)
            localStorage.setItem('darkMode', newMode);
            
            // Show notification
            showModeChangeNotification(newMode);
        }
        
        // Update all dark mode icons
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
        
        // Show notification when mode changes
        function showModeChangeNotification(isDarkMode) {
            // Create toast notification
            const toastHtml = `
                <div class="toast align-items-center text-white ${isDarkMode ? 'bg-dark' : 'bg-light text-dark'} border-0" 
                     role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="d-flex">
                        <div class="toast-body">
                            <i class="fas ${isDarkMode ? 'fa-moon' : 'fa-sun'} me-2"></i>
                            Switched to ${isDarkMode ? 'dark' : 'light'} mode
                        </div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                    </div>
                </div>
            `;
            
            // Add to page and show
            const toastContainer = document.getElementById('toastContainer') || createToastContainer();
            toastContainer.innerHTML += toastHtml;
            
            const toastElement = toastContainer.lastElementChild;
            const toast = new bootstrap.Toast(toastElement, { delay: 2000 });
            toast.show();
            
            // Remove after hidden
            toastElement.addEventListener('hidden.bs.toast', function() {
                toastElement.remove();
            });
        }
        
        // Create toast container if it doesn't exist
        function createToastContainer() {
            const container = document.createElement('div');
            container.id = 'toastContainer';
            container.style.position = 'fixed';
            container.style.top = '20px';
            container.style.right = '20px';
            container.style.zIndex = '9999';
            document.body.appendChild(container);
            return container;
        }
        
        // Initialize dark mode on page load
        document.addEventListener('DOMContentLoaded', function() {
            initializeDarkMode();
            setupSystemPreferenceListener();
        });
        
        // Initialize dark mode based on preferences
        function initializeDarkMode() {
            let darkMode = false;
            
            // Check localStorage first
            const savedMode = localStorage.getItem('darkMode');
            if (savedMode !== null) {
                darkMode = savedMode === 'true';
            } 
            // Then check session
            else if (${sessionScope.darkMode != null ? sessionScope.darkMode : 'false'} === true) {
                darkMode = true;
            }
            // Finally check system preference
            else {
                darkMode = window.matchMedia('(prefers-color-scheme: dark)').matches;
            }
            
            // Apply mode
            if (darkMode) {
                document.documentElement.setAttribute('data-bs-theme', 'dark');
                updateDarkModeIcons(true);
            }
        }
        
        // Listen for system preference changes
        function setupSystemPreferenceListener() {
            const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)');
            
            mediaQuery.addEventListener('change', event => {
                // Only change if user hasn't set a preference
                if (!localStorage.getItem('darkMode')) {
                    const newMode = event.matches;
                    document.documentElement.setAttribute('data-bs-theme', newMode ? 'dark' : 'light');
                    updateDarkModeIcons(newMode);
                }
            });
        }
    </script>
    
    <!-- Page-specific JavaScript -->
    <c:if test="${not empty pageJs}">
        <script src="${pageContext.request.contextPath}/js/${pageJs}"></script>
    </c:if>
</body>
</html>