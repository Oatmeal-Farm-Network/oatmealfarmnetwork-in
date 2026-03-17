<!DOCTYPE HTML>
<html>
<head>
<%  Pagelayoutid=19
Products = True %>
<!--#Include virtual="/GlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body >

<% Current = "Products" %>

<%
dim attrID(1000)
dim Color(1000)
dim totalprice(1000)
dim Quantity(1000)
dim Dimension(1000)
dim tempprodname(1000)
TotalCount = request.form("TotalCount")
ProdID = request.form("ProdID")
DimensionTitle = request.form("DimensionTitle")
PaypalEmail = request.form("PaypalEmail")
shippingperitem = request.form("shippingperitem")

email = request.form("email")
first_name = request.form("first_name")
last_name = request.form("last_name")
address1 = request.form("address1")
address2 = request.form("address2")
city = request.form("city")
state = request.form("state")
zip = request.form("zip")
Country = request.form("Country")

rowcount = 1
while cint(rowcount) < cint(TotalCount)

tempprodnamecount = "tempprodname(" & rowcount & ")"
tempprodname(rowcount)=Request.Form(tempprodnamecount)


totalpricecount = "totalprice(" & rowcount & ")"
totalprice(rowcount)=Request.Form(totalpricecount)
Colorcount = "Color(" & rowcount & ")"
Color(rowcount)=Request.Form(Colorcount)
totalpricecount = "totalprice(" & rowcount & ")"
totalprice(rowcount)=Request.Form(totalpricecount)
Quantitycount = "Quantity(" & rowcount & ")"
Quantity(rowcount)=Request.Form(Quantitycount)

Dimensioncount = "Dimension(" & rowcount & ")"
Dimension(rowcount)=Request.Form(Dimensioncount)
rowcount = rowcount +1
Wend
%>

<%
Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = '" & Country & "'" 
'response.write("Query=" & Query )
rs.Open Query, conn, 3, 3  
If not rs.eof Then
ShippingCost = rs("ShippingCost1")
end if
'response.write("USShippingCost=" & USShippingCost )
rs.close


rowcount =1
itemcount = 1
%>

<table align = center width = 640>
<tr>
<td class =body>
This may take a few seconds as your order is processed.
<form method="post" action="https://www.paypal.com/cgi-bin/webscr">

<input type="hidden" name="redirect_cmd" value="_xclick">
<input type="hidden" name="cmd" value="_cart">
<input type="hidden" name="business" value="<%=PaypalEmail%>">
<input type="hidden" name="currency_code" value="USD">
<input type="hidden" name="return" value="">
<input type="hidden" name="upload" value="1">

<input type="hidden" name="email" value="<%=email %>">
<input type="hidden" name="first_name" value="<%=first_name %>">
<input type="hidden" name="last_name" value="<%=last_name %>">
<input type="hidden" name="address1" value="<%=address1 %>">
<input type="hidden" name="address2" value="<%=address2 %>">
<input type="hidden" name="city" value="<%=city %>">
<input type="hidden" name="state" value="<%=state %>">
<input type="hidden" name="zip" value="<%=zip %>">

<% 
foundorder = True
while cint(rowcount) < cint(TotalCount)
if len(Quantity(rowcount)) > 0 then
if Quantity(rowcount) > 0 then

foundorder = True
%>
<input type="hidden" name="item_name_<%=itemcount %>" value="<%=tempprodname(rowcount) %>"><br />
<input type="hidden" name="amount_<%=itemcount %>" value="<%=totalprice(rowcount) %>"><br />
<input type="hidden" name="quantity_<%=itemcount %>" value = <%=Quantity(rowcount) %>><br />
<input type="hidden" name="color_<%=itemcount %>" value = <%=color(rowcount) %>><br />
<%if len(ShippingCost) > 0 then %>
<input type="hidden" name="shipping_<%=itemcount %>" value = <%=clng(ShippingCost) * clng(Quantity(rowcount)) %>><br />
<%
end if
itemcount = itemcount + 1

 end if
end if
rowcount= rowcount +1
Wend

if foundorder = false then
response.redirect("ProductDetails.asp?prodid=" & ProdID & "&Noqty=True" )
end if
%>



<center>
</center>
</form>
</td></tr></table>


<% test = false
if test = false then %>
 <SCRIPT LANGUAGE="JavaScript">     document.forms[0].submit();</SCRIPT>
<% end if %>
<% screenwidth = screenwidth - 145 %>

</body>
</html>

