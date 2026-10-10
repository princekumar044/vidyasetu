<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle" value="Students Data - VidyaSetu " scope="request"/>
<%@include file="header.jsp" %>

<div class="professional-card">
    <div class="card-header">
        <div class="d-flex justify-content-between align-items-center">
            <h4 class="mb-0"><i class="fas fa-users me-2"></i> Students Database</h4>
            <div>
                <span class="badge bg-primary fs-6 p-2">
                    <i class="fas fa-database me-1"></i> Total Students: ${list.size()}
                </span>
            </div>
        </div>
    </div>
    
    <div class="card-body">
        <c:if test="${not empty list}">
            <div class="table-responsive">
                <table class="table professional-table">
                    <thead>
                        <tr>
                            <th><i class="fas fa-hashtag"></i> #</th>
                            <th><i class="fas fa-user"></i> Full Name</th>
                            <th><i class="fas fa-envelope"></i> Email</th>
                            <th><i class="fas fa-key"></i> Password</th>
                            <th><i class="fas fa-map-marker-alt"></i> Address</th>
                            <th><i class="fas fa-cogs"></i> Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="student" items="${list}" varStatus="status">
                            <tr>
                                <td class="fw-bold">${status.index + 1}</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="avatar-circle me-2" style="width: 36px; height: 36px; background-color: #3498db; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold;">
                                            ${student.fullname.charAt(0)}
                                        </div>
                                        ${student.fullname}
                                    </div>
                                </td>
                                <td>${student.email}</td>
                                <td>
                                    <span class="badge bg-secondary">
                                        <i class="fas fa-lock me-1"></i> ${student.password}
                                    </span>
                                </td>
                                <td class="text-truncate" style="max-width: 200px;" title="${student.address}">
                                    ${student.address}
                                </td>
                                <td>
                                    <div class="btn-group" role="group">
                                        <!-- FIXED: Added leading slash for correct URL -->
                                        <a href="/profileedit/${student.id}" class="btn btn-warning btn-sm me-2">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <!-- FIXED: Added leading slash for correct URL -->
                                        <a href="/delete/${student.id}" class="btn btn-danger btn-sm"
                                           onclick="return confirm('Are you sure you want to delete ${student.fullname}?')">
                                            <i class="fas fa-trash-alt"></i> Delete
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
        
        <c:if test="${empty list}">
            <div class="text-center py-5">
                <div class="mb-4">
                    <i class="fas fa-users-slash fa-4x text-muted"></i>
                </div>
                <h4 class="text-muted mb-3">No Students Found</h4>
                <p class="text-muted mb-4">There are no registered students in the database yet.</p>
                <a href="/register" class="btn btn-primary-custom">
                    <i class="fas fa-user-plus me-2"></i> Register First Student
                </a>
            </div>
        </c:if>
        
        <div class="mt-4 d-flex justify-content-between">
            <a href="/register" class="btn btn-success-custom">
                <i class="fas fa-user-plus me-2"></i> Add New Student
            </a>
            <a href="/" class="btn btn-secondary">
                <i class="fas fa-home me-2"></i> Back to Home
            </a>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>