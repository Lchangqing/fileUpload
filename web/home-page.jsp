<%@page import="cn.edu.swu.mvcapp.listener.FileUploadSessionListener"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>home</title>
		<meta content="width=device-width, initial-scale=1.0" name="viewport">
		<meta content="" name="keywords">
		<meta content="" name="description">

		<!-- Custom fonts for this template -->
		<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
		<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

		<!-- Bootstrap css -->
		<!-- <link rel="stylesheet" href="css/bootstrap.css"> -->
		<link rel="stylesheet" type="text/css" href="css/sb-admin-2.min.css" />
		<!-- Libraries CSS Files -->
		<link href="vendor/animate/animate.min.css" rel="stylesheet">

		<!-- Main Stylesheet File -->
		<link href="css/style.css" rel="stylesheet">
		<style type="text/css">
			body {
				font-family: Nunito, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
				font-size: 1rem;
				font-weight: 400;
				line-height: 1.5;
				color: #858796;
				text-align: left;
			}
		</style>
	</head>

	<body style="background: #f8f9fc;">

		<div id="wrapper">

			<!-- sidebar -->
			<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion  wow fadeInUp" id="accordionSidebar">

				<!-- Sidebar - Brand -->
				<a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
					<div class="sidebar-brand-icon rotate-n-15">
						<i class="fas fa-laugh-wink"></i>
					</div>
					<div class="sidebar-brand-text mx-3">文件管理 <sup></sup></div>
				</a>

				<!-- Divider -->
				<hr class="sidebar-divider my-0">

				
				<!-- Nav Item - Dashboard -->
				<li class="nav-item">
					<a class="nav-link" href="home-page.jsp">
						<i class="fas fa-fw fa-tachometer-alt"></i>
						<span>首页</span></a>
				</li>

				<!-- Divider -->
				<hr class="sidebar-divider">

				<li class="nav-item ">
					<a class="nav-link" href="fileupload.jsp">
						<i class="fas fa-fw fa-file-upload  "  ></i>
						<span>文件上传</span></a>
				</li>

				<!-- Nav Item - Utilities Collapse Menu -->
				<li class="nav-item">
					<a class="nav-link collapsed" href="file-manage.jsp">
						<i class="fas fa-fw fa-folder-open"></i>
						<span>文件管理</span>
					</a>

				</li>

				<!-- Nav Item - Pages Collapse Menu -->
				<li class="nav-item">
					<a class="nav-link collapsed" href="userinfo.jsp">
						<i class="fas fa-fw fa-user-edit"></i>
						<span>个人信息</span>
					</a>
				</li>

				<!-- Divider -->
				<hr class="sidebar-divider">

				<!-- Nav Item - Charts -->
				<li class="nav-item">
					<a class="nav-link" href="authority-manager.jsp">
						<i class="fas fa-fw fa-cog"></i>
						<span>权限修改</span></a>
				</li>

				<!-- Divider -->
				<hr class="sidebar-divider d-none d-md-block">

				<!-- Sidebar Toggler (Sidebar) -->
				<div class="text-center d-none d-md-inline">
					<button class="rounded-circle border-0" id="sidebarToggle"></button>
				</div>

			</ul>
			<!-- End of Sidebar -->
			<!--==========================
    Get Started Section
  ============================-->
			<section id="get-started" class="padd-section text-center wow fadeInUp">
				<div class="container">
					<div>
		              <i class="fa fa-map-marker"></i>
		              <p>在线人数<br><%= FileUploadSessionListener.getActiveSessions()%></p>
		            </div>
					<div class="section-title text-center">

						<h2 class="text-dark">欢迎来到文件管理系统 </h2>
						<p class="">通过该系统，您可以进行文件的上传和下载</p>

					</div>
				</div>

				<div class="container">
					<div class="row">

						<div class="col-md-6 col-lg-4">
							<div class="feature-block">

								<img src="img/svg/cloud.svg" alt="img" class="img-fluid">
								<h4 class="text-dark">文件上传</h4>
								<p>您可以将本地文件上传</p>
								<a href="fileupload.jsp">进入</a>

							</div>
						</div>

						<div class="col-md-6 col-lg-4">
							<div class="feature-block">

								<img src="img/svg/planet.svg" alt="img" class="img-fluid">
								<h4 class="text-dark">文件管理</h4>
								<p>您可以对自己的文件进行下载或删除</p>
								<a href="file-manage.jsp">进入</a>

							</div>
						</div>

						<div class="col-md-6 col-lg-4">
							<div class="feature-block">

								<img src="img/svg/asteroid.svg" alt="img" class="img-fluid">
								<h4 class="text-dark">个人信息</h4>
								<p>你可以对个人的信息进行编辑</p>
								<a href="userinfo.jsp">进入</a>

							</div>
						</div>

					</div>
				</div>

			</section>
		</div>

		<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>

		<!-- JavaScript Libraries -->
		<script src="vendor/jquery/jquery.min.js"></script>
		<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
		<script src="vendor/wow/wow.js"></script>

		<!-- Template Main Javascript File -->
		<script src="js/main.js"></script>
		<script src="js/sb-admin-2.min.js" type="text/javascript" charset="utf-8"></script>

	</body>

</html>