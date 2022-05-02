<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QCali :: 관리자 로그인</title>
  <style>
    .rounded-t-5 {
      border-top-left-radius: 0.5rem;
      border-top-right-radius: 0.5rem;
    }

    @media (min-width: 992px) {
      .rounded-tr-lg-0 {
        border-top-right-radius: 0;
      }

      .rounded-bl-lg-5 {
        border-bottom-left-radius: 0.5rem;
      }
    }
    </style>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
</head>
<body>
	<jsp:include page="/WEB-INF/views/admin/main/adminHeader.jsp"></jsp:include>


	<div class="card mb-3">
		<div class="row g-0 d-flex align-items-center">
			<div class="col-lg-4 d-none d-lg-flex">
				<img
					src="https://mdbootstrap.com/img/new/ecommerce/vertical/004.jpg"
					alt="Trendy Pants and Shoes"
					class="w-100 rounded-t-5 rounded-tr-lg-0 rounded-bl-lg-5" />
			</div>
			<div class="col-lg-8">
				<div class="card-body py-5 px-md-5">

					<form:form commandName="AdminLoginCommand">
						<!-- Email input -->
						<div class="form-outline mb-4">
							<form:input class="form-control" path="adminId" />
							<form:errors path="adminId" />
							<label class="form-label" for="form2Example1">Email
								address</label>
						</div>

						<!-- Password input -->
						<div class="form-outline mb-4">
							<form:password class="form-control" path="adminPassword" />
							<form:errors path="adminPassword" />
							<label class="form-label" for="form2Example2">Password</label>
						</div>

						<button type="submit" class="btn btn-primary btn-block mb-4">Login</button>
					</form:form>
				</div>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
</body>
</html>