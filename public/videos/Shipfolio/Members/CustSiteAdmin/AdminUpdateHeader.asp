<!DOCTYPE HTML>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="style.css">
    <!--#Include File="AdminGlobalVariables.asp"--> 
</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body>
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include File="AdminHeader.asp"--> 
<br>
<%
screenwidth = screenwidth - 20

PeopleID = session("PeopleID")
sql = "select * from SiteDesign where Peopleid=667"
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
PeopleID = rs("PeopleID")
MultipleHeaders = rs("MultipleHeaders")
rs.close

sql = "select * from SiteDesign where Peopleid=667"
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
FavIcon= rs("FavIcon")
Header = rs("Header")
rs.close

%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  width = "<%=screenwidth %>"><tr><td class = "body roundedtopandbottom" align = "left">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  width = "<%=screenwidth %>" class = "roundedtopandbottom">
<tr><td class = "body " align = "left">
<H3><div align = "left">FavIcon</div></H3>
The FavIcon appears on the address bar in browsers when people come to your website. it should be 32pixels x 32 pixels in size and should have a <i>.ico, .jpg, .jpeg, or .png</i> extension. 
<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminPageUploadFaviconHandle2.asp" >
<% If len(Favicon) > 0 then%>
Current FavIcon: <img src = "<%= Favicon%>" width = 32 /><br>
<% End If %>

Upload Website FavIcon Image: 
<input name="attach1" type="file" size=45 /><br>
<center><input  type="submit" value="Upload" class = "regsubmit2"></center>
</form>
</td></tr>

<% If Len(Favicon) > 1 then%>
<tr><td >
<form action= 'AdminPageRemoveFavIcon2.asp' method = "post">
<input type = "hidden" name="ImageID" value= "1" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
<center><input type=submit value="Remove"class = "regsubmit2"></center>
</form>
</td></tr>
<% end if %>
</table>



	<br />

<% if MultipleHeaders = False then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtopandbottom" align = "left">
<H1><div align = "left">Heading</div></H1>
<% if len(Header) > 4 then %>
<img src ="<%=Header %>" width = "<%=screenwidth %>" />
<% end if %>


<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminHeaderUploadHandle2.asp" >
<% wrongformat = request.querystring("wrongformat")
if wrongformat = "True" then %>
<h1><font color=red><% end if %>  
<b>Images must be in JPG, JPEG, GIF, or PNG format and under 1MB in size.</b><br /><br />
<% if wrongformat = True then %>
</font></h1><% end if %>
Upload Heading Image: 
<input name="attach1" type="file" size=45 /><br>
<center><input  type="submit" value="Upload" class = "regsubmit2"></center>
</form>
</td></tr></table>

<% else %>


<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth -45%>" align = "center" class = "roundedtopandbottom">
<tr><td  align = "right"   class = "body roundedtopandbottom" colspan = "4">
<h1>Header Images</h1>
<b>Your header image should be 989 pixels wide must be in JPG, JPEG, GIF, or PNG format and under 1MB in size.</b><br />
<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminAddHeading.asp" >
Add a Header Image: 
<input name="attach1" type="file" size=45 /><br>
<center><input  type="submit" value="Upload" class = "regsubmit2"></center>
</form><br />
</td></tr>
<tr><td>


<% sql = "select * from SiteDesignHeaderImages order by HeaderMonth, HeaderTimeOfDay, HeaderDay"
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -45%>" class = "roundedtopandbottom"><tr><td class = "body " align = "left">
<H3><div align = "left">Current Header Images</div></H3>
<% wrongformat = request.querystring("wrongformat")
if wrongformat = "True" then %>
<h1><font color=red><% end if %>  
<b>Images must be in JPG, JPEG, GIF, or PNG format and under 1MB in size.</b></font></h1><br /><br />
<% if wrongformat = True then %>
<% end if %>
      
