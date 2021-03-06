<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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
	
	<script type="text/javascript">			
			var currentUserId =	 '<%=session.getAttribute("userid")%>';			
			var userData;
			if(typeof currentUserId != "undefined")
				userData = JSON.parse(currentUserId);
		</script>
<title>מועדונית</title>

<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap Core CSS RTL-->
<link href="css/bootstrap-rtl.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/sb-admin.css" rel="stylesheet">
<link href="css/sb-admin-rtl.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet"
	type="text/css">
<link href="css/datepicker.css" rel="stylesheet">
<!-- jqgrid style -->
 <link rel="stylesheet"	href="resources/jquery-ui-1.11.4.custom/jquery-ui.css">
 <link rel="stylesheet" href="css/ui.jqgrid.css">
<link rel="stylesheet" href="css/ui.jqgrid-bootstrap-ui.css">
 <link href="css/mycss.css" rel="stylesheet">

<!-- jQuery -->
<script src="js/jquery.js"></script>
<script src="js/jquery-ui.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="js/bootstrap.min.js"></script>
<script src="js/i18n/grid.locale-he.js"></script>
 <script src="js/jquery.jqGrid.min.js"></script>
 <script src="js/jQuery.jqGrid.setColWidth.js"></script>
 <script src="js/jQuery.jqGrid.autoWidthColumns.js"></script>
<!-- bootbox code -->
<script src="js/bootbox.js"></script>
<script src="js/bootstrap-datepicker.js"></script> 
<script src="js/i18n/bootstrap-datepicker.he.min.js"></script> 

<!-- form validation plugin -->
<script src="js/jquery.validate.js"></script>
<script src="js/additional-methods.js"></script>
<script src="js/messages_he.js"></script>

<script src="js/js_logic.js"></script>
<script src="js/js_pupil_week_view.js"></script>
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
   <!-- datepicker datepicker-dropdown dropdown-menu datepicker-rtl datepicker-orient-left datepicker-orient-bottom  -->
<style type="text/css">

 .ui-jqgrid .ui-jqgrid-view, .ui-jqgrid .ui-jqgrid-pager {
    z-index: 9;
} 

.ui-jqgrid tr.jqgrow td {
 white-space: normal !important;
 height:auto;
 vertical-align:text-top;
 padding-top:2px;
}
</style>

</head>

<body>

	<div id="wrapper">

		<!-- Navigation -->
		<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
			<div class="nav navbar-right top-nav" style="padding-top: 15px;">
				<a href="login.jsp?action=logout"> <i class="fa fa-fw fa-power-off"></i>&nbsp;יציאה
				</a>
			</div>
			<div class="navbar-header">
				<a class="navbar-brand" href="dashboard.jsp"> <i
					class="fa fa-home fa-fw"></i>&nbsp;מועדונית
				</a>

			</div>

			<!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
			<div class="collapse navbar-collapse navbar-ex1-collapse">
				<ul class="nav navbar-nav side-nav" id="menuSideBar">
					<li>
						<a href="" style="font-size: 120%; pointer-events: none;" ><i class="fa fa-fw fa-users"></i> כרטיס תלמיד </a> <br>
					</li>
					<li><a href="pupil_card_view.jsp" id="detailsLink" ><i
							class="fa fa-fw fa-list-alt" ></i> פרטים אישיים</a></li>
					<li><a href="pupil_week_view.jsp" id="scheduleLink"><i
							class="fa fa-fw fa-th"></i> תכנית שבועית</a></li>
					<li><a href="pupil_week_view.jsp" id="regLink"><i
							class="fa fa-fw fa-edit"></i>עריכת רישום</a></li>
					<li>
                        <a href= "pupil_one_time_act.jsp" id="oneTimeLink"><i class="fa fa-fw fa-plus-square-o"></i> פעילות חד פעמית</a>
                     </li>  
                     <li>
                     	<a href="pupil_add.jsp" id="addNew"><i class="fa fa-fw fa-edit"></i> הוספת חדש</a>
                     </li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->

		</nav>

		<!-- Main content -->
		<div id="page-wrapper">


			<div class="container-fluid">

				<!-- Page Heading -->
