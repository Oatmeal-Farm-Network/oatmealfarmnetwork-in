<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Language=VBScript %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<!--#Include file="AdminConn.asp"-->
</head>
<body>
<% 
Set rs3 = Server.CreateObject("ADODB.Recordset")
attrDetailID=request.querystring("attrDetailID")
if len(attrDetailID) > 0 then
%>
<table width = "500" cellpadding = "0" cellspacing = "0" border = "0">
<% Counter= 0
i = 0
Counter = counter + 1
sql3 = "select attrDetailImage from sfattributeDetail where attrDetailID = " & attrDetailID & " order by attrDetailOrder "
rs3.Open sql3, conn, 3, 3 
attrDetailImage = rs3("attrDetailImage") %>
<form name="frmSend" method="POST" enctype="multipart/form-data" action="/administration/AdminFrameAddAttributephotosUpload.asp?attrDetailID=<%=attrDetailID %>" >
<tr><td width = "50">
<% if len(attrDetailImage) > 0  then %>
      <img src = "<%=attrDetailImage %>" width = "50" border = "0">
<% else %>
      <img src = "/uploads/ImageNotAvailable.jpg" width = "50" border = "0">
<% end if  %></td>
<td><input name="attach1" type="file" size=25 class = "regsubmit2">
<input type=submit value="Upload" class = "regsubmit2">
</td></form>
<% rs3.close %>

<% if len(attrDetailImage) > 0  then %>
<td>
<form action= 'AdminFramedeleteAttributephotos.asp?attrDetailID=<%=attrDetailID %>' method = "post">
<input type=submit value="Remove" class = "regsubmit2">
</td></form>
<% end if %>
</tr>

</table>
</td>
</tr>
</table>
<% end if %>
</body>
</html>