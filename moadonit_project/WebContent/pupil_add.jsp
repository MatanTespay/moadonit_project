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
    <link href="css/mycss.css" rel="stylesheet">

    <!-- Morris Charts CSS -->
    <link href="css/plugins/morris.css" rel="stylesheet">

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
                        <a href="" style="font-size: 120%; pointer-events: none;"> <i class="fa fa-fw fa-users"></i> �������</a>
                        <br>
                     </li> 
                     <li>
                        <a href="pupils_search.jsp" ><i class="fa fa-fw fa-search"></i> �����</a>
                     </li> 
                     <li>
                        <a href="pupils_phones.jsp" ><i class="fa fa-fw fa-phone"></i> ��� ���</a>
                     </li>
                     <li class="active">
                        <a href= "pupil_add.jsp"><i class="fa fa-fw fa-edit"></i> ����� ���</a>
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
                            ����� �����
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                 <a href="dashboard.jsp"><i class="fa fa-home"></i> ����</a>
                            </li>
                            <li>
                                 <a href="pupils_search.jsp"><i class="fa fa-users"></i> �������</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-edit"></i> ����� �����
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

				<form role="form">
		<!-- row 1 col 1 -->
					<div class="row">
						<div class="col-lg-12">
							<div class="col-lg-3">
								<div class="form-group">
									<label for="fName">�� ����</label> <input type="text"
										class="form-control" id="fName" placeholder="��">
								</div>
								<div class="form-group">
									<label for="lName">�� �����</label> <input type="text"
										class="form-control" id="lName" placeholder="�����">
								</div>
								<div class="form-group">
									<label for="cell">����� ���� �����</label> <input type="text"
										class="form-control" id="cell" placeholder="�����">
								</div>
							</div>
		<!-- row 1 col 2 -->
							<div class="col-lg-3">
								<div class="form-group">
									<label for="fName">����� ����</label> <input type="text"
										class="form-control" id="fName" placeholder="��">
								</div>
								<div class="form-group">
									<label for="class">����</label> <select class="form-control"
										id="class">
										<option value="11">�-�</option>
										<option value="12">�-�</option>
										<option value="13">�-�</option>
										<option value="21">�-�</option>
										<option value="22">�-�</option>
										<option value="23">�-�</option>
										<option value="31">�-�</option>
										<option value="32">�-�</option>
										<option value="33">�-�</option>
										<option value="41">�-�</option>
										<option value="42">�-�</option>
										<option value="43">�-�</option>
										<option value="51">�-�</option>
										<option value="52">�-�</option>
										<option value="53">�-�</option>
										<option value="61">�-�</option>
										<option value="62">�-�</option>
										<option value="63">�-�</option>
									</select>
								</div>
								<div class="form-group">
									<label for="cell" class="col-lg-1">����</label>
									<label class="radio-inline col-lg-2"> 
									<input type="radio" name="inlineRadioOptions" id="male" value="1"> �� </label>
									<label class="radio-inline col-lg-2">
									<input type="radio" name="inlineRadioOptions" id="female" value="2">��</label>
								</div>
							</div>
		<!-- row 1 col 3 -->
							<div class="col-lg-3">
								<div class="form-group">
									<label for="food">��� ���</label> <select class="form-control"
										id="food">
										<option value="1">�����</option>
										<option value="2">�����</option>
										<option value="3">�������</option>
										<option value="4">���-�����</option>
									</select>
								</div>
								<div class="checkbox ">
									<label for="ethi">������</label> <input type="checkbox"
										id="ethi">
								</div>
								<div class="checkbox">
									<label for="staff">��� ���</label> <input type="checkbox"
										id="staff">
								</div>
							</div>
							
		<!-- row 1 col 4 -->							
							<div class="col-lg-3">
								<div class="form-group">
									<label for="health">����� ������</label> <input type="text"
										class="form-control" id="health" placeholder="">
								</div>
								<div class="form-group">
									<label for="foodsens">������ �����</label> <input type="text"
										class="form-control" id="foodsens" placeholder="">
								</div>
								<div class="form-group">
									<label for="comnt">����� ������</label> <input type="text"
										class="form-control" id="comnt" placeholder="">
								</div>
							</div>
						</div>
					</div>
					
					
					<!-- row 2 col 1 -->
					<div class="row">
						<div class="col-lg-12">
						<h2>���� �������</h2>
							<div class="col-lg-3">
								
								<div class="form-group">
									<label for="p1fName">�� �����</label> <input type="text"
										class="form-control" id="p1fName" placeholder="��">
								</div>
								<div class="form-group">
									<label for="p1lName">�� �����</label> <input type="text"
										class="form-control" id="p1lName" placeholder="�����">
								</div>
								<div class="form-group">
									<label for="p1cell">����� ����</label> <input type="text"
										class="form-control" id="p1cell" placeholder="�����">
								</div>
								<div class="form-group">
									<label for="p1relat">����</label>
									<select class="form-control"
										id="p1relat">
										<option value="1">���</option>
										<option value="2">���</option>
										<option value="3">��</option>
										<option value="4">����</option>
										<option value="5">���</option>
									</select>
								</div>
							</div>
			<!-- row 2 col 2 -->
							<div class="col-lg-3">
								
								<div class="form-group">
									<label for="p2fName">�� �����</label> <input type="text"
										class="form-control" id="p2fName" placeholder="��">
								</div>
								<div class="form-group">
									<label for="p2lName">�� �����</label> <input type="text"
										class="form-control" id="p2lName" placeholder="�����">
								</div>
								<div class="form-group">
									<label for="p2cell">����� ����</label> <input type="text"
										class="form-control" id="p2cell" placeholder="�����">
								</div>
								<div class="form-group">
									<label for="p2relat">����</label>
									<select class="form-control"
										id="p2relat">
										<option value="1">���</option>
										<option value="2">���</option>
										<option value="3">��</option>
										<option value="4">����</option>
										<option value="5">���</option>
									</select>
								</div>
							</div>

			<!-- row 2 col 3 -->
							<div class="col-lg-3">
								
								<div class="form-group">
									<label for="address">����� ������</label> <input type="text"
										class="form-control" id="address" placeholder="�����">
								</div>
								<div class="form-group">
									<label for="phone">����� ����</label> <input type="text"
										class="form-control" id="phone" placeholder="�����">
								</div>
							</div>
							
			<!-- row 2 col 4 -->				
							<div class="col-lg-3">
								
								<div class="form-group">
									<button>����</button>
								</div>
								<div class="form-group">
									<button>���� ����</button>
								</div>
								<div class="form-group">
									<button>���</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
       </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Morris Charts JavaScript -->
    <script src="js/plugins/morris/raphael.min.js"></script>
    <script src="js/plugins/morris/morris.min.js"></script>
    <script src="js/plugins/morris/morris-data.js"></script>

</body>

</html>
