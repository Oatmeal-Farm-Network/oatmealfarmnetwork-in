<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>


<!--#Include file="membersGlobalVariables.asp"-->
</head>
<body >
	<% MasterDashboard= True 
    BladeSection = "users"
	pagename = "password" %> 
<!--#Include file="MembersHeader.asp"-->	<br />

<script>
function togglePasswordVisibility() {
  var passwordInput = document.getElementById("LeftShoe");
  if (passwordInput.type === "password") {
    passwordInput.type = "text";
  } else {
    passwordInput.type = "password";
  }
}


function togglePasswordVisibility2() {
  var passwordInput = document.getElementById("RightShoe");
  if (passwordInput.type === "password") {
    passwordInput.type = "text";
  } else {
    passwordInput.type = "password";
  }
}


</script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<%
sql = "select PeoplePassword from People where PeopleID = " & PeopleID

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
PeoplePassword = rs("PeoplePassword") 
end if
%>



<div class ="container roundedtopandbottom">
<div >
    <div>
		<H1>Reset Your Password</H1>
<% message = Request.Querystring("message") %>
<div>
   <div>
		<% if len(Message)> 2 then %>
	<b><font color = "brown">
    Please correct the following errors:
    <ul>
    <%=Message %>
    </ul>
    </font></b>
    
    <br><br>
	<% end if %>
      </div>
	</div>
</div>
<table width = "450" height = "100"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
<tr><td class = "body" valign = "top">
<form action= 'membersPasswordUpdate.asp'  name=form method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=5 cellspacing=5 bordercolor = "" align = "center" width = "460">
	<tr >
		<td  align = "left" valign = top  width= "180">
			New Password
		</td>
	</tr>
	<tr>
		<td  class = "body">
			<div class="input-group">
			 <input type="password" class="formbox" id="LeftShoe" name="LeftShoe" style="min-height: 36px" height=26 size= 26 maxlength="26">
			 <div class="input-group-append">
				 <button class="btn btn-outline-secondary" type="button" onclick="togglePasswordVisibility()" style="max-height:47px">
					 <i class="fa fa-eye"></i>
				 </button>
			</div>
			</div>

           
		</td>
	</tr>
	<tr>
		<td colspan ="2" style ="min-height:20px"></td>
	</tr>
	<tr >
		<td  align = "left"  >
			Re-Enter Password
		</td>
		</tr>
	<tr>
		<td  class = "body">
				<div class="input-group">
			 <input type="password" class="formbox" id="RightShoe" name="RightShoe" style="min-height: 36px" height=26 size= 26 maxlength="26">
			 <div class="input-group-append">
				 <button class="btn btn-outline-secondary" type="button" onclick="togglePasswordVisibility2()" style="max-height:47px">
					 <i class="fa fa-eye"></i>
				 </button>
			</div>
			</div>
		</td>
</tr>
<tr>
<td  valign = "middle" colspan = "2" class = "body">
<div align = "center">
<Input type = hidden name='PeopleID' value = <%=session("PeopleID")%> >
<small>Your password must be at least 8 charecters long.</small><br>
<input type=submit value = "Submit" size = "110" class = "regsubmit2" ><br><br><br>
</td></tr></table>
</form>
</td></tr></table>
</div></div>

<br>
<!--#Include file="membersFooter.asp"-->
</Body>
</HTML>