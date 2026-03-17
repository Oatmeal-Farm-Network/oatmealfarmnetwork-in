 <!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!--#Include virtual="/GlobalVariables.asp"-->
<% SetLocale("en-us") 
CurrentPeopleID=Request.Form("CurrentPeopleID") 
If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.QueryString("CurrentPeopleID") 
End if
If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.QueryString("PeopleID") 
End if
If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.querystring("custID") 
End if
If Not Len(CurrentPeopleID)> 0 Then 
	Response.Redirect("Default.asp")
End if
sql = "select  * from People where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
	RanchHomeText = rs("RanchHomeText")
	BusinessID   = rs("BusinessID")
	AddressID  = rs("AddressID")
	Logo = rs("Logo")
	Header = rs("Header")
	str1 = RanchHomeText
str2 = vblf
end if 
rs.close
if len(BusinessID) > 0 then
else
response.Redirect("default.asp")
end if
sql = "select  BusinessName from Business where BusinessID= " & BusinessID
rs.Open sql, conn, 3, 3
If not rs.eof then
BusinessName = rs("BusinessName")
end if 
rs.close
sql = "select  * from Address where AddressID= " & AddressID
rs.Open sql, conn, 3, 3
If not rs.eof then
AddressCity = rs("AddressCity")
AddressState = rs("AddressState")
end if 
rs.close
if len(AddressState) > 1 then
  sql = "SELECT * from States where StateAbbreviation =  '" & AddressState & "'"
'response.write (sql)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql, conn, 3, 3   
if not rs2.eof then
StateName = trim(rs2("StateName"))
StateAbbreviation = rs2("StateAbbreviation")
Nicknames = rs2("Nicknames") 
end if
rs2.close
end if
%>
<title><%= BusinessName %> | <%=StateName %> Properties for Sale</title>
<meta name="Title" content="<%= BusinessName %> | <%=StateName %> Properties for Sale">
<meta name="description" content="<%=StateName %> Properties at <%= BusinessName %> in <%= AddressCity %>, <%= AddressState %> presented by Livestock of America - Online Animal marketplace.  " >
<meta name="robots" content="index,follow">
<meta name="rating" content="Safe for kids">
<meta name="revisit-after" content="1">
<meta name="Googlebot" content="index,follow">
<meta name="robots" content="All">
<meta name="subject" content="<%=StateName %> Properties for Sale" >
<link rel="stylesheet" type="text/css" href="/style.css">
 <!--#Include file="RanchPropertiesDetailDBInclude.asp"--> 
</head>
<BODY onload="addEvents();" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<!--#Include file="RanchHeader.asp"-->
 <% Current3 = "Properties" %>
 <!--#Include file="RanchPagesTabsInclude.asp"-->
<table border="0"   cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" width = "<%=screenwidth %>" class = "roundedtopandbottom">
<tr><td class = "body">
<br><h1><%= PropName%></h1>
<table border="0">
<tr><td valign = "top" width = "350" class = "body">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="2"  cellpadding=2 cellspacing=2 >
<tr><td   class = "body"  align = "right">	
Price: 
</td><td   class = "body">	
<b><%=FormatCurrency(PropPrice, 0)%></b>
</td></tr>
<% if  propSold = "Yes" Or  propSold = True Then %>
<tr>
<td   class = "body" colspan = "2" align = "center">
<B>Sold!</b>
</td>
</tr>
<% End If %>
<tr>
				<td class = "body"  align = "right">
					MLS# : 
				</td>
				<td class = "body"   >
					<%=PropMLS %>
				</td>
				</tr>
 <% if len(propTaxes) > 0 then %>			
<tr><td class = "body"  align = "right">
Taxes:
</td>
<td class = "body" >
<%=FormatCurrency(propTaxes, 0) %>
</td></tr>
 <% end if %>
			<tr>
				<td class = "body"  align = "right">
					Square Feet:
				</td>
				<td class = "body" >
						<%=PropSqFeet %>
				</td>
			</tr>
			<tr>
				<td class = "body"  align = "right">
					Acreage:
				</td>
				<td class = "body" >
					<%=PropAcres %>
				</td>
			</tr>
					<% If Len(PropYearBuilt) > 1 then %>
			<tr>
				<td class = "body"  align = "right">
					House Style:
				</td>
				<td class = "body" >
					<%=propStyle%>
				</td>
			</tr>
			<% End If %>
			<% If Len(PropYearBuilt) > 1 then %>
			<tr>
				<td class = "body"  align = "right">
					Year Built:
				</td>
				<td class = "body" >
					<%=PropYearBuilt %>
				</td>
			</tr>
			<% End If %>
			<tr>
				<td class = "body"  align = "right">
					Bedrooms:
				</td>
				<td class = "body">
					<%=PropBedrooms %>
					
			</td>
		</tr>
		<tr>
			<td class = "body"  align = "right">
				Bathrooms:
			</td>
			<td class = "body" >
			<%=PropBathrooms %>
		</td>
	</tr>
	<tr>
				<td class = "body"  align = "right">
					Fireplaces:
				</td>
				<td class = "body" >
					<%=PropFireplaces %>
				</td>
			</tr>
