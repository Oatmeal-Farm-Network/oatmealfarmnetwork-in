<table border = "0" width = "600"    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
<% bcounter = 0
pictureside = "left"
counter = 0
While Not rs.eof  
counter = counter + 1
BFSID = rs("BFSID")

 response.write("BFSIDA =" &  rs("BFSID")  )
BFSPrice = rs("BFSAskingPrice")
BFSName=rs("BFSName" ) 
BFSAskingPrice=rs("BFSAskingPrice" ) 
BFSDescription=rs("BFSDescription") 
BFSForSale=rs("BFSForSale") 
BFSSold=rs("BFSSold") 
BFSStreet1=rs("BFSStreet1") 
BFSStreet2=rs("BFSStreet2") 
BFSCity=rs("BFSCity") 
BFSState=rs("BFSState") 
BFSZip=rs("BFSZip") 
BFSGrossIncome=rs("BFSGrossIncome" ) 
BFSCashFlow=rs("BFSCashFlow" ) 
BFSFFandE=rs("BFSFFandE" ) 
BFSEBITDA=rs("BFSEBITDA" ) 
BFSEstablished=rs("BFSEstablished" ) 
BFSEmployees=rs("BFSEmployees" ) 
BFSWebsite1=rs("BFSWebsite1") 
BFSWebsite2=rs("BFSWebsite2") 
BFSWebsite3=rs("BFSWebsite3") 
BFSInventory=rs("BFSInventory") 
BFSRealEstate=rs("BFSRealEstate") 
propID=rs("propID")

BFSDescription = rs("BFSDescription")
str1 = BFSDescription
str2 = vblfvblf
If InStr(str1,str2) > 0 Then
BFSDescription= Replace(str1, str2 , "</br>")
End If  
str1 = BFSDescription
str2 = vblf
If InStr(str1,str2) > 0 Then
BFSDescription= Replace(str1, str2 , "</br>")
End If  
str1 = BFSDescription
str2 = vbtab
If InStr(str1,str2) > 0 Then
BFSDescription= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  
counter = counter +1	
If pictureside = "left" then
pictureside = "right"
Else
pictureside = "left" 
End if
 %>          
<tr>
<% if counter = 1 then%>
<td class = "products" width = "200" align = "center" >
<%

If Len(rs("BFSImage1")) > 4 Then 
 Image =  rs("BFSImage1")
 Else
Image = "/uploads/ImagenotAvailable.jpg"
End If 
%>
<a href = "businessDetails.asp?BFSid=<%=BFSid %>" class = "products">
<IMG alt="main image" border=0  src="<%= Image %>" align = "center" height = "177"><br>
<div align = "left"><b><%=Trim(rs("BFSName"))%></b><br>
<% if len(rs("BFSAskingPrice")) > 1 then %>
<%=formatCurrency(rs("BFSAskingPrice"),0)%>
<% else %>
<b>Call for Price</b>
<% end if %>
<br>
<% If Len(BFSStreet1) > 1 Then %>
<%=BFSStreet1 %><br><% End If %>
<% If Len(BFSStreet2) > 1 Then %>
<%=BFSStreet2 %><br><% End If %>
<% If Len(BFSCity) > 1 Then %><%=BFSCity %><% End If %>
<% If Len(BFSState) > 1 Then %>, <%=BFSState %> <%=BFScountry %>&nbsp;<%=BFSZip %><% End If %>
</a><br><br></div>
<div align = "center"><a href = "businessDetails.asp?BFSid=<%=BFSid %>" class = "products">Learn more...</a></div>
</td>
<% rs.movenext  

if counter = 2 then
counter = 0 %>
</tr> 
<% end if %></table>
<%  Wend %>