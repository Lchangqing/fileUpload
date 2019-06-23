<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>flieupload</title>

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">

	<div class="container">

		<!-- Outer Row -->
		<div class="row justify-content-center">

			<div class="col-sm-9">

				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-0">
						<!-- Nested Row within Card Body -->
						<div class="row">
							<div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
							<div class="col-lg-6">
								<div class="p-5">
									<div class="text-center">
										<h1 class="h4 text-gray-900 mb-4">欢迎回来!</h1>
									</div>

									<%
										Object msg = request.getAttribute("message");
										if (msg != null) {
									%>
									<div class="card mb-2  ">
										<div class="px-3 py-1 bg-gradient-primary text-white"><%= msg %></div>
									</div>
									<%
										}
									%>
									
									<% System.out.println("index.jsp:"+request.getSession().getId()); %>
									<form class="user" action="<%= response.encodeURL(request.getContextPath()+"/gohome.do")%>" method="post" id="log">
										<div class="form-group row">
											<div class="col-sm-12 cqdiv ">用户</div>
												<div class="col-sm-12 ">
													<input type="password" class="form-control form-control-user" id="exampleFirstName" placeholder="006" name='snumber'>
												</div>
										</div>
										<div class="form-group row">
											<div class="col-sm-12 cqdiv ">密码</div>
												<div class="col-sm-12 ">
													<input type="password" class="form-control form-control-user" id="exampleFirstName" placeholder="123456" name='passwd'>
												</div>
										</div>
										<a href="javascript:;" onclick="doucument:log.submit()"
											class="btn btn-primary btn-user btn-block"> 登陆 </a>
									</form>
									<hr>
									<div class="text-center">
										<a class="small" href="<%= response.encodeURL(request.getContextPath()+"/register.jsp")%>">创建用户!</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>

		</div>

	</div>

	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin-2.min.js"></script>

</body>

</html>