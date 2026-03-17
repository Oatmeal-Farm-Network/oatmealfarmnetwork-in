<% if EcommerceAvailable = True then
sql = "select * from sfProducts "
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
rowcount = 1
Recordcount = rs.RecordCount +1
if not rs.eof Then %>
<table border = 0 cellspacing = 0 cellpadding = 0 width = 190 >
 <tr><td align = "center" width = "100%" class = "roundedtop"><h2>Products</h2></td></tr>
 <tr><td class = "roundedBottom body"> 
 <iframe src="/administration/AdminleftsidemenuProductsframe.asp" height = "400" width = "199" frameborder = 0></iframe><br /><br />
<% end if %>
<center><a href = "/administration/AdminClassifiedAdPlace.asp" class = "body"><b>Add a Product</b></a></center>
</td>
</tr>
</table>
<% end if %>
