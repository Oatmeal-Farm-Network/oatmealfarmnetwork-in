<% sql = "SELECT  * FROM Properties, sfCustomers, PropertyPhotos WHERE cint(Properties.propID)=PropertyPhotos.propID and Properties.custID = sfCustomers.custID and Propforsale = true and  Properties.PropID = " & Propid & "  order by PropPrice DESC " 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
	
PropName=rs("PropName" ) 
PropMLS=rs("PropMLS" ) 
propPrice=rs("propPrice" ) 
propTaxes=rs( "propTaxes" ) 
PropSqFeet=rs( "PropSqFeet" ) 
PropAcres=rs( "PropAcres" ) 
PropBedrooms=rs("PropBedrooms")
PropBathrooms=rs("PropBathrooms")
PropFirePlaces=rs("PropFirePlaces") 
PropGarage=rs("PropGarage") 
PropRoof=rs("PropRoof") 
PropDescription=rs("PropDescription") 
PropOutBuildings=rs("PropOutBuildings") 
PropForSale=rs("PropForSale") 
PropSold=rs("PropSold") 
PropStreet1=rs("PropStreet1") 
PropStreet2=rs("PropStreet2") 
PropCity=rs("PropCity") 
PropState=rs("PropState") 
PropZip=rs("PropZip") 
propStyle=rs("propStyle") 
PropYearBuilt=rs("PropYearBuilt") 

str1 = PropDescription
str2 = vblf
If InStr(str1,str2) > 0 Then
	'PropDescription= Replace(str1, str2 , "</br>")
End If  

str1 = PropDescription
str2 = vbtab
If InStr(str1,str2) > 0 Then
	PropDescription= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  

if len(PropDescription) > 1 then
For y = 1 to Len(PropDescription)
    spec = Mid(PropDescription, y, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
	PropDescription= Replace(PropDescription,  spec, " ")
   end if
 Next
end if


custCompany=rs("custCompany") 
custFirstName=rs("custFirstName") 
custPhone=rs("custPhone") 
custPhone2=rs("custPhone2") 
custFAX=rs("custFAX") 
custAddr1=rs("custAddr1") 
custAddr2=rs("custAddr2") 
custCity=rs("custCity") 
custState=rs("custState") 
custCountry=rs("custCountry") 
custZip=rs("custZip") 
custCompany=rs("custCompany") 
Weblink=rs("Weblink") 
%>
<table  border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"    valign = "top">
					<td class= "body"  valign = "top" colspan = "3" width = "150">
					<br><h1><%= PropName%></h1>
							<% If (rs("PropPrice")) > 0 Then %>
									<br>	Price: <b><%=FormatCurrency(rs("PropPrice"))%></b><br>
									
	               <% End If  %>
							<br><%= PropDescription%><br><br>
<% ccounter = 1
ProductCounter = 1 %>

			


				</td>
			</tr>
			
			
		
	<tr>
		<td align = "center">
			<table>
				<tr>
					<td valign = "top" class = "body">
<br><br>To learn more please contact:<br>
			<% if Len(Logo) > 2 Then %>
				<a href = "/alpacaRanchQuest/OurHerd.asp?CustID=<%=CustID%>" class = "body"><img src = "/Uploads/Logos/<%=Logo %>" border = "0" width = "170"></a><br>
			<% End If %>
			<b><%=custCompany%></b><br>
				<%=custFirstName%><br>
					
					<% If Len(custPhone) > 1 Then %>
						Phone: 	<%=custPhone%><br>
					<% End If %>
						<% If Len(custphone2) > 1 Then %>
						Phone: 	<%=custPhone2%><br>
					<% End If %>
						<% If Len(custFAX) > 1 Then %>
						Fax: 	<%=custFAX%><br>
					<% End If %>
					<% If Len(custAddr1) > 1 Then %>
						<%=custAddr1%><br>
						<% If Len(custAddr2) > 1 Then %>
								<%=custAddr2%><br>
						<% End If %>
					<%=custCity%>,&nbsp;<%=custState%>&nbsp;<%=custCountry%>&nbsp;<%=custZip%><br>
					<% End If %>
					<br>
			
			<% If Len(Weblink) > 1 Then %>
					Find out more about <%=custCompany%> by going to their <a href = "http://<%=Weblink%>" class = "body" target = "blank" rel="nofollow" ><b>Website</b></a>.<br>
							<% End If %>


					</td>
				</tr>
			</table>
		</td>
	</tr>

</table>