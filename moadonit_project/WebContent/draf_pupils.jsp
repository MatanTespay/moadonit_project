<%@ page language="java" contentType="text/html; charset=windows-1255"
	pageEncoding="windows-1255"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1255">
<!--  java script -->
<script src="resources/js/jquery-1.12.2.js"></script>
<script src="resources/bootstrap/js/bootstrap.js"></script>
<script src="resources/js/template_logic.js"></script>
<script src="resources/jquery-ui-1.11.4.custom/jquery-ui.min.js"></script>
<!--  css -->

<link rel="stylesheet" href="resources/bootstrap/css/bootstrap.css" />
<link rel="stylesheet"
	href="resources/jquery-ui-1.11.4.custom/jquery-ui.css" />
<link rel="stylesheet" href="resources/bootstrap/css/dashboard.css" />
<link rel="stylesheet" href="resources/bootstrap/css/sticky-footer.css" />
<link rel="stylesheet" href="resources/bootstrap/css/login-css.css" />
<link rel="stylesheet" href="resources/bootstrap/css/simple-sidebar.css" />
<!-- <link rel="stylesheet" href="resources/css/login.css" /> -->

<script type="text/javascript">
		var currentUserId =	 '<%=session.getAttribute("userid")%>	';
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
<script type="text/javascript">

$( document ).ready(function() {
	$('#segelCheck').click(function() {
	    $("#segelPosition").toggle(this.checked);
	});
});


</script>
<title>��������</title>
</head>
<body dir="rtl">
	<div id="header">
		<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">

					<div class="navbar-collapse collapse" style="margin-top: 15px">
						<a id="logout" href="login.jsp?action=logout">
						<span
							style="color: white; font-size: large;">�����</span><img
							src="resources/images/exit.png" id="logout"> </a>

					</div>
				</div>
				
				<div class="col-md-6 .col-md-offset-3">
					<DIV style="padding: 10px; color: white; font-size: x-large;">
						��������</DIV>


				</div>

			</div>
		</div>
	</div>
	<br>
	<br>
	<div id="content"></div>
	<div id="FormError" class="alert alert-danger" role="alert"
		style="display: none;"></div>

	<form id="registerForm" name="myForm" action="RegisterHandler.jsp"
		onsubmit="return onBtnClick()" method="post">
		
 <input
			type="text" name="fn" id="fn" onblur="OnlyLetters(this, fnErr)"
			placeholder="First Name" class="regInput" /> <span id="fnErr"
			class="error" style="display: none;"></span> <label id="icon"
			for="name"><i class="icon-user"></i></label> <input type="text"
			name="ln" id="ln" onblur="OnlyLetters(this, lnErr)"
			placeholder="Last Name" class="regInput" /> <span id="lnErr"
			class="error" style="display: none;"> </span> <input type="text"
			name="phone" id="phone" onblur="OnlyLetters(this, lnErr)"
			placeholder="phone" class="regInput" /> <span id="phoneErr"
			class="error" style="display: none;"> </span> <input type="text"
			name="bdate" id="bdate" onblur="OnlyLetters(this, lnErr)"
			placeholder="date" class="regInput" /> <span id="bdateErr"
			class="error" style="display: none;"> </span> 
			����
			<select>
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
		���
		<select>
		
			<option value="1">��</option>
			<option value="2">��</option>
			
		</select>

��� ���
		<select>
		
			<option value="1">�����</option>
			<option value="2">�����</option>
			<option value="3">�������</option>
			<option value="4">���-�����</option>
			
		</select>
		
		������: <input type="checkbox" id="ethi">
		���: <input type="checkbox" id="segelCheck" onclick="segelCheck()">
		
		<input
			type="text" name="segelPosition" id="segelPosition"  style="display: none;"
			placeholder="�����" />
			<br><br>
���� ������� 1			<input
			type="text" name="fnParent1" id="fnParent1" onblur="OnlyLetters(this, fnErr)"
			placeholder="First Name parent 1" class="regInput" />
			<input
			type="text" name="lnParent1" id="lnParent1" onblur="OnlyLetters(this, fnErr)"
			placeholder="Last Name parent 1" class="regInput" />
			<input
			type="text" name="phoneParen1" id="fnParent1" onblur="OnlyLetters(this, fnErr)"
			placeholder="phone number 1" class="regInput" />
			
			<input
			type="text" name="emailParent1" id="emailParent1" onblur="validateEmail(this,emailErr)"
			placeholder="emailParent1" class="regInput" />
			
			
����
		<select id="releation1">
		
			<option value="1">���</option>
			<option value="2">���</option>
			<option value="3">��</option>
			<option value="4">����</option>
			<option value="5">���</option>
			
		</select>
			<br>
			<br>
			
���� ������� 1			<input
			type="text" name="fnParent2" id="fnParent2" onblur="OnlyLetters(this, fnErr)"
			placeholder="phoneParen1" class="regInput" />
			
			<input
			type="text" name="lnParent2" id="lnParent2" onblur="OnlyLetters(this, fnErr)"
			placeholder="Last Name parent 1" class="regInput" />
			
			
				<input
			type="text" name="phoneParen2" id="fnParent2" onblur="OnlyLetters(this, fnErr)"
			placeholder="phone number 2" class="regInput" />
			
			<input
			type="text" name="emailParent2" id="emailParent2" onblur="validateEmail(this,emailErr)"
			placeholder="emailParent2" class="regInput" />
			
			
����
		<select id="releation2">
		
			<option value="1">���</option>
			<option value="2">���</option>
			<option value="3">��</option>
			<option value="4">����</option>
			<option value="5">���</option>
			
		</select>
			<br>
			����� 
			<input
			type="text" name="adress" id="adress"  
			placeholder="�����" />
			
			<input
			type="text" name="familyPhone" id="familyPhone"  
			placeholder="����� ����" />
			
			<textarea id="healthProblems" placeholder="healthProblems" rows="4" cols="15"></textarea>
				
				<textarea id="foodSensitivity" placeholder="foodSensitivity" rows="4" cols="15"></textarea>
				
				<textarea id="otherComments" placeholder="otherComments" rows="4" cols="15"></textarea>
				
				<input type="button" onclick="myFunction()" value="Submit form">

	</form>
	<div class="footer">
		<div class="container-fluid text-center">
			<p class="text-muted">�����....�����....�����....</p>
		</div>
	</div>

</body>
</html>