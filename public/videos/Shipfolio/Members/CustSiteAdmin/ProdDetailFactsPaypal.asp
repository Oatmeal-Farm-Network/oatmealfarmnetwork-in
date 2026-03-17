
<% 
ProdID=request.form("ProdID") 
If ProdID  >0 then
Else
ProdID= Request.QueryString("ProdID") 
End if

Session("PhotoPageCount") = 0

'*******************Get Customer Location *********************
PeopleID = Session("PeopleID")
Dim CurrentCategoryID
Dim CurrentCategoryName
Dim SubCurrentCategoryID
Dim SubCurrentCategoryName
dim ColorsArray(900)
dim DimensionsArray(900)
dim AttrpriceChangeArray(900)
dim AttrQuantityAvailableArray(900)

if rs2.state = 0 then
else
rs2.close
end if

sql2 = "select DimensionTitle from SFAttributeTitles where ProdID=" & ProdID
rs2.Open sql2, connloa, 3, 3 
if not rs2.eof then
DimensionTitle = rs2("DimensionTitle")
end if
rs2.close

sql2 = "select PrimaryAttribute from sfAttributePrimary where ProdID=" & ProdID
rs2.Open sql2, connloa, 3, 3 
if not rs2.eof then
PrimaryAttribute = rs2("PrimaryAttribute")
end if
rs2.close

if len(PrimaryAttribute) > 0 then
else
PrimaryAttribute = "Color"
end if

sql2 = "select distinct Color from sfAttributes where len(lower(Color))> 0 and len(" & PrimaryAttribute & ")> 0 and ProdID=" & ProdID & " Order by Color"
'response.write("sql2=" & sql2)
i = 0
rs2.Open sql2, connloa, 3, 3 
while not rs2.eof 
i =i + 1
ColorsArray(i) = rs2("Color")
rs2.movenext
wend
TotalColors= i
rs2.close
'response.write("TotalColors=" & TotalColors )

sql2 = "select distinct Dimension from sfAttributes where len(lower(Dimension))> 0 and len(" & PrimaryAttribute & ")> 0 and ProdID=" & ProdID & " Order by Dimension"
i = 0
rs2.Open sql2, connloa, 3, 3 
while not rs2.eof 
i =i + 1

DimensionsArray(i) = rs2("Dimension")

rs2.movenext
wend
TotalDimensions= i
'response.write("TotalDimensions=" & TotalDimensions )
rs2.close


Totalattributes = i
'response.write("Totalattributes=" & Totalattributes )
i = 0


sql = "select * from productCategoriesList, sfCategories where productCategoriesList.prodCategoryID =  sfCategories.catID and prodcategoryID > 0 and ProductID = " & ProdID & ";" 
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, connloa, 3, 3 

if not rs.eof then
	Category1= rs("CatName")
	'response.Write("Category1=" & Category1)
	Category1ID = rs("catID")
	ProductCategoriesListID1= rs("ProductCategoriesListID")
end if
if not rs.eof then
	rs.movenext
end if
if not rs.eof then
	Category2= rs("CatName")
	'response.Write("Category2=" & Category2)
	Category2ID = rs("catID")
	ProductCategoriesListID2= rs("ProductCategoriesListID")
end if
if not rs.eof then
	rs.movenext
end if
if not rs.eof then
	Category3= rs("CatName")
	Category3ID = rs("catID")
	'response.Write("Category3=" & Category3)
	ProductCategoriesListID3= rs("ProductCategoriesListID")
end if
rs.close

sql = "select * from sfProducts where sfProducts.ProdID = " & ProdID & ";" 
'response.write("<br>sql=" & sql)

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, connloa, 3, 3 
ProdPrice  = rs("ProdPrice")

if len(ProdPrice) > 0 then
ProdPrice = cDbl(ProdPrice)
if ProdPrice = 0 then
ProdPrice = ""
end if
end if

prodProductID = rs("prodProductID")
ProductID  = rs("ProductID")
SalePrice  = rs("ProdSalePrice")