<% while not rs.eof
HeaderImage = rs("HeaderImage")
ScreenBackgroundColor = rs("ScreenBackgroundColor")
ScreenBackgroundImage= rs("ScreenBackgroundImage")
HeaderMonth= rs("HeaderMonth")
HeaderYear= rs("HeaderYear")
HeadertimeOfday= rs("HeadertimeOfday")
HeaderID= rs("HeaderID") %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -45%>" class = "roundedtopandbottom"><tr><td class = "roundedtopandBottom" align = "center" width = "<%=screenwidth %>">
<table cellpadding = "0" cellspacing = "0" align = "center" width = "400" class = "roundedtopandbottom" >
<tr><td class = "body">
<img src = "<%=HeaderImage %>" width = "380" />

<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminUpdatedExistingHeading.asp?HeaderID=<%=HeaderID %>" >
Update Header Image: 
<input name="attach1" type="file" size=45 /><br>
<center><input  type="submit" value="Upload" class = "regsubmit2"></center>
</form>
</td></tr>
</table>
<form action= 'AdminUpdateHeaderDateTime.asp?HeaderID=<%=HeaderID%>' method = "post">
<table cellpadding = "0" cellspacing = "0" align = "center" width = "400" class = "roundedtopandbottom" >
<tr><td colspan = "5"><b>What time and month do you want the header to start appearing?</b>
</td></tr>
<tr>
<td class = "body2" align = "center"><b>Month</b></td>
<td class = "body2" align = "center"><b>Time Of Day</b></td>
<td class = "body2" align = "center"></td>
</tr>
<tr>
<td >
<%
if len(HeaderMonth) > 0 then
else
 HeaderMonth = Month(now) 
end if
if len(Headerday) > 0 then
else
 Headerday = day(now) 
end if
if len(HeadertimeOfday) > 0 then
else
HeadertimeOfday = "Day and Night"
end if


%>
<select size="1" name="HeaderMonth">
<% if len(HeaderMonth) > 0 then %>
<option value="<%=HeaderMonth%>" selected><%=HeaderMonth%></option>
<% else %>
<option value="" selected>------</option>
<% end if %>
<option value="1">Jan.(1)</option>
<option  value="2">Feb.(2)</option>
<option  value="3">March (3)</option>
<option  value="4">April (4)</option>
<option  value="5">May (5)</option>
<option  value="6">June (6)</option>
<option  value="7">July (7)</option>
<option  value="8">Aug. (8)</option>
<option  value="9">Sept. (9)</option>
<option  value="10">Oct. (10)</option>
<option  value="11">Nov. (11)</option>
<option  value="12">Dec. (12)</option>
</select>
</td>
<td >
<select size="1" name="HeadertimeOfday">
<% if len(HeadertimeOfday) > 0 then %>
<option value="<%=HeadertimeOfday%>" selected><%=HeadertimeOfday%></option>
<% else %>
<option value="" selected>------</option>
<% end if %>
<option value="Day and Night">Day and Night</option>
<option value="Day">Day</option>
<option  value="Night">Night</option>
</select>
</td></tr>
<tr>
<td align = "center" colspan = 2><input type=submit value = "Update"  size = "110" Class = "regsubmit2" ></td>
</tr>
</table>
</form>
<br />
<form action= 'AdminHeaderDelete.asp?HeaderID=<%=HeaderID%>' method = "post">
<table cellpadding = "0" cellspacing = "0" align = "center" width = "400" class = "roundedtopandbottom" >
<tr><td colspan = "5" bgcolor ="#abacab"><b>Delete This Header</b> &nbsp;<input type=submit value = "Delete"  size = "110" Class = "regsubmit2" >
</td></tr>
</table>




</td></tr>

<% rs.movenext
wend 
rs.close
%>
</table>
<% end if %>

<% end if %>
</td></tr></table>
</td></tr></table>
<!-- #include file="adminFooter.asp" -->
 </Body>
</HTML>