<!-- 				<div class="row">
					<div class="col-lg-12">
						<h1 class="page-header"><br></h1>
						<ol class="breadcrumb">
							<li><a href="dashboard.jsp"><i class="fa fa-home"></i>
									ראשי</a></li>
							<li><a href="dashboard.jsp"><i class="fa fa-users"></i>
									תלמידים</a></li>
							<li><a href="dashboard.jsp"><i class="fa fa-list-alt"></i>
									כרטיס תלמיד</a></li>
							<li class="active"><i class="fa fa-th"></i> תכנית שבועית
								לתלמיד</li>
						</ol>
					</div>
				</div> -->
				   <div class="row">
                    <div class="col-lg-12">
                        <h2 class="page-header" id="nameTitle" style="margin: 0px 0 0px; border-bottom: 1px solid #a6b7bd">                     
                        </h2>
                       <ol class="breadcrumb">
							<li><a href="dashboard.jsp"><i class="fa fa-home"></i>
									ראשי</a></li>
							<li><a href="pupils_search.jsp"><i class="fa fa-users"></i>
									תלמידים</a></li>
							<li><a href="pupil_card_view.jsp" id="bcPupilCard" ><i class="fa fa-list-alt"></i>
									כרטיס תלמיד</a></li>
							<li class="active"><i class="fa fa-th"></i> תכנית שבועית
								לתלמיד</li>
						
						</ol>
                    </div>
                </div>
				<!-- /.row -->

				<div class="row">


					<!-- /.row -->

					<div class="col-lg-1"></div>
					<div class="col-lg-10">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title pull-right">
									<!-- <i class="fa fa-search fa-fw"></i> --> תכנית שבועית
								</h3>
								<button id="goToCourses" class="pull-left btn btn-primary">עבור לרישום חוגים</button>
								<div class="clearfix"></div>
							</div>
							<div class="panel-body">
								<div class="table-responsive col-lg-12">
									<table class="table table-bordered table-hover "
										id="list">

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
				<div class="row">


					<!-- /.row -->

					<!-- <div class="col-lg-1"></div> -->
					<div class="col-lg-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">
									<!-- <i class="fa fa-search fa-fw"></i> --> היסטורית רישום
								</h3>
							</div>
							<div class="panel-body">
								<div class="table-responsive col-lg-12">
									<table class="table table-bordered table-hover table-striped"
										id="listRegistration">

										<tr>
											<td></td>
										</tr>
									</table>
 
									<div id="listRegistrationPager"></div> 

								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-1"></div>
					<div class="col-lg-10">
							<div id="RegMsg" class="alert alert-warning" style="display: none;">
							 <input type="checkbox" id="OkToReg" name="OkToReg" value="1" onchange="OkToReg(this)" >&nbsp;&nbsp;שמור שינויים בכל זאת.<br>
							 <strong>שיב לב</strong> התאריכים לא בתקופת השינויים
							</div>
					</div>
				</div>				
				<div class="row">
					<!-- <div class="col-lg-1"></div> -->
					<div class="col-lg-12">
						<div class="panel panel-default" id="newRegPanel">
							<div class="panel-heading">								
								<a href="#" id="regHeaderlink">
								<!-- <a href="#editReg" data-toggle="collapse" data-target="#editReg" -->
									עריכת רישום <i
									class="fa fa-arrow-circle-down"></i></a>
							
							</div>
							<div class="panel-body">
									<div id="editReg" class="collapse">
										<form id="regform" >
												<div class="row" id="regOptions">
												<div class="form-group col-lg-2">
												<input type="checkbox" id="checkAllDays" name="checkAllDays" value="1" onchange="checkChange(this)" >&nbsp;&nbsp;שבוע מלא<br>
												</div>												
												</div>
												<div class="row" id="regDays">
													<div class="form-group col-lg-2">
														<label for="action">יום ראשון</label> <select onchange="ondayChange(this)"
															class="form-control " id="sunday" name="sunday"
															 >
															
														</select>
													</div>
													<div class="form-group col-lg-2">
														<label for="action">יום שני</label> <select onchange="ondayChange(this)"
															class="form-control " id="monday" name="monday"
															 >
														
														</select>
													</div>
													<div class="form-group col-lg-2">
														<label for="action">יום שלישי</label> <select onchange="ondayChange(this)"
															class="form-control " id="tuesday" name="tuesday"
															 >
															
														</select>
													</div>
													<div class="form-group col-lg-2">
														<label for="action">יום רביעי</label> <select onchange="ondayChange(this)"
															class="form-control " id="wednesday" name="wednesday"
															 >
															
														</select>
													</div>
													<div class="form-group col-lg-2">
														<label for="action">יום חמישי</label> <select onchange="ondayChange(this)"
															class="form-control " id="thursday" name="thursday"
															 >
															
														</select>
													</div>
													
													<!-- <div class="form-group  col-lg-2">
													<label for="type"> </label>
													<input class="form-control btn btn-primary " style="margin-top: 5px;" type="button" value="שמור">
												</div> -->
												</div>
												<div class="row">
												<div class="form-group  col-lg-2">
													<label for="datePick">תאריך התחלה</label>
													<input  type="text" class="form-control" id="datePick" name="datePick" >
												</div>
												<div class="form-group  col-lg-2">
													<label for="endDatePick">תאריך סיום</label>
													<input  type="text" class="form-control" id="endDatePick" name="endDatePick" >
												</div>
													<div class="form-group col-lg-2">
														<label for="reason">סיבת הרישום</label> <select
															class="form-control " id="reason" name="reason" >
															
														</select>
													</div>
													<div class="form-group  col-lg-2">
														<label for="type"> </label> <input
															class="form-control btn btn-primary" id="btnSave"
															style="margin-top: 5px;" type="button" value="שמור">															 
													</div>
													<div class="form-group  col-lg-2">
														<label for="type"> </label> <input
															class="form-control btn btn-primary" id="clearBtn"
															style="margin-top: 5px;" type="button" value="נקה">															 
													</div>
													<!-- <div class="form-group  col-lg-2">
													<label for="clearBtn"> </label>
														<input
															type="button" id="clearBtn" name="clearBtn"
															class="form-control btn btn-primary" value="נקה" alt="נקה ערכים">													 
													</div> -->
												</div>
											</form>											
									</div>
								<div id="endP"></div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>

		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->


	<%
		if (request.getParameter("pupil") != null) {
			String pupil = request.getParameter("pupil");
			String li = request.getParameter("li");
			String reg = request.getParameter("reg");
	%>
	<script type="text/javascript">
					var pupilID = "<%=pupil%>";
					var selectedLi = "<%=li%>";
					var reg = "<%= reg %>";
	</script>
	<%
		} else {
	%>

	<script type="text/javascript">
		var pupilID = "3";
		var selectedLi, reg;
	</script>

	<%
		}
	%>

</body>

</html>