ProdDimensions  = rs("ProdDimensions")
ProdCustomOrder = rs("ProdCustomOrder")

ProdMadeIn= rs("ProdMadeIn")
ProdAnimalID = rs("ProdAnimalID")
ProdAnimalID2 = rs("ProdAnimalID2")
ProdAnimalID3 = rs("ProdAnimalID3")
ProdFiberType1= rs("ProdFiberType1") 
ProdFiberType2= rs("ProdFiberType2") 
ProdFiberType3= rs("ProdFiberType3") 
ProdFiberType4= rs("ProdFiberType4") 
ProdFiberType5= rs("ProdFiberType5") 

prodFiberPercent1= rs("prodFiberPercent1") 
prodFiberPercent2= rs("prodFiberPercent2") 
prodFiberPercent3= rs("prodFiberPercent3") 
prodFiberPercent4= rs("prodFiberPercent4") 
prodFiberPercent5= rs("prodFiberPercent5") 
ProdWeight =rs("ProdWeight")
ProdQuantityAvailable  = rs("ProdQuantityAvailable")
prodImageLargePath  = rs("prodImageLargePath")
ProdDescription = rs("ProdDescription")
ProdSellStore =request.form("ProdSellStore")
ProdForSale = rs("ProdForSale")
If ProdQuantityAvailable = 0 Then
 ProdForSale = false
End if

ProdName  = rs("ProdName")

str1 = ProdName
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdName= Replace(str1, "'", "'")
End If

	rs.close

	'response.write("CurrentCategoryName=" & CurrentCategoryName )

NeedQTY=request.QueryString("NeedQTY")
NeedColor=request.QueryString("NeedColor")
NeedSize=request.QueryString("NeedSize")

'Response.Write("NeedSize = " & NeedSize )
%>

<% if screenwidth > 800 then %>
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top" width = "<%=screenwidth - 430 %>" >
<% else %>
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top" width = "<%=screenwidth%>" >
<% end if %>
<tr>
<td  class = "body" ><br><h2><%=ProdName %></h2>





		
<table cellpadding = 0 cellpadding = 0>
<% if len(ProdProductID) > 1 then%>
<tr><td class = body>Product ID</td><td class = body><b><%=ProdProductID%></b></td></tr>
<% end if %>

<% 
'response.write("ProdAnimalID=" & ProdAnimalID)

if len(ProdAnimalID) > 0 then
sql2 = "select Animals.FullName from Animals where ID=" & ProdAnimalID
'acounter = 1
rs2.Open sql2, connloa, 3, 3 
if not rs2.eof then
ProdAnimalname = rs2("FullName")
end if %>
<% if len(trim(ProdAnimalname)) > 1 then %>
<tr><td class = body>Made From </td><td class = body><b><a href = "/details.asp?ID=<%=ProdAnimalID %>&screenwidth=<%=screenwidth %>" target = "_blank"><%=ProdAnimalname%></a></b></td></tr>
<% end if %>

<% end if%>
<% if len(ProdMadeIn) > 0 then %>
<tr><td class = "body2">
Made In
</td>
<td class = "body2">
<b><%=ProdMadeIn%></b>
</td>
</tr>
<% end if %>

<% if len(ProdWeight) > 0 then %>
 <% if prodWeight > 0 then %>
	<tr><td class = "body2">Weight</td>
	<td class = "body2"><b><%=ProdWeight %> lbs </b></td></tr>
<% end if %>
<% end if %>
<%if len(ProdFiberType1) > 0 or len(ProdFiberType2) > 0 or len(ProdFiberType3) > 0 or len(ProdFiberType4) > 0 or len(ProdFiberType5) > 0 then %>
<tr><td class = "body2"></td>
<td class = "body2"><b>
<%if len(ProdFiberType1) > 0 then %>
<%if len(prodFiberPercent1) > 0 then %>
<%if prodFiberPercent1 > 0 then %>
<%=prodFiberPercent1 %>% 
<% end if %>
<% end if %>
<%=ProdFiberType1 %>
<% end if %>
</b>
</td></tr>

