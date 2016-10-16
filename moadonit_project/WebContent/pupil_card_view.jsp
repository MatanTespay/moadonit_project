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
		<!-- bootbox code -->
    <script src="js/bootbox.js"></script> 
	<script src="js/js_logic.js"></script>
    
    
	<script src="js/moment-with-locales.js"></script> 
	<script src="js/combodate.js"></script> 	   
    
    <script src="js/js_pupil_card_view.js"></script> 
	
    
    <script src="js/jquery.are-you-sure.js"></script> 
    
    	<!-- form validation plugin -->
	<script src="js/jquery.validate.js"></script>
	<script src="js/additional-methods.js"></script>
	<script src="js/messages_he.js"></script>
	

    
    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Core CSS RTL-->
    <link href="css/bootstrap-rtl.min.css" rel="stylesheet">


    
    <!-- Custom CSS -->
    <link href="css/sb-admin.css" rel="stylesheet">
    <link href="css/sb-admin-rtl.css" rel="stylesheet">
    

    <!-- Morris Charts CSS -->
   <!--  <link href="css/plugins/morris.css" rel="stylesheet"> -->

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="css/mycss.css" rel="stylesheet">

	
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
                        <a href="" style="font-size: 120%; pointer-events: none;"> <i class="fa fa-fw fa-user"></i> ����� �����</a>
                        <br>
                     </li> 
                     <li class="active">
                        <a href= "pupil_card_view.jsp" id="detailsLink"><i class="fa fa-fw fa-list-alt"></i> ����� ������</a>
                     </li> 
                     <li>
                        <a href= "pupil_week_view.jsp" id="scheduleLink"><i class="fa fa-fw fa-th"></i> ����� ������</a>
                     </li>
                     <li>
                        <a href= "pupil_week_view.jsp" id="regLink" ><i class="fa fa-fw fa-edit"></i> ����� �����</a>
                     </li>  
                    <li>
                        <a href= "pupil_one_time_act.jsp" id="oneTimeLink"><i class="fa fa-fw fa-plus-square-o"></i> ������ �� �����</a>
                     </li> 
                     <li>
                     	<a href="pupil_add.jsp"><i class="fa fa-fw fa-edit"></i> ����� ���</a>
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
                                 <a href="pupils_search.jsp"><i class="fa fa-users"></i> �������</a>
                            </li>
                            <li>
                                 <a href="#"><i class="fa fa-user"></i> ����� �����</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-list-alt"></i> ����� ������
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

     <!--         copy content from pupil_add change buttons text & fonctionality -->
           		<form role="form" id="ajaxform">
           		<fieldset >
		<!-- row 1 col 1 -->
					<div class="row" style="border-bottom: 1px solid #a6b7bd">
						<div class="col-lg-12">
							<div class="col-lg-3">
								
								<div class="form-group">
									<label for="lName">�� �����</label> <input type="text"
										class="form-control input-sm" id="lName" name="lName"  placeholder="�����" >
								</div>
								<div class="form-group">
									<label for="fName">�� ����</label> <input type="text" 
										class="form-control input-sm" name="fName"  id="fName" placeholder="��">
								</div>
								<div class="form-group">
									<label for="cell">����� ���� �����</label> <input type="text"
										class="form-control input-sm" id="cell" name="cell"  placeholder="�����">
								</div> 
							</div>
		<!-- row 1 col 2 -->
							<div class="col-lg-3">
								<div class="form-group">
									<label for="date_of_birth">����� ����</label>
									<br>	
									<input id="date_of_birth" name="date_of_birth" 
									class=".ignore" data-smartDays="true" data-firstItem="name"
										data-format="DD-MM-YYYY" data-template="DD MMM YYYY" > 
								</div>
								<div class="form-group col-lg-5">
									
									<label for="grade">����</label>
									<select class="form-control input-sm"
										id="grade" name="grade" onchange="setGradeBgColor(this)">
										
									</select>
								</div>
								<div class="form-group col-lg-7">
									
									<label for="teacher">����/�</label>
									<input type="text" name="teacher" class="form-control" id="teacher"
										placeholder="����/�">
								<!-- 	<select class="form-control input-sm"
										id="teacher" name="teacher" onchange="" disabled>
										<option value="�">����� �����</option>
										<option value="�">���� ����</option>
										<option value="�">����� ������</option>
										<option value="�">����� ����</option>
										<option value="�">����� �����</option>
									</select> -->
								</div>
								<div class="form-group">
									<div class="checkbox-group required">
									<label for="genderGruop" class="col-lg-1">����</label>
										<label class="radio-inline col-lg-2"> 
										<input type="radio" name="genderGruop" id="male" value="1"> �� </label>
										<label class="radio-inline col-lg-2">
										<input type="radio" name="genderGruop" id="female" value="2">��</label>
									</div>
								</div>
							</div>
		<!-- row 1 col 3 -->
							<div class="col-lg-2">
								<div class="form-group">
									<label for="food">��� ���</label>
									<select class="form-control input-sm"
										id="food" name="food" >
										<!-- <option value="0">���</option> -->
										<!-- <option value="1">�����</option>
										<option value="2">�����</option>
										<option value="3">�������</option>
										<option value="4">���-�����</option> -->
									</select>
								</div>
								<table dir="rtl"  style="width:100%" cellpadding="3" cellspacing="5">
									<tr align="right">
										<td  style=" width:60%;"><label for="ethi">������</label></td>
										<td><input type="checkbox"
										id="ethi" name="ethi"></td>
									</tr>
									<tr align="right">
										<td><label for="divorce">����� ������</label></td>
										<td><input type="checkbox"
										id="divorce" name="divorce" ></td>
									</tr>
									<tr align="right">
										<td><label for="staff">��� ���</label></td>
										<td><input type="checkbox"
										name="staff" id="staff"></td>
									</tr>
								</table>
								<div class="form-group" style="display: none;" id="staffJobDiv">
									<label for="staffJob">����� �����</label> <input type="text"
										name="staffJob" class="form-control" id="staffJob"
										placeholder="�����">
								</div>
							<!-- 	<div class="checkbox ">
									<label for="ethi">������</label> <input type="checkbox"
										id="ethi" name="ethi" >
								</div>
								<div class="checkbox ">
									<label for="divorce">����� ������</label> <input type="checkbox"
										id="divorce" name="divorce" >
								</div>
								<div class="checkbox">
									<label for="staff">��� ���</label> <input type="checkbox"
										id="staff" name="staff" >
								</div>
								<div class="form-group" style="display: none;" id="staffJobDiv">
									<label for="staffJob">����� �����</label> <input type="text"
										name="staffJob" class="form-control" id="staffJob"
										placeholder="�����">
								</div> -->
							</div>
							
		<!-- row 1 col 4 -->							
							<div class="col-lg-4">
								<div class="form-group">
									<label for="health">����� ������</label> 
									 <input type="text"
										class="form-control input-sm" id="health" name="health"  placeholder=""> 
										<!-- <textarea rows="2" class="form-control input-sm" id="health" ></textarea> -->
								</div>
								<div class="form-group">
									<label for="foodsens">������ �����</label> <input type="text"
										class="form-control input-sm" id="foodsens" name="foodsens" placeholder="">
								</div>
								<div class="form-group">
									<label for="comnt">����� ������</label> <input type="text"
										class="form-control input-sm" id="comnt"  name="comnt" placeholder="">
								</div>
							</div>
						</div>
					</div>
					
					
					<!-- row 2 col 1 -->
					<div class="row" style="position: relative; ">
						<div class="col-lg-12">	
						<h3>���� �������</h3>					
							<div class="col-lg-3">
								<div class="form-group">
									<label for="p1relat">����</label>
									<select class="form-control input-sm"
										id="p1relat" name="p1relat" >
										<!-- <option value="1" selected="selected">���</option>
										<option value="2">���</option>
										<option value="3">��</option>
										<option value="4">����</option>
										<option value="5">���</option> -->
									</select>
								</div>
								<div class="form-group">
									<label for="p1fName">�� �����</label> <input type="text"
										class="form-control input-sm" id="p1fName" name="p1fName" placeholder="��">
								</div>
								<div class="form-group">
									<label for="p1lName">�� �����</label> <input type="text"
										class="form-control input-sm" id="p1lName" name="p1lName"  placeholder="�����">
								</div>
								<div class="form-group">
									<label for="p1cell">����� ����</label> <input type="text"
										class="form-control input-sm" id="p1cell" name="p1cell"  placeholder="�����">
								</div>
								<div class="form-group">
									<label for="p1mail">������</label> <input type="text"
										class="form-control input-sm" id="p1mail" name="p1mail"  placeholder="������">
								</div>
								
							</div>
			<!-- row 2 col 2 -->
							<div class="col-lg-3">
								<div class="form-group">
									<label for="p2relat">����</label>
									<select class="form-control input-sm"
										id="p2relat" name="p2relat" >
										<!-- <option value="1">���</option>
										<option value="2" selected="selected">���</option>
										<option value="3">��</option>
										<option value="4">����</option>
										<option value="5">���</option> -->
									</select>
								</div>
								<div class="form-group">
									<label for="p2fName">�� �����</label> <input type="text"
										class="form-control input-sm" id="p2fName" name="p2fName" placeholder="��">
								</div>
								<div class="form-group">
									<label for="p2lName">�� �����</label> <input type="text"
										class="form-control input-sm" id="p2lName" name="p2lName" placeholder="�����">
								</div>
								<div class="form-group">
									<label for="p2cell">����� ����</label> <input type="text"
										class="form-control input-sm" id="p2cell" name="p2cell"  placeholder="�����">
								</div>
								<div class="form-group">
									<label for="p2mail">������</label> <input type="text"
										class="form-control input-sm" id="p2mail" name="p2mail" placeholder="������">
								</div>
								
							</div>

			<!-- row 2 col 3 -->
							<div class="col-lg-3">
								
								<div class="form-group">
									<label for="address">����� ������</label> <input type="text"
										class="form-control input-sm" id="address" name="address" placeholder="�����">
								</div>
								<div class="form-group">
									<label for="phone">����� ����</label> <input type="text"
										class="form-control input-sm" id="phone" name="phone"  placeholder="�����">
								</div>
							</div>
							
			<!-- row 2 col 4 -->				
							<div class="col-lg-9"></div>
							<div class="col-lg-3" >
								
								<div class="form-group " id="viewModeBtn">
									<input type="button" id="editBtn" name="editBtn"
									class="btn btn-primary" value="�����">
								
									<input type="button" id="deleteBtn" name="deleteBtn"
									class="btn btn-primary" value="�����">
								
									<!-- <input type="button" id="addPupil" name="addPupil"
									 class="btn btn-primary" value="���� ���"> -->
									
								</div>
								
								<div class="form-group " id="editModeBtn" style="display: none">
									<input type="submit" id="saveBtn" name="saveBtn"
									class="btn btn-primary" value="���� �������">
								
									<input type="submit" id="cancelBtn" name="deleteBtn"
									class="btn btn-primary" value="��� �������">
								</div>
							</div>
						</div>
					</div>
					</fieldset>
				</form>
  			</div>
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

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
	var pupilData;	
	// set the state at start to read. (state object from js_logic file)
	var currentPageState = state.READ;
	var grades;

	</script>

	<!-- Morris Charts JavaScript -->
   <!--  <script src="js/plugins/morris/raphael.min.js"></script>
    <script src="js/plugins/morris/morris.min.js"></script>
    <script src="js/plugins/morris/morris-data.js"></script> -->

</body>

</html>
