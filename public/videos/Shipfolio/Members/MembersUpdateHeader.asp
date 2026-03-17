<!DOCTYPE HTML>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="style.css">
    <!--#Include File="AdminGlobalVariables.asp"--> 
</HEAD>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<!--#Include File="AdminHeader.asp"--> 
<br>
<% PeopleID = session("PeopleID")
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
<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  width = "100%"><tr><td class = "body roundedtopandbottom" align = "left">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  width = "100%">
<tr><td class = "body roundedtopandbottom" align = "left">
<H3><div align = "left">FavIcon</div></H3>
The FavIcon appears on the address bar in browsers when people come to your website. it should be 32pixels x 32 pixels in size and should have a <i>.ico</i> extension. 
<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminPageUploadFaviconHandle2.asp" >
<% If len(Favicon) > 0 then %>
Current Fav Icon Image File Name: <%= Favicon%><br>
<% End If %>
Upload Page FavIcon Image: 
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


<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth %>" align = "center" class = "roundedtopandbottom">
<tr><td  align = "right"   class = "body" colspan = "4">
<h1>Header Images</h1><br /><br />
<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminAddHeading.asp" >
<% If len(Favicon) > 0 then %>
Current Fav Icon Image File Name: <%= Favicon%><br>
<% End If %>
Upload Page FavIcon Image: 
<input name="attach1" type="file" size=45 /><br>
<center><input  type="submit" value="Upload" class = "regsubmit2"></center>
</form>
<br><br>



<% sql = "select * from SiteDesignHeaderImages"
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "body " align = "left">
<H3><div align = "left">Header Images</div></H3>
 Your header image should be 989 pixels wide and .jpg or .png format.
</td></tr>
      
<% while not rs.eof
HeaderImage = rs("HeaderImage")
ScreenBackgroundColor = rs("ScreenBackgroundColor")
ScreenBackgroundImage= rs("ScreenBackgroundImage")
HeaderMonth= rs("HeaderMonth")
HeaderYear= rs("HeaderYear")
HeaderTimeofDay= rs("HeaderTimeofDay") %>
<tr><td class = "roundedBottom" align = "center" width = "100%">
 image=<%=HeaderImage  %>


<b>What time and date do you want the header to appear?</b><br><br>
<table cellpadding = "0" cellspacing = "0" align = "center"><tr>
<td class = "body2" align = "center"><b>Month</b></td>
<td class = "body2" align = "center"><b>Day</b></td>
<td class = "body2" align = "center"><b>Year</b></td>
<td class = "body2" align = "center"><b>Time Of Day</b></td>
<td class = "body2" align = "center"></td>
</tr>
<tr>
<td valign = "top">
<%
if len(HeaderMonth) > 0 then
else
 HeaderMonth = Month(now) 
end if
if len(Headerday) > 0 then
else
 Headerday = day(now) 
end if
if len(HeaderYear) > 0 then
else
 HeaderYear = Year(now) 
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
<td valign = "top">
<select size="1" name="HeaderDay">
<% if len(HeaderDay) > 0 then %>
<option value="<%=HeaderDay%>" selected><%=HeaderDay%></option>
<% else %>
<option value="" selected>------</option>
<% end if %>
<option value="1">1</option>
<option  value="2">2</option>
<option  value="3">3</option>
<option  value="4">4</option>
<option  value="5">5</option>
<option  value="6">6</option>
<option  value="7">7</option>
<option  value="8">8</option>
<option  value="9">9</option>
<option  value="10">10</option>
<option  value="11">11</option>
<option  value="12">12</option>
<option  value="13">13</option>
<option  value="14">14</option>
<option  value="15">15</option>
<option  value="16">16</option>
<option  value="17">17</option>
<option  value="18">18</option>
<option  value="19">19</option>
<option  value="20">20</option>
<option  value="21">21</option>
<option  value="22">22</option>
<option  value="23">23</option>
<option  value="24">24</option>
<option  value="25">25</option>
<option  value="26">26</option>
<option  value="27">27</option>
<option  value="28">28</option>
<option  value="29">29</option>
<option  value="30">30</option>
<option  value="31">31</option>
</select>
</td>
<td valign = "top">
<select size="1" name="HeaderYear">
<% if len(HeaderYear) > 0 then %>
<option value="<%=HeaderYear%>" selected><%=HeaderYear%></option>
<% else %>
<option value="<%=year(now)%>" selected><%=year(now)%></option>
<% end if %>
<% currentyear = year(date)  - 5
'response.write(currentyear)
For yearv=currentyear+1 To currentyear + 5%>
<option value="<%=yearv%>"><%=yearv%></option>
<% Next %></select>
</td>
<td valign = "top">
<select size="1" name="HeadertimeOfday">
<% if len(StartHour) > 0 then %>
<option value="<%=HeadertimeOfday%>" selected><%=HeadertimeOfday%></option>
<% else %>
<option value="" selected>------</option>
<% end if %>
<option value="Day and Night">Day and Night</option>
<option value="Day">Day</option>
<option  value="Night">Night</option>
</select>
</td>
<td valign = "top"><input type=submit value = "Submit"  size = "110" Class = "regsubmit2" ></td>
</tr>
</table>
</form>

</td></tr>
<% rs.movenext
wend 
rs.close
%>
</table>
<% end if %>

<% end if %>
</td></tr></table>

<!-- #include file="adminFooter.asp" -->
 </Body>
</HTML>
