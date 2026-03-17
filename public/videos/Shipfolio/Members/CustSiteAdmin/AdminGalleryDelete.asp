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

<!--#Include file="AdminGlobalVariables.asp"-->
</HEAD>
<body >

    <!--#Include file="AdminHeader.asp"--> 
<!--#Include file="AdminSecurityInclude.asp"-->
 

  <% Current3 = "DeleteGallery" %>
<!--#Include file="AdminGalleryTabsInclude.asp"-->

<% TempCategoryType="For Sale" 
 DeleteGalleryID=request.QueryString("GalleryID")
 
%>
   	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "980"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Delete an Gallery</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "300" width = "960"  valign = "top">

<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
if len(DeleteGalleryID) > 0 then						
	 sql = "select * from Gallerys where GalleryID = " &  DeleteGalleryID					
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
      DeleteGalleryHeadline = rs("GalleryHeadline")
    rs.close
end if					
						
 sql = "select * from Gallerys"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim GalleryID(40000)
	dim GalleryText(40000)
	dim Gallery(40000)
	dim Gallerydescription(40000)

	
Recordcount = rs.RecordCount +1
%>

<table border = "0" align = "left">
<tr>
  <td colspan = "2" align = "left">




				<%  
				dim aID(40000)
				dim GalleryHeadline(40000)
				dim aGallery(40000)

				conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
				"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
				sql2 =  "select * from Gallerys"

			acounter = 1
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3 
	
			While Not rs2.eof  
				aID(acounter) = rs2("GalleryID")
				GalleryHeadline(acounter) = rs2("GalleryHeadline")

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>

<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left">
	<tr>
		<td valign = "top" align = "Left" class = "body">
<br /><br />
<% Message=request.QueryString("Message")
if len(Message) > 0 then
 %>
   <font color = "brown"><b><%=Message %></b></font><br /><br />
 <% end if %>
			<form action= 'AdminGalleryDeleteHandleForm.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "Left">
			   <tr>
				 <td  class ="body" width = "200">
				 <div align = "right">
					<b>Gallery's Name: </b></div>
					</td>
					<td >
					<select size="1" name="GalleryID">
					<%  if len(DeleteGalleryID) > 0 then %>
						<option name = "AID0" value= "<%=DeleteGalleryID %>" selected><%=DeleteGalleryHeadline %></option>
					<% else %>
						<option name = "AID0" value= "" selected></option>
					<% end if %>
					
				
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=aID(count)%>">
							<%=GalleryHeadline(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<td valign = "top">
					<input type=submit value = "Delete" class = "regsubmit2" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>
<br><br><br>
<br><br>

</td>
</tr>
</table></td>
</tr>
</table><br><br>
   <!--#Include File="AdminFooter.asp"--> 
</Body>
</HTML>