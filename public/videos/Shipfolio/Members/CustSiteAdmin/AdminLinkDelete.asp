<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="/administration/style.css"> 
   <!--#Include file="AdminSecurityInclude.asp"-->
    <!--#Include file="AdminGlobalVariables.asp"--> 
</head>
<body >
<!--#Include file="AdminHeader.asp"--> 
     <% Current3 = "Links" %>
<!--#Include file="AdminPagesTabsInclude.asp"-->
 <!--#Include file="AdminLinksTabsInclude.asp"-->
 	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Delete a Link</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" width = "960"  height = "200" valign = "top" >
     <div align = "left">
     <br />
 <% LinkID = request.QueryString("LinkID") 
if len(LinkID) > 0 then
else
LinkID = request.Form("LinkID") 
end if
    
sql = "select * from Links, LinkCategories where Links.CatID= LinkCategories.CatID and  linkID = " & LinkID

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3  
   if Not rs.eof then        
CategoryName =   rs("CategoryName")
LinkImage =   rs("LinkImage")
LinkText =   rs("LinkText")
LinkID=   rs("LinkID")
Linkdescription =   rs("LinkDescription")
CatID =   rs("Linkcategories.CatID")
Link =   rs("Link")
end if
rs.close
set rs=nothing
set conn = nothing
   imagefound =False
	 If Len(LinkImage) > 4 Then
	 imagefound =True
	 else 
	    LinkImage = "/Uploads/ImageNotAvailable.jpg"
	End If %> 


	
<form action= 'AdminLinkDeleteHandleForm.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" class = "roundedtopandbottom" width= "600">
<tr><td colspan = "2" align = "center"><img src = "<%= LinkImage%>" width = "75"></td></tr>
<tr><td class = "body2" width = "100" align = "right">Title:&nbsp;</td>
<td class = "body" align = "left"><b><input type = "text" name="LinkText" value= "<%= LinkText%>" ></b>
</tr>
<tr><td class = "body2" width = "100" align = "right">Link:&nbsp;</td>
<td class = "body" align = "left"><b><small>http://</small><%= Link%></b>
</tr>
<tr><td class = "body2" width = "100" align = "right" valign = "top">Description:&nbsp;</td>
<td class = "body" align = "left">
	<%= LinkDescription%>
		</td>
	</tr>
	<tr>
<td  colspan = "2" align = "center" valign = "middle" class = "body2" >
<br />
   <b>Warning! Once a link is deleted from your database, it's gone!</b><br><br>
   <input type = "hidden" name="LinkID" value= "<%= LinkID%>" >
	<input type=submit value = "Delete Link" class = "regsubmit2" >
		
		</td>
	</tr>
</table>

<br>
</form>

		

	</td>
	</tr>
</table>
<br />
<!--#Include file="AdminFooter.asp"--> </Body>
</HTML>