<%@page import="cn.edu.swu.mvcapp.domain.Students"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>

	<head>

		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="">
		<meta name="author" content="">

		<title>userinfo</title>

		<!-- Custom fonts for this template -->
		<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
		<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

		<!-- Custom styles for this template -->
		<link href="css/sb-admin-2.min.css" rel="stylesheet">

		<!-- Custom styles for this page -->
		<link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

		<script src="vendor/jquery/jquery.min.js"></script>
		<script type="text/javascript">
			$(function() {
				$("#inputsnumber").bind("input propertychange",function(event){
				       if($("#inputsnumber").val().match(/^\s*$/)){
				       	console.log('no')
				       	$("#psnumber").css('display','block')
				       }else{
				       	$("#psnumber").css('display','none')
				       }
				
				});
				
				$(document).keydown(function(event){
					if(event.keyCode==13){
						check()
					}
				})
			});
			function check(){
		        if ( $("#inputsnumber").val().match(/^\s*$/) ) {
		            alert("学号不能为空");
		            return false;
		        }
		        return $("#userinfo").submit();
		    }
		</script>
		<style type="text/css">
			.cqrow {
				margin: 2.3em 0;
			}
			
			.cqa {
				color: rgb(58, 97, 208) !important;
				width: 10em;
			}
			
			.cqa:hover {
				color: white !important;
			}
			
			.cqdiv1 {
				margin-bottom: 2em;
			}
			.cqdiv{
				line-height: 3em ;
			}
		</style>

	</head>

	<body id="page-top">

		<!-- Page Wrapper -->
		<div id="wrapper">

			<!-- Sidebar -->
			<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

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
			<div id="content-wrapper" class="d-flex flex-column">

				<!-- Main Content -->
				<div id="content">

					<!-- Begin Page Content -->
					<div class="container">

						<!-- DataTales Example -->
						<div class="card shadow mb-5">
							<div class="card-header py-3">
								<h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-fw fa-cog"></i>个人信息</h6>
							</div>

							<div class="card o-hidden border-0 shadow-lg my-5">
								<div class="card-body p-0">
									<!-- Nested Row within Card Body -->
									<div class="row">
										<div class="col-lg-5 d-none d-lg-block bg-userinfo-image"></div>
										<div class="col-lg-7">
											<div class="p-5">
												<div class="text-center">
													<h1 class="h4 text-gray-900 mb-4">信息完善</h1>
												</div>
												<% Students s=(Students)session.getAttribute("STUDENT"); 
													String oldsnumber=s.getSnumber();
												  Object msg=request.getAttribute("message");
														if(msg!=null){
													%>
													<p style="color: brown;text-align: center;font-weight: bold;"><%=msg %></p>
													<% } %>
												<form class="user" action="<%=request.getContextPath()%>/savemore.do?oldsnumber=<%=oldsnumber %>" method="post"  id="userinfo">
													<div class="form-group row">
														<div class="col-sm-2 cqdiv ">姓名</div>
														<div class="col-sm-8 ">
															<input name="name" id="inputname" type="text" class="form-control form-control-user" value="<%= s.getName()==null?"":s.getName() %>">
														</div>
													</div>
													
													<div class="form-group row">
														<div class="col-sm-2 cqdiv">学号</div>
														<div class="col-sm-8 ">
															<input name="snumber"  type="text" class="form-control form-control-user" id="inputsnumber" value="<%= s.getSnumber() %>">
														</div>
														<div>
															<p id="psnumber" style="color: brown; font-size: 0.8em;line-height: 4em ;display:none;">学号不能为空</p>	
														</div>
													</div>
													<div class="form-group row">
														<div class="col-sm-2 cqdiv">电话</div>
														<div class="col-sm-8 ">
															<input name="phone" id="inputphone" type="text" class="form-control form-control-user"  value="<%= s.getPhone()==null?"":s.getPhone() %>">
														</div>
													</div>
													<div class="form-group row">
														<div class="col-sm-2 cqdiv">QQ</div>
														<div class="col-sm-8 ">
															<input name="qq" id="inputqq" type="text" class="form-control form-control-user"  value="<%= s.getQq()==null?"":s.getQq() %>">
														</div>
													</div>
													<div class="form-group row">
														<div class="col-sm-2 cqdiv">邮箱</div>
														<div class="col-sm-8 ">
															<input name="email" id="inputemail" type="text" class="form-control form-control-user"  value="<%= s.getEmail()==null?"":s.getEmail() %>">
														</div>
													</div>

													<a href="javascript:;" class="btn btn-primary btn-user btn-block col-sm-10" onclick="check()">
														确认修改
													</a>
													<hr>

												</form>

												<div class="offset-sm-4">
													<a class="small" href="passwd-manage.jsp">修改密码？点这里</a>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="card-body">
							</div>
							<!-- /.container-fluid -->

						</div>
						<!-- End of Main Content -->

						<!-- Footer -->
						<footer class="sticky-footer bg-white">
							<div class="container my-auto">
								<div class="copyright text-center my-auto">
									<span>Copyright &copy; Your Website 2019</span>
								</div>
							</div>
						</footer>
						<!-- End of Footer -->

					</div>
					<!-- End of Content Wrapper -->

				</div>
				<!-- End of Page Wrapper -->
				<!-- Scroll to Top Button-->
				<a class="scroll-to-top rounded" href="#page-top">
					<i class="fas fa-angle-up"></i>
				</a>
				<!-- Bootstrap core JavaScript-->
				<script src="vendor/jquery/jquery.min.js"></script>
				<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

				<!-- Core plugin JavaScript-->
				<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

				<!-- Custom scripts for all pages-->
				<script src="js/sb-admin-2.min.js"></script>

				<!-- Page level plugins -->
				<script src="vendor/datatables/jquery.dataTables.min.js"></script>
				<script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

				<!-- Page level custom scripts -->
				<script src="js/demo/datatables-demo.js"></script>

	</body>

</html>