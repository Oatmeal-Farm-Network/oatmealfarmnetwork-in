<% bcounter = 0
pictureside = "left"
 While Not rs.eof  
PropDescription = rs("PropDescription")
str1 = PropDescription
str2 = vblfvblf
If InStr(str1,str2) > 0 Then
PropDescription= Replace(str1, str2 , "</br>")
End If  
str1 = PropDescription
str2 = vblf
If InStr(str1,str2) > 0 Then
PropDescription= Replace(str1, str2 , "</br>")
End If  
str1 = PropDescription
str2 = vbtab
If InStr(str1,str2) > 0 Then
PropDescription= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  
counter = counter +1	
If pictureside = "left" then
pictureside = "right"
Else
pictureside = "left" 
End if
 %>          
<table border = "0" width = "600"    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
 <% oldPropID = PropID
PropID = rs("PropID")
PropPrice = rs("PropPrice")
while PropID=  oldPropID 
rs.movenext
PropID = rs("PropID")
wend
PropStreet1=rs("PropStreet1") 
PropStreet2=rs("PropStreet2") 
PropCity=rs("PropCity") 
PropState=rs("PropState") 
PropZip=rs("PropZip") 	 
%> 
<tr>
<% For counter = 1 To 2%>
<td class = "products" width = "200" align = "center" >
<%
If Not rs.eof Then 
						
If Len(rs("PropImage1")) > 4 Then 
 Image =  rs("PropImage1")
 Else
Image = "/uploads/ImagenotAvailable.jpg"
End If 
%>
<a href = "RanchPropertyDetails.asp?propid=<%=propid %>&CurrentPeopleID=<%=CurrentPeopleID %>" class = "products">
<IMG alt="main image" border=0  src="<%= Image %>" align = "center" height = "177"><br>
<div align = "left"><b><%=Trim(rs("propName"))%></b><br>
<%=FormatCurrency(rs("propPrice"),0)%>
<br>
<% If Len(PropStreet1) > 1 Then %>
<%=PropStreet1 %><br><% End If %>
<% If Len(PropStreet2) > 1 Then %>
<%=PropStreet2 %><br><% End If %>
<% If Len(PropCity) > 1 Then %><%=PropCity %><% End If %>
<% If Len(PropState) > 1 Then %>, <%=PropState %> <%=Propcountry %> <%=PropZip %><% End If %>
</a><br>
<div align = "center"><a href = "RanchPropertyDetails.asp?propid=<%=propid %>&CurrentPeopleID=<%=CurrentPeopleID %>" class = "products">Learn more...</a><br></div>
</td>
<% rs.movenext  
End If 
Next %>
</tr> </table>
<%  Wend %>