<%if len(ProdFiberType2) > 0 then %>
<%if len(prodFiberPercent2) > 0 then %>
<%if prodFiberPercent2 > 0 then %>
<tr><td>&nbsp;</td>
<td class = "body"><b>
<%=prodFiberPercent2 %>% 
<% end if %>
<% end if %>
<%=ProdFiberType2 %></b>
</td></tr>
<% end if %>


<%if len(ProdFiberType3) > 0 then %>
<%if len(prodFiberPercent3) > 0 then %>
<tr><td>&nbsp;</td>
<td class = "body">
<b>
<%if prodFiberPercent3 > 0 then %>
<%=prodFiberPercent3 %>% 
<% end if %>
<% end if %>
<%=ProdFiberType3 %></b>
</td></tr>
<% end if %>


<%if len(ProdFiberType4) > 0 then %>
<%if len(prodFiberPercent4) > 0 then %>
<tr><td>&nbsp;</td>
<td class = "body">
<b>
<%if prodFiberPercent4 > 0 then %>
<%=prodFiberPercent4 %>% 
<% end if %>
<% end if %>
<%=ProdFiberType4 %></b>
</td></tr>
<% end if %>

<%if len(ProdFiberType5) > 0 then %>
<%if len(prodFiberPercent5) > 0 then %>
<tr><td>&nbsp;</td>
<td class = "body">
<b>
<%if prodFiberPercent5 > 0 then %>
<%=prodFiberPercent5 %>% 
<% end if %>
<% end if %>
<%=ProdFiberType5 %></b>
</td></tr>
<% end if %>
<% end if %>
</table>
<br /><%=ProdDescription%>
</td></tr></table>


<% Contactbuyer = False
'**********************************************************************
' Contact Buyer
'**********************************************************************
if prodPurchasemethod = "Contact Me" or ProdCustomOrder = True or len(trim(ProdPrice)) < 1 or shippingcount = 0 then 
Contactbuyer = True
%>

<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=5 width = "100%" align = "left">
 
<% 
sql = "select * from SFAttributePrimary where ProdId = " & ProdId 
rs.Open sql, connloa, 3, 3  
if rs.eof then
PrimaryAttribute= "Color"
else 
PrimaryAttribute= rs("PrimaryAttribute")
end if
rs.close

sql = "select count(*) as Recordcount from sfattributes where ProdId = '" & ProdId & "' and len(" & PrimaryAttribute & ") > 0  "
rs.Open sql, connloa, 3, 3  
Recordcount = cint(rs("RecordCount"))
rs.close

sql = "select * from sfattributes where ProdId = '" & ProdId & "' and len(" & PrimaryAttribute & ") > 0  order by  " & PrimaryAttribute & " DESC"
rs.Open sql, connloa, 3, 3   
rowcount = 1
order = "even"
rowcount = 1 %>

 <tr bgcolor = "wheat">
		
        <td class = "body"><div align = "center"><b>Color</b>
        <% if PrimaryAttribute = "Color" then %>
        <% end if %>
        </div></td>
		<td class = "body"><div align = "center">
        <% if len(DimensionTitle) > 1 then %>
<b><%=DimensionTitle%></b><br />
       <% else %>
       <b>Dimension</b>
        <% end if %>
        </div></td>
		<td class = "body"><div align = "center"><b>Price</b></div></td>

		<td class = "body"><div align = "center"><b>Quantity</b></div></td>

	</tr>
<% While rowcount < Recordcount + 1
Dimension =rs("Dimension")

Color = rs("Color")
AttrpriceChange = rs("AttrpriceChange")
attrID = rs("attrID")
AttrQuantityAvailable = rs("AttrQuantityAvailable")
 if screenwidth > 600 then
fieldwidth  = 28
fieldwidth2  = 14
end if
if screenwidth > 800 then
fieldwidth  = 38
fieldwidth2  = 29
end if

