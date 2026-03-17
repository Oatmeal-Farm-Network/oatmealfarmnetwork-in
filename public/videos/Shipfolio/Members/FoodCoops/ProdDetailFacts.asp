<%sql = "SELECT sfProducts.prodID, sfProducts.PeopleID, sfProducts.prodCategoryId, People.* FROM sfProducts, People WHERE sfProducts.PeopleID = People.PeopleID and Prodforsale = true and ProdID = " & prodid & " order by prodPrice DESC " 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  
if rs.eof then
response.Redirect("default.asp")
else
prodPurchasemethod = rs("prodPurchasemethod")
PaypalEmail = rs("PaypalEmail")
prodCategoryId = rs("prodCategoryId")
OtherURL= rs("OtherURL")
str1 = OtherURL
str2 = "http"
If not InStr(str1,str2) > 0 Then
OtherURL = "http://" & OtherURL
End If 
end if
rs.close
sql = "SELECT * FROM sfProducts, ProductsPhotos WHERE sfProducts.prodID=ProductsPhotos.ID and Prodforsale = true and ProdID = " & prodid & " order by prodPrice DESC " 
rs.Open sql, conn, 3, 3  
prodName = rs("ProdName")
prodDescription = rs("proddescription")
Prodweight = rs("ProdWeight")
ProdcustomOrder = rs("ProdCustomOrder")

ProdFiberType1= rs("ProdFiberType1") 
ProdFiberType2= rs("ProdFiberType2") 
ProdFiberType3= rs("ProdFiberType3") 
ProdFiberType4= rs("ProdFiberType4") 
ProdFiberType5= rs("ProdFiberType5") 
ProdFiberType6= rs("ProdFiberType6") 
ProdFiberType7= rs("ProdFiberType7") 
ProdFiberType8= rs("ProdFiberType8") 
ProdFiberType9= rs("ProdFiberType9") 
ProdFiberType10= rs("ProdFiberType10") 
ProdFiberType11= rs("ProdFiberType11") 
ProdFiberType12= rs("ProdFiberType12") 
ProdFiberType13= rs("ProdFiberType13") 
ProdFiberType14= rs("ProdFiberType14") 
ProdFiberType15= rs("ProdFiberType15") 

prodFiberPercent1= rs("prodFiberPercent1") 
prodFiberPercent2= rs("prodFiberPercent2") 
prodFiberPercent3= rs("prodFiberPercent3") 
prodFiberPercent4= rs("prodFiberPercent4") 
prodFiberPercent5= rs("prodFiberPercent5") 
prodFiberPercent6= rs("prodFiberPercent6") 
prodFiberPercent7= rs("prodFiberPercent7") 
prodFiberPercent8= rs("prodFiberPercent8") 
prodFiberPercent9= rs("prodFiberPercent9") 
prodFiberPercent10= rs("prodFiberPercent10") 
prodFiberPercent11= rs("prodFiberPercent11") 
prodFiberPercent12= rs("prodFiberPercent12") 
prodFiberPercent13= rs("prodFiberPercent13") 
prodFiberPercent14= rs("prodFiberPercent14") 
prodFiberPercent15= rs("prodFiberPercent15") 




if ProdCustomOrder = true then
prodPurchasemethod = "Contact Me"
end if
ProdPrice = rs("ProdPrice")

SalePrice = trim(rs("prodSalePrice"))

If Prodweight > 0 Then
Else
Prodweight =0
End if
str1 = prodDescription
str2 = vblf
If InStr(str1,str2) > 0 Then
'prodDescription= Replace(str1, str2 , "</br>")
End If 
str1 = prodDescription
str2 = vbtab
If InStr(str1,str2) > 0 Then
prodDescription= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If 

