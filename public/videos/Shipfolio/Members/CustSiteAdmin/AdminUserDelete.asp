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
		
		
<% Message = request.querystring("Message") 
   
if len(Message) > 5 then 
%>
 <table border = "0" bordercolor = "bbbbbb"  cellpadding=0 cellspacing=0 width = "900" >
 <tr>
	<td  Class = "body">
		<br><big><b><%=Message %></b></big><br><br>
   </td>
  </tr>
 </table>
<% end if %>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center">
	<tr>
		<td Class = "body" >
			<h2>Delete a User</h2>
		</td>
	</tr>
	<tr>
		<td bgcolor = "#abacab" height = "1" ><img src = "images/px.gif"></td>
	</tr>
</table>
<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" bgcolor = "#D4D4D4">
	<tr>
		<td class = "body">
			&nbsp;&nbsp;Select a user to be deleted from the list below:
			
		</td>
	</tr>

<%  
dim OldMemberID(800)
dim OldCustFirstName(800)
dim OldCustLastName(800)

	

						 
	sql2 = "select * from Users order by custLastName"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		OldMemberID(acounter) = rs2("CustID")
		OldCustFirstName(acounter) = rs2("CustFirstName")
		OldCustLastName(acounter) = rs2("CustLastName")
		'response.write ("name=" & OldCustLastName(acounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		



%>
	<tr>
		<td align = "left">
		<table width = "700" align = "center"><tr><td>

			<form action= 'AdminMembersDeleteHandleform.asp' method = "post">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left">
			   <tr>
			   <td width = "150" class = 'body' align = "right">Users:</td>
				 <td>
						<select size="1" name="OldMemberID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=OldMemberID(count)%>">
							<%=OldCustlastName(count)%> , <%=OldCustFirstName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select><br>
				</td>
			</tr>
			<tr>
				<td colspan = "2" align = "center">
					<input type=submit value = "Delete User"  style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" ><br><br>
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>
		</td>
	</tr>
</table>

		</td>
	</tr>
</table>
<br><br>
<!--#Include file="AdminFooter.asp"--> 

</Body>
</HTML>