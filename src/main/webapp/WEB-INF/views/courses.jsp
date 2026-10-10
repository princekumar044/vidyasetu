<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="Available Courses - VidyaSetu " scope="request"/>
<%@include file="header.jsp"%>

<!-- Search Bar -->
<div class="row mb-4">
    <div class="col-md-8">
        <form action="/search-courses" method="get" class="d-flex">
            <input type="text" name="keyword" class="form-control me-2" 
                   placeholder="Search courses by name, description, or category..." 
                   value="${searchKeyword}">
            <button type="submit" class="btn btn-primary-custom">
                <i class="fas fa-search"></i> Search
            </button>
        </form>
    </div>
    <c:if test="${sessionScope.loggedInStudent != null}">
        <div class="col-md-4 text-end">
            <a href="/my-courses" class="btn btn-success-custom">
                <i class="fas fa-user-graduate"></i> My Courses
            </a>
        </div>
    </c:if>
</div>

<!-- Courses Grid -->
<c:choose>
    <c:when test="${not empty courses}">
        <div class="row">
            <c:forEach var="course" items="${courses}">
                <div class="col-md-4 mb-4">
                    <div class="professional-card h-100">
                        <div class="card-header" style="background: linear-gradient(135deg, #2c3e50, #3498db);">
                            <h5 class="mb-0 text-white">${course.courseName}</h5>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <span class="course-badge">${course.category}</span>
                                <span class="badge bg-secondary ms-2">${course.duration}</span>
                            </div>
                            <p class="card-text">
                                <c:choose>
                                    <c:when test="${course.description.length() > 100}">
                                        ${course.description.substring(0, 100)}...
                                    </c:when>
                                    <c:otherwise>
                                        ${course.description}
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <p class="fw-bold"><i class="fas fa-chalkboard-teacher"></i> ${course.instructor}</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="text-success mb-0">
                                    <i class="fas fa-rupee-sign"></i> 
                                    <fmt:formatNumber value="${course.price}" type="number" minFractionDigits="0"/>
                                </h5>
                                <a href="/course/${course.id}" class="btn btn-primary-custom btn-sm">
                                    <i class="fas fa-info-circle"></i> View Details
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <div class="text-center py-5">
            <i class="fas fa-book fa-4x text-muted mb-3"></i>
            <h4 class="text-muted">No Courses Available</h4>
            <p class="text-muted">Check back later for new courses.</p>
        </div>
    </c:otherwise>
</c:choose>

<%@include file="footer.jsp"%>