if order = "even" then
order = "odd"
else 
order = "even"%>
<tr bgcolor = "wheat">
<% end if %>
<td align = "center" class = body>
<input  type = "hidden" name="Color(<%=rowcount%>)" value= "<%=Color%>" >
<%=Color%>
</td>
<td  align = "center" class = "body">
<input  type = "hidden" name="Dimension(<%=rowcount%>)" value= "<%=Dimension%>" >

<%=Dimension%>
</td>
<td align = "center" class = "body">
<% if len(saleprice) > 1 then %>


<% if len(AttrpriceChange) > 0 then
totalprice = cDbl(ProdPrice) + cDbl(AttrpriceChange) 
else
totalprice = ProdPrice
end if 

if len(AttrpriceChange) > 0 then
totalSaleprice = cDbl(SalePrice) + cDbl(AttrpriceChange) 
else
totalSaleprice = SalePrice
end if 

Finaltotalprice = totalSaleprice
%>
Full Price: <%=formatcurrency(cDbl(totalprice),2)%><br />
<b>Sale Price: <%=formatcurrency(cDbl(totalSaleprice),2)%></b><br />


<% else %>
<% if len(AttrpriceChange) > 0 then
totalprice = ProdPrice + AttrpriceChange 
else
totalprice = ProdPrice
end if 

Finaltotalprice = totalprice
%>
<%=formatcurrency(cDbl(totalprice),2)%>

<% end if %>

</td>

<td  align = "center" class = body>
<% if AttrQuantityAvailable > 0 then %>
<%=AttrQuantityAvailable %>
<% else %>
Contact Buyer
<% end if %>
</td>


</tr>
	<%
		rowcount = rowcount + 1
	   If Not rs.eof Then
			rs.movenext
		End if
	Wend
TotalCount=rowcount 
'response.write("totalcount=" & TotalCount)
	rs.close
%>
</table>







<table><tr><td class = "body">
To purchase this product please contact us<br>
<blockquote>
<% if len(Businessname) > 0 then %>
<B><%=Businessname %></B><br />
<% end if %>
<% if len(Owners) > 0 then %>
<%=Owners %><br />
<% end if %>
<% if len(Phone) > 0 then %>
<%=Phone %><br />
<% end if %>
<% if len(AddressStreet) > 0 then %>
<%=AddressStreet %><br />
<% end if %>
<% if len(AddressCity) > 0 then %>
<%=AddressCity%>,&nbsp; 
<% end if %>
<% if len(AddressState ) > 0 then %>
<%=AddressState %>
<% end if %>
<% if len(AddressZip) > 0 then %>
&nbsp;<%=AddressZip%>
<% end if %>
<% if len(AddressCity) > 0 or len(AddressState) > 0 or len(AddressZip) > 0 then %>
<br />
<% end if %>
<a href = "/ContactUs.asp" class = "body">Contact Us</a>
</blockquote>

</td></tr></table>
<% end if%>

<%
'**********************************************************************
' Default Purchase
'**********************************************************************
If Totalattributes = 0 and Contactbuyer = False then 


Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = 'United States of America'" 
'response.write("Query=" & Query )
rs.Open Query, connloa, 3, 3  
If not rs.eof Then
USShippingCost = rs("ShippingCost1")
end if
'response.write("USShippingCost=" & USShippingCost )
rs.close

Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = 'Mexico'" 
'response.write("Query=" & Query )
rs.Open Query, connloa, 3, 3  
If not rs.eof Then
MXShippingCost = rs("ShippingCost1")
end if
rs.close
'response.write("MXShippingCost=" & MXShippingCost )


Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = 'Canada'" 
'response.write("Query=" & Query )
rs.Open Query, connloa, 3, 3  
If not rs.eof Then
CAShippingCost = rs("ShippingCost1")
end if
rs.close
'response.write("CAShippingCost=" & CAShippingCost )


Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = 'Other'" 
'response.write("Query=" & Query )
rs.Open Query, connloa, 3, 3  
If not rs.eof Then
OtherShippingCost = rs("ShippingCost1")
end if
rs.close
'response.write("OtherShippingCost=" & OtherShippingCost )



