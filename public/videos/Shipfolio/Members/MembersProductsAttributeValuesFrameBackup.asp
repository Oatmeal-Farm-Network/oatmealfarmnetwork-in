<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <base target="_self" />
<link rel="stylesheet" type="text/css" href="/style.css">
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include file="membersglobalvariables.asp"-->
<style type="text/css">
.blink_text {
-webkit-animation-name: blinker;
-webkit-animation-duration: 2s;
-webkit-animation-timing-function: linear;
-webkit-animation-iteration-count: 1;

-moz-animation-name: blinker;
-moz-animation-duration: 2s;
-moz-animation-timing-function: linear;
-moz-animation-iteration-count: 1;

 animation-name: blinker;
 animation-duration: 2s;
 animation-timing-function: linear;
 animation-iteration-count: 1;

 color: green;
}

@-moz-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@-webkit-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }
 </style>
<% 
prodPurchasemethod = request.querystring("prodPurchasemethod")
screenwidth = request.QueryString("screenwidth")
ProdId = request.QueryString("ProdId")
PrimaryAttribute= request.QueryString("PrimaryAttribute")
DimensionTitle= request.QueryString("DimensionTitle")
if len(ProdId) < 1 then
ProdId = Request.Form("ProdId")
end if
ProdPrice = request.QueryString("ProdPrice")
%>

<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "100%">
<tr><td  align = "left">
<%
ProdId = request.querystring("ProdId")
Set rs = Server.CreateObject("ADODB.Recordset")

'****************************************************************
' Prices
'****************************************************************  
sql = "select * from sfProducts where sfProducts.ProdID = " & ProdID & ";" 
'response.write("sql=" & sql )
rs.Open sql, conn, 3, 3 
if not rs.eof then
ProdPrice  = clng(rs("ProdPrice"))
if ProdPrice > 0 then
session("ProdPriceSet") = True
else
session("ProdPriceSet") = False
end if
SKU = rs("ProductID")

ProdQuantityAvailable= rs("ProdQuantityAvailable")

ProdForSalex  = rs("ProdForSale")
ProdSalePrice = rs("ProdSalePrice")
if  ProdSalePrice = "0.00"  or ProdSalePrice = "0" then
ProdSalePrice  = ""
else

end if
if  ProdPrice = "0.00"  or  ProdPrice  = "0" then
 ProdPrice  = ""
else

end if
prodCustomOrder = rs("prodCustomOrder")
ProdSellStore =request.form("ProdSellStore")
ProdForSalex = rs("ProdForSale")
end if
rs.close



'****************************************************************
' Primary Attribute
'****************************************************************  
 if rs.state = 0 then
 else
 rs.close
 end if  	
sql = "select * from SFAttributePrimary where ProdId = " & ProdId 

rs.Open sql, conn, 3, 3  
if rs.eof then
primaryset = False
PrimaryAttribute= "Color"
else 
PrimaryAttribute= rs("PrimaryAttribute")
primaryset = True
end if
rs.close


screenwidth = request.querystring("screenwidth")

%>

<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "100%">
<tr>
    <td class = "body" align = "left">

 <blockquote>

<% 
'****************************************************************
' Dimension Title
'****************************************************************  
    	
sql = "select * from SFAttributetitles where ProdId = " & ProdId 
rs.Open sql, conn, 3, 3  
if rs.eof then
DimensionTitleset = False
else 
DimensionTitle= rs("DimensionTitle")
DimensionTitleset = True
end if
rs.close %>

<% sql = "select count(*) as RecordCount  from sfattributes where ProdId = " & ProdId & " order by  " & PrimaryAttribute & " DESC"
rs.Open sql, conn, 3, 3   
Recordcount = cint(rs("RecordCount"))
rs.close

sql = "select Color, AttrpriceChange, attrID, AttrQuantityAvailable, Dimension   from sfattributes where ProdId = " & ProdId & " order by  " & PrimaryAttribute & " DESC"
rs.Open sql, conn, 3, 3   
rowcount = 1


changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Product Attributes Changes Have Been Made.</b></font></div>
<% end if %>

<form action= 'membersProductsAttributesHandleForm.asp?prodPurchasemethod=<%=prodPurchasemethod %>' method = "post">

<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=5 width = "100%">
<tr>
<td class = "body2" align=right width = 170>
<b>Price</b>
</td>
<td class ="body" align = "left" colspan = 3>
<% if len(ProdPrice) > 0 then  %>
	<%=Currencycode%><input type=text class = "formbox" onBlur="checkNumeric(this,0,5000000,',','.','-');"
	name="ProdPrice" size=5 maxlength=18 value="<%=formatnumber(ProdPrice,2) %>">
<% else %>
<%=Currencycode%><input type=text class = "formbox" onBlur="checkNumeric(this,0,5000000,',','.','-');"
	name="ProdPrice" size=5 maxlength=18 value="<%=ProdPrice %>">
<% end if %>
<font color = "#777777">Must be a number, if left blank than the price will be "Call for Price."</font>

<% if len(ProdPrice) < 1 then %>
<div align = "left"><font color = maroon><b>You have not set a price! Attributes will not be viewable unless you set a Price. </b></font></div>
<% end if %>

</td></tr>

<tr><td class = "body2" align=right >
	<b>Sale Price</b>
</td>
<td class ="body" align = "left" colspan = 3>
<% if len(ProdSalePrice) > 0 then  %>
<%=Currencycode%><input type=text class = "formbox" onBlur="checkNumeric(this,-5,5000000,',','.','-');"
	name="ProdSalePrice" size=5 maxlength=18 value="<%=formatnumber(ProdSalePrice,2) %>">
