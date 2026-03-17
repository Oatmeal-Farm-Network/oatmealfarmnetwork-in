<% If AlpacaPAC = True  Then %>

<div class="container"> 
<b class="rtop"> 
  <b class="rs1"></b> <b class="rs2"></b> 
</b> 
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "754">
	<tr>
		<td Class = "body" >
		<%  If Garagesale = True Then %>
 <a name = "Edit"></a><img src = "images/HomePackagesandMADHeader.jpg" width = "754" height = "34">
	   <% Else %>
	    <a name = "Edit"></a><img src = "images/HomePackagesHeader.jpg" width = "754" height = "34">
		<% End If %>
			
		</td>
	</tr>

<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Package where custID =  '" & session("custID") & "'"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim PackageID(200)
	dim PackagePrice(200)
	dim Value(200)
	dim PackageName(200)
	dim Description(200)
	dim CustID(200)
	Dim MADLotID(200)

Recordcount = rs.RecordCount +1
%>
<% if rs.eof  then%>
<tr>
   <td>
		<font class = "body"><b>Currently you do not have any packages. To create a package please <a href= "packagesadd.asp" class = "body"><b>click here</b></a>.</font><br><br>
	</td>
</tr>
<% else %>
<tr>
	<td>
	<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0" width = "100%">
		<tr>
		
		<td class = "body" align = "center" width = "300"><b>Name</b></td>
		<td class = "body" align = "center" width = "200"><b>Price</b></td>
		<td class = "body" align = "center" ><b>Value</b></td>
		<td width = "200">
		</td>
	  </tr>
	  </table>
	  </td>
</tr>
<%
even = True
rowcount = 1
 While  Not rs.eof     
	 PackageID(rowcount) =   rs("PackageID")
	 PackageName(rowcount) =   rs("PackageName")
	 PackagePrice(rowcount) =   rs("PackagePrice")
	  Value(rowcount) =   rs("PackageValue")
	 Description(rowcount) =   rs("Description")
	 custID(rowcount) =   rs("custID")
	 MADLotID(rowcount) = rs("MADLotID")
If even = True then
	even = False
Else
	even = True
End If 

If even = True then
%>
   <tr>
		<td>
				<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0" width = "754">
		<tr>
<% Else %>
<tr>
		<td>
		<table bgcolor = "white" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0" width = "754">
		<tr>
<% End If %>
	
		<td class = "body" width = "300">
		<% If Len(MADLotID(rowcount)) > 0 Then %>
		(Make a Deal Lot # <%=MADLotID(rowcount)%>)<br>
		<% End If %>
		<b><a href = "editPackageStep2.asp?PackageID=<%= PackageID(rowcount)%>" class = "body"><%= PackageName(rowcount)%></a></b> 
		</td>
		<td class = "body" width = "200" align = "center" >
		<% if len(PackagePrice(rowcount)) > 1 Then %>
			<%= formatcurrency(PackagePrice(rowcount), 2) %>
		<% Else %>
		Not <br>Assigned
		<% end if %>

				</td>
		<td class = "body" align = "center">
		<% if len(Value(rowcount)) > 1 Then %>
		<%= formatcurrency(Value(rowcount),2)%>
		<% Else %>
		Not <br>Assigned
		<% end if %>
		

		</td>
		<td width = "100" align = "right">
			<img src = "images/px.gif" width = "60" height = "0"><a href = "editPackageStep2.asp?PackageID=<%= PackageID(rowcount)  %>" class = "body"><b>Edit</a>

		</td>
		<td width = "100" align = "right">
			<img src = "images/px.gif" width = "60" height = "0"><a href = "editPackageLayout2.asp?PackageID=<%= PackageID(rowcount)  %>" class = "body"><b>Layout</a>

		</td>
		</tr>
	</table>
	</td>
	</tr>
		
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
%>



<% end if%>
<tr><td><div align = "right"><br><a href = "PackagesAdd.asp" class = "body"><b>Add a Package</b></a>&nbsp;</div></td></tr>
</table>
<br>

<b class="rbottom"> 
   <b class="rs2"></b> <b class="rs1"></b> 
</b> 
</div>
<% End if%>