if len(ProdDescription) > 1 then
For y = 1 to Len(ProdDescription)
    spec = Mid(ProdDescription, y, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
	ProdDescription= Replace(ProdDescription,  spec, " ")
   end if
 Next
end if


If Len(prodPurchasemethod ) > 2 Then
else
prodPurchasemethod = "Contact Me"
End If 
If prodPurchasemethod = "Contact Me" Then 
End If 
If prodPurchasemethod = "OtherURL" Then 
End If %> 
<table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  valign = "top">
<td class= "body" valign = "top" colspan = "3" width = "500">
<%
ProdPrice = rs("ProdPrice")
SalePrice = rs("prodSalePrice")
If prodPurchasemethod = "PayPal" Then 
paypalprodname = rs("ProdName")
str1 = paypalprodname
str2 = chr(34)
If InStr(str1,str2) > 0 Then
paypalprodname= Replace(str1, chr(34) , "")
End If 

Set rs2 = Server.CreateObject("ADODB.Recordset")

sql2 = "SELECT * FROM SFShipping WHERE ShippingToCountry = 'United States of America' and prodID = " & prodID & ""
rs2.Open sql2, conn, 3, 3    
If Not rs2.eof then
ShippingCost1 = rs2("ShippingCost1")
end if
'response.write("ShippingCost1=" & ShippingCost1)
rs2.close

sql2 = "SELECT * FROM SFStandardShipping WHERE PeopleID = " & PeopleID & ""
rs2.Open sql2, conn, 3, 3    
If Not rs2.eof then
if Prodweight > 0 Then
ShippingCost = rs2("valBaseRate") + (Prodweight-1) * rs2("valBaseRate")
Else
ShippingCost =rs2("valdefaultRate")
End If 
End if%>

<form target="_paypal" action="https://www.paypal.com/cgi-bin/webscr" method="post" onsubmit="javascript:return ValidForm(this)">
<input type="hidden" name="add" value="1"/>
<input type="hidden" name="cmd" value="_cart"/>
<input type="hidden" name="business" value="<%=PaypalEmail%>"/>
<input type="hidden" name="item_name" value="LOA: <%=paypalprodname%>"/>
<% if len(trim(SalePrice)) > 2 then %>
<input type="hidden" name="amount" value="<%=SalePrice%>"/>
<% else %>
<input type="hidden" name="amount" value="<%=ProdPrice%>"/>
<% end if  %>
<input type="hidden" name="shipping" value="<%=ShippingCost1%>"/>
<input type="hidden" name="no_note" value="1"/>
<input type="hidden" name="currency_code" value="USD"/>
<input type="hidden" name="lc" value="US"/>
<input type="hidden" name="bn" value="PP-ShopCartBF"/>

<% End If 
 ProdPrice = cLng(ProdPrice)
%>
<font Color = "<%=PageTextColor %>"><br><h3><b><%= prodName%></b></h3>

 
 <% 

 
 
 
  If len(salePrice) > 0 Then %>
  <% If ProdPrice > 0 Then %>
 Full Price: <strike><%=FormatCurrency(ProdPrice)%></strike><br>
 <% end if %>
Sale Price: <b><%=FormatCurrency(SalePrice)%></b><br>
<% else 
if prodprice > 0 then
%>

Price: <%=FormatCurrency(ProdPrice)%><br>
<% end if %>
 <% End If %>
<br><%= prodDescription%><br><br></font>
<% ccounter = 1
ProductCounter = 1 %>
</td>
</tr>
<tr>
<td class = "body">
<% If prodPurchasemethod = "PayPal" Then
If rs("ProdQuantityAvailable") > 1 Then %>
<select size="1" name="quantity">
<option name = "Quantity0" value= "" selected><font color = "grey">quantity</font></option>
<% count = 1
while count < (rs("ProdQuantityAvailable")+1)
%>
<option name = "Quantity1" value="<%=count%>">
<%=count%> 
<% count = count + 1
wend %>
</select><br>
<%Else %>
<select size="1" name="quantity">
<option name = "Quantity0" value= "1" selected><font color = "grey">Quantity:1</font></option>
</select><br>
<% End If %>
<% End If %>
<%
ProdSize1 = rs("ProdSize1")
ProdSize2 = rs("ProdSize2")
ProdSize3 = rs("ProdSize3")
ProdSize4 = rs("ProdSize4")
ProdSize5 = rs("ProdSize5")
ProdSize6 = rs("ProdSize6")
ProdSize7 = rs("ProdSize7")
ProdSize8 = rs("ProdSize8")
ProdSize9 = rs("ProdSize9")
ProdSize10 = rs("ProdSize10")
If Len(ProdSize1) > 1 Or Len(ProdSize2) > 1 Or Len(ProdSize3) > 1 Or Len(ProdSize4) > 1 Or Len(ProdSize5) > 1 Or Len(ProdSize6) > 1 Or Len(ProdSize7) > 1 Or Len(ProdSize8) > 1 Or Len(ProdSize9) > 1 Or Len(ProdSize10) > 1 Then %>
<input type="hidden" name="on0" value="Size">
<select name="os0">
<option name = "Size0" value= "" selected><font color = "grey">Size</font></option>
<% If Len(ProdSize1) > 0 Then %>
<option value="<%=ProdSize1%>"><%=ProdSize1%></option>
<% End If %>
<% If Len(ProdSize2) > 0 Then %>
<option value="<%=ProdSize2%>"><%=ProdSize2%></option>
<% End If %>
<% If Len(ProdSize3) > 0 Then %>
<option value="<%=ProdSize3%>"><%=ProdSize3%></option>
<% End If %>
<% If Len(ProdSize4) > 0 Then %>
<option value="<%=ProdSize4%>"><%=ProdSize4%></option>
<% End If %>
<% If Len(ProdSize5) > 0 Then %>
<option value="<%=ProdSize5%>"><%=ProdSize5%></option>
<% End If %>
<% If Len(ProdSize6) > 0 Then %>
<option value="<%=ProdSize6%>"><%=ProdSize6%></option>
<% End If %>
<% If Len(ProdSize7) > 0 Then %>
<option value="<%=ProdSize7%>"><%=ProdSize7%></option>
<% End If %>
<% If Len(ProdSize8) > 0 Then %>
<option value="<%=ProdSize8%>"><%=ProdSize8%></option>
<% End If %>
<% If Len(ProdSize9) > 0 Then %>
<option value="<%=ProdSize9%>"><%=ProdSize9%></option>
<% End If %>
<% If Len(ProdSize10) > 0 Then %>
<option value="<%=ProdSize10%>"><%=ProdSize10%></option>
<% End If %>
</select><br>
<% 
End If 

Color1 = rs("Color1")
Color2 = rs("Color2")
Color3 = rs("Color3")
Color4 = rs("Color4")
Color5 = rs("Color5")
Color6 = rs("Color6")
Color7 = rs("Color7")
Color8 = rs("Color8")
Color9 = rs("Color9")
Color10 = rs("Color10")

If Len(Color1) > 1 Or Len(Color2) > 1 Or Len(Color3) > 1 Or Len(Color4) > 1 Or Len(Color5) > 1 Or Len(Color6) > 1 Or Len(Color7) > 1 Or Len(Color8) > 1 Or Len(Color9) > 1 Or Len(Color10) > 1 Then %>
<input type="hidden" name="on1" value="Color">

<select name="os1">
<option name = "Size0" value= "" selected><font color = "grey">color</font></option>
<% If Len(Color1) > 0 Then %>
<option value="<%=Color1%>"><%=Color1%></option>
<% End If %>
<% If Len(Color2) > 0 Then %>
<option value="<%=Color2%>"><%=Color2%></option>
<% End If %>
<% If Len(Color3) > 0 Then %>
<option value="<%=Color3%>"><%=Color3%></option>
<% End If %>
<% If Len(Color4) > 0 Then %>
<option value="<%=Color4%>"><%=Color4%></option>
<% End If %>
<% If Len(Color5) > 0 Then %>
<option value="<%=Color5%>"><%=Color5%></option>
<% End If %>
<% If Len(Color6) > 0 Then %>
<option value="<%=Color6%>"><%=Color6%></option>
<% End If %>
<% If Len(Color7) > 0 Then %>
<option value="<%=Color7%>"><%=Color7%></option>
<% End If %>
<% If Len(Color8) > 0 Then %>
<option value="<%=Color8%>"><%=Color8%></option>
<% End If %>
<% If Len(Color9) > 0 Then %>
<option value="<%=Color9%>"><%=Color9%></option>
<% End If %>
<% If Len(Color10) > 0 Then %>
<option value="<%=Color10%>"><%=Color10%></option>
<% End If %>
</select><br>
<% 
End If 
%>
</td>
</tr>
<%
If prodPurchasemethod = "PayPal" Then %>
<tr>
<td align = "center">
<input type="submit" value = "Add to Cart" border="0" class="regsubmit2" />
</form>
<form target="paypal" action="https://www.paypal.com/cgi-bin/webscr" method="post">
<input type="hidden" name="cmd" value="_cart">
<input type="hidden" name="business" value="<%=PaypalEmail%>">
<input type="submit" value = " View Cart " border="0" class="regsubmit2" >
<input type="hidden" name="display" value="1">
</form>
</td>
</tr>
<tr>
<td align = "center">
<table>
<tr>
<td valign = "top" class = "body">
<font Color = "<%=PageTextColor %>"><br><br>This product is presented by:<br>
<% if Len(Logo) > 2 Then %>
<a href = "/ranches/Ranchhome.asp?CurrentPeopleID=<%=CurrentPeopleID%>" class = "body"><img src = "<%=Logo %>" border = "0" width = "170" alt = "<%=Businessname%> Alpaca Products" ></a><br>
<% End If %>
<b><%=BusinessName%></b><br>
<%=Owners%><br>

<% If Len(PeoplePhone) > 1 Then %>
Phone: <%=PeoplePhone%><br>
<% End If %>
<% If Len(PeoplePhone2) > 1 Then %>
Phone: <%=PeoplePhone2%><br>
<% End If %>
<% If Len(PeopleFAX) > 1 Then %>
Fax: <%=PeopleFAX%><br>
<% End If %>
<% If Len(AddressStreet) > 1 Then %>
<%=AddressStreet%><br>
<% If Len(AddressApt) > 1 Then %>
<%=AddressApt%><br>
<% End If %>
<%=AddressCity%>,&nbsp;<%=addressState%>&nbsp;<%=AddressCountry%>&nbsp;<%=AddressZip%><br>
<% End If %>
<a href="RanchContactUs.asp" class = "body">Contact us <%=BusinessName%></a>
<br>
<% If Len(Weblink) > 1 Then %>
Find out more about <%=BusinessName%> by going to their <a href = "http://<%=Weblink%>" class = "body" target = "blank" ><b>Website</b></a>.<br>
<% End If %>

</font>
</td>
</tr>
</table>
</td>
</tr>
<% End If %>

<% If prodPurchasemethod = "Contact Me" Then %>
<tr>
<td align = "center">
<table>
<tr>
<td valign = "top" class = "body" align = "left"><font Color = "<%=PageTextColor %>">
<br><br>To purchase this product please contact:<br>
<% if Len(Logo) > 2 Then %>
<a href = "/ranches/Ranchhome.asp?CurrentPeopleID=<%=CurrentPeopleID%>" class = "body"><img src = "<%=Logo %>" border = "0" width = "170" alt = "<%=businessname %> Products"></a><br>
<% End If %>
<b><%=BusinessName%></b><br>
<%=Owners%><br>

<% If Len(PeoplePhone) > 1 Then %>
Phone: <%=PeoplePhone%><br>
<% End If %>
<% If Len(PeoplePhone2) > 1 Then %>
Phone: <%=PeoplePhone2%><br>
<% End If %>
<% If Len(PeopleFAX) > 1 Then %>
Fax: <%=PeopleFAX%><br>
<% End If %>
<% If Len(AddressStreet) > 1 Then %>
<%=AddressStreet%><br>
<% If Len(AddressApt) > 1 Then %>
<%=AddressApt%><br>
<% End If %>
<%=AddressCity%>,&nbsp;<%=AddressState%>&nbsp;<%=addressCountry%>&nbsp;<%=addressZip%>
<% End If %>
<br /><br />
<b>Contact Form</b><br />
<a href="RanchContactUs.asp?CurrentpeopleID=<%=CurrentpeopleID %>" class = "body">Contact <%=BusinessName%></a>

<form  name=form method="post" action="RanchProductContactUsSendEmail.asp">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "450">
<tr> 
<td colspan="4" align="center" width="450" class = "body"> 
  	( &quot;*&quot; indicates required field)</i>
<INPUT TYPE="hidden" NAME="AnimalName"  Value = "<%=Name%>" size="45">
	<INPUT TYPE="hidden" NAME="CurrentPeopleID"  Value = "<%=CurrentPeopleID%>" size="45">
</td>
</tr>

<tr> 
	<td width="200" height="20" class = "body2" align = "right">Product:</td>
	<td  height="20" class = "body2" align = "left"> 
<%=prodName %> 	<INPUT TYPE="Hidden" NAME="Product" value = "<%=prodName %> ">
 </td>
</tr>

<tr> 
	<td width="200" height="20" class = "body2" align = "right">First Name:*</td>
	<td  height="20" class = "body2" align = "left"> 
<input name="FirstName" size = "40">
 </td>
</tr>
<tr> 
	<td  height="20" class = "body2" align = "right">Last Name:*</td>
	<td  height="20" class = "body2" align = "left"> 
 <input name="LastName" size = "40">
 </td>
	</td>
</tr>
         	<tr> 
	<td  height="20" class = "body2" align = "right"> City: </td>
	<td  height="20" class = "body2" align = "left"> 
  	<INPUT TYPE="text" NAME="Fieldname6" size="45">
	</td>
            	</tr>
            	<tr> 
	<td  height="20" class = "body2" align = "right"> State:  </td>
	<td  height="20" class = "body2" align = "left">
  	<INPUT TYPE="TEXT" NAME="Fieldname5" size="5">

	 &nbsp; &nbsp;Postal Code:  &nbsp;
 <INPUT TYPE="TEXT" NAME="Fieldname4" size="5">
	</td>
            	</tr>

            	<tr> 
	<td height="20" class = "body2" align = "right">Email*: </td>
	<td  height="20" class = "body" align = "left"> 
  	<INPUT TYPE="TEXT" NAME="Fieldname2" size="45">
  	 </td>
	</td>
            	</tr>
<tr> 
	<td height="20" class = "body2" align = "right">Phone#: </td>
	<td  height="20" class = "body" align = "left"> 
  	<INPUT TYPE="TEXT" NAME="Fieldname0" size="45">
  	 </td>
	</td>
            	</tr>
            	<tr> 
	<td  height="1"  class = "body2" align = "right" valign = "top">Comments:</td>
	<td class = "body" valign = "top" align = "left">
	  <TEXTAREA NAME="Fieldname1" cols="40" rows="13" wrap="file"></textarea>
  	
	</td>
            	</tr>
  <% 
' begin random function
randomize

' random numbers is the varible that will contain a numeriv value
' between one and nine
random_number=int(rnd*10)
Select Case random_number
Case 0
 MIMage = "/images/X987045.jpg"
Case 1 
 MIMage = "/images/X583198.jpg"
 Case 2 
 MIMage = "/images/X949256.jpg"
 Case 3 
 MIMage = "/images/X096367.jpg"
 Case 4 
 MIMage = "/images/X583198.jpg"
 Case 5 
 MIMage = "/images/X912578.jpg"
Case 6 
 MIMage = "/images/X234697.jpg"
Case 7 
 MIMage = "/images/X781736.jpg"
Case 8 
 MIMage = "/images/X987834.jpg"
Case 9 
 MIMage = "/images/X983999.jpg"
End Select

' write the random number out to the browser

%>
<tr><td class = "body" colspan = "2">
            	  <b>Math Question</b>
            	  Please answer the simple question below so we know that you are a human being.</td>
            	</tr> 
<tr> 
	<td height="20" class = "body" align = "right"><img src = "<%=MIMage %>"></td>
	<td  height="20" class = "body"> 
	<INPUT TYPE="hidden" NAME="Question" Value="<%=MIMage %>">
	 <INPUT TYPE="TEXT" NAME="fieldX" size="3">*
	     
    </td>
            	</tr>
            	<tr> 
	<td align=center colspan="4" width="550" class = "body2">    
  	<input type="submit" value="Submit" class = "regsubmit2">
  	<input type="reset" value="Reset" class = "regsubmit2">            
  	<INPUT TYPE="TEXT" NAME="Shoesize" size="1" class = "shoes">
	</td>
           	</tr>
	</table>
</form><br />
<br>

<% If Len(Weblink) > 1 Then %>
Find out more about <%=BusinessName%> by going to their  <a href = "http://<%=Weblink%>" class = "body" target = "blank" rel="nofollow" ><b>Website</b></a>.<br>
<% End If %>

</font>
</td>
</tr>
</table>
</td>
</tr>
<% End If %>

<%
'response.write(prodPurchasemethod)
If prodPurchasemethod = "Send Users to Another Website" Then %>
<tr>
<td align = "center">
<table>
<tr>
<td valign = "top" class = "body" align = "left"><font Color = "<%=PageTextColor %>">
<br><br>To purchase this product<br> please go to: <br><a href = "<%=OtherURL%>" class = "body" target = "blank" rel="nofollow"><b><%=OtherURL%></b></a><br>
<% if Len(Logo) > 2 Then %>
<a href = "/ranches/ranchhome.asp?CurrentPeopleID=<%=CurrentPeopleID%>" class = "body" ><img src = "<%=Logo %>" border = "0" width = "170" alt = "<%=businessname %> logo"></a><br>
<% End If %>
<b><%=BusinessName%></b><br>
<%=Owners%><br>

<% If Len(PeoplePhone) > 1 Then %>
Phone: <%=PeoplePhone%><br>
<% End If %>
<% If Len(PeoplePhone2) > 1 Then %>
Phone: <%=PeoplePhone2%><br>
<% End If %>
<% If Len(PeopleFAX) > 1 Then %>
Fax: <%=PeopleFAX%><br>
<% End If %>
<% If Len(AddressStreet) > 1 Then %>
<%=AddressStreet%><br>
<% If Len(AddressApt) > 1 Then %>
<%=AddressApt%><br>
<% End If %>
<%=AddressCity%>,&nbsp;<%=PeopleState%>&nbsp;<%=custCountry%>&nbsp;<%=custZip%><br>
<% End If %>
<br>

<% If Len(Weblink) > 1 Then %>
Find out more about <%=BusinessName%> by going to their  <a href = "http://<%=Weblink%>" class = "body" target = "blank" rel="nofollow" ><b>Website</b></a>.<br>
<% End If %>
</font>

</td>
</tr>
</table>
</td>
</tr>
<% End If %>


</table>
</td>
</tr>
</table>