<% else %>
<%=Currencycode%><input type=text class = "formbox" onBlur="checkNumeric(this,0,5000000,',','.','-');"
	name="ProdSalePrice" size=5 maxlength=18 value="<%=ProdSalePrice %>">
<% end if %>
<font color = "#777777">Must be a number.</font>
</td></tr>

<% if prodPurchasemethod = "PayPal" Then %>

<tr><td class = "body2" align=right >
      <b>Custom Order?</b></td>
	<td class = "body" colspan = 3>
<% if  prodCustomOrder = "True" or prodCustomOrder = 1 Then %>
Yes<input TYPE="RADIO" name="prodCustomOrder" Value = True checked>
No<input TYPE="RADIO" name="prodCustomOrder" Value = False >
<% Else %>
Yes<input TYPE="RADIO" name="prodCustomOrder" Value = True >
No<input TYPE="RADIO" name="prodCustomOrder" Value = False checked>
<% End if%>
<font color=#777777>Customer cannot order custom orders online they must contact you to place their order. </small></font>
</td></tr>
<tr>
<td class = "body2" align=right valign = top>
	<b>Default # Available</b>
</td>
<td class = "body" align = "left" colspan = 3>
<% if ProdQuantityAvailable = 0 then
ProdQuantityAvailable = ""
end if%>
	<input name="ProdQuantityAvailable" onBlur="checkNumeric(this,-5,5000,',','.','-');" value="<%=ProdQuantityAvailable%>" size = "5" class = 'formbox'> <font color="#777777">Used if quantities are not defined with attributes.</font>
		</td>
	</tr>

  <tr>
  <td class = "body2" align = right width = 120>
  <b>Dimension Title</b>
</td>
<td class = "body">
 <input name="DimensionTitle" value= "<%=DimensionTitle%>" size = "8" class = "formbox">
</td>
<td class = "body" valign = "top"><font color = "#777777">The dimension attribute can be length, size, weight, etc. Whatever title you give it will be what users will see.</font></td>
  </tr>

  <tr>
  <td class = "body2" align = right >
  <b>Primary Attribute</b>
    </td>
<td class = "body">
 <select size="1" name="PrimaryAttribute" class = "formbox body">
 
 <option name = "AID0" value= "<%=PrimaryAttribute %>" selected><%=PrimaryAttribute %></option>
 <% if PrimaryAttribute= "Color" then %>
 <option name = "AID0" value= "Dimension" >Dimension</option>
 <% end if %>

  <% if PrimaryAttribute= "Dimension" then %>
 <option name = "AID0" value= "Color" >Color</option>

 <% end if %>


</option>
</select></td>
<td class = "body" valign = "top"><font color = "#777777">Your primary Attribute is the attribute that will always be displayed if there inconsistency in your data. For instance if you set color as your primary attribute, but enter an option of length without a color, then that option will not be available to customers.</font></td>
</tr>
</table>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "right">
 <tr bgcolor = "#cccccc">
		
        <td class = "body"><div align = "center"><b>Color</b>
        <% if PrimaryAttribute = "Color" then %>
        <br /><i>Primary Attribute</i>
        <% end if %>
        </div></td>
		<td class = "body"><div align = "center">
        <% if len(DimensionTitle) > 1 then %>
<b><%=DimensionTitle%></b><br />
(Dimension)
 <% if PrimaryAttribute = "Dimension" then %>
         <br /><i>Primary Attribute</i>
        <% end if %>

       <% else %>
       <b>Dimension</b>
        <% end if %>
        </div></td>
		<td class = "body"><div align = "center"><b>Additional Price</b></div></td>
		<td class = "body"><div align = "center"><b>Quantity Available</b></div></td>
	</tr>
<% 
rowcount = 1
While rowcount < Recordcount +1
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
<tr bgcolor = "#eeeeee">
<% end if %>
<td align = "center" >
<input  type = "hidden" name="attrID(<%=rowcount%>)" value= "<%=attrID%>" >
<input name="Color(<%=rowcount%>)" value= "<%=Color%>" size = "18">
</td>
<td  align = "center" >
<input name="Dimension(<%=rowcount%>)" value= "<%=Dimension%>" size = "18">
</td>
<td  align = "center"><%=Currencycode%>
<input name="AttrpriceChange(<%=rowcount%>)" value= "<%=AttrpriceChange%>" size = "3">
</td>
<td  align = "center">
	<input name="AttrQuantityAvailable(<%=rowcount%>)" value= "<%=AttrQuantityAvailable%>" size = "3">
</td>

		</tr>
	<%
		rowcount = rowcount + 1
	   If Not rs.eof Then
			rs.movenext
		End if
	Wend
TotalCount=rowcount 
'response.write(TotalCount)
	rs.close

end if ' Paypal purchase method
  set rs=nothing
  set conn = nothing
%>

</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "right">
<tr>
	<br />	
	<td class = "body" align = "right">
		<input type = "hidden" name="ProdID" value= "<%= prodID%>" >
		<input type = "hidden" name="TotalCount" value= "<%= Recordcount%>" >
         
		<div align = "right">
        <br />
		<input type="submit" class = "regsubmit2"  <%=Disablebutton %> value="SUBMIT PRICING & ATTRIBUTES"  ></div>
	</td>
</tr>
</table></form>

</blockquote>
	</td>
</tr>
</table>
</td>
</tr>
</table>
</body>
</html>