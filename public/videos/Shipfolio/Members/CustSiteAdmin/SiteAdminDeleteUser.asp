<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title><%=Sitenamelong %> Administration</title>
<meta name="Title" content="<%=Sitenamelong %> Administration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
<!--#Include file="AdminGlobalVariables.asp"-->
<% Current2 = "SiteAdmin" 
Current3 = "DeleteUsers" %> 
<!--#Include file="adminHeader.asp"-->
<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>
<!--#Include file="SiteAdminTabsInclude.asp"-->
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 class ="roundedtopandbottom" width = "<%=screenwidth%>" >
<tr><td height = "560" valign = "top">

<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			 <H2>Delete a Member</H2>
		</td>
	</tr>
</table>

<%  
dim PeopleIDArray(5000) 
dim BusinessNameArray(5000) 
dim PeopleFirstNameArray(5000) 
dim PeopleLastNameArray(5000) 
		
    
		sql2 = "select * from People, Business where People.BusinessID = Business.BusinessID order by BusinessName"
		Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   

While Not rs2.eof  
		PeopleIDArray(acounter) = rs2("PeopleID")
		BusinessNameArray(acounter) = rs2("BusinessName")
		PeopleFirstNameArray(acounter) = rs2("PeopleFirstName")
		PeopleLastNameArray(acounter) = rs2("PeopleLastName")
		acounter = acounter +1
		rs2.movenext
	Wend		
		
%>

<form action= 'SiteAdminDeleteUserhandleform.asp' method = "post">
 <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select a member:
					<select size="1" name="PeopleID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=PeopleIDArray(count)%>">
						<%=BusinessNameArray(count)%> - <%=PeopleLastNameArray(count)%>, <%=PeopleFirstNameArray(count)%> 
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Delete" class = "regsubmit2" >
				</td>
			  </tr>
		    </table>
		  </form>
		  
	

<!--#Include virtual="/Footer.asp"--> </Body>
</HTML>