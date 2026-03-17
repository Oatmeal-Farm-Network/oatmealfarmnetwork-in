<% SetLocale("en-us") %>
<html>

<head>
<!--#Include file="AdminGlobalVariables.asp"-->
<!--#Include file="AdminReportsGlobalVariables.asp"-->
<% linecounter = 1 %>

<STYLE TYPE="text/css">
     H4 {page-break-before: always}
</STYLE> 

</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">




<table   border="0"  bordercolor = "#AA8560" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"   width = "700" bgcolor = "white">
	<tr>
		 <td  align = "center" class = "body">	
<table   border="0"  bordercolor = "#AA8560" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"   width = "600" bgcolor = "white">
	<tr>
		 <td  align = "center" class = "body">	
		 <% if len(logo)> 1 then 
		 leftwidth = "50%" %>
		 <img src = "<%=Logo%>" border = "0" height = "100"><br>
		 <% else
leftwidth = "100%"		 
 end if %>
		 </td>
		 <td width = "<%=leftwidth%>">
		 <font face="arial" size="4"><b><%=Website%></b></font><br>
<font face="arial" size="3">
<% if len(Owners) > 1 then %>
	<%=Owners%>&nbsp;&nbsp;<br>
<% END IF %>
<%=PeoplePhone%>&nbsp;&nbsp;<br>
<% if len(PeopleCell) > 1 then %>
	<%=PeopleCell%>&nbsp;&nbsp;<br>
<% END IF %>
<% if len(PeopleFax) > 1 then %>
	Fax: <%=PeopleFax%>&nbsp;&nbsp;<br>
<% END IF %>
<% If  Len(AddressStreet) >1 Then %>
<%=AddressStreet%><br>
<% end if %>
<% If  Len(AddressApt) >1 Then %>
	<%=AddressApt%><br>
<% End If %>
<% IF LEN(Addresscity) > 1 then %>
<%=AddressCity%>, <%=AddressState%> &nbsp;<%=AddressZip%><br>
<% end if %></font>
<font face="arial" size="3"><%=WebSiteName%></font><br>
<font face="arial" size="3"><%=PeopleEmail %></font><br>
</td></tr></table>

<table width = "700"    border="0" cellspacing="0" cellpadding="0"  align = "center">
	<tr>
		<td  class = "body" valign = "top"  align = "center">
							
<table border = "0" width = "700"    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
<tr>
		<td   class = "body" valign = "top" colspan = "5"   >
				<font face="arial" size="3"><b>Dams for Sale</b></font><BR>
	</tr>
				
	

<% 	' Get marketing text for the top of the page:
      sql = "select animals.*, Pricing.*, colors.*, photos.*, ancestors.* from Animals, Pricing, Colors, photos, ancestors  where Animals.ID = Pricing.ID and animals.id = ancestors.id and animals.id = photos.id and animals.id = colors.id and (Category = 'Experienced Female' or Category = 'Inexperienced Female'  ) and forsale = true order by FullName"
      
	'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 
 	if rs.eof then %>
		  <tr><td class = "body" align = "center"><b>Currently we do not have any female alpacas for sale.</b>
		<br><br></td></tr>  
	<%end if%>
<% DetailType = "Dam" %>
<!--#Include file="AdminReportDetailInclude.asp"--> 
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
								<tr>
									<td class = "body" valign = "top" width = "300">
											<% linecounter = 0 %>
									
										
<table border = "0" width = "700"    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
<tr>
		<td background = "images/linebackground.jpg"  class = "body" valign = "top" colspan = "5"  height = "10" >
				<font face="arial" size="3"><b>Males for Sale</b></font><BR>
	</tr>
	

<% 	     
     sql = "select animals.*, Pricing.*, colors.*, photos.*, ancestors.* from Animals, Pricing, Colors, photos, ancestors  where Animals.ID = Pricing.ID and animals.id = ancestors.id and animals.id = photos.id and animals.id = colors.id and (Category = 'Experienced Male' or Category = 'Inexperienced Male'  ) and forsale = true order by FullName"
      
	' response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 
 	if rs.eof then %>
		  <tr><td class = "body" align = "center" ><b>Currently we do not have any herdsires for sale.</b>
		<br><br></td></tr>  
	<%end if%>
<% DetailType = "Sire" %>
<!--#Include file="AdminReportDetailInclude.asp"--> 
	
</td>
		</tr>
</table>


<br>


<% linecounter = 0 %>
<h4>&nbsp;</h4>



<% 	     
  sql = "select animals.*, Pricing.*, colors.*, photos.*, ancestors.* from Animals, Pricing, Colors, photos, ancestors  where Animals.ID = Pricing.ID and animals.id = ancestors.id and animals.id = photos.id and animals.id = colors.id  and ( Category = 'non-breeder'  ) and forsale = true order by FullName"
      

	' response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 
 	if rs.eof then %>
		
	<%else%>
	<a name="FiberMales"></a>
<table border = "0" width = "700"    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
<tr>
		<td background = "images/linebackground.jpg"  class = "body" valign = "top" colspan = "5"  height = "10" >
				<h2>Fiber Males for Sale</h2>
	</tr>
				
	<tr>
				<td colspan = "5" height = "9" valign = "top">&nbsp;</td>
</tr>
<% DetailType = "Other" %>
<!--#Include file="AdminReportDetailInclude.asp"--> 

</td>
		</tr>
</table><% End If %></td></tr></table></td></tr></table></td></tr></table>




</body>
</html>

