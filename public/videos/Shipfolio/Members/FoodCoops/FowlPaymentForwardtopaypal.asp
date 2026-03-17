<!DOCTYPE HTML>
<html>
<head>
<%  Pagelayoutid=19
Products = True %>
<!--#Include virtual="/GlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title><%= SEOTitle %> </title>
<META name="description" content="<%= SEODescription %> ">
<link rel="stylesheet" type="text/css" href="/style.css" />
<script src="/js/jquery-1.8.2.min.js"></script>
<script src="/js/zoomsl-3.0.min.js"></script>

<script>
    function validateForm() {
        var x = document.forms["myForm"]["Country"].value;
        if (x == null || x == "") {
            alert("Country must be filled out.");
            return false;
        }
    }
</script>

<% 
dim attrID(1000)
dim Color(1000)
dim totalprice(1000)
dim Quantity(1000)
dim Dimension(1000)
TotalCount = request.form("TotalCount")
ProdID = request.form("ProdID")
ProdName = request.form("ProdName")
DimensionTitle = request.form("DimensionTitle")
PaypalEmail = request.form("PaypalEmail")
%>
</head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&ProdID=' + ProdID);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<% Current = "Products" %>
<!--#Include virtual="Header.asp"-->

<%
'response.write("TotalCount =" & TotalCount & "<br>")
'response.write("ProdID = " & ProdID & "<br>")
'response.write("ProdName = " & ProdName & "<br>")
'response.write("DimensionTitle =" & DimensionTitle & "<br>")
'response.write("PaypalEmail = " & PaypalEmail & "<br>")

rowcount = 1
while cint(rowcount) < cint(TotalCount)
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
shippingcount = 0

Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = 'United States of America'" 
'response.write("Query=" & Query )
rs.Open Query, conn, 3, 3  
If not rs.eof Then
USShippingCost = rs("ShippingCost1")
if len(USShippingCost) > 0 then
shippingcount = shippingcount + 1
end if
end if
'response.write("USShippingCost=" & USShippingCost )
rs.close

Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = 'Mexico'" 
'response.write("Query=" & Query )
rs.Open Query, conn, 3, 3  
If not rs.eof Then
MXShippingCost = rs("ShippingCost1")
if len(USShippingCost) > 0 then
shippingcount = shippingcount + 1
end if
end if
rs.close
'response.write("MXShippingCost=" & MXShippingCost )


Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = 'Canada'" 
'response.write("Query=" & Query )
rs.Open Query, conn, 3, 3  
If not rs.eof Then
CAShippingCost = rs("ShippingCost1")
if len(USShippingCost) > 0 then
shippingcount = shippingcount + 1
end if
end if
rs.close
'response.write("CAShippingCost=" & CAShippingCost )


Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = 'Other'" 
'response.write("Query=" & Query )
rs.Open Query, conn, 3, 3  
If not rs.eof Then
OtherShippingCost = rs("ShippingCost1")
if len(USShippingCost) > 0 then
shippingcount = shippingcount + 1
end if
end if
rs.close
'response.write("OtherShippingCost=" & OtherShippingCost )

rowcount =1
itemcount = 1
'response.redirect("PaymentForwardtopaypalstep2.asp")
%>
<div align= center class = body2>
<h1>Shipping Address</h1>
Please enter your shipping address below and select the Pay Now button:
</div>
<table align = center  cellpadding = 5 cellspacing = 5 width = 440>
<tr>
<td class = body>

</td>
</tr>
<tr>
<td class= body>

<form  method="post" target =_blank action="PaymentForwardtopaypalstep2.asp">
<input type="hidden" name="paypalemail" value="<%=PaypalEmail%>">
<input type="hidden" name="prodid" value="<%=prodid%>">
<input type="hidden" name="TotalCount" value="<%=TotalCount%>">
<% 
foundorder = false
while cint(rowcount) < cint(TotalCount)
if Quantity(rowcount) > 0 then
foundorder = True

if len(Dimension(rowcount)) > 1 then
tempprodname = ProdName & " : " & Dimension(rowcount)
else
tempprodname = ProdName
end if

%>
<input  type = "hidden" name="tempprodname(<%=rowcount%>)" value= "<%=tempprodname%>" >
<input  type = "hidden" name="Color(<%=rowcount%>)" value= "<%=Color(rowcount)%>" >
<input  type = "hidden" name="totalprice(<%=rowcount%>)" value= "<%=totalprice(rowcount)%>" >
<input  type = "hidden" name="Quantity(<%=rowcount%>)" value= "<%=Quantity(rowcount)%>" >


<% 
itemcount = itemcount + 1
end if
rowcount= rowcount +1
Wend




if foundorder = false then
response.redirect("clothingProductDetails.asp?prodid=" & ProdID & "&Noqty=True" )
end if

%>
Email<br>
<input type="text" size =40 name="email" class = "formbox"><br><br>
First Name<br>
<input type="text" size =40 name="first_name" class = "formbox"><br><br>
Last Name<br>
<input type="text" size =40 name="last_name" class = "formbox"><br><br>
Street<br>
<input type="text" size =40 name="address1" class = "formbox"><br>
<input type="text" size =40 name="address2" class = "formbox"><br><br>
City<br>
<input type="text" size =40 name="city" class = "formbox"><br><br>
State<br>
<input type="text" size =40 name="state" class = "formbox"><br><br>
Postal Code<br>
<input type="text" size =40 name="zip" class = "formbox"><br><br>

<b>Country (required)</b><br>


<select size="1" name="Country" class = "formbox" width="250" style="width: 250px">
<% if shippingcount > 1 then %>


<% if len(USShippingCost) > 0 then %>
<option value="United States of America">United States</option>
<% end if %>
<% if len(CAShippingCost) > 0 then %>
<option value="Canada">Canada</option>	
<% end if %>
<% if len(MXShippingCost) > 0 then %>
<option value="Mexico">Mexico</option>	
<% end if %>
<% if len(OtherShippingCost) > 0 then %>
<option value="Other">Other</option>	
<% end if %>

<% else %>
<option value="<%=fullcountryname %>"><%=fullcountryname %></option>
<% end if %>
</select>



<br />
<center>
<input type=submit value = "PAY NOW" class = "regsubmit2"/>
</center>
</form>
 <br /><br /><br /><br />

</td></tr></table>


<% test = True
if shippingcount = 1 then %>
 <SCRIPT LANGUAGE="JavaScript">     document.forms[0].submit();</SCRIPT>
<% end if %>
<% screenwidth = screenwidth - 145 %>
<!--#Include virtual="/Footer.asp"--> 
</body>
</html>

