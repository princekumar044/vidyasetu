<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="${sessionScope.darkMode ? 'dark' : 'light'}">
<head>
    <title>${course.courseName} - Student Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --card-bg: #ffffff;
            --text-color: #212529;
            --border-color: #dee2e6;
            --primary-color: #3498db;
            --success-color: #27ae60;
        }
        
        [data-bs-theme="dark"] {
            --card-bg: #1e1e1e;
            --text-color: #e9ecef;
            --border-color: #343a40;
            --primary-color: #3498db;
            --success-color: #27ae60;
        }
        
        /* Fix navigation bar visibility */
        .navbar {
            background: linear-gradient(135deg, #2c3e50, #1a2530) !important;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        /* Course card enhancement */
        .course-card {
            border: none !important;
            border-radius: 12px !important;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08) !important;
            overflow: hidden;
            background: var(--card-bg) !important;
            color: var(--text-color);
        }
        
        .course-header {
            background: linear-gradient(135deg, #2c3e50, #3498db) !important;
            padding: 25px !important;
            position: relative;
        }
        
        /* Enrollment card styling */
        .enrollment-card {
            border: 2px solid var(--border-color) !important;
            border-radius: 12px !important;
            overflow: hidden;
            transition: all 0.3s ease;
            background: var(--card-bg);
            color: var(--text-color);
        }
        
        .enrollment-card:hover {
            border-color: var(--primary-color) !important;
            box-shadow: 0 8px 25px rgba(52, 152, 219, 0.15);
        }
        
        .enrollment-card .card-header {
            background: linear-gradient(135deg, #34495e, #2c3e50) !important;
            padding: 20px !important;
            font-size: 1.2rem;
            color: white !important;
        }
        
        /* Price styling */
        .price-tag {
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--success-color);
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        
        /* Alert styling */
        .alert-enhanced {
            border-radius: 10px;
            padding: 20px;
            border: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            background: var(--card-bg);
            color: var(--text-color);
            border: 1px solid var(--border-color);
        }
        
        .bg-light {
            background-color: var(--card-bg) !important;
            color: var(--text-color);
        }
        
        .text-muted {
            color: var(--text-color) !important;
            opacity: 0.8;
        }
        
        body {
            background-color: ${sessionScope.darkMode ? '#121212' : '#f8f9fa'};
            color: var(--text-color);
            transition: background-color 0.3s, color 0.3s;
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
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-graduation-cap me-2"></i> Student Portal
            </a>
            <div class="navbar-nav ms-auto align-items-center">
                <a class="nav-link" href="/">
                    <i class="fas fa-home me-1"></i> Home
                </a>
                <a class="nav-link" href="/courses">
                    <i class="fas fa-book me-1"></i> Courses
                </a>
                <c:if test="${not empty sessionScope.loggedInStudent}">
                    <a class="nav-link" href="/my-courses">
                        <i class="fas fa-user-graduate me-1"></i> My Courses
                    </a>
                    <span class="navbar-text">
                        <i class="fas fa-user me-1"></i> Welcome, ${sessionScope.loggedInStudent.fullname}
                    </span>
                    <a class="nav-link" href="/logout">
                        <i class="fas fa-sign-out-alt me-1"></i> Logout
                    </a>
                </c:if>
                <c:if test="${empty sessionScope.loggedInStudent}">
                    <a class="nav-link" href="/login">
                        <i class="fas fa-sign-in-alt me-1"></i> Login
                    </a>
                </c:if>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- Success/Error Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-enhanced alert-dismissible fade show">
                <i class="fas fa-check-circle me-2"></i> ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-enhanced alert-dismissible fade show">
                <i class="fas fa-exclamation-circle me-2"></i> ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Course Details -->
        <div class="card course-card">
            <div class="card-header course-header text-white">
                <h2><i class="fas fa-book-open me-2"></i> ${course.courseName}</h2>
                <h5 class="mb-0">
                    <span class="badge bg-light text-dark me-2">${course.courseCode}</span>
                    <span class="badge bg-info">${course.category}</span>
                </h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-8">
                        <h4 class="mb-3"><i class="fas fa-align-left me-2"></i> Description</h4>
                        <div class="bg-light p-4 rounded mb-4">
                            <p class="mb-0">${course.description}</p>
                        </div>
                        
                        <h4 class="mt-4 mb-3"><i class="fas fa-info-circle me-2"></i> Course Details</h4>
                        <div class="list-group">
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                <div>
                                    <i class="fas fa-chalkboard-teacher me-2 text-primary"></i>
                                    <strong>Instructor:</strong>
                                </div>
                                <span class="fw-bold">${course.instructor}</span>
                            </div>
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                <div>
                                    <i class="fas fa-clock me-2 text-primary"></i>
                                    <strong>Duration:</strong>
                                </div>
                                <span class="badge bg-warning text-dark">${course.duration}</span>
                            </div>
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                <div>
                                    <i class="fas fa-rupee-sign me-2 text-primary"></i>
                                    <strong>Price:</strong>
                                </div>
                                <span class="fw-bold text-success">₹${course.price}</span>
                            </div>
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                <div>
                                    <i class="fas fa-users me-2 text-primary"></i>
                                    <strong>Students Enrolled:</strong>
                                </div>
                                <span class="badge bg-primary">${enrollmentCount}</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card enrollment-card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-user-plus me-2"></i> Course Enrollment</h5>
                            </div>
                            <div class="card-body text-center p-4">
                                <!-- ENROLLMENT BUTTON SECTION -->
                                <c:choose>
                                    <c:when test="${empty sessionScope.loggedInStudent}">
                                        <div class="alert alert-warning alert-enhanced">
                                            <i class="fas fa-exclamation-triangle me-2"></i>
                                            <p class="mb-2">Please login to enroll in this course.</p>
                                            <a href="/login" class="btn btn-warning">
                                                <i class="fas fa-sign-in-alt me-1"></i> Login Now
                                            </a>
                                        </div>
                                    </c:when>
                                    <c:when test="${isEnrolled}">
                                        <div class="alert alert-success alert-enhanced">
                                            <i class="fas fa-check-circle me-2"></i>
                                            <p class="mb-2">You are enrolled in this course!</p>
                                            <a href="/my-courses" class="btn btn-success">
                                                <i class="fas fa-book me-1"></i> Go to My Courses
                                            </a>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- ENROLL BUTTON -->
                                        <div class="price-tag mb-4">${course.price}</div>
                                        <div class="mb-4">
                                            <form action="/enroll/${course.id}" method="post">
                                                <button type="submit" class="btn enroll-btn">
                                                    <i class="fas fa-user-plus me-2"></i> Enroll Now
                                                </button>
                                            </form>
                                        </div>
                                        <p class="text-muted">
                                            <small><i class="fas fa-shield-alt me-1"></i> Secure enrollment</small>
                                            <br>
                                            <small><i class="fas fa-bolt me-1"></i> Instant access after enrollment</small>
                                        </p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-footer bg-light">
                <a href="/courses" class="btn back-btn">
                    <i class="fas fa-arrow-left me-2"></i> Back to Courses
                </a>
            </div>
        </div>
    </div>

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

    <!-- Floating Dark Mode Toggle Button -->
    <button class="dark-mode-toggle" onclick="toggleDarkMode()" title="Toggle Dark Mode">
        <i class="fas ${sessionScope.darkMode ? 'fa-sun' : 'fa-moon'} fa-lg"></i>
    </button>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
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
        
        // Initialize when document is ready
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
            
            // Listen for system preference changes
            window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', event => {
                if (!localStorage.getItem('darkMode')) {
                    const newMode = event.matches;
                    document.documentElement.setAttribute('data-bs-theme', newMode ? 'dark' : 'light');
                    updateDarkModeIcons(newMode);
                }
            });
        });
        
        // Debug script to check session data
        console.log('Debug - Course Details Page:');
        console.log('Logged in student:', '${sessionScope.loggedInStudent}');
        console.log('Is enrolled:', '${isEnrolled}');
        console.log('Course ID:', '${course.id}');
        
        // Add hover effect to cards
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.card');
            cards.forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-5px)';
                });
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                });
            });
        });
    </script>
</body>
</html>