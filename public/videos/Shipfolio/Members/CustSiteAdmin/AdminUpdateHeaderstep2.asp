<!DOCTYPE HTML>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="style.css">
    <!--#Include File="AdminGlobalVariables.asp"--> 
</HEAD>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<!--#Include File="AdminHeader.asp"--> 


<%
if rs.state = 0 then
else
rs.close
end if
sql = "select HeaderID from SiteDesignHeaderImages order by HeaderID Desc"
'response.write(sql)
rs.Open sql, conn, 3, 3   
HeaderID = rs("HeaderID")
rs.close
%>

<br>
<form action= 'AdminUpdateHeaderstep3.asp?HeaderID=<%=HeaderID%>' method = "post">
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth %>" align = "center" class = "roundedtopandbottom">
<tr>
<td class = "body" align = "right" colspan = "4">
<% FileName = request.querystring("FileName") 

if len(FileName) > 0 then %>
<img src = "<%=FileName%>" width = "<%=screenwidth - 20%>" align = "center">
<% end if %>
<h1>Upload Image</h1>
<b>What time and date do you want the header to start?</b><br><br>
<table cellpadding = "0" cellspacing = "0" align = "center"><tr>
<td class = "body2" align = "center"><b>Month</b></td>
<td class = "body2" align = "center"><b>Time Of Day</b></td>
<td class = "body2" align = "center"></td>
</tr>
<tr>
<td >
<% HeaderMonth = Month(now) 
HeaderDay = day(now)
HeaderYear  =  Year(now)
HeadertimeOfday = "Day and Night"
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
</td>
<td valign = "top"><input type=submit value = "Submit"  size = "110" Class = "regsubmit2" ></td>
</tr>
</table>
</form>
</td></tr>
</table>



<br><br>


<!-- #include file="adminFooter.asp" -->
 </Body>
</HTML>
