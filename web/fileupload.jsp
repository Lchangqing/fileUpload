<%@page import="cn.edu.swu.mvcapp.domain.Students"%>
<%@page import="cn.edu.swu.mvcapp.domain.FileUploadBean"%>
<%@page import="cn.edu.swu.mvcapp.domain.DirBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html >

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>fileupload</title>

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
				$('input[id=lefile]').change(function() {
					$('#photoCover').val($(this).val());
					/* window.alert($(this).val()); */
				});
				$(document).keydown(function(event){
					if(event.keyCode==13){
						$("#file").submit();
					}
					})
			});
			function check(test){
		        if ($("#desc").val().match(/^\s*$/) || $("#snumber").val().match(/^\s*$/) ||$("#name").val().match(/^\s*$/) || $("#photoCover").val().match(/^\s*$/)) {
		            alert("请将信息填写完整");
		            console.log('snumber:',$("#snumber").val())
		            return false;
		        }else if(test==null){
		        	
		        	alert("请先选择文件夹")
		        	return false;
		        }
		        return $("#file").submit();
		    }
		</script>
		<style type="text/css">
			.cqrow{
				margin: 2.3em 0;
			}
			.cqa{
				color:rgb(58,97,208) !important;
				width: 100%;
			}
			.cqa:hover{
				color: white !important;
			}
			.cqdiv1{
				margin-bottom: 2em;
			}
			tr:hover{
				background: #fbfbfb;
				font-weight: bold;
			}
		</style>

</head>

<body id="page-top">
<%
	Object msg=request.getAttribute("message");
	if(msg!=null){
		%>
			<script type="text/javascript" >$(function() {alert('<%=msg%>')})</script>
	   <% 	}
%>

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
								<h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-fw fa-table"></i>文件上传</h6>
							</div>
							<div class="card-body">
								<div class=" cqdiv1 " >
								<div class="row ">
									<div class="  col-sm-2 col-1 text-right">
										<i class="fas fa-fw fa-folder" style="font-size: 3em;"></i>
									</div>
									<div class="col-sm-3 offset-sm-0 col-12 ">
										<p style="line-height: 300%;text-align: left;">文件上传</p>
									</div>
								</div>
								<%
									Students s=(Students)session.getAttribute("STUDENT"); 
								%>
								<form action="<%=request.getContextPath()%>/uploadServlet?dirName=<%=request.getAttribute("dirName")%>" method="post" enctype="multipart/form-data" id="file">
								<div class="row cqdiv1">
									
									<div class="offset-sm-2 col-sm-6 ">
										<input id="lefile" type="file" style="display:none" name="file">
										<input id="photoCover" class="form-control " type="text"  />
									</div>
									<div class=" col-sm-3 col-12">
										<a class="btn btn-outline-primary cqa " onclick="$('input[id=lefile]').click();" >浏览</a>
									</div>
								</div>
								<div class="row">
									<div class=" col-sm-2  col-1 text-right ">
										<i class="fas fa-fw fa-wrench" style="font-size: 3em;"></i>
									</div>
									<div class=" col-sm-3 offset-sm-0 col-12  ">
										<p style="line-height: 300%;text-align: left;">描述</p>
									</div>
								</div>
								<div class="row" style="margin: 0;">
									<div class=" col-sm-4 offset-sm-2">
										<input id="name" name="name" class="form-control " type="text" placeholder="姓名（完善个人信息，此处可自动生成）" value="<%= s.getName()==null?"": s.getName()%>">
									</div>
									<div class=" col-sm-5 ">
										<input id="snumber" name="snumber" class="form-control " type="text" placeholder="学号（完善个人信息，此处可自动生成）"value="<%= s.getSnumber()==null?"": s.getSnumber()%>">
									</div>
								</div>
																		
								<div class="row cqrow ">
									<div class="col-sm-6 offset-sm-2  col-12">
									<input id="desc" name="desc" class="form-control  " type="text" placeholder="实验描述">
									</div>
									<div class="col-sm-3 col-12 ">
										<a id="upload" class="btn btn-outline-primary cqa " href="javascript:;" onclick="check(<%= request.getAttribute("flag") %>)" >上传</a>
									</div>
								</div>
								</form>
									</div>
									<hr />
								<div class="table-responsive">
									<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
										<thead>
											<tr>
												<th>文件/文件夹</th>
												<th>创建时间</th>
											</tr>
										</thead>
										<tfoot>
											<tr>
												<th>文件/文件夹</th>
												<th>创建时间</th>
											</tr>
										</tfoot>
										<tbody id="tbody1">
										<% Object flag=request.getAttribute("flag");
										Object flag2=request.getAttribute("flag2");
											if(flag==null && flag2==null){
											List<DirBean> dirs=(List<DirBean>)session.getAttribute("DIRS");
											System.out.println("flag"+flag);
											System.out.println("dirs"+dirs);
											for(DirBean dir:dirs){
												%>
												<tr>
													<td><a style="text-decoration: none;" href="<%=request.getContextPath()%>/query.go?dirName=<%=dir.getDirName()%>"><%=dir.getDirName() %></a></td>
													<td><%=dir.getTime() %></td>
												</tr>
												<% 
											}}else{
												List<FileUploadBean> files=(List<FileUploadBean>)request.getAttribute("files");
												for(FileUploadBean file: files){
													%>
													<tr>
														<td><%=file.getFileDesc() %></td>
														<td><%=file.getTime() %></td>
													</tr>
													<%
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