<tr>
				<td class = "body"  align = "right">
						Garages:
				</td>
				<td class = "body" >
						<%=PropGarage %>
				</td>
			</tr>
			<tr>
				<td class = "body"  align = "right">
						Roof:
				</td>
				<td class = "body" >
						<%=PropRoof %>
				</td>
			</tr>
	<tr>
<td class = "body"  align = "left" colspan = "2">
<BR><b>Address:</b> <BR>
<% If Len(PropStreet1) > 1 Then %>
<%=PropStreet1 %><br>
<% End If %>
<% If Len(PropStreet2) > 1 Then %>
<%=PropStreet2 %><br>
<% End If %>
<% If Len(PropCity) > 1 Then %>
<%=PropCity %>
<% End If %>
<% If Len(PropState) > 1 Then %>
, <%=PropState %> <%=Propcountry %> <%=PropZip %>
<% End If %>
</td></tr></table>
</td> <td valign = "top">
<% if counter < 1 then%>
<table valign = "top" border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width= "500" >
<tr><td>
<%=click%>
</td></tr></table>
<% else %>
<table border = "0"  valign = "top" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width= "500">
<tr>
<td >
<IMG alt="main image" border=0  name='but1' src="<%=buttonimages(1)%>" align = "center" height = "300">
</td></tr></table>
<% end if%>
</td>
<td valign = "top">
<%
if not rsA.eof And foundimagecount > 1 then
rsA.movefirst
counter = 0
counttotal = rsA.recordcount
counttotal = 8
While counter < counttotal
%>
<table border="0" cellspacing="0" align = "center" valign = "top" >
<tr>
<% for x= 1 to 1
 if counter = counttotal then
exit for
 end if 
counter = counter +1
			if Len(buttonimages(counter)) > 10  then
			%>
			<td valign = "top" align = "center">
			<font 
			onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
			onMouseOut="img<%=counter%>('but1')"  class = "menu">
			<img src="<%=buttonimages(counter)%>" width = "60" alt = "<%=buttontitle(counter)%>" border = "0">
			<% If Len(buttontitle(counter)) > 1 Then %>
					<br>
					<small><%=buttontitle(counter)%></small></font>
			<% End If %>
			</td>

		<%
			end if
		if counter< counttotal then
			'rsA.movenext
		end if
		
				next
		%>
			</tr>
			</table>
		<%
	wend
	end if
%>
</td>
</tr>
</table>		
</td>
</tr>
<tr>
<td colspan = "2" class = "body">
<br><%= PropDescription%><br><br>
<b>Out Buildings:</b><br>
<%=PropOutBuildings%>
<br><br>To learn more please contact:<br>
<% if Len(Logo) > 2 Then %>
<a href = "/Ranches/OurHerd.asp?CustID=<%=CustID%>" class = "body"><img src = "<%=Logo %>" border = "0" ></a><br>
<% End If %>
<b><%=BusinessName%></b><br>
<%=peopleFirstName%> <%=peopleLastName%><br>
<% If Len(PeoplePhone) > 1 Then %>
Phone: 	<%=PeoplePhone%><br>
<% End If %>
<% If Len(PeopleCell) > 1 Then %>
Cell: <%=PeopleCell%><br>
<% End If %>
<% If Len(PeopleFax) > 1 Then %>
Fax: <%=PeopleFax%><br>
<% End If %>
<% If Len(custAddr1) > 1 Then %>
<%=AddressStreet%><br>
<% If Len(AddressApt) > 1 Then %>
<%=AddressApt%><br>
<% End If %>
<%=AddressCity %>,&nbsp;<%=AddressState%>&nbsp;<%=AddressCountry%>&nbsp;<%=Addresszip%><br>
<% End If %>
<br>

<br><br><br>
		</td>
	</tr>
</table>
<!--#Include virtual="/Footer.asp"--> 
</body>
</html>