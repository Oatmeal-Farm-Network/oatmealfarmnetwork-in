<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>The Andresen Group Content Management System</title>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/alpacachamps/infinityknot.ico" /> 
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/administration/style.css">

<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalvariables.asp"--> 
</HEAD>
<body >

<!--#Include file="AdminHeader.asp"-->
    <% 
   Current3="LinkDelete" %> 
 <!--#Include file="AdminLinksTabsInclude.asp"-->

<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Links"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim LinkID(40000)
	dim LinkText(40000)
	dim Link(40000)
	dim Linkdescription(40000)

	
Recordcount = rs.RecordCount +1
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Delete Links</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
        <table border = "0" width = "960"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td  valign = "top" class = "body">
<br />

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "770" align = "center">
<tr>
  <td colspan = "2">




				<%  
				dim aID(40000)
				dim aLinkText(40000)
				dim aLink(40000)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
"User Id=;Password=;" 
sql2 =  "select * from Links where not (trim(LinkText)='Alpaca Infinity') and not(trim(LinkText) ='Etsy') and not (trim(LinkText) ='AlpacaSeller') and not (trim(LinkText) ='AlpacaStreet') and not( trim(LinkText) ='AlpacaNation') and not (trim(LinkText) ='OpenHerd') and not trim(LinkText) ='Facebook' and not (trim(LinkText) ='Twitter') and not(trim(LinkText) ='Google+') and not (trim(LinkText) ='LinkedIn') and not (trim(LinkText) ='YouTube') and not (trim(LinkText) ='Yahoo!') "

			acounter = 1
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3 
	
			While Not rs2.eof  
				aID(acounter) = rs2("LinkID")
				aLinkText(acounter) = rs2("LinkText")
				aLink(acounter) = rs2("Link")

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>


	<form action= 'AdminLinkDeleteHandleForm.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "770" align = "center">
	<tr>
		<td valign = "top" >
		
		
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 height = "300">
			   <tr>
				 <td >
				 
					<b>Link's Title:</b>
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=aID(count)%>">
							<%=aLinkText(count)%> (<%=aLink(count)%>)
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<td >
					<input type=submit value = "Delete" class = "regsubmit2" >
				</td>
			  </tr>
			  <tr>
			  <td height = "280">
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
</td>
	</tr>
</table>
<br><br>

    <!--#Include file="AdminFooter.asp"-->

</Body>
</HTML>