<%@page import="cn.edu.swu.mvcapp.domain.Students"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">

	<head>

		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="">
		<meta name="author" content="">

		<title>filemanage</title>

		<!-- Custom fonts for this template -->
		<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
		<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

		<!-- Custom styles for this template -->
		<link href="css/sb-admin-2.min.css" rel="stylesheet">

		<!-- Custom styles for this page -->
		<link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="vendor/icheck/all.css"/>
		<script src="vendor/jquery/jquery.min.js"></script>
		<script src="vendor/icheck/icheck.min.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
			$(function() {
				$("input").iCheck({
				  labelHover : false, 
				  cursor : true, 
				  checkboxClass: 'icheckbox_square-blue',
  				  radioClass: 'iradio_square-blue',
				  increaseArea : '20%' 
				})
				$("#myModal").on("show.bs.modal",function(){
					console.log("id",id)
					$("#getid").attr("value",id)
				})
			});
			let id;
			function get(id_){
				id=id_
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
			
			.cqdiv {
				line-height: 3em;
			}
			
			.cqmb-back {
				background: url(img/3.jpg) no-repeat;
				/*opacity: 0.4;*/
				background-size: cover;
			}
			
			.cqmb-top {
				background-color: rgba(255, 255, 255, 0.9);
			}
			
			.cqfont {
				color: #4e73df !important;
				opacity: 1;
			}
			
			.table th,
			.table td,
			.table thead th {
				border-color: #9598a3;
				text-align: center;
			}
			
			tr:hover{
				font-weight: bolder;
			}
			a:hover{
			text-decoration:none;
			}
		</style>

	</head>

	<body id="page-top ">

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
					<div class="container text-gray-700">

						<!-- DataTales Example -->
						<div class="card shadow mb-5">
							<div class="card-header py-3">
								<h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-fw fa-cog"></i>权限修改</h6>
							</div>
						<!--begin modal-->
							 <!--按钮触发模态框--> 
							<!--<button class="btn btn-outline-primary col-sm-2" data-toggle="modal" data-target="#myModal" >权限修改</button>-->
							<!-- 模态框（Modal） -->
							<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title" id="myModalLabel">权限修改</h4>
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
										</div>
										<form action="<%=request.getContextPath()%>/updateAuth.go" method="post"  id="updateAuth">
											<input id="getid" type="hidden" name="id" value="" />
											<div class="modal-body" margin:0;padding:0">
												<div class="input-group mb-1 mt-1" >
												  <div class="input-group-prepend" style="margin-left: 1em">
												    <span class="input-group-text" id="">管理个人文件</span>
												  </div>
												  <div class="input-group-prepend" >
												    <div class="input-group-text">
												      <input name="auth" value="authone" type="checkbox" aria-label="Checkbox for following text input">
												    </div>
												  </div>
												   <div class="input-group-prepend" style="margin-left: 5em">
												    <span class="input-group-text" id="">管理所有文件</span>
												  </div>
												  <div class="input-group-prepend">
												    <div class="input-group-text">
												    <input name="auth" value="authall" type="checkbox" aria-label="Checkbox for following text input">
												    </div>
												  </div>
												</div>

											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
												<button type="button" class="btn btn-primary" onclick='doucument:updateAuth.submit()' >修改</button>
											</div>
										</form>
										
									</div>
									<!-- /.modal-content -->
								</div>
								<!-- /.modal -->
							</div>
							<!--end modal-->
							<div class="card o-hidden border-0 shadow-lg my-5 cqmb-back">
								<div class="cqmb-top">
									<div class="card-body">
										<div class="bg-primary text-white p-3 rotate-15 d-inline-block my-4 offset-sm-4"  >选择用户修改其权限</div>
										<div class="table-responsive" style="margin-top: 2em;">
											<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
												<thead>
													<tr>
														<th>学号</th>
														<th>管理个人文件</th>
														<th>管理所有文件</th>
													</tr>
												</thead>
												<tbody>
												<%List<Students> userinfo=(List<Students>)session.getAttribute("USERINFO");
													for(Students student:userinfo){
												%>
													<tr>
														<td><a href="javascript:;" data-toggle="modal" onclick="get(<%=student.getId() %>)" data-target="#myModal" id="addfolder"><%=student.getSnumber() %></a></td>
														<td><%if( student.isAuthone()){%><i class="fas fa-fw fa-check"></i><%	}%></td>
														<td><%if( student.isAuthall()){%><i class="fas fa-fw fa-check"></i><%	}%></td>
													</tr>
												</tbody> 
												<%	}%>
											</table>
										</div>
									</div>
								</div>
							</div>
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
			<script src="vendor/icheck/icheck.min.js" type="text/javascript" charset="utf-8"></script>
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