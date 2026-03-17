<!DOCTYPE HTML>

<HTML>
<HEAD>
 <title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"-->
  </HEAD>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">

<!--#Include file="AdminHeader.asp"-->
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "980" align = "center">
 <tr>
		<td colspan = "9" align = "center">

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center">
	<tr>
		<td Class = "body" >
			<h2>&nbsp;&nbsp;Edit Users</h2>
		</td>
	</tr>
		<tr>
		<td bgcolor = "#abacab" height = "1" ><img src = "images/px.gif"></td>
	</tr>
</table>


<%
 sql = "select * from Users order by custLastName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim CustID(800)
	dim CustLastName(800)
	dim CustFirstName(800)
	dim CustEmail(800)
	dim ActiveMember(800)
	dim AccessLevel(800)



Recordcount = rs.RecordCount +1
%>

<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center">
 <tr>
		<td colspan = "5" align = "center" >
					<H2>Edit an Existing Entry</H2>
		</td>
	</tr>
	<tr bgcolor = "#D4D4D4">
		<th width = "50" class = "body"><b>Access<br>Level</b></th>
		<th width = "170" align = "center" class = "body"><b>Last Name</b></th>
		<th width = "170" align = "center" class = "body"><b>First Name</b></th>
		<th width = "100" align = "center" class = "body"><b>Email Adress</b></th>
		<th width = "100" align = "center" class = "body"><b>Action</b></th>
	</tr>


	
<%
order = "odd"	

 While  Not rs.eof         
	 CustID(rowcount) =   rs("CustID")
	 CustFirstName(rowcount) =   rs("CustFirstName")
	 CustLastName(rowcount) =   rs("CustLastName")
	 CustEmail(rowcount) =   rs("CustEmail")
	 AccessLevel(rowcount) =   rs("accesslevel")
	%>

	<form action= 'AdminMembershandleform.asp' method = "post">

<% 
	 if order = "even" then
	  	order = "odd" %>
	  	<tr bgcolor = "#D4D4D4">
	  	
	 <% else
	     order = "even" %>
	 	<tr bgcolor = "white">    
	<% end if %>


		<td class = "body" valign = "top">
			&nbsp;	<select size="1" name="AccessLevel(<%=rowcount%>)">
					<% if len(AccessLevel(rowcount)) > 0 then 
				   if AccessLevel(rowcount) = "1" then %>
				   	<option value="1" selected >Basic Users</option>
				   		<option  value="2">Administrator</option>
				  <% else %>
				  	<option  value="2" selected >Administrator</option>
				  	<option value="1">Basic Users</option>

				  <% end if %>
				<% end if %>
				</select>
		</td>
		 <td class = "body">
			<input  name="CustLastName(<%=rowcount%>)" value= "<%=CustLastname(rowcount)%>" size = "30" class = "body">
		</td>
		<td class = "body">
			<input  name="CustFirstName(<%=rowcount%>)" value= "<%=CustFirstname(rowcount)%>" size = "20" class = "body">
		</td>
		<td class = "body">
			<input  name="CustEmail(<%=rowcount%>)" value= "<%=CustEmail(rowcount)%>" size = "30" class = "body">
		
		  <input  type = "hidden" name="CustID(<%=rowcount%>)" value= "<%=  CustID(rowcount)%>" >

		 </td>
	  	<td class = "body" align = "right"><a href = "AdminResetpassword.asp?CID=<%=CustID(rowcount)%>" class = "small">Reset Password</a></td>

	</tr>

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	
%>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" >
<tr>
		<td  valign = "middle">
			<div align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" AClass = "menu" >
			</form>
		</td>

</tr>
</table>

<!--#Include file="AdminFooter.asp"--> 

</Body>
</HTML>