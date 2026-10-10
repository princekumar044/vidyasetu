<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="My Courses - VidyaSetu " scope="request"/>
<%@include file="header.jsp"%>

<div class="professional-card">
	<div class="card-header">
		<div class="d-flex justify-content-between align-items-center">
			<h4 class="mb-0">
				<i class="fas fa-user-graduate"></i> My Enrolled Courses
			</h4>
			<span class="badge bg-primary fs-6 p-2"> <i
				class="fas fa-book"></i> <c:choose>
					<c:when test="${not empty enrollments}">${enrollments.size()} Courses</c:when>
					<c:otherwise>0 Courses</c:otherwise>
				</c:choose>
			</span>
		</div>
	</div>

	<div class="card-body">
		<!-- Success Message -->
		<c:if test="${not empty successMessage}">
			<div class="alert alert-success alert-professional">
				<i class="fas fa-check-circle me-2"></i> ${successMessage}
			</div>
		</c:if>

		<c:if test="${not empty enrollments}">
			<div class="table-responsive">
				<table class="table professional-table">
					<thead>
						<tr>
							<th><i class="fas fa-hashtag"></i> #</th>
							<th><i class="fas fa-book"></i> Course Name</th>
							<th><i class="fas fa-code"></i> Course Code</th>
							<th><i class="fas fa-user-tie"></i> Instructor</th>
							<th><i class="fas fa-calendar-alt"></i> Enrolled Date</th>
							<th><i class="fas fa-rupee-sign"></i> Price</th>
							<th><i class="fas fa-cogs"></i> Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="enrollment" items="${enrollments}"
							varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td><strong>${enrollment.course.courseName}</strong>
									<div class="small text-muted">${enrollment.course.category}</div>
								</td>
								<td>${enrollment.course.courseCode}</td>
								<td>${enrollment.course.instructor}</td>
								<td><fmt:formatDate
										value="${enrollment.enrolledDateAsDate}"
										pattern="dd-MMM-yyyy" /></td>
								<td class="fw-bold text-success">₹<fmt:formatNumber
										value="${enrollment.course.price}" type="number"
										minFractionDigits="0" />
								</td>
								<td>
									<div class="btn-group" role="group">
										<a href="/course/${enrollment.course.id}"
											class="btn btn-primary btn-sm me-2"> <i
											class="fas fa-eye"></i> View
										</a>
										<form action="/unenroll/${enrollment.id}" method="post"
											style="display: inline;">
											<button type="submit" class="btn btn-danger btn-sm"
												onclick="return confirm('Are you sure you want to unenroll from ${enrollment.course.courseName}?')">
												<i class="fas fa-trash"></i> Unenroll
											</button>
										</form>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<!-- Course Statistics -->
			<div class="row mt-4">
				<div class="col-md-3">
					<div class="stats-card text-center">
						<i class="fas fa-book fa-2x mb-2" style="color: #3498db;"></i>
						<h4>${enrollments.size()}</h4>
						<p class="text-muted mb-0">Total Courses</p>
					</div>
				</div>
				<div class="col-md-3">
					<div class="stats-card text-center">
						<i class="fas fa-rupee-sign fa-2x mb-2" style="color: #27ae60;"></i>
						<h4>
							<c:set var="totalPrice" value="0" />
							<c:forEach var="enrollment" items="${enrollments}">
								<!-- Convert BigDecimal to double for addition -->
								<c:set var="totalPrice"
									value="${totalPrice + enrollment.course.price.doubleValue()}" />
							</c:forEach>
							₹
							<fmt:formatNumber value="${totalPrice}" type="number"
								minFractionDigits="0" />
						</h4>
						<p class="text-muted mb-0">Total Investment</p>
					</div>
				</div>
				<div class="col-md-3">
					<div class="stats-card text-center">
						<i class="fas fa-chart-line fa-2x mb-2" style="color: #e74c3c;"></i>
						<h4>
							<!-- Calculate progress (simplified) -->
							<c:set var="progress" value="${enrollments.size() * 20}" />
							<c:if test="${progress > 100}">
								<c:set var="progress" value="100" />
							</c:if>
							${progress}%
						</h4>
						<p class="text-muted mb-0">Overall Progress</p>
					</div>
				</div>
				<div class="col-md-3">
					<div class="stats-card text-center">
						<i class="fas fa-calendar-check fa-2x mb-2"
							style="color: #9b59b6;"></i>
						<h4>${enrollments.size()}</h4>
						<p class="text-muted mb-0">Active Enrollments</p>
					</div>
				</div>
			</div>
		</c:if>

		<c:if test="${empty enrollments}">
			<div class="text-center py-5">
				<i class="fas fa-graduation-cap fa-4x text-muted mb-3"></i>
				<h4 class="text-muted">No Courses Enrolled</h4>
				<p class="text-muted mb-4">You haven't enrolled in any courses
					yet.</p>
				<a href="/courses" class="btn btn-primary-custom btn-lg"> <i
					class="fas fa-search me-2"></i> Browse Available Courses
				</a>
			</div>
		</c:if>

		<div class="mt-4">
			<a href="/courses" class="btn btn-secondary me-3"> <i
				class="fas fa-arrow-left me-2"></i> Back to All Courses
			</a> <a href="/" class="btn btn-primary-custom"> <i
				class="fas fa-home me-2"></i> Back to Home
			</a>
		</div>
	</div>
</div>

<style>
.stats-card {
	background: white;
	border-radius: 10px;
	padding: 20px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
	transition: transform 0.3s ease;
	height: 100%;
}

.stats-card:hover {
	transform: translateY(-5px);
}

.stats-card i {
	margin-bottom: 15px;
}
</style>

<%@include file="footer.jsp"%>