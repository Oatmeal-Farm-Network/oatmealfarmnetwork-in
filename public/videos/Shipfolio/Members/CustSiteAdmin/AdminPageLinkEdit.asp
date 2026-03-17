<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="/administration/style.css">

<!--#Include file="AdminGlobalvariables.asp"--> 
</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include file="AdminHeader.asp"-->
<% Current3="LinksHome" %> 

<% LinkID = request.QueryString("LinkID") 
if mobiledevice = False  then %>
<% Current3="Links" %> 
<br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Edit Link</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "100%">

<%    
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
CatIDx =   rs("Linkcategories.CatID")

Link =   rs("Link")
LinkShowOnfooter = rs("LinkShowOnfooter")
Dim TempCatID(100,100)
Dim TempCategoryName(100, 100)
%>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" class = "roundedtopandbottom" width = "100%">
<tr >
	 <td class = "body2" valign = "top" align = "center" colspan = "2">
		 <% 
	    imagefound =False
	 If Len(LinkImage) > 4 Then
	 imagefound =True
	 else 
	    LinkImage = "/uploads/ImageNotAvailable.jpg"
	End If %> 

<img src = "<%= LinkImage%>" width = "150"><br />
		
<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminLinkUploadImage.asp?LinkID=<%=LinkID %>&Returnpage=AdminpageLinkEdit.asp">
Upload Photo: <br>
<input name="attach" type="file" size=35 class = "regsubmit2 body">
<input  type=submit value="Upload" class = "regsubmit2 body">
</form>
  </td>
</tr>
<tr><td class = "body2" colspan = "2" align = 'center'>
<form action= 'AdminLinkImageRemove.asp' method = "post">
<input type = "hidden" name="ImageID" value= "1" >
<input type = "hidden" name="LinkID" value= "<%= LinkID %>" >
<input type = "hidden" name="ReturnPage" value = "AdminpageLinkEdit.asp?LinkID=<%=LinkID %>">
<input type=submit value="Remove This Image" class="regsubmit2">
</form>
	
</td></tr>
<tr><td height = "30" colspan = "2">&nbsp;</td></tr>

<form action= 'AdminLinkhandleform.asp' method = "post">

<input type = "hidden" name="ReturnPage" value = "AdminpageLinkEdit.asp?LinkID=<%=LinkID %>">
<tr><td class = "body2" width = "140" align = "right">Title:&nbsp;</td>
<td class = "body" align = "left"><b><input type = "text" name="LinkText" value= "<%= LinkText%>" size = "60"></b>
</tr>
<tr><td class = "body2"  align = "right" height = "20">Link:&nbsp;</td>
<td class = "body" align = "left"><b><small>http://</small><input type = "Text" name="Link" value= "<%= Link%>" size = "53" class = "body"></b>
</tr>

<tr><td class = "body2"  align = "right" height = "40"><b><a class="tooltip" href="#">Show On Footer?<span class="custom info">If a link is marked as <i>Show on Footer</i> as true then it will appear at the bottom of ever page of the website, <b>if an image is associated with it.</b></span></a></b>:&nbsp;</td>
<td class = "body" align = "left"><% if  LinkShowOnfooter = "Yes" Or  LinkShowOnfooter = True Then %>
Yes<input TYPE="RADIO" name="LinkShowOnfooter" Value = True checked>
No<input TYPE="RADIO" name="LinkShowOnfooter" Value = False >
<% Else %>
Yes<input TYPE="RADIO" name="LinkShowOnfooter" Value = True >
No<input TYPE="RADIO" name="LinkShowOnfooter" Value = False checked>
<% End if%> </td></tr>
				
				
<input type = "hidden" name="CatID" value = "<%=CatIDx %>">

<tr><td class = "body2"  align = "right" valign = "top">Description:&nbsp;</td>
<td class = "body" align = "left">
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
<script language="javascript1.2" type="text/javascript">
// attach the editor to the textarea with the identifier 'textarea1'.
WYSIWYG.attach("LinkDescription", mysettings);
mysettings.Width =  "450px"
mysettings.Height = "200px"
</script>
 <textarea name="LinkDescription"  ID="LinkDescription" cols="60" rows="30"   class = "body"  ><%= LinkDescription%></textarea>
</td></tr>
<tr><td class = "body2" colspan = "2" align = 'center'>
<input type = "hidden" name="LinkID" value= "<%= LinkID%>" >
<center><input type=submit value = "Update Link" class = "regsubmit2 body" ></center>
</form>
</td></tr></table>
<%
end if
rs.close
set rs=nothing
set conn = nothing
%>
</td>
</tr>
</table>
<%end if %>

<br />

    <!--#Include file="AdminFooter.asp"-->

</Body>
</HTML>