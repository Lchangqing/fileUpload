<%@page import="cn.edu.swu.mvcapp.dao.impl.FileUpLoadDAOJdbcImpl"%>
<%@page import="cn.edu.swu.mvcapp.domain.Students"%>
<%@page import="cn.edu.swu.mvcapp.domain.FileUploadBean"%>
<%@page import="cn.edu.swu.mvcapp.domain.DirBean"%>
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

		<title>file manager</title>

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
				$("#createBtn").on("click",function(){
					 if ($("#dirname").val().match(/^\s*$/) ) {
				            alert("文件名不能为空");
				            console.log('dirname:',$("#dirname").val())
				            return false;
				        }
				        return $("#createDir").submit();
						})	
			});
			function isdelete(){
				return window.confirm('确认删除吗？')
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
			tr:hover{
				background: #fbfbfb;
				font-weight: bold;
			}
			#addfolder:hover{
				font-size: 1.5em;
				color: rgb(46,86,199);
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
								<h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-fw fa-folder-open"></i>文件管理</h6>
							</div>
							<div class="h3" style="text-align: center;">
								<h3 class="h3" style="font-family:'黑体'; text-align: center;margin-top: 1em;">
									选择文件/文件夹进行操作
								</h3>
							</div>
							<%
								Object msg=request.getAttribute("message");
								if(msg!=null){
									%>
									<script type="text/javascript" >$(function() {alert('<%=msg%>')})</script>
							<% 	}
							%>
							<!--begin modal-->
							 <!--按钮触发模态框--> 
							<!--<button class="btn btn-outline-primary col-sm-2" data-toggle="modal" data-target="#myModal" >新建文件夹</button>-->
							<!-- 模态框（Modal） -->
							<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title" id="myModalLabel">请输入文件名</h4>
											<%
											Object flag=request.getAttribute("flag2");
											Students student=(Students)session.getAttribute("STUDENT");
											boolean authall=student.isAuthall();
											if(flag==null){
											%>
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
											<% }%>
										</div>
										<form action="<%=request.getContextPath()%>/creatDir.down?" method="post"  id="createDir">
											<div class="modal-body" style="background:red;margin:0;padding:0">
												<input id="dirname" name="dirName" type="text" style="width:100%;height:3em;" />
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
												<button type="button" class="btn btn-primary" onclick="check()" id="createBtn">创建</button>
											</div>
										</form>
										
									</div>
									<!-- /.modal-content -->
								</div>
								<!-- /.modal -->
							</div>
							<!--end modal-->
							<div style="margin-bottom: 2em;" >
								<hr />
								<%if(authall!=false){ %>
								<div style="margin-top: -1.3em;margin-left:30em;font-size: 2em;">
									<a class="fas fa-fw fa-folder-plus" data-toggle="modal" data-target="#myModal" id="addfolder" ></a>
								</div>
								<% }%>
							</div>
							
								<div class="card-body">
								<div class="table-responsive">
									<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
										<thead>
											<tr>
												<th>文件/文件夹</th>
												<th>创建时间</th>
												<th>文件下载/删除</th>
											</tr>
										</thead>
										<tfoot>
											<tr>
												<th>文件/文件夹</th>
												<th>创建时间</th>
												<th>文件下载/删除</th>
											</tr>
										</tfoot>
										<tbody>
											<% 
											
											if(authall==false){
												
											    FileUpLoadDAOJdbcImpl filedao=new FileUpLoadDAOJdbcImpl();
												int id=student.getId();
												List<FileUploadBean> files=filedao.getBySid(id);
												for(FileUploadBean file: files){
												%>
												
												<tr>
													<td><%=file.getFileDesc() %></td>
													<td><%=file.getTime() %></td>
													<td><a href="<%=request.getContextPath()%>/file.down?fileId=<%=file.getId() %>" class="fas fa-fw fa-arrow-alt-circle-down" style="font-size: 1.5em;text-decoration: none;margin-left: 45%;" ></a></td>
												</tr>
												<%
												}
											}else{
											if(flag==null){
											List<DirBean> dirs=(List<DirBean>)session.getAttribute("DIRS");
											for(DirBean dir:dirs){
												%>
												<tr>
													<td><a style="text-decoration: none;" href="<%=request.getContextPath()%>/query2.go?dirName=<%=dir.getDirName()%>"><%=dir.getDirName() %></a></td>
													<td><%=dir.getTime() %></td>
													<td><a href="<%=request.getContextPath()%>/dir.down?dirId=<%=dir.getId() %>" class="fas fa-fw fa-arrow-alt-circle-down" style="font-size: 1.5em;text-decoration: none;margin-left: 15%;" ></a>
														<a href="<%=request.getContextPath()%>/dirDelet.go?dirId=<%=dir.getId() %>" class="fas fa-fw fa-trash-alt" style="font-size: 1.5em;text-decoration: none;margin-left: 45%;" onclick='isdelete()'></a>
													</td>
												</tr>
												<% 
											}}else{
												List<FileUploadBean> files=(List<FileUploadBean>)request.getAttribute("files");
												for(FileUploadBean file: files){
													%>
													<tr>
														<td><%=file.getFileDesc() %></td>
														<td><%=file.getTime() %></td>
														<td><a href="<%=request.getContextPath()%>/file.down?fileId=<%=file.getId() %>" class="fas fa-fw fa-arrow-alt-circle-down" style="font-size: 1.5em;text-decoration: none;margin-left: 15%;" ></a>
															<a href="<%=request.getContextPath()%>/fileDelet.go?fileId=<%=file.getId() %>" class="fas fa-fw fa-trash-alt" style="font-size: 1.5em;text-decoration: none;margin-left: 45%;" onclick='isdelete()'></a>
														</td>
													</tr>
													<%
												}
											}
											}
										%>
										</tbody>
									</table>
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