%>
<br /><br />



<form action="https://www.paypal.com/cgi-bin/webscr" method="post">
<input type="hidden" name="cmd" value="_xclick">
<input type="hidden" name="business" value="<%=PaypalEmail%>">
<input type="hidden" name="currency_code" value="USD">
<input type="hidden" name="return" value="">
<input type="hidden" name="upload" value="1">
<input type="hidden" name="currency_code" value="USD">

<table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top" >
<tr><td class=body>
<% if len(saleprice) > 0 then %>
<% if len(ProdPrice) > 0 then %>
Full Price<strike><%=formatcurrency(ProdPrice,2) %></strike>	<br />
<% end if %>
<font color = "hotpink"><b>Discount Price <%=formatcurrency(saleprice,2) %></b></font><br />
<% else %>
<% if len(ProdPrice) > 0 then %>
<%=formatcurrency(ProdPrice,2) %>
<% else %>
<b>Call For Price</b>
<% end if %><br />
<% end if %>
</td></tr>

<% if len(ProdPrice) > 0 then %>
<tr><td class = 'body'>
<% if NeedQTY = "True" then %>
<b>Quantity</b>
<font color="white" size = "0">&nbsp;<b>! Please select a Quantity</B></font>
<% else %>
<font color="#606060">Quantity</font><br>
<% end if %>


</td></tr>
<tr><td>


<% if len(ProdQuantityAvailable) > 0  then
if ProdQuantityAvailable > 0 then
else
ProdQuantityAvailable = 7
end if
else
ProdQuantityAvailable = 7
end if %>
<select size="1" name="quantity" width="150" style="width: 150px">
<option name = "AID0" value= "1" selected><font color="#bababa">1</font></option>
<% count = 1
while count < ProdQuantityAvailable
count = count + 1 %>
<option value="<%=count %>"><font face = "verdana" size = "1"><%=count %></font>
</option>
<% 	
wend %>
</select>

<% if len(ProdPrice) > 0 then
ProdPrice =formatcurrency(ProdPrice,2) 
end if %>

<input type="hidden" name="item_name" value="<%=prodname %>">
<input type="hidden" name="shipping" value = <%=USShippingCost %>>
<input type="hidden" name="shipping2" value = <%=USShippingCost %>>
<input type="hidden" name="amount" value="<%=ProdPrice %>">

</td></tr>
<% end if %>

<tr><td>
<% if len(ProdPrice) > 0 then %>
<div align = "center"><input type=submit value = "Buy Now"  class = "Regsubmit2" style="color:white" ></div>
<% end if %>
</form>
<br />
</td></tr></table>
<% end if %>


<%
'**********************************************************************
' Purchase With Attributes
'**********************************************************************
If Totalattributes > 0 and Contactbuyer = False then %>
<table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top" >
<tr><td class = "body">
<% Noqty = request.querystring("Noqty")
if Noqty = "True" then %>
<Font color = maroon"><b>Please select a quantity.</b></Font>
<% end if %>


<form action="PaymentForwardtopaypal.asp" method="post" >

<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=5 width = "100%" align = "left">
  <tr bgcolor = "wheat">
		
        <td class = "body"><div align = "center"><b>Color</b>
        <% if PrimaryAttribute = "Color" then %>
        <% end if %>
        </div></td>
		<td class = "body"><div align = "center">
        <% if len(DimensionTitle) > 1 then %>
<b><%=DimensionTitle%></b><br />
       <% else %>
       <b>Dimension</b>
        <% end if %>
        </div></td>
		<td class = "body"><div align = "center"><b>Price</b></div></td>
		<td class = "body"><div align = "center"><b>Quantity</b></div></td>
	</tr>
<% 
sql = "select * from SFAttributePrimary where ProdId = " & ProdId 
rs.Open sql, connloa, 3, 3  
if rs.eof then
PrimaryAttribute= "Color"
else 
PrimaryAttribute= rs("PrimaryAttribute")
end if
rs.close

