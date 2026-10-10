<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle" value="Error - Student Portal" scope="request"/>
<%@include file="header.jsp"%>

<div class="container text-center py-5">
    <div class="professional-card">
        <div class="card-header bg-danger text-white">
            <h3><i class="fas fa-exclamation-triangle"></i> Error Occurred</h3>
        </div>
        <div class="card-body p-5">
            <c:choose>
                <c:when test="${pageContext.errorData.statusCode == 500}">
                    <i class="fas fa-bug fa-4x text-danger mb-4"></i>
                    <h4 class="text-danger">Server Error</h4>
                    <p class="lead">
                        <c:if test="${not empty exception}">
                            ${exception.message}
                        </c:if>
                        <c:if test="${empty exception}">
                            An internal server error occurred.
                        </c:if>
                    </p>
                </c:when>
                <c:when test="${pageContext.errorData.statusCode == 404}">
                    <i class="fas fa-map-signs fa-4x text-warning mb-4"></i>
                    <h4 class="text-warning">Page Not Found</h4>
                    <p class="lead">The page you're looking for doesn't exist.</p>
                </c:when>
                <c:otherwise>
                    <i class="fas fa-exclamation-circle fa-4x text-warning mb-4"></i>
                    <h4 class="text-warning">Error ${pageContext.errorData.statusCode}</h4>
                    <p class="lead">An error occurred while processing your request.</p>
                </c:otherwise>
            </c:choose>
            
            <div class="mt-4">
                <a href="/" class="btn btn-primary-custom me-3">
                    <i class="fas fa-home"></i> Back to Home
                </a>
                <a href="javascript:history.back()" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Go Back
                </a>
            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp"%>