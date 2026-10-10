<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle" value="Edit Course - Admin Panel" scope="request"/>
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
        
        .navbar-admin {
            background: var(--navbar-bg) !important;
            color: var(--navbar-text);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        /* Form Card */
        .form-card {
            max-width: 900px;
            margin: 0 auto;
        }
        
        .course-category {
            display: inline-block;
            padding: 4px 12px;
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            color: #1565c0;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        
        .price-input-group .input-group-text {
            background: var(--success-color);
            color: white;
            font-weight: bold;
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
        
        /* Form Controls */
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
    <nav class="navbar navbar-dark navbar-admin">
        <div class="container-fluid">
            <a class="navbar-brand" href="/admin/dashboard">
                <i class="fas fa-user-shield me-2"></i> Admin Panel
            </a>
            <div class="d-flex align-items-center">
                <!-- REMOVED: Dark Mode Toggle from navbar -->
                
                <span class="navbar-text text-light me-3">
                    <i class="fas fa-user me-1"></i> ${not empty admin ? admin.fullname : 'Admin'}
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
                            <a class="nav-link active" href="/admin/courses">
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

                <!-- Edit Form -->
                <div class="card form-card">
                    <div class="card-header" style="background: linear-gradient(180deg, var(--primary-color), #764ba2); color: white;">
                        <div class="d-flex justify-content-between align-items-center">
                            <h4 class="mb-0"><i class="fas fa-edit me-2"></i> Edit Course</h4>
                            <span class="badge bg-light text-dark">
                                <i class="fas fa-hashtag me-1"></i> ID: ${course.id}
                            </span>
                        </div>
                    </div>
                    <div class="card-body">
                        <!-- Course Info Header -->
                        <div class="text-center mb-4">
                            <div class="mb-3">
                                <i class="fas fa-book fa-3x" style="color: var(--primary-color);"></i>
                            </div>
                            <h4>Editing: ${course.courseName}</h4>
                            <p class="text-muted">
                                <span class="course-category me-2">${course.category}</span>
                                <span class="badge bg-secondary">${course.duration}</span>
                            </p>
                        </div>
                        
                        <form action="/admin/courses/update/${course.id}" method="post">
                            <div class="row">
                                <!-- Course Name -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">
                                        <i class="fas fa-book me-1"></i> Course Name
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-heading"></i></span>
                                        <input type="text" name="courseName" value="${course.courseName}" 
                                               class="form-control" required>
                                    </div>
                                </div>
                                
                                <!-- Course Code -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">
                                        <i class="fas fa-code me-1"></i> Course Code
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                                        <input type="text" name="courseCode" value="${course.courseCode}" 
                                               class="form-control" required>
                                    </div>
                                </div>
                                
                                <!-- Instructor -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">
                                        <i class="fas fa-chalkboard-teacher me-1"></i> Instructor
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-user-tie"></i></span>
                                        <input type="text" name="instructor" value="${course.instructor}" 
                                               class="form-control" required>
                                    </div>
                                </div>
                                
                                <!-- Duration -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">
                                        <i class="fas fa-clock me-1"></i> Duration
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-calendar-alt"></i></span>
                                        <input type="text" name="duration" value="${course.duration}" 
                                               class="form-control" required>
                                    </div>
                                    <small class="text-muted">e.g., 3 Months, 6 Weeks, etc.</small>
                                </div>
                                
                                <!-- Price -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">
                                        <i class="fas fa-rupee-sign me-1"></i> Price
                                    </label>
                                    <div class="input-group price-input-group">
                                        <span class="input-group-text">₹</span>
                                        <input type="number" name="price" value="${course.price}" 
                                               step="0.01" min="0" class="form-control" required>
                                    </div>
                                </div>
                                
                                <!-- Category -->
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">
                                        <i class="fas fa-tags me-1"></i> Category
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-layer-group"></i></span>
                                        <select name="category" class="form-select" required>
                                            <option value="Programming" ${course.category == 'Programming' ? 'selected' : ''}>Programming</option>
                                            <option value="Full Stack" ${course.category == 'Full Stack' ? 'selected' : ''}>Full Stack</option>
                                            <option value="Frontend" ${course.category == 'Frontend' ? 'selected' : ''}>Frontend</option>
                                            <option value="Backend" ${course.category == 'Backend' ? 'selected' : ''}>Backend</option>
                                            <option value="Database" ${course.category == 'Database' ? 'selected' : ''}>Database</option>
                                            <option value="DevOps" ${course.category == 'DevOps' ? 'selected' : ''}>DevOps</option>
                                            <option value="Cloud" ${course.category == 'Cloud' ? 'selected' : ''}>Cloud</option>
                                            <option value="System" ${course.category == 'System' ? 'selected' : ''}>System</option>
                                            <option value="Other" ${course.category == 'Other' ? 'selected' : ''}>Other</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <!-- Description -->
                                <div class="col-12 mb-4">
                                    <label class="form-label fw-bold">
                                        <i class="fas fa-align-left me-1"></i> Description
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-file-alt"></i></span>
                                        <textarea name="description" class="form-control" rows="5" required>${course.description}</textarea>
                                    </div>
                                    <small class="text-muted">Detailed course description for students</small>
                                </div>
                                
                                <!-- Action Buttons -->
                                <div class="col-12">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <a href="/admin/courses" class="btn btn-secondary">
                                                <i class="fas fa-arrow-left me-2"></i> Back to Courses
                                            </a>
                                            <a href="/course/${course.id}" target="_blank" class="btn btn-info ms-2">
                                                <i class="fas fa-eye me-2"></i> View as Student
                                            </a>
                                        </div>
                                        <div>
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fas fa-save me-2"></i> Update Course
                                            </button>
                                            <a href="/admin/courses/delete/${course.id}" 
                                               class="btn btn-danger ms-2"
                                               onclick="return confirm('Are you sure you want to delete ${course.courseName}? This action cannot be undone.')">
                                                <i class="fas fa-trash me-2"></i> Delete Course
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Course Stats Footer -->
                    <div class="card-footer bg-light">
                        <div class="row">
                            <div class="col-md-4 text-center">
                                <small class="text-muted d-block">
                                    <i class="fas fa-code me-1"></i> Course Code
                                </small>
                                <strong>${course.courseCode}</strong>
                            </div>
                            <div class="col-md-4 text-center">
                                <small class="text-muted d-block">
                                    <i class="fas fa-rupee-sign me-1"></i> Price
                                </small>
                                <strong class="text-success">₹${course.price}</strong>
                            </div>
                            <div class="col-md-4 text-center">
                                <small class="text-muted d-block">
                                    <i class="fas fa-clock me-1"></i> Duration
                                </small>
                                <strong>${course.duration}</strong>
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
            
            // Update floating button icon
            const toggleBtn = document.querySelector('.dark-mode-toggle i');
            if (toggleBtn) {
                if (isDarkMode) {
                    toggleBtn.classList.remove('fa-moon');
                    toggleBtn.classList.add('fa-sun');
                } else {
                    toggleBtn.classList.remove('fa-sun');
                    toggleBtn.classList.add('fa-moon');
                }
            }
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
            
            // Form validation
            const form = document.querySelector('form');
            form.addEventListener('submit', function(e) {
                const price = document.querySelector('input[name="price"]').value;
                if (price < 0) {
                    e.preventDefault();
                    alert('Price cannot be negative');
                    return false;
                }
                
                const courseName = document.querySelector('input[name="courseName"]').value;
                if (courseName.trim().length < 3) {
                    e.preventDefault();
                    alert('Course name must be at least 3 characters');
                    return false;
                }
            });
            
            // Price formatting
            const priceInput = document.querySelector('input[name="price"]');
            priceInput.addEventListener('blur', function() {
                let value = parseFloat(this.value);
                if (!isNaN(value)) {
                    this.value = value.toFixed(2);
                }
            });
        });
    </script>
</body>
</html>