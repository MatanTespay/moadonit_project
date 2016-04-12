<%@ page language="java" contentType="text/html; charset=windows-1255"
	pageEncoding="windows-1255"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">

<head>

   <!--  <meta charset="utf-8"> -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>��������</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Core CSS RTL-->
    <link href="css/bootstrap-rtl.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/sb-admin.css" rel="stylesheet">
    <link href="css/sb-admin-rtl.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

	<link rel="stylesheet" href="css/ui.jqgrid.css">

 <!-- jQuery -->
    <script src="js/jquery.js"></script>
	<script src="js/jquery-ui.js"></script>
    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
	


	<!-- bootbox code -->
    <script src="js/bootbox.js"></script> 
    
    <script src="js/i18n/grid.locale-he.js"></script>
    <script src="js/jquery.jqGrid.min.js"></script> 
	
	<script src="js/js_logic.js"></script>    
    <script src="js/js_pupil_week_view.js"></script>    
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="nav navbar-right top-nav" style="padding-top: 15px; ">
            	<a href="index.html">
	            	<i class="fa fa-fw fa-power-off"></i>&nbsp;�����</a>
            </div>
            <div class="navbar-header" >
            	<a class="navbar-brand" href="dashboard.jsp">
            	<i class="fa fa-home fa-fw"></i>&nbsp;��������</a>
                
            </div>
            
             <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav side-nav">
                    <li>
                        <a href="" style="font-size: 120%; pointer-events: none;"> <i class="fa fa-fw fa-users"></i> ����� �����</a>
                        <br>
                     </li> 
                     <li>
                        <a href= "pupil_card_view.jsp"><i class="fa fa-fw fa-list-alt"></i> ����� ������</a>
                     </li> 
                     <li class="active">
                        <a href= "pupil_week_view.jsp"><i class="fa fa-fw fa-th"></i> ����� ������</a>
                     </li>
                     <li>
                        <a href= "pupil_week_view.jsp"><i class="fa fa-fw fa-edit"></i> ����� �����</a>
                     </li>  
                </ul>
            </div>
            <!-- /.navbar-collapse -->
            
        </nav>
        
        <!-- Main content -->
        <div id="page-wrapper">
			

            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            ���� ���
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                 <a href="dashboard.jsp"><i class="fa fa-home"></i> ����</a>
                            </li>
                            <li>
                                 <a href="dashboard.jsp"><i class="fa fa-users"></i> �������</a>
                            </li>
                            <li>
                                 <a href="dashboard.jsp"><i class="fa fa-list-alt"></i> ����� �����</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-th"></i> ����� ������ ������
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                   
               
                <!-- /.row -->
				
				<div class="col-lg-2">
				</div>
                <div class="col-lg-8">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-search fa-fw"></i> ����� ������</h3>
                            </div>
                            <div class="panel-body">
              					<div class="table-responsive col-lg-12">
                                    <table class="table table-bordered table-hover table-striped" id="list">
                                
										<tr>
											<td>
											</td>
										</tr>
									</table>
								
								<div id="pager"></div>
                                
                            	</div>                              
                            </div>
                        </div>
                    </div>
             	</div>
             	
             	<div class="row">
             	<div class="col-lg-2">
				</div>
             	 <div class="col-lg-8">
             	 <div class="panel panel-default">
                            <div class="panel-heading">
                               <!--  <h3 class="panel-title"><i class="fa fa-search fa-fw"></i>����� �����</h3> -->
                                <a href="javascript:;" data-toggle="collapse" data-target="#editReg">����� ������ <i class="fa fa-arrow-circle-down"></i></a>
                               
                                </div>
                            <div class="panel-body">
                            <div class="text-right">
                                   
								<div id="editReg" class="collapse">
									������ ���� �� ��� ������, ��� ��� ����� ���� ���� ������
									<br>
									����� ����� ����� ������ ������ ���� ������ ������� ����� ������
								</div>


								</div>
                            </div>
                </div>
                 </div>
                              
             	 </div>
             	</div>
            </div>

        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>


		<%
			if(request.getParameter("pupil") != null){
				String pupil = request.getParameter("pupil");
		%>	
				<script type="text/javascript">
					var pupilID = "<%=pupil%>";
				</script>
				<%} 
		else{%>
		
				<script type="text/javascript">
					var pupilID = "3";
				</script>
				
		<%} %>
		
		<script type="text/javascript">
		
		
	$(function(){	
	
		loadRegistrationGrid(pupilID);
	
	});
		</script>
</body>

</html>
