<% bcounter = 0
pictureside = "left"
While Not rs.eof  
ProdDescription = rs("ProdDescription")
str1 = ProdDescription
str2 = vblfvblf
If InStr(str1,str2) > 0 Then
ProdDescription= Replace(str1, str2 , "</br>")
End If  
str1 = ProdDescription
str2 = vblf
If InStr(str1,str2) > 0 Then
ProdDescription= Replace(str1, str2 , "</br>")
End If  
str1 = ProdDescription
str2 = vbtab
If InStr(str1,str2) > 0 Then
ProdDescription= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  
'prodPurchasemethod = rs("prodPurchasemethod")
'PaypalEmail = rs("PaypalEmail")
'OtherURL= rs("OtherURL")
counter = counter +1	
If pictureside = "left" then
pictureside = "right"
Else
 pictureside = "left" 
 End if %>          
 <table border = "0" width = "<%=screenwidth - 200 %>"    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
<% oldProdID = ProdID
ProdID = rs("ProdID")
' while ProdID=  oldProdID 
' if not rs.eof then
' rs.movenext
' if not rs.eof then
' ProdID = rs("ProdID")
' end if
' end if
'response.write( ProdID)
'wend

%> 
<tr>
 <% For counter = 1 To 3 
 
 ProdPrice= 0
SalePrice = 0
if not rs.eof then
 ProdPrice= rs("ProdPrice")
SalePrice= rs("ProdSalePrice")
 end if
 %>
<td class = "products" width = "200" align = "center" valign = "top">
<%
If Not rs.eof Then 
sqlp = "SELECT * FROM productsphotos WHERE ID= " & ProdID  & " order by ProductImage1"
 'response.write("sqlp=" & sqlp)
Set rsp= Server.CreateObject("ADODB.Recordset")
rsp.Open sqlp, conn, 3, 3  
If Len(rsp("productImage1")) < 3 Then  
Image = "/uploads/imagenotavailable.jpg" 
else
If Len(rsp("productImage1")) < 30 Then 
 Image = "/uploads/" & rsp("productImage1")
Else
Image = rsp("productImage1")
End If 
End If 	

If Len(trim(Image)) > 3 Then 
else 
Image = "/uploads/imagenotavailable.jpg" 
end if

str1 = lcase(Image) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Image  = Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
rsp.close		
				
prodMadeIn = rs("prodMadeIn")
%>
<table border = "0" width = "200" height = "100"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
<tr><td class = "body2" align = "center"><a href = "ProductDetails.asp?prodid=<%=rs("prodid")%>&CurrentPeopleID=<%=CurrentPeopleID%>&screenwidth=<%=screenwidth %>" class = "body">
<IMG alt="main image" border=0  src="<%= Image %>" align = "center" height = "140" class = "Pictures"><br>
<div align = "left" class = "body"><b><%=Trim(rs("ProdName"))%></b><br>
<% If len(ProdPrice) > 0 and len(saleprice) < 1 Then %>
<br> Price: <b><%=FormatCurrency(ProdPrice)%></b><br>
<% End If %>
<% If len(salePrice) > 0 Then %>
<% If salePrice > 0 Then %>
<% If len(ProdPrice) > 0 Then %>
Full Price: <strike><%=FormatCurrency(ProdPrice)%></strike><br>
<% end if %>
Sale Price: <b><%=FormatCurrency(SalePrice)%></b><br>
<% End If %>
<% End If %>
</a>
</td></tr></table>
<br>
<% If UCase(prodMadeIn) = "USA" Or UCase(prodMadeIn) = "US" Or UCase(prodMadeIn) = "America" Then %>
<img src = "/images/Flag.jpg" alt="Alpaca Product Made in the USA" width = "15"><small>Made in the USA</small>
<% End If %>
<br><br><br>
</div>
 </td>
<%
 rs.movenext  
if not rs.eof then
ProdId = rs("ProdID")
end if
End If 
Next %>
 </tr>
 </table>
<% Wend %>