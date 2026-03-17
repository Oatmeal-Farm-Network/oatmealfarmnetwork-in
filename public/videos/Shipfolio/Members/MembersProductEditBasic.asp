<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalVariables.asp"-->

<% 
sql = "select * from people where peopleId = " & session("PeopleID")
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
prodPurchasemethod = rs("prodPurchasemethod")
PaypalEmail = rs("PaypalEmail")
OtherURL= rs("OtherURL")
peopleEmail = rs("peopleEmail")
Weblink= rs("Weblink")
showtaxes = false
if showtaxes = true then
TaxNexusState= rs("TaxNexusState")
TaxRate= rs("TaxRate")
TaxActive= rs("TaxActive")
end if
If Len(prodPurchasemethod) > 3 Then

else
	prodPurchasemethod ="Contact Me"
End If 

If Len(OtherURL) > 3 Then
else
	OtherURL =Weblink
End If 

If Len(PaypalEmail) > 3 Then
else
	PaypalEmail =custEmail 
End If 
    rs.close

ProdID = request.QueryString("ProdID")
if len(ProdID) < 1 then
ProdID = Request.Form("ProdID")
end if
sql = "select * from sfProducts where sfProducts.ProdID = " & ProdID & ";" 
'response.write("sql=" & sql )
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
ProdPrice  = rs("ProdPrice")
'response.write("ProdPrice=" & ProdPrice )
if len(prodPrice) > 0 then
ProdPrice = clng(ProdPrice)
else
ProdPrice = 0
end if

if ProdPrice > 0 then
session("ProdPriceSet") = True
else
session("ProdPriceSet") = False
end if
SKU = rs("ProdProductID")

ProdForSale  = rs("ProdForSale")
SalePrice = rs("SalePrice")

if  SalePrice = "0.00"  or SalePrice = "0" then
SalePrice  = ""
else

end if
if  ProdPrice = "0.00"  or  ProdPrice  = "0" then
 ProdPrice  = ""
else

end if
prodCustomOrder = rs("prodCustomOrder")
ProdSellStore =request.form("ProdSellStore")

ProdDimensions  = rs("ProdDimensions")
ProdAnimalID = rs("ProdAnimalID")
ProdAnimalID2 = rs("ProdAnimalID2")
ProdAnimalID3 = rs("ProdAnimalID3")

ProdMadeIn= rs("ProdMadeIn")

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

if prodFiberPercent1 = "0" then
prodFiberPercent1 = ""
end if
if prodFiberPercent2 = "0" then
prodFiberPercent2 = ""
end if
if prodFiberPercent3 = "0" then
prodFiberPercent3 = ""
end if
if prodFiberPercent4 = "0" then
prodFiberPercent4 = ""
end if
if prodFiberPercent5 = "0" then
prodFiberPercent5 = ""
end if


ProdQuantityAvailable  = rs("ProdQuantityAvailable")
prodImageLargePath  = rs("prodImageLargePath")
'ProdDescription = rs("ProdDescription")



'response.write("ProdQuantityAvailable=" & ProdQuantityAvailable )
'if len(ProdQuantityAvailable) > 0 then
'else
'ProdQuantityAvailable = 10
'end if
'If ProdQuantityAvailable = 0 Then
	'ProdForSalex = false
'End if


ProdName  = rs("ProdName")

str1 = ProdName
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdName= Replace(str1, "'", "'")
End If

rs.close

if len(ProdMadein) > 1 then
sql = "select name from country where Name = '" & prodMadeIn & "';" 
response.write("sql=" & sql )
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
if not rs.eof then
    ProdMandeInName = rs("name")
    end if
rs.close
end if




%>
 </head>
<body >
<% Current1="Products"
Current2 = "EditProduct" 
Current3 = "Basics" %> 
<!--#Include file="MembersHeader.asp"-->
<!--#Include file="MembersProductJumpLinks2.asp"-->



<div class ="container roundedtopandbottom">

<div class ="container ">
<div>
	<div >
    		<h1>Basics</h1>
    </div>
</div>
    <% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div>
	<div style="background-color: floralwhite; min-height:60px">
        <br /><b>&nbsp;&nbsp;&nbsp;Your Product Basic Facts Changes Have Been Made.</b><br>
	</div>
</div>
<% end if %>

</div>
<div class ="container ">
  <div class="row">
    <div class="col-lg-6 col-md-12">
      <br />
        <form action= "membersProductsGeneralStatsHandleForm.asp?ProdID=<%=ProdID %>" method = "post" name="myform">
<input name="Subject" type = "hidden" value = "<%=Subject%>"/>


        <div class="col body" style="height: 70px">
<% ProdNameFound = Request.querystring("ProdNameFound")
if ProdNameFound = "true" then%>
        <font color = "maroon"><b>Product name already exists. Please enter a new product name.</font>

