<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="pageTitle" value="Add New Course - Admin Panel"
	scope="request" />

<!DOCTYPE html>
<html lang="en"
	data-bs-theme="${sessionScope.darkMode ? 'dark' : 'light'}">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${pageTitle}</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<style>
/* DARK MODE VARIABLES - MATCHING CALENDAR PAGE */
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
	background-color: var(--bg-color) !important;
	color: var(--text-color) !important;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	transition: background-color 0.3s ease, color 0.3s ease !important;
}

/* Admin Navigation - MATCHING CALENDAR PAGE */
.admin-nav {
	background: var(--sidebar-bg) !important;
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
	background: rgba(52, 152, 219, 0.2) !important;
	border-left: 4px solid var(--primary-color) !important;
	color: white !important;
}

.admin-nav .nav-link.active {
	background: rgba(52, 152, 219, 0.3) !important;
	border-left: 4px solid var(--primary-color) !important;
	color: white !important;
}

/* Navbar - MATCHING CALENDAR PAGE */
.navbar {
	background: var(--navbar-bg) !important;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1) !important;
}

.navbar-brand, .navbar-text, .nav-link {
	color: var(--navbar-text) !important;
}

.btn-outline-light {
	color: var(--navbar-text) !important;
	border-color: rgba(255, 255, 255, 0.5) !important;
}

.btn-outline-light:hover {
	background-color: rgba(255, 255, 255, 0.1) !important;
	border-color: rgba(255, 255, 255, 0.8) !important;
}

/* Card Styles - MATCHING CALENDAR PAGE */
.card {
	background-color: var(--card-bg) !important;
	border-color: var(--border-color) !important;
	color: var(--text-color) !important;
	border-radius: 10px;
	box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
	margin-bottom: 20px;
	transition: background-color 0.3s, color 0.3s, border-color 0.3s;
}

.card-header {
	background-color: var(--card-bg) !important;
	border-bottom-color: var(--border-color) !important;
	color: var(--text-color) !important;
	font-weight: 700;
}

/* Form Controls - MATCHING CALENDAR PAGE */
.form-control, .form-select, .form-check-input, textarea {
	background-color: var(--card-bg) !important;
	color: var(--text-color) !important;
	border-color: var(--border-color) !important;
}

.form-control:focus, .form-select:focus {
	background-color: var(--card-bg) !important;
	color: var(--text-color) !important;
	border-color: var(--primary-color) !important;
	box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25) !important;
}

.form-label, .form-text, .form-check-label {
	color: var(--text-color) !important;
}

.text-muted {
	color: var(--muted-text) !important;
}

/* Alerts */
.alert {
	background-color: var(--card-bg) !important;
	color: var(--text-color) !important;
	border-color: var(--border-color) !important;
}

.alert-success {
	border-color: var(--success-color) !important;
}

.alert-danger {
	border-color: var(--danger-color) !important;
}

