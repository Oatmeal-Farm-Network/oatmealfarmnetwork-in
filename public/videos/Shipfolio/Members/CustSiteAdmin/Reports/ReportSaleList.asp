<% SetLocale("en-us") %>
<html>

<head>
<!--#Include file="ReportsGlobalVariables.asp"-->

<% linecounter = 0 %>
<link rel="stylesheet" type="text/css" href="/Style.css">
<STYLE TYPE="text/css">
     H4 {page-break-before: always}
</STYLE> 

</head>
<body  border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<table   border="0"  bordercolor = "#AA8560" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"   width = "600">
	<tr>
		 <td  align = "center" class = "body">	
		 <% if len(Logo) > 1 then%>
		    <img src = "<%=Logo%>" align = "center" />
		 <% end if %>
		 <font face="arial" size="4"><b><%=WebSiteName%></b></font><br>
		 <font face="arial" size="3"><b>Alpacas Sales List</b></font><br>
<font face="arial" size="3">
Phone Number: <%=Phone%>&nbsp;&nbsp;<br>
		<% if len(Fax) > 1 then %>
					Fax: <%=Fax%>&nbsp;&nbsp;<br>
		<% end if %> 
				<% if len(Street) > 1 then %>
							<%=Street%><br>
				<% end if %>
					<% If  Len(Street2) >1 Then %>
						<%=Street2%><br>
					<% End If %>
					<% if len(City) > 1 then %>
					    <%=City%>, &nbsp;
					<% end if  %>
					<% if len(State) > 1 then %>
					<%=State%>&nbsp;
					<% end if %>
					<% if len(Zip) > 1 then %>
					    <%=Zip%>
					 <% end if %>
					 <% if len(City) > 1 or  len(State) > 1 or len(Zip) > 1 then %>
					 <br>
					 <% end if %></font>
					<font face="arial" size="3"><%=Email%></font>
	
				<table width = "700"    border="0" cellspacing="0" cellpadding="0"  align = "center">
					<tr>
						<td  class = "body" valign = "top"  align = "center">
							
<table border = "0" width = "700"    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
<tr>
		<td   class = "body" valign = "top" colspan = "5"   >
				<font face="arial" size="4"><b>Females for Sale</b></font><BR>
	</tr>
				
	

<% 	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	' Get marketing text for the top of the page:
     
	sql = "SELECT Animals.*, Pricing.*, Photos.*, Ancestors.*, Femaledata.*, colors.* FROM Animals, Pricing, Photos, Ancestors, Femaledata, colors WHERE Animals.ID=Pricing.ID And Animals.ID=colors.ID  And Animals.ID=Photos.ID And Animals.ID=Ancestors.ID And Femaledata.ID=Animals.ID And Animals.ID=Ancestors.ID and (Category = 'Experienced Female' or Category = 'Inexperienced Female' ) and not(sold = true)  and forSale = True order by Price DESC" 
	' response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 
 	if rs.eof then %>
		  <tr><td class = "body" align = "center"><font color = "Black" face="arial"  size = "3"><b>Currently we do not have any female for sale.</font></b>
		<br><br></td></tr>  
	<%end if%>
<% DetailType = "Dam" %>
<!--#Include file="ReportDetailInclude.asp"--> 
</td>
		</tr>
			<tr>
					<td colspan = "5">
					<br style="page-break-after:always;">

					</td>
				</tr>
</table>

<br>

<table width = "700"    border="0" cellspacing="0" cellpadding="0" >
<tr><td class = "body" valign = "top" width = "300">
											<% linecounter = 0 %>
	
<table border = "0" width = "700"    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
<tr>
		<td   class = "body" valign = "top" colspan = "5"  height = "10" >
							<font face="arial" size="4"><b>Males for Sale</b></font><BR>
	</tr>
	

<% 	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	' Get marketing text for the top of the page:
  	sql = "SELECT Animals.*, Pricing.*, Photos.*, Ancestors.*,  colors.* FROM Animals, Pricing, Photos, Ancestors,  colors WHERE Animals.ID=Pricing.ID And Animals.ID=colors.ID  And Animals.ID=Photos.ID And Animals.ID=Ancestors.ID And  Animals.ID=Ancestors.ID and (Category = 'Experienced Male' or Category = 'Inexperienced Male' ) and not(sold = true) and forSale = True order by Price DESC" 

	' response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 
 	if rs.eof then %>
		  <tr><td class = "body" align = "center" ><font color = "Black" face="arial"  size = "3"><b>Currently we do not have any males for sale.</font></b>
		<br><br></td></tr>  
	<%end if%>
<% DetailType = "Sire" %>
<!--#Include file="ReportDetailInclude.asp"--> 
	
</td>
		</tr>
</table>

<br>


<% linecounter = 0 %>
<h4>&nbsp;</h4>



<% 	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	' Get marketing text for the top of the page:
       	sql = "SELECT Animals.*, Pricing.*, Photos.*, Ancestors.*,  colors.* FROM Animals, Pricing, Photos, Ancestors,  colors WHERE Animals.ID=Pricing.ID And Animals.ID=colors.ID  And Animals.ID=Photos.ID And Animals.ID=Ancestors.ID And  Animals.ID=Ancestors.ID and (Category = 'non-Breeder'  ) and not(sold = true) and forSale = True order by Price DESC" 
 
	' response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 
 	if rs.eof then %>
		
	<%else%>
	<a name="FiberMales"></a>
<table border = "0" width = "700"    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
<tr>
		<td background = "images/linebackground.jpg"  class = "body" valign = "top" colspan = "5"  height = "10" >
				<font face="arial" size="4"><b>Fiber Males for Sale</b></font><BR>
	</tr>
				
	<tr>
				<td colspan = "5" height = "9" valign = "top">&nbsp;</td>
</tr>
<% DetailType = "Other" %>
<!--#Include file="ReportDetailInclude.asp"--> 

</td>
		</tr>
</table><% End If %></td></tr></table></td></tr></table></td></tr></table>




</body>
</html>