<% end if%>
<% if len(MissingProdName) > 0 or len(MissingProdName) > 0 or len(MissingProdPrice) > 0 or len(MissingCategory) > 0 then %>
    <font color = "maroon"><b>Missing Information!<ul>
    <%  if len(MissingProdName) > 0 then %>
    <li>Please enter a Product Name.</li>
    <% end if %>
    <%  if len(Missingcategory) > 0 then %>
    <li>Please select a category.</li>
    <% end if %>
    <%  if len(MissingProdPrice) > 0 then %>
    <li>Please enter a price greater than $0.</li>
    <% end if %>
    <%  if len(MissingSubCategory) > 0 then %>
    <li>Please enter at least one category and subcategory.</li>
    <% end if %>
    </ul></font></b><br />

<% end if %>

        <form name="myform" method="post" action= 'membersClassifiedAdPlaceStep2.asp?ProdID=<%=ProdID %>' >
        Product Name<br>
        <input name="ProdName" value="<%=ProdName %>" size = "40" style="width: 400px; max-height:28px; text-align: left" required><br>
       </div>
         <div class="col body" style="height: 100px">
        Price <font color="#abacab">(Optional)</font><br>
             <input name="ProdPrice" type="number"  min="0" step="0.01" data-number-to-fixed="2" data-number-stepfactor="100" value="<%=ProdPrice%>" class="currency formbox" id="c1" style="width: 200px; max-height:28px; text-align: left"/><br>
            <i><font color = "#404040"><small>Must be a number, and greater than $0.</small></font></i>
        </div>
        <div class="col body" style="height: 100px">
        Sale Price <font color="#abacab">(Optional)</font><br>
           <input name="SalePrice" type="number"  min="0" step="0.01" data-number-to-fixed="2" data-number-stepfactor="100" value="<%=SalePrice%>" class="currency formbox" id="c1" style="width: 200px; max-height:28px; text-align: left" id="c1" /><br>
            <i><font color = "#404040"><small>Must be a number, and greater than $0.</small></font></i>
        </div>
        <div class="col body" style="height: 100px">
             Custom Order? <font color="#abacab">(Optional)</font><br />
            <% if prodCustomOrder = 1  Then %>
              Yes<input TYPE="RADIO" name="prodCustomOrder" Value = True checked>
              No<input TYPE="RADIO" name="prodCustomOrder" Value = False >
            <% Else %>
             Yes<input TYPE="RADIO" name="prodCustomOrder" Value = True >
             No<input TYPE="RADIO" name="prodCustomOrder" Value = False checked>
             <% End if%>
            <br /><i><font color = "#404040"><small>Customers cannot place custom orders online, they must contact you to place their order. </small></font></i><br>
        </div>
        <div class="col body" style="height: 70px">
        # Available <font color="#abacab">(Optional)</font><br />
        <% if rs.state = 1 then
            rs.close
           end if
            
            if len(ProdQuantityAvailable) < 1 then
            ProdQuantityAvailable = ""
          else
            if ProdQuantityAvailable = 0 then
                ProdQuantityAvailable = ""
            end if
         end if%>
         <input name="ProdQuantityAvailable" type = number value="<%=ProdQuantityAvailable%>" size = "20" class = "formbox" id="c1" style="width: 200px; text-align: left"> 
        </div>
        <div class="col body" style="height: 70px">
            Made In <font color="#abacab">(Optional)</font><br>
            <select size="1" name="ProdMadeIn" class = formbox>
                <% if len(ProdMadeIn) > 0 then %>
                    <option value="<%=ProdMadeIn %>" selected><%=ProdMandeInName%></option>
                <% else %>
                    <option value="" selected></option>
                <% end if %>
            <%  sql = "select * from country order by name asc "
			'response.write(sql2)
        	Set rs = Server.CreateObject("ADODB.Recordset")
            rs.Open sql, conn, 3, 3 
              while not rs.eof %>
               <option value="<%=rs("iso_code") %>"><%=rs("name") %></option>
          <% rs.movenext 
         wend%>
          </select>
        </div>
    </div>
    <div class="col-lg-6 col-md-12">
        <br />
       <iframe src="membersAddProductCategoriesInclude.asp?prodCategory1ID=<%=prodCategory1ID %>&prodCategory2ID=<%=prodCategory2ID %>&prodCategory3ID=<%=prodCategory3ID %>&prodSubCategory1ID=<%=prodSubCategory1ID %>&prodSubCategory2ID=<%=prodSubCategory2ID %>&prodSubCategory3ID=<%=prodSubCategory3ID %>&twocatagories=True" height = '270' width = '400' frameborder= '0' border = '0' leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" seamless = Yes scrolling = no style="background-color: white"></iframe><br><br />
        <br />
    </div>
  </div>
<br>
<input type=submit value = "Submit" class = "submitbutton"  <%=Disablebutton %> >
<br><br>


</form>
<br>
</div>


<% 
showtaxes=False
if showtaxes = true then %>
<div>
    <div align = "left" >
        <h1>Taxes</h1>
    </div>
</div>
<div>
   <div >
     <iframe src="membersProductTaxFrame.asp?ProdID=<%=ProdID %>" height = '230' width = '100%' frameborder= '0' valign='abstop' seamless = Yes scrolling = auto></iframe>
    </div>
</div>
<% end if %>
 </div> 
 <br>
<!--#Include file="membersFooter.asp"--> 

</Body>
</HTML>