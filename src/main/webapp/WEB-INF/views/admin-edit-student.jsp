<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle" value="Edit Student - Admin Panel" scope="request"/>
<style>
    .admin-nav {
        background: linear-gradient(135deg, #2c3e50, #1a2530);
        min-height: 100vh;
        padding: 0;
    }
    
    .admin-nav .nav-link {
        color: #ecf0f1 !important;
        padding: 15px 20px;
        border-left: 4px solid transparent;
        transition: all 0.3s;
    }
    
    .admin-nav .nav-link:hover {
        background: rgba(52, 152, 219, 0.2);
        border-left: 4px solid #3498db;
        color: white !important;
    }
    
    .admin-nav .nav-link.active {
        background: rgba(52, 152, 219, 0.3);
        border-left: 4px solid #3498db;
        color: white !important;
    }
    
    .form-card {
        max-width: 800px;
        margin: 0 auto;
    }
</style>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body>
    <!-- Admin Header -->
    <nav class="navbar navbar-dark" style="background: linear-gradient(135deg, #1a2530, #2c3e50);">
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
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0"><i class="fas fa-user-edit me-2"></i> Edit Student</h4>
                    </div>
                    <div class="card-body">
                        <div class="text-center mb-4">
                            <div class="avatar-circle mx-auto mb-3" 
                                 style="width: 80px; height: 80px; background: linear-gradient(135deg, #3498db, #2980b9); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 2rem; font-weight: bold;">
                                ${student.fullname.charAt(0)}
                            </div>
                            <h5>Editing: ${student.fullname}</h5>
                            <p class="text-muted">Student ID: ${student.id}</p>
                        </div>
                        
                        <form action="/admin/students/update/${student.id}" method="post">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Full Name</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                                        <input type="text" name="fullname" value="${student.fullname}" 
                                               class="form-control" required>
                                    </div>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Email Address</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                        <input type="email" name="email" value="${student.email}" 
                                               class="form-control" required>
                                    </div>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Password</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                        <input type="password" name="password" 
                                               placeholder="Leave empty to keep current password" 
                                               class="form-control">
                                    </div>
                                    <small class="text-muted">Leave blank to keep current password</small>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Role</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-user-tag"></i></span>
                                        <select name="role" class="form-select" required>
                                            <option value="STUDENT" ${student.role == 'STUDENT' ? 'selected' : ''}>Student</option>
                                            <option value="ADMIN" ${student.role == 'ADMIN' ? 'selected' : ''}>Administrator</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="col-12 mb-4">
                                    <label class="form-label fw-bold">Address</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                                        <textarea name="address" class="form-control" rows="3" required>${student.address}</textarea>
                                    </div>
                                </div>
                                
                                <div class="col-12">
                                    <div class="d-flex justify-content-between">
                                        <a href="/admin/students" class="btn btn-secondary">
                                            <i class="fas fa-arrow-left me-2"></i> Back to Students
                                        </a>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save me-2"></i> Update Student
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>