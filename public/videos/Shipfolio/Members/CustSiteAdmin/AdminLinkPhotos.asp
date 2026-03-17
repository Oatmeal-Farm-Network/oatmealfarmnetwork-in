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


</HEAD>
<body >
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalvariables.asp"--> 
<!--#Include file="AdminHeader.asp"-->
    <% 
   Current3="AlpacaPhotos" %> 
   <% if mobiledevice = False  then %>     
 <!--#Include file="AdminLinksTabsInclude.asp"-->
<% end if %>
<% 
LinkID=Trim(Request.Form("LinkID")) 
If Len(LinkID) < 1 then
	LinkID= Request.QueryString("LinkID") 
End if

session("LinkID") = LinkID
'response.write("LinkID=" & LinkID & "<br>")
Dim LinkIDArray2(1000)
Dim LinkTextArray(1000)


 If Len(LinkID) = 0 Then 

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from Links order by LinkText"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		LinkIDArray2(acounter) = rs2("LinkID")
		LinkTextArray(acounter) = rs2("LinkText")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>


        
<form action="AdminLinkPhotos.asp" method = "post">
	<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center">		 
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your Links:
					<select size="1" name="LinkID">
					<option name = "ALinkID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "ALinkID1" value="<%=LinkIDArray2(count)%>">
							<%=LinkTextArray(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Edit" class = "Submit" >
				</td>
			  </tr>
		    </table>
		  </form>
<% Else %>
	
 <!-- #include file="AdminLinkPhotoFormInclude.asp" -->
 <% End if %>
</td>
			  </tr>
		    </table>
<br>	
<!-- #include file="AdminFooter.asp" -->

 </Body>
</HTML>
