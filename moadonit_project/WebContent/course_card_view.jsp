<%@ page language="java" contentType="text/html; charset=utf-8"
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

<script type="text/javascript">
		var currentUserId =	 '<%=session.getAttribute("userid")%>';	
		
	</script>
	
	<%
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
	%>
	
 	<%
		if (session.getAttribute("userid") == null) {
			response.sendRedirect("login.jsp");
			return;
		}
	%> 

    <title>��������</title>
	
     <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
	
	<script src="js/jquery-ui.js"></script>
	<script src="js/js_logic.js"></script>
    
    
	<script src="js/moment-with-locales.js"></script> 
	<script src="js/combodate.js"></script> 	   
    
    <script src="js/js_course_card_view.js"></script> 
	
    
    <script src="js/jquery.are-you-sure.js"></script> 
    
    	<!-- form validation plugin -->
	<script src="js/jquery.validate.js"></script>
	<script src="js/additional-methods.js"></script>
	<script src="js/messages_he.js"></script>
	<script src="js/jquery.timepicker.min.js"></script>
	<!-- bootbox code -->
    <script src="js/bootbox.js"></script> 
    
    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Core CSS RTL-->
    <link href="css/bootstrap-rtl.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/jquery.timepicker.css">

    
    <!-- Custom CSS -->
    <link href="css/sb-admin.css" rel="stylesheet">
    <link href="css/sb-admin-rtl.css" rel="stylesheet">
    <link href="css/mycss.css" rel="stylesheet">

    <!-- Morris Charts CSS -->
   <!--  <link href="css/plugins/morris.css" rel="stylesheet"> -->

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    

	
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
            	<a href="login.jsp?action=logout">
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
                        <a href="" style="font-size: 120%; pointer-events: none;"> <i class="fa fa-futbol-o"></i> ���� ���</a>
                        <br>
                     </li> 
                     <li class="active">
                        <a href= "pupil_card_view.jsp" id="detailsLink"><i class="fa fa-fw fa-list-alt"></i> ���� ���</a>
                     </li> 
                     <li>
                        <a href= "pupil_week_view.jsp" id="scheduleLink"><i class="fa fa-fw fa-th"></i> ������</a>
                     </li>
                     <li>
                        <a href= "pupil_week_view.jsp" id="regLink" ><i class="fa fa-fw fa-edit"></i> ����� �����</a>
                     </li>  
                    <li>
                        <a href= "pupil_one_time_act.jsp" id="oneTimeLink"><i class="fa fa-fw fa-plus-square-o"></i> ������ �� �����</a>
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
                        <h2 class="page-header" id="nameTitle" style="margin: 0px 0 0px; border-bottom: 1px solid #a6b7bd">                     
                        </h2>
                        <ol class="breadcrumb">
                            <li>
                                 <a href="dashboard.jsp"><i class="fa fa-home"></i> ����</a>
                            </li>
                            <li>
                                 <a href="course_search.jsp"><i class="fa fa-futbol-o"></i> �����</a>
                            </li>
                         <!--    <li>
                                 <a href="dashboard.jsp"><i class="fa fa-user"></i> ����� ���</a>
                            </li> -->
                            <li class="active">
                                <i class="fa fa-list-alt"></i> ���� ���
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

     <!--         copy content from pupil_add change buttons text & fonctionality -->
           		<form role="form" id="ajaxform">
           		<fieldset >
		<!-- row 1 col 1 -->
					<div class="col-lg-12" style="border-bottom: 1px solid #a6b7bd">
						<div class="col-lg-12">
							<div class="col-lg-3">
								<div class="form-group">
									<label for="fName">�� ����</label> <input type="text" 
										class="form-control input-sm" name="activityName"  id="activityName" >
								</div>
								<div class="form-group">
									<label for="cell">��� ����</label>
										<select class="form-control input-sm" style="width: 100px;"
										id="regularOrPrivate" name="regularOrPrivate" >
										<option value="����">����</option>
										<option value="�����">�����</option>
										
									</select>
									
								</div> 
								<div class="form-group">
									<label for="weekDay">��� �����</label> 
										<select class="form-control input-sm" style="width: 50px;"
										id="weekDay" name="weekDay" >
										<option value="�">�</option>
										<option value="�">�</option>
										<option value="�">�</option>
										<option value="�">�</option>
										<option value="�">�</option>
										<!-- <option value="�">�</option>		 -->								
									</select>
									
								</div>
								
							</div>
		<!-- row 1 col 2 -->
							<div class="col-lg-2">
								<div class="form-group">
									<label for="date_of_birth">��� �����</label>
									<br>	
									<input type="text"
										class="form-control input-sm" id="startTime" name="startTime" style="width: 90px;"  > 
								</div>
								<div class="form-group">
									<label for="food">��� ����</label>									
									<br>	
									<input type="text"
										class="form-control input-sm" id="endTime" name="endTime" style="width: 90px;"  > 
								</div>
								<div class="form-group">
									
									<label for="grade">���� �����</label>
									<input type="text"
										class="form-control input-sm" id="pricePerMonth" name="pricePerMonth"  > 
								</div>								
							</div>
		<!-- row 1 col 3 -->
							<div class="col-lg-2">
							<div class="form-group">
								<label for="weekDay">�� �����</label> 
										<select class="form-control input-sm" style="width: 50px;"
										id="firstName" name="firstName" >
										<option value="�">�</option>
										<option value="�">�</option>
										<option value="�">�</option>
										<option value="�">�</option>
										<option value="�">�</option>
										<!-- <option value="�">�</option>		 -->								
									</select>								
								</div>
								<div class="checkbox">
									<label for="extraPriceChk">����� ������</label> <input type="checkbox"
										id="extraPriceChk" name="staff" >
								</div>
								<div class="form-group" style="display: none;" id="extraPriceDiv">
									<label for="extraPrice">���� ������</label> <input type="text"
										name="extraPrice" class="form-control" id="extraPrice"
										placeholder="����">
								</div>
								<!-- <div class="form-group">
									
									<label for="genderGruop" class="col-lg-1">�������</label>
										<select class="form-control input-sm"
										id="regularOrPrivate" name="regularOrPrivate" >
										<option value="����">����</option>
										<option value="�����">�����</option>
										
									</select>
									
								</div> -->
							</div>
							
		<!-- row 1 col 4 -->							
							
						</div>
						<div class="col-lg-12">
						<div class="form-group pull-left" id="viewModeBtn">
									<input type="button" id="editBtn" name="editBtn"
									class="btn btn-primary" value="�����">
								
									<input type="submit" id="deleteBtn" name="deleteBtn"
									class="btn btn-primary" value="�����">
								
									<input type="submit" id="addCourse" name="clearBtn"
									 class="btn btn-primary" value="���� ���">
									<!-- <button id="testBtn">test</button> -->
								</div>
								
								<div class="form-group pull-left" id="editModeBtn" style="display: none">
									<input type="button" id="saveBtn" name="saveBtn"
									class="btn btn-primary" value="���� �������">
								
									<input type="submit" id="cancelBtn" name="deleteBtn"
									class="btn btn-primary" value="��� �������">
								</div>
						</div>
					</div>									
					</fieldset>
				</form>
  			
  				<div class="col-lg-12" style="margin: 0px 0 0px; border-bottom: 1px solid #a6b7bd">
                    <div class="col-lg-12" >
                        <h3  >  
                        	������� ����                   
                        </h3>
                        <div class="table-responsive col-lg-10">
                        <table class="table table-bordered table-hover table-striped"
									id="list" >

									<tr>
										<td></td>
									</tr>
								</table>

								<div id="pager"></div>
                        </div>
                    </div>
                </div>
  			</div>
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

		<%
			if(request.getParameter("activityNum") != null){
				String activityNum = request.getParameter("activityNum");
		%>	
	<script type="text/javascript">
		var activityNum = "<%=activityNum%>";
	</script>
	<%} 
	else{%>
	
	<script type="text/javascript">
		var activityNum = "1";
	</script>
	
	<%} %>
	
	<script type="text/javascript">
	
	

   	
	</script>

	<!-- Morris Charts JavaScript -->
   <!--  <script src="js/plugins/morris/raphael.min.js"></script>
    <script src="js/plugins/morris/morris.min.js"></script>
    <script src="js/plugins/morris/morris-data.js"></script> -->

</body>

</html>