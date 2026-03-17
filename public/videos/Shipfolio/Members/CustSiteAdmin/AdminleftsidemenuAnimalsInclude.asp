<% if LivestockAvailable = True then %>
<% sql = "select distinct animals.*, Pricing.* from animals, Pricing where Animals.ID = Pricing.ID and Sold=No order by speciesID, FullName"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
rowcount = 1
Recordcount = rs.RecordCount +1
if not rs.eof Then %>
<table border = 0 cellspacing = 0 cellpadding = 0 width = 199 >
<tr><td align = "center" width = "100%" class = "roundedtop"><h2>Animals</h2></td></tr>
<tr><td class = "roundedBottom body"> 
<iframe src="/administration/AdminleftsidemenuAnimalsframe.asp" height = "400" width = "199" frameborder = 0></iframe><br /><br />
<center><a href = "/administration/AdminAnimalAdd1.asp" class = "body"><b>Add an Animal</b></a></center>
</td></tr></table>
<% End If %>
<% End If %>