sql = "select count(*) as Recordcount from sfattributes where ProdId = " & ProdId & " and length(" & PrimaryAttribute & ") > 0  order by  " & PrimaryAttribute & " DESC"
rs.Open sql, connloa, 3, 3  
Recordcount = cint(rs("RecordCount"))
rs.close

sql = "select * from sfattributes where ProdId = " & ProdId & " and length(" & PrimaryAttribute & ") > 0  order by  " & PrimaryAttribute & " DESC"
rs.Open sql, connloa, 3, 3   
rowcount = 1
order = "even"
rowcount = 1
While rowcount < Recordcount + 1
Dimension =rs("Dimension")

Color = rs("Color")
AttrpriceChange = rs("AttrpriceChange")
attrID = rs("attrID")
AttrQuantityAvailable = rs("AttrQuantityAvailable")
 if screenwidth > 600 then
fieldwidth  = 28
fieldwidth2  = 14
end if
if screenwidth > 800 then
fieldwidth  = 38
fieldwidth2  = 29
end if

if order = "even" then
order = "odd"
else 
order = "even"%>
<tr bgcolor = "wheat">
<% end if %>
<td align = "center" class = body>
<input  type = "hidden" name="Color(<%=rowcount%>)" value= "<%=Color%>" >
<%=Color%>
</td>
<td  align = "center" class = "body">
<input  type = "hidden" name="Dimension(<%=rowcount%>)" value= "<%=Dimension%>" >

<%=Dimension%>
</td>
<td align = "center" class = "body">
<% if len(saleprice) > 1 then %>


<% if len(AttrpriceChange) > 0 then
totalprice = cint(ProdPrice) + cint(AttrpriceChange) 
else
totalprice = ProdPrice
end if 

if len(AttrpriceChange) > 0 then
totalSaleprice = cint(SalePrice) + cint(AttrpriceChange) 
else
totalSaleprice = SalePrice
end if 

Finaltotalprice = totalSaleprice
%>
Full Price: <%=formatcurrency(clng(totalprice),2)%><br />
<b>Sale Price: <%=formatcurrency(clng(totalSaleprice),2)%></b><br />


<% else %>
<% if len(AttrpriceChange) > 0 then
totalprice = cint(ProdPrice) + cint(AttrpriceChange) 
else
totalprice = ProdPrice
end if 

Finaltotalprice = totalprice
%>
<%=formatcurrency(clng(totalprice),2)%>

<% end if %>




<input type = "hidden" name="totalprice(<%=rowcount%>)" value= "<%= Finaltotalprice%>" >
</td>
<td  align = "center">

<select size="1" name="Quantity(<%=rowcount%>)" width="90" style="width: 90px">
<option name = "AID0" value= "0" selected><font color="#bababa">0</font></option>
<% count = 0
while count < AttrQuantityAvailable
count = count + 1 %>
<option value="<%=count %>"><font face = "verdana" size = "1"><%=count %></font>
</option>
<% 	
wend %>
</select>

</td></tr>
	<%
		rowcount = rowcount + 1
	   If Not rs.eof Then
			rs.movenext
		End if
	Wend
TotalCount=rowcount 
'response.write("totalcount=" & TotalCount)
	rs.close
%>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "right">
<tr>
<td class = "body" align = "right">
<input  type = "hidden" name="DimensionTitle" value= "<%=DimensionTitle%>" >
<input type = "hidden" name="ProdName" value= "<%= ProdName%>" >
<input type = "hidden" name="ProdID" value= "<%= prodID%>" >
<input type = "hidden" name="TotalCount" value= "<%= TotalCount%>" >
<input type = "hidden" name="PaypalEmail" value= "<%= PaypalEmail%>" >
<div align = "center">
<input type="submit" class = "regsubmit2"  <%=Disablebutton %> value="ORDER NOW" style="COLOR: WHITE" ></div>
</td></tr>
</table></form>
</blockquote>
</td></tr></table>
</td></tr></table>
<% end if %>
<br><br>