/* Buttons */
.btn-primary {
	background: linear-gradient(135deg, var(--primary-color), #2980b9);
	border: none;
	color: white;
	padding: 10px 20px;
	border-radius: 5px;
	font-weight: 600;
	transition: all 0.3s;
}

.btn-primary:hover {
	background: linear-gradient(135deg, #2980b9, var(--primary-color));
	color: white;
	transform: translateY(-2px);
}

.btn-secondary {
	background-color: var(--secondary-color);
	border-color: var(--secondary-color);
}

/* Floating Dark Mode Toggle Button - MATCHING CALENDAR PAGE */
.dark-mode-toggle-btn {
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

.dark-mode-toggle-btn:hover {
	transform: scale(1.1);
}

/* Responsive Styles */
@media ( max-width : 768px) {
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
}
</style>
</head>
<body>
	<!-- Admin Header - MATCHING CALENDAR PAGE -->
	<nav class="navbar navbar-dark">
		<div class="container-fluid">
			<a class="navbar-brand" href="/admin/dashboard"> <i
				class="fas fa-user-shield me-2"></i> Admin Panel
			</a>
			<div class="d-flex align-items-center">
				<span class="navbar-text text-light me-3"> <i
					class="fas fa-user me-1"></i> ${admin.fullname}
				</span> <a href="/admin/logout" class="btn btn-outline-light btn-sm"> <i
					class="fas fa-sign-out-alt me-1"></i> Logout
				</a>
			</div>
		</div>
	</nav>

	<div class="container-fluid">
		<div class="row">
			<!-- Sidebar - UPDATED TO MATCH CALENDAR PAGE -->
			<div class="col-md-3 col-lg-2 px-0 admin-nav">
				<div class="p-3">
					<h5 class="text-light mb-4">
						<i class="fas fa-tachometer-alt me-2"></i> Dashboard
					</h5>
					<ul class="nav flex-column">
						<li class="nav-item"><a class="nav-link"
							href="/admin/dashboard"> <i class="fas fa-chart-bar me-2"></i>
								Overview
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/admin/students"> <i class="fas fa-users me-2"></i>
								Students
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/admin/courses"> <i class="fas fa-book me-2"></i>
								Courses
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/admin/enrollments"> <i
								class="fas fa-user-graduate me-2"></i> Enrollments
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/admin/calendar"> <i class="fas fa-calendar-alt me-2"></i>
								Event Calendar
						</a></li>
						<li class="nav-item"><a class="nav-link active"
							href="/admin/add-course"> <i class="fas fa-plus-circle me-2"></i>
								Add Course
						</a></li>
						<li class="nav-item"><a class="nav-link" href="/"> <i
								class="fas fa-external-link-alt me-2"></i> View Site
						</a></li>
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
					<h3>
						<i class="fas fa-plus-circle me-2"></i> Add New Course
					</h3>
					<a href="/admin/courses" class="btn btn-secondary"> <i
						class="fas fa-arrow-left me-1"></i> Back to Courses
					</a>
				</div>

				<!-- Course Form -->
				<div class="card">
					<div class="card-body">
						<form action="/admin/courses/add" method="POST" id="courseForm">
							<div class="row mb-3">
								<div class="col-md-6">
									<label class="form-label">Course Name</label> <input
										type="text" class="form-control" name="courseName" required>
								</div>
								<div class="col-md-6">
									<label class="form-label">Course Code</label> <input
										type="text" class="form-control" name="courseCode" required>
								</div>
							</div>

							<div class="row mb-3">
								<div class="col-md-12">
									<label class="form-label">Description</label>
									<textarea class="form-control" name="description" rows="3"
										required></textarea>
								</div>
							</div>

							<div class="row mb-3">
								<div class="col-md-6">
									<label class="form-label">Instructor</label> <input type="text"
										class="form-control" name="instructor" required>
								</div>
								<div class="col-md-6">
									<label class="form-label">Duration</label> <input type="text"
										class="form-control" name="duration" required
										placeholder="e.g., 3 Months">
								</div>
							</div>

							<div class="row mb-3">
								<div class="col-md-6">
									<label class="form-label">Price (₹)</label> <input
										type="number" class="form-control" name="price" step="0.01"
										required>
								</div>
								<div class="col-md-6">
									<label class="form-label">Category</label> <select
										class="form-select" name="category" required>
										<option value="">Select Category</option>
										<option value="Programming">Programming</option>
										<option value="Web Development">Web Development</option>
										<option value="Data Science">Data Science</option>
										<option value="Mobile Development">Mobile Development</option>
										<option value="Other">Other</option>
									</select>
								</div>
							</div>

							<div class="d-grid">
								<button type="submit" class="btn btn-primary btn-lg">
									<i class="fas fa-save me-2"></i> Add Course
								</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Floating Dark Mode Toggle Button -->
	<button class="dark-mode-toggle-btn" onclick="toggleDarkMode()"
		title="Toggle Dark Mode">
		<i id="floatIcon"
			class="fas ${sessionScope.darkMode ? 'fa-sun' : 'fa-moon'}"></i>
	</button>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script>
        // SIMPLIFIED DARK MODE FUNCTION
        function toggleDarkMode() {
            const html = document.documentElement;
            const isDark = html.getAttribute('data-bs-theme') === 'dark';
            const newMode = isDark ? 'light' : 'dark';
            
            console.log('Switching from', isDark ? 'dark' : 'light', 'to', newMode);
            
            // Update HTML attribute
            html.setAttribute('data-bs-theme', newMode);
            
            // Update floating button icon
            const floatIcon = document.getElementById('floatIcon');
            if (floatIcon) {
                floatIcon.className = newMode === 'dark' ? 'fas fa-sun' : 'fas fa-moon';
            }
            
            // Save to localStorage
            localStorage.setItem('darkMode', newMode === 'dark');
            
            // Send to server if needed
            try {
                fetch('/api/settings/dark-mode', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ darkMode: newMode === 'dark' })
                });
            } catch (e) {
                console.log('Could not save to server:', e);
            }
        }
        
        // Initialize on page load
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Page loaded, checking dark mode...');
            
            // Get current dark mode state
            const savedMode = localStorage.getItem('darkMode');
            const sessionMode = ${sessionScope.darkMode ? 'true' : 'false'};
            const currentMode = document.documentElement.getAttribute('data-bs-theme');
            
            console.log('Saved mode:', savedMode);
            console.log('Session mode:', sessionMode);
            console.log('Current HTML mode:', currentMode);
            
            // Determine which mode to use
            let darkMode = false;
            
            if (savedMode !== null) {
                darkMode = savedMode === 'true';
            } else if (sessionMode) {
                darkMode = sessionMode;
            } else {
                // Check system preference
                darkMode = window.matchMedia('(prefers-color-scheme: dark)').matches;
            }
            
            console.log('Applying dark mode:', darkMode);
            
            // Apply if different
            if ((darkMode && currentMode !== 'dark') || (!darkMode && currentMode !== 'light')) {
                document.documentElement.setAttribute('data-bs-theme', darkMode ? 'dark' : 'light');
                
                // Update floating button
                const floatIcon = document.getElementById('floatIcon');
                if (floatIcon) {
                    floatIcon.className = darkMode ? 'fas fa-sun' : 'fas fa-moon';
                }
            }
            
            // Listen for system preference changes
            window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
                if (!localStorage.getItem('darkMode')) {
                    const newMode = e.matches ? 'dark' : 'light';
                    document.documentElement.setAttribute('data-bs-theme', newMode);
                    
                    // Update floating button
                    const floatIcon = document.getElementById('floatIcon');
                    if (floatIcon) {
                        floatIcon.className = newMode === 'dark' ? 'fas fa-sun' : 'fas fa-moon';
                    }
                }
            });
        });
    </script>
</body>
</html>