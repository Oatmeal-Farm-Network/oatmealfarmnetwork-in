<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="membersGlobalVariables.asp"-->
<!--#Include virtual="/administration/AdminMobileWidthInclude.asp"-->
</head>
<body>
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


<SCRIPT LANGUAGE="JavaScript">
<!-- Original:  Nannette Thacker -->
<!-- http://www.shiningstar.net -->
<!-- Begin
function checkNumeric(objName,minval, maxval,comma,period,hyphen)
{
	var numberfield = objName;
	if (chkNumeric(objName,minval,maxval,comma,period,hyphen) == false)
	{
		numberfield.select();
		numberfield.focus();
		return false;
	}
	else
	{
		return true;
	}
}

function chkNumeric(objName,minval,maxval,comma,period,hyphen)
{
// only allow 0-9 be entered, plus any values passed
// (can be in any order, and don't have to be comma, period, or hyphen)
// if all numbers allow commas, periods, hyphens or whatever,
// just hard code it here and take out the passed parameters
var checkOK = "0123456789" + comma + period + hyphen;
var checkStr = objName;
var allValid = true;
var decPoints = 0;
var allNum = "";

for (i = 0;  i < checkStr.value.length;  i++)
{
ch = checkStr.value.charAt(i);
for (j = 0;  j < checkOK.length;  j++)
if (ch == checkOK.charAt(j))
break;
if (j == checkOK.length)
{
allValid = false;
break;
}
if (ch != ",")
allNum += ch;
}
if (!allValid)
{	
alertsay = "Please enter only these values \""
alertsay = alertsay + checkOK + "\" in the \"" + checkStr.name + "\" field."
alert(alertsay);
return (false);
}

// set the minimum and maximum
var chkVal = allNum;
var prsVal = parseInt(allNum);
if (chkVal != "" && !(prsVal >= minval && prsVal <= maxval))
{
alertsay = "Please enter a value greater than or "
alertsay = alertsay + "equal to \"" + minval + "\" and less than or "
alertsay = alertsay + "equal to \"" + maxval + "\" in the \"" + checkStr.name + "\" field."
alert(alertsay);
return (false);
}
}
//  End -->
</script>
<% 



Update=request.QueryString("Update")
Delete=request.querystring("Delete")
AddSendToCountry = request.Form("AddSendToCountry")
ShippingCost1= request.Form("ShippingCost1")
ShippingCost2= request.Form("ShippingCost2")
ShipID = request.Form("ShipID")
SpeciesSalesType = request.querystring("SpeciesSalesType")
SpeciesID= request.querystring("SpeciesID")

if SpeciesID = 22 or SpeciesID = 19 or SpeciesID = 15 or SpeciesID = 14 or SpeciesID = 13 then 
SpeciesSalesType = "Fowl"
end if
ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
end if

Category = request.QueryString("Category")
if len(category) < 1 then
category = Request.Form("category")
end if

if len(ShippingCost1) > 0 then
wordlength = Len(ShippingCost1)
For loopi=1 to wordlength
    spec = Mid(ShippingCost1, loopi, 1) 
     specchar = ASC(spec)
    if specchar < 46 or specchar > 57 then
    	ShippingCost1= Replace(ShippingCost1,  spec, " ")
   end if
 Next
end if

if len(ShippingCost2) > 0 then
wordlength = Len(ShippingCost2)
For loopi=1 to wordlength
    spec = Mid(ShippingCost2, loopi, 1) 
     specchar = ASC(spec)
    if specchar < 46 or specchar > 57 then
    	ShippingCost2= Replace(ShippingCost2,  spec, " ")
   end if
 Next
end if

ShippingCost1 = trim(ShippingCost1)

if Delete = "True" then
	Query =  "Delete * From sfShipping where ShipID = " &  ShipID & "" 
connLOA.Execute(Query) 

if len(ProdID)> 0 then
   'response.Redirect("membersShippingFrame.asp?ProdID=" & ProdID & "&Update=True" )
else
   'response.Redirect("membersShippingFrame.asp?ServicesID=" & ServicesID & "&Update=True"  )
end if
end if


if Update = "True" then
if len(ShippingCost1) > 0 then
Query =  " UPDATE sfShipping Set ShippingCost1 = " &  ShippingCost1 & " "
Query =  Query & " where ShipID = " & ShipID & ";" 
connLOA.Execute(Query) 
else
Query =  " UPDATE sfShipping Set ShippingCost1 = Null" 
Query =  Query & " where ShipID = " & ShipID & ";" 
connLOA.Execute(Query) 

end if

if len(ShippingCost2) >0 then
Query =  " UPDATE sfShipping Set ShippingCost2 = " &  ShippingCost2 & " "
Query =  Query & " where ShipID = " & ShipID & ";" 
connLOA.Execute(Query) 
else
Query =  " UPDATE sfShipping Set ShippingCost2 = Null "
Query =  Query & " where ShipID = " & ShipID & ";"
connLOA.Execute(Query) 

end if

if len(ProdID)> 0 then
    'response.Redirect("membersShippingFrame.asp?ProdID=" & ProdID & "&Update=True"  )
else
    'response.Redirect("membersShippingFrame.asp?ServicesID=" & ServicesID & "&Update=True"  )
end if
end if

if len(AddSendToCountry) > 0 then
    Query =  "INSERT INTO sfshipping (AnimalID, ShippingToCountry)"  
    Query =  Query & " Values (" &  ID & ", '" & AddSendToCountry & "' )"

connLOA.Execute(Query) 

end if


sql = "select * from sfShipping where AnimalID=" & ID

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, connLOA, 3, 3 
 if rs.eof then 
 
Query =  "INSERT INTO sfshipping (AnimalID)"  
Query =  Query & " Values (" &  ID & ")"


connLOA.Execute(Query) 

rs.close
end if

if rs.state = 0 then
else
rs.close
end if
sql = "select CoOwnerName1, CoOwnerLink1, CoOwnerBusiness1, CoOwnerName2, CoOwnerLink2, CoOwnerBusiness2, CoOwnerName3, CoOwnerLink3, CoOwnerBusiness3, numberofanimals from Animals where ID=" & ID	
rs.Open sql, connLOA, 3, 3
numberofanimals = rs("numberofanimals")
CoOwnerName1 = rs("CoOwnerName1")
CoOwnerLink1 = rs("CoOwnerLink1")
CoOwnerBusiness1 = rs("CoOwnerBusiness1")
CoOwnerName2 = rs("CoOwnerName2")
CoOwnerLink2 = rs("CoOwnerLink2")
CoOwnerBusiness2 = rs("CoOwnerBusiness2")
CoOwnerName3 = rs("CoOwnerName3")
CoOwnerLink3 = rs("CoOwnerLink3")
CoOwnerBusiness3= rs("CoOwnerBusiness3")
rs.close

sql = "select * from Pricing where ID=" & ID

rs.Open sql, connLOA, 3, 3
If rs.eof then
Query =  "INSERT INTO Pricing (ID)" 
Query =  Query & " Values (" &  ID & ")"

response.write("Query=" & Query )
connLOA.Execute(Query) 
rs.close

sql = "select * from Pricing where ID=" & ID
response.write("sql=" & sql)

rs.Open sql, connLOA, 3, 3

else

Set rs = Server.CreateObject("ADODB.Recordset")
    sql = "select * from Pricing where ID=" & ID
    rs.Open sql, connLOA, 3, 3




End If 


EmbryoPrice  = rs("EmbryoPrice") 
SemenPrice  = rs("SemenPrice") 
Display=rs("Display") 

Foundation=rs("Foundation") 

'response.write("Display=" & Display & "<br>" )
 ' response.write("Foundation=" & Foundation & "<br>" )
Price = rs("Price")
Price2=rs("Price2") 

Price3=rs("Price3") 
Price4=rs("Price4") 
MinOrder1=rs("MinOrder1") 
MinOrder2=rs("MinOrder2") 
MinOrder3=rs("MinOrder3") 
MinOrder4=rs("MinOrder4") 
MaxOrder1=rs("MaxOrder1") 
MaxOrder2=rs("MaxOrder2") 
MaxOrder3=rs("MaxOrder3") 
MaxOrder4=rs("MaxOrder4") 

if Price = "0" then
Price = ""
end if
if Price2 = "0" then
Price2 = ""
end if
if Price3 = "0" then
Price3 = ""
end if
if Price4 = "0" then
Price4 = ""
end if

Free = rs("Free")
OBO = rs("OBO")
Foundation = rs("Foundation")
PayWhatYouCanAnimal = rs("PayWhatYouCanAnimal")
PayWhatYouCanStud = rs("PayWhatYouCanStud")
Discount = rs("Discount")
PriceComments = rs("PriceComments")
ForSale = rs("ForSale")
Sold = rs("Sold")
ShowPrices = rs("ShowPrices")
SalePending = rs("SalePending")
StudFee = rs("StudFee")
if StudFee = "0" then
StudFee = ""
end if
Financeterms = rs("Financeterms")
%>

<% if mobiledevice = True or screenwidth < 600 then %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
 <tr>
    <td class = "roundedtopandbottom" align = "left">
		<H2><div align = "left"> <a name="Pricing"></a>Pricing</div></H2>
<% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Pricing Changes Have Been Made.</b></font></div>
<% end if %>
<form action= 'membersPricingHandleForm.asp?category=<%=category %>' method = "post" name = "pricingform"> 
<input type = "hidden" name="ID" Value = "<%=  ID%>">  
<input type = "hidden" name="SpeciesID" Value = "<%= SpeciesID%>"> 	
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "100%">

		<% If trim(category) = "Experienced Male" Or trim(category) = "Inexperienced Male" Then 
			'response.write("StudFee=" & StudFee )
            
            'If Len(StudFee) < 2 Then
			'	StudFee = ""
			'End If
		%>
		<tr><td class = "body2" align = "right"><b>
      <td class = "body" height = "30" align = "left">
		<a class="tooltip" href="#"><b>Stud Fee:</b><span class="custom info"><em>Stud Fee</em>If you set the stud fee as $0 it will show the stud fee as "Call For Price".</span></a>
        
        </b>&nbsp;</td>
			<td class = "body" align = "left">
					<%=Currencycode %><input type=text onBlur="checkNumeric(this,1,500000,',','.','-');"
					name='StudFee' size=10 maxlength=10 Value= "<%= StudFee%>">
				</td>
		</tr>
        <% showpwyc = false 
        if showpwyc = true then%>
		<tr >
			<td class = "body2"  align = "right"><b>Offer Pay What You Can?:</b>&nbsp;</td>
			<td class = "body" align = "left">
			<% 		
		if PayWhatYouCanStud = "True" Or PayWhatYouCanStud = True Then %>
			Yes<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "True" checked>
			No<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "False" >
		<% Else %>
			Yes<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "True" >
			No<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "False" checked>
		<% End If %>
		</td>
		</tr>
        <% end if %>
	<tr>

	<% Else %>
				<input type=hidden  name='StudFee'  Value= "">
	<% End If %>

    <tr >
		<td  class="body2" align = "right"><b>For Sale?:</b>&nbsp;</td>
			<td class = "body" align = "left">
		<div class="button-holder">
		<% 		
		if ForSale = "True" Or ForSale = 1 Then %>
			Yes<input TYPE="RADIO" name="ForSale" Value = "1" id="radio-2-1"  checked class="regular-radio big-radio"><label for="radio-2-1"></label><img src = "images/px.gif" width = "5" height = "1" />
			No<input TYPE="RADIO" name="ForSale" Value = "0"  id="radio-2-2" class="regular-radio big-radio"><label for="radio-2-2"></label>
		<% Else %>
			Yes<input TYPE="RADIO" name="ForSale" Value = "1" id="radio-2-1"  class="regular-radio big-radio"><label for="radio-2-1"></label><img src = "images/px.gif" width = "5" height = "1" />
			No<input TYPE="RADIO" name="ForSale" Value = "0"  id="radio-2-2" class="regular-radio big-radio" checked><label for="radio-2-2"></label>
		<% End If %></div>

		</td>
</tr>

  <% showOBO = false 
        if showOBO = true then%>
<tr >
	<td class = "body2"  align = "right"><b>OBO?:</b>&nbsp;</td>
		<td class = "body" align = "left">
				<div class="button-holder">	
				
		<% 		
		if OBO = "True" Or OBO = 1 Then %>
			Yes<input TYPE="RADIO" name="OBO" Value = "True" checked  id="radio-3-1"  checked class="regular-radio big-radio"><label for="radio-3-1"></label>
			No<input TYPE="RADIO" name="OBO" Value = "False"  id="radio-3-2"  checked class="regular-radio big-radio" ><label for="radio-3-2">
		<% Else %>
			Yes<input TYPE="RADIO" name="OBO" Value = "True" >
			No<input TYPE="RADIO" name="OBO" Value = "False" checked>
		<% End If %>
		</div>
		</td>
		</tr>
    <% end if %>

<% If SpeciesSalesType = "Fowl" and numberofanimals > 1 then %>


<% else %>

		<tr>
			<td class = "body2" align = "right" ><b>Price:</b>&nbsp;</td>
				<td class = "body" align = "left">
		<%=Currencycode %><input type=text onBlur="checkNumeric(this,1,500000,',','.','-');"
		name='price' size=10 maxlength=10 Value= "<%= Price%>" class = "regsubmit2 body">
		</td>
	</tr>
	<tr>
		<td class = "body2"  align ="right"><b>% Discount:</b>&nbsp;</td>
				<td class = "body" align = "left">
		<select size="1" name="Discount" class = "regsubmit2 body">
					<option value="<%= Discount%>" selected><%= Discount%>%</option>
					<option value="0">No discount</option>
					<option value="10">10%</option>
					<option  value="20">20%</option>
					<option  value="25">25%</option>
					<option  value="30">30%</option>
					<option  value="40">40%</option>
					<option  value="50">50%</option>
					<option  value="60">60%</option>
					<option  value="70">70%</option>
					<option  value="75">75%</option>
					<option  value="80">80%</option>
					<option  value="90">90%</option>
					<option  value="95">95%</option>
					<option  value="99">99%</option>
					<option  value="100">100%</option>
				</select></td>
	</tr>
	<tr>
		<td class = "body2"  align ="right"><b>Discount Price:</b>&nbsp;</td>
			<td class = "body" align = "left">

<% 
if len(Discount) > 1 then
Discount = cint(Discount)
end if

if len(price) > 1 then
price = cint(price)
end if


If discount > 0 And price > 0 then
			DiscountPrice = FormatCurrency(Price  - (Price * Discount/100) )
		Else
		DiscountPrice = "N/A"
		
		End if%>
	<%= (DiscountPrice)%></big>
	
	</td>	
	</tr>
<% showfoundation = True %>
<% if ShowFoundationHerd = True and showfoundation = True then %>
	<tr>
		<td class = "body2"  align ="right"><b>Foundation?</b>&nbsp;</td>
			<td class = "body" align = "left">
		<div class="button-holder">	
		
		<% 
		If Foundation = False then %>
		Yes<input TYPE="RADIO" name="Foundation" Value = "1" id="radio-6-1"   class="regular-radio big-radio"><label for="radio-6-1"></label>
		No<input TYPE="RADIO" name="Foundation" Value = "0" checked id="radio-6-2" class="regular-radio big-radio"><label for="radio-6-2"></label> 
		<% else %>
	Yes<input TYPE="RADIO" name="Foundation" Value = "1" id="radio-6-1"  checked class="regular-radio big-radio"><label for="radio-6-1"></label>
		No<input TYPE="RADIO" name="Foundation" Value = "0" id="radio-6-2" class="regular-radio big-radio"><label for="radio-6-2"></label> 
		<% end if %>
		</div>
		</td>
	</tr>
	<% end if %>
    <% showsalepending = false
    if showsalepending = True then %>
	<tr>
		<td class = "body2"  align ="right"><b>Sale Pending?:</b>&nbsp;</td>
		<td class = "body" align = "left">
		<div class="button-holder">
		<% 
		if SalePending = "True" Or SalePending = 1 Then %>
			Yes<input TYPE="RADIO" name="SalePending" Value = "True" checked id="radio-4-1"  checked class="regular-radio big-radio"><label for="radio-4-1"></label>
			No<input TYPE="RADIO" name="SalePending" Value = "False" id="radio-4-2"   class="regular-radio big-radio"><label for="radio-4-2"></label>
		<% Else %>
						Yes<input TYPE="RADIO" name="SalePending" Value = "True"  id="radio-4-1"  class="regular-radio big-radio"><label for="radio-4-1"></label>
			No<input TYPE="RADIO" name="SalePending" Value = "False" id="radio-4-2"  checked class="regular-radio big-radio"><label for="radio-4-2"></label>
		<% End If %>
		</div>
		</td>
		</tr>
<% end if %>
<% end if %>

		<tr>
		<td class = "body2"  align ="right"><b>Sold?:</B>&nbsp;</td>
		<td class = "body" align = "left">
		<div class="button-holder">
		<% 		
		if Sold = "True" Or Sold = True Then %>
			<div valign = "top">Yes<input TYPE="RADIO" name="Sold" Value = "True" checked id="radio-5-1"  class="regular-radio big-radio"><label for="radio-5-1"></label>
			No<input TYPE="RADIO" name="Sold" Value = "False" id="radio-5-2"  class="regular-radio big-radio"><label for="radio-5-2"></label></div>
		<% Else %>
			<div valign = "top">Yes<input TYPE="RADIO" name="Sold" Value = "True"  id="radio-5-1"  class="regular-radio big-radio"><label for="radio-5-1"></label>
			No<input TYPE="RADIO" name="Sold" Value = "False" checked id="radio-5-2"  class="regular-radio big-radio"><label for="radio-5-2"></label></div>
		<% End If %>
		</div>
		</td>
	</tr>
    <tr>
		<td class = "body2"  align ="right"><a class="tooltip" href="#"><b>Show Pricing?:</b><span class="custom info"><em>Show Pricing?:</em>If you don't want to display anything at all for your pricing.</span></a>
        
        
        </td>
		<td class = "body" align = "left">
		<div class="button-holder">
		<% 		
		if Sold = "True" Or Sold = True Then %>
			<div valign = "top">Yes<input TYPE="RADIO" name="Sold" Value = "True" checked id="radio-5-1"  class="regular-radio big-radio"><label for="radio-5-1"></label>
			No<input TYPE="RADIO" name="Sold" Value = "False" id="radio-5-2"  class="regular-radio big-radio"><label for="radio-5-2"></label></div>
		<% Else %>
			<div valign = "top">Yes<input TYPE="RADIO" name="Sold" Value = "True"  id="radio-5-1"  class="regular-radio big-radio"><label for="radio-5-1"></label>
			No<input TYPE="RADIO" name="Sold" Value = "False" checked id="radio-5-2"  class="regular-radio big-radio"><label for="radio-5-2"></label></div>
		<% End If %>
		</div>
		</td>
	</tr>

<tr>
<td class = "body"  align = "left" colspan = "2">
	<b>Marketing Comment</b>:</td></tr>
<tr><td class = "body"  align = "left" colspan = "2">
	<textarea name="PriceComments" ID="PriceComments" cols="35" rows="2" wrap="VIRTUAL" class = "regsubmit2 body" ><%= PriceComments%></textarea>	

</td>
</tr>
<tr>
	<td  align = "center" colspan = "2">
			<Input type = Hidden name='TotalCount' Value = <%=TotalCount%> >

			<div align = "center">
				<input type="submit" class = "regsubmit2 body" value="SUBMIT"  >
	    </div>
		</td>
</tr>
</table></form>
</td>
</tr>
</table>


<% else %>
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
 <tr>
    <td class = "roundedtopandbottom" align = "left">
		<H2><div align = "left"> <a name="Pricing"></a>Pricing</div></H2>

<% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Pricing Changes Have Been Made.</b></font></div>
<% end if %>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "100%">
	<tr>
		<td valign = "top">
	<form action= 'membersPricingHandleForm.asp?category=<%=category %>' method = "post"  action="/articles/articles/javascript/checkNumeric.asp?ID=<%=siteID%>" name = "pricingform">
	<input type = "hidden" name="ID" Value = "<%=  ID%>">
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >

		<% If trim(category) = "Experienced Male" Or trim(category) = "Inexperienced Male" Then 
			'If Len(StudFee) < 2 Then
			'	StudFee = ""
			'End If
		%>
		<tr>
				<td class = "body" height = "30" align = "left"><b><a class="tooltip" href="#"><b>Stud Fee:</b><span class="custom info"><em>Stud Fee</em>If you set the stud fee as $0 it will show the stud fee as "Call For Price".</span></a></b>
					<%=Currencycode %><input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
					name='StudFee' size=4 maxlength=10 Value= "<%= StudFee%>" class = "formbox">
<% if StudFee = "0" then %><font color ="#abacab">$0 ="Call For Price"</font><% end if %></span>
				</td>
		</tr>
        <% showpwyc = false 
        if showpwyc = true then%>

		<tr >
				<td class = "body" height = "30" align = "left">
		<a class="tooltip" href="#"><b>Offer Pay What You Can Stud Breedings?:</b><span class="custom info"><em>About Pay What You Can </em>By offering <i>Pay What You Can</i>you are adding the ability for potential buyers to make you an offer on a  Stud Breeding based upon what they can afford; however, that does not mean that you have to accept an offer, if you don't want to.</span></a>
		<br />
		<% 		
		if PayWhatYouCanStud = "True" Or PayWhatYouCanStud = 1 Then %>
			Yes<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "1" checked class = "formbox">
			No<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "0" class = "formbox" >
		<% Else %>
			Yes<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "1" class = "formbox" >
			No<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "0" checked class = "formbox">
		<% End If %>
		<br><br>
		</td>
		</tr>
    <% end if %>
	<tr>
	
		
	<% Else %>
				<input type=hidden  name='StudFee'  Value= "">
	<% End If %>

    <tr >
		<td class = "body" height = "30" align = "left">
		<b>For Sale?:</b>
		<% 		
		if ForSale = "True" Or ForSale = 1 Then %>
			Yes<input TYPE="RADIO" name="ForSale" Value = "1" checked class = "formbox">
			No<input TYPE="RADIO" name="ForSale" Value = "0" class = "formbox">
		<% Else %>
			Yes<input TYPE="RADIO" name="ForSale" Value = "1" class = "formbox">
			No<input TYPE="RADIO" name="ForSale" Value = "0" checked class = "formbox">
		<% End If %>
		<br>
		</td>
		</tr>

      <% showobo = false 
        if showobo = true then%>
		 <tr >
				<td class = "body" height = "30" align = "left">
		
		<a class="tooltip" href="#"><b>OBO?:</b><span class="custom info"><em>About OBO</em>By sellecting OBO you are adding the ability for potential buyers to make you an offer; however, that does not mean that you have to accept an offer, if you are not interested.</span></a>
		
		
		<% 		
		if OBO = "True" Or OBO = 1 Then %>
			Yes<input TYPE="RADIO" name="OBO" Value = "1" checked class = "formbox">
			No<input TYPE="RADIO" name="OBO" Value = "0" class = "formbox">
		<% Else %>
			Yes<input TYPE="RADIO" name="OBO" Value = "1" class = "formbox">
			No<input TYPE="RADIO" name="OBO" Value = "0" checked class = "formbox">
		<% End If %>
		<br>
		</td>
		</tr>
    <% end if %>

<% If SpeciesSalesType = "Fowl" and numberofanimals > 1 then %>
<tr>
<td>
<table  cellpadding = 1 cellspacing = 1 border = 0>
<tr>
	<td class = "body" height = "30" width = 120 >
            <b>Straight Run</b><br /><center>Price</center>
    </td>
    <td class = "body2" height = "30" align = "center" valign = "bottom" width = 120>
            Min Order
    </td>
    <td class = "body2" height = "30" align = "center" valign = "bottom" width = 120>
            Max Order
    </td>
<tr>

<tr>
	<td class = "body" height = "30" align = "center">
             <% tempPrice = Price
            if Price = "0" then
            tempPrice  = "" 
            end if %>
		$<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='price' size=6 maxlength=6 Value= "<%= tempPrice%>"><font color="#404040">
    </td>
    <td class = "body" height = "30" align = "center">
            <% tempMinOrder1 = MinOrder1
            if MinOrder1 = "0" then
            tempMinOrder1  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='MinOrder1' size=6 maxlength=6 Value= "<%= tempMinOrder1%>">
    </td>
    <td class = "body" height = "30" align = "center">
           <% tempMaxOrder1 = MaxOrder1
            if MaxOrder1 = "0" then
            tempMaxOrder1  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='MaxOrder1' size=6 maxlength=6 Value= "<%= tempMaxOrder1%>">
    </td>
<tr>
<tr><td colspan = 3 height = 20>
</td></tr>
<tr>
	<td class = "body" height = "30"  >
            <b>Females</b><br /><center>Price</center>
    </td>
    <td class = "body2" height = "30" align = "center" valign = "bottom">
            Min Order
    </td>
    <td class = "body2" height = "30" align = "center" valign = "bottom">
            Max Order
    </td>
<tr>

<tr>
	<td class = "body" height = "30" align = "center">
             <% tempPrice2 = Price2
            if Price2 = "0" then
            tempPrice2  = "" 
            end if %>
		$<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='price2' size=6 maxlength=6 Value= "<%= tempPrice2%>"><font color="#404040">
    </td>
    <td class = "body" height = "30" align = "center">
            <% tempMinOrder2 = MinOrder2
            if MinOrder2 = "0" then
            tempMinOrder2  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='MinOrder2' size=6 maxlength=6 Value= "<%= tempMinOrder2%>">
    </td>
    <td class = "body" height = "30" align = "center">
           <% tempMaxOrder2 = MaxOrder2
            if MaxOrder2 = "0" then
            tempMaxOrder2  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='MaxOrder2' size=6 maxlength=6 Value= "<%= tempMaxOrder2%>">
    </td>
<tr>
<tr><td colspan = 3 height = 20>
</td></tr>

<tr>
	<td class = "body" height = "30"  >
            <b>Males</b><br /><center>Price</center>
    </td>
    <td class = "body2" height = "30" align = "center" valign = "bottom">
            Min Order
    </td>
    <td class = "body2" height = "30" align = "center" valign = "bottom">
            Max Order
    </td>
<tr>

<tr>
	<td class = "body" height = "30" align = "center">
             <% tempPrice3 = Price3
            if Price3 = "0" then
            tempPrice3  = "" 
            end if %>
		$<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='price3' size=6 maxlength=6 Value= "<%= tempPrice3%>"><font color="#404040">
    </td>
    <td class = "body" height = "30" align = "center">
            <% tempMinOrder3 = MinOrder3
            if MinOrder3 = "0" then
            tempMinOrder3  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='MinOrder3' size=6 maxlength=6 Value= "<%= tempMinOrder3%>">
    </td>
    <td class = "body" height = "30" align = "center">
           <% tempMaxOrder3 = MaxOrder3
            if MaxOrder3 = "0" then
            tempMaxOrder3  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='MaxOrder3' size=6 maxlength=6 Value= "<%= tempMaxOrder3%>">
    </td>
<tr>
<tr><td colspan = 3 height = 20>
</td></tr>


<tr>
	<td class = "body" height = "30"  >
            <b>Eggs</b><br /><center>Price</center>
    </td>
    <td class = "body2" height = "30" align = "center" valign = "bottom">
            Min Order
    </td>
    <td class = "body2" height = "30" align = "center" valign = "bottom">
            Max Order
    </td>
<tr>

<tr>
	<td class = "body" height = "30" align = "center">
             <% tempPrice4 = Price4
            if Price4 = "0" then
            tempPrice4  = "" 
            end if %>
		$<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='price4' size=6 maxlength=6 Value= "<%= tempPrice4%>"><font color="#404040">
    </td>
    <td class = "body" height = "30" align = "center">
            <% tempMinOrder4 = MinOrder4
            if MinOrder4 = "0" then
            tempMinOrder4  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='MinOrder4' size=6 maxlength=6 Value= "<%= tempMinOrder4%>">
    </td>
    <td class = "body" height = "30" align = "center">
           <% tempMaxOrder4 = MaxOrder4
            if MaxOrder4 = "0" then
            tempMaxOrder4  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='MaxOrder4' size=6 maxlength=6 Value= "<%= tempMaxOrder4%>">
    </td>
<tr>
</table>
<table width = "100%" border =0 cellpadding = 3 cellspacing =3>
<tr><td class = "body" colspan = "6">
<% if Update = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Shipping Changes Have Been Made.</b></font></div>
<% end if %>




<tr><td class = "body" ><br /><b>Ship to</b></td><td class = "body" width = '75'><br /><center><b>Cost</b></center></td>

<% showwithanotherproduct = false
if showwithanotherproduct  = True then %>
<td class = "body" width = '110'><center><b>With<br />Another Item</b><a class="tooltip" href="#"><b>?</b><span class="custom info">When you add a location, it will automatically be added to your list below:</span></a></center></td>
<% end if %>
<% showdelete = false
if showdelete = true then %>
<td width = '9' class = "body"><center><b>Delete</b></center></td>
<% end if %>

</tr>
<% CountryCount = 0

Query =  "Select * From sfShipping where AnimalID = " & ID & " and ShippingToCountry = 'United States of America'" 
'response.write("Query=" & Query )
rsA.Open Query, connLOA, 3, 3  
If not rsA.eof Then

else
Query =  "INSERT INTO sfshipping (AnimalID, ShippingToCountry)"  
Query =  Query & " Values (" & ID & ", 'United States of America' )"

connLOA.Execute(Query) 

end if 
rsA.close

Query =  "Select * From sfShipping where AnimalID = " & ID & " and ShippingToCountry = 'Canada'" 

rsA.Open Query, connLOA, 3, 3  
If not rsA.eof Then
else
Query =  "INSERT INTO sfshipping (AnimalID, ShippingToCountry)"  
 Query =  Query & " Values (" &  ID & ", 'Canada' )"
'response.write("Query=" & Query )
connLOA.Execute(Query) 

end if 
rsA.close

Query =  "Select * From sfShipping where AnimalID = " & ID & " and ShippingToCountry = 'Mexico'" 

rsA.Open Query, connLOA, 3, 3  
If not rsA.eof Then

else
Query =  "INSERT INTO sfshipping (AnimalID, ShippingToCountry)"  
 Query =  Query & " Values (" &  ID & ", 'Mexico' )"
'response.write("Query=" & Query )
connLOA.Execute(Query) 

end if 
rsA.close

Query =  "Select * From sfShipping where AnimalID = " & ID & " and ShippingToCountry = 'Other'" 

rsA.Open Query, connLOA, 3, 3  
If not rsA.eof Then

else
Query =  "INSERT INTO sfshipping (AnimalID, ShippingToCountry)"  
 Query =  Query & " Values (" &  ID & ", 'Other' )"
'response.write("Query=" & Query )
connLOA.Execute(Query) 

end if 
rsA.close

sql = "select * from sfShipping where AnimalID=" & ID
'response.write("sql=" & sql)
		
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, connLOA, 3, 3 

while not rs.eof
if len(rs("ShippingToCountry")) > 0 then
CountryCount = CountryCount + 1
%>

<tr><td class = "body">&nbsp;&nbsp;<b><%=rs("ShippingToCountry") %>
<input name="ShippingToCountry(<%=CountryCount%>)" value="<%=rs("ShippingToCountry")%>" size = "4" type = "hidden" >

</b>
<input name="shipID" value="<%=rs("shipID") %>" type = "hidden">
</td><td class = "body" align = 'center' ><center>$<input name="ShippingCost1(<%=CountryCount%>)" value="<%=rs("ShippingCost1")%>" size = "4" type = "text" ></center></td>
<% if showwithanotherproduct  = True then %>
<td class = "body" align = 'center'><center>$<input name="ShippingCost2" value="<%=rs("ShippingCost2") %>" size = "4" type = "text" ></center></td>
<% end if %>


<td align = 'center'>

 
  <input name="shipID" value="<%=rs("shipID") %>" type = "hidden">
  </td>
  </tr>

<% 
end if
rs.movenext
wend  

CountryTotalCount = CountryCount
%>
  <input name="CountryTotalCount" value="<%=CountryTotalCount %>" type = "hidden">
<tr><td colspan  = 3></td></tr>
</table>

	
<% else %>

		<tr>
			<td class = "body" height = "30" align = "left"><b>Price:</b>
		<%=Currencycode %><input type=text onBlur="checkNumeric(this,1,9000000,',','.','-');"
		name='price' size=10 maxlength=10 Value= "<%= Price%>" class = "formbox">
		</td>
	</tr>

	<tr>
		<td class = "body" height = "30" align = "left">
		<b>% Discount:</b> 
		<select size="1" name="Discount" class = "formbox">
					<option value="<%= Discount%>" selected><%= Discount%>%</option>
					<option value="0">No discount</option>
					<option value="10">10%</option>
					<option  value="20">20%</option>
					<option  value="25">25%</option>
					<option  value="30">30%</option>
					<option  value="40">40%</option>
					<option  value="50">50%</option>
					<option  value="60">60%</option>
					<option  value="70">70%</option>
					<option  value="75">75%</option>
					<option  value="80">80%</option>
					<option  value="90">90%</option>
					<option  value="95">95%</option>
					<option  value="99">99%</option>
					<option  value="100">100%</option>
				</select></td>
	</tr>
	<tr>
		<td class = "body" height = "30" align = "left">
		<b>Discount Price:</b>
<%if len(Discount) > 0 then
Discount = clng(Discount) 
end if 

if len(Price) > 0 then
Price = clng(Price) 
else
Price= "" 
end if  

If Discount > 0 And len(Price) > 0 then
DiscountPrice = FormatCurrency(Price  - (Price * Discount/100) )
Else
DiscountPrice = "N/A"
End if%>
<%= (DiscountPrice)%></big>
</td>	
	</tr>
<% showfoundation = True
if showfoundation = True then %>
	<tr>
		<td  height = "30" align = "left" class = "body" ><b>Show On Foundation Page?</b>&nbsp;
		<% 
		If Foundation = False or Foundation = 0 then %>
		Yes<input TYPE="RADIO" name="Foundation" Value = "1" class = "formbox">
		No<input TYPE="RADIO" name="Foundation" Value = "0" checked class = "formbox"> 
		<% else %>
		Yes<input TYPE="RADIO" name="Foundation" Value = "1" checked class = "formbox">
		No<input TYPE="RADIO" name="Foundation" Value = "0" class = "formbox"> 
		<% end if %>
	</tr>
<% end if %>

<tr >
	<td  height = "30" align = "left" class = "body" ><b>Display?:</b>&nbsp;
 		<% 		
		if (Display = "No" Or Display = False Or Display = 0)  Then %>
			Yes<input TYPE="RADIO" name="Display" Value = "1" id="radio-2-1"   class="regular-radio big-radio"><label for="radio-2-1"></label><img src = "images/px.gif" width = "5" height = "1" />
			No<input TYPE="RADIO" name="Display" Value = "0"  id="radio-2-2" checked class="regular-radio big-radio"><label for="radio-2-2"></label>
		<% Else %>
			Yes<input TYPE="RADIO" name="Display" Value = "1" id="radio-2-1"  class="regular-radio big-radio" checked><label for="radio-2-1"></label><img src = "images/px.gif" width = "5" height = "1" />
			No<input TYPE="RADIO" name="Display" Value = "0"  id="radio-2-2" class="regular-radio big-radio" ><label for="radio-2-2"></label>
		<% End If %>
		</td>
</tr>



<% showpending = false
if showpending = true then %>
	<tr>
		<td class = "body" height = "30" align = "left"><b>Sale Pending?:</b>
		<% if SalePending = "True" Or SalePending = 1 Then %>
			Yes<input TYPE="RADIO" name="SalePending" Value = "1" checked class = "formbox">
			No<input TYPE="RADIO" name="SalePending" Value = "0" class = "formbox">
		<% Else %>
			Yes<input TYPE="RADIO" name="SalePending" Value = "1" class = "formbox">
			No<input TYPE="RADIO" name="SalePending" Value = "0" checked class = "formbox">
		<% End If %>
		
		</td>
		</tr>
<% end if %>


<tr>
		<td class = "body" height = "30" align = "left">
		<b>Sold?:</B>
		<% if Sold = "True" Or Sold = 1 Then %>
			Yes<input TYPE="RADIO" name="Sold" Value = "1" checked class = "formbox">
			No<input TYPE="RADIO" name="Sold" Value = "0" class = "formbox">
		<% Else %>
			Yes<input TYPE="RADIO" name="Sold" Value = "1" class = "formbox">
			No<input TYPE="RADIO" name="Sold" Value = "0" checked class = "formbox">
		<% End If %>
		
		</td>
	</tr>
<% 
showpricing = False
if showpricing = true then %>
     <tr>
		<td class = "body2"  align ="left"><a class="tooltip" href="#"><b>Show Pricing?:</b><span class="custom info"><em>Show Pricing?:</em>If you don't want to display anything at all for your pricing.</span></a>

		
		<% 	if len(ShowPrices) > 0 then
        else
        ShowPrices = 1
        end if	
		if ShowPrices = "False" Or ShowPrices = 0 Then %>
			Yes<input TYPE="RADIO" name="ShowPrices" Value = "1" class = "formbox">
			No<input TYPE="RADIO" name="ShowPrices" Value = "0" checked class = "formbox">
		<% Else %>
			Yes<input TYPE="RADIO" name="ShowPrices" Value = "1" checked class = "formbox">
			No<input TYPE="RADIO" name="ShowPrices" Value = "0" class = "formbox">
		<% End If %>
       </td>
	</tr>
<% end if %>
<% end if %>


<% If SpeciesSalesType = "Fowl"  then
else %>
<tr>
<td class = "body"  align = "left" valign = "top">
<b>Finance Terms</b><br>
<textarea name="Financeterms"  cols="40" rows="20" wrap="VIRTUAL" class = "body" ><%= Financeterms%></textarea>	
</td>
</tr>
<% end if %>
</table>
</td>
<td class = "body" height = "30" align = "left" valign = "top">
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg.js"></script> 
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg-settings.js"></script>
<script type="text/javascript">
    var mysettings = new WYSIWYG.Settings();
    mysettings.Width = "550";
    mysettings.Height = "80px";
    mysettings.ImagePopupWidth = 600;
    mysettings.ImagePopupHeight = 245;
    WYSIWYG.attach('PriceComments', mysettings);
</script>
	<b>Sales Comment</b> (a short comment like "Great Price!" or "Wonderful Fleece!"):<br>
	<textarea name="PriceComments" ID="PriceComments" cols="45" rows="2" wrap="VIRTUAL" class = "body" ><%= PriceComments%></textarea>	
<table border = 0 width = 550>

<% If SpeciesSalesType = "Fowl"  and numberofanimals > 1 then %>

<tr><td  class = body>
<font color = #404040><B>Straight Run Fowl</B> -  birds that are randomly selected and can be males or females.<br /><br />
<b>Prices</b> - If you do not enter a price than that option will not be available. For example, if you have no price selected for Males, then males will not be available for purchase.<br /><br />
<b>Min Order</b> - If you do not enter a minimum order, then it will default to 1.<br /><br />
<b>Max Order</b> - If you do not enter a maximum order, then it will default to 12.<br /><br />


<img src="images/Important_Triangle.png" height = 20 /> <b>If you do not set any shipping and handling costs then buyers will only be able to order your animal(s), in your home country.</b><br /><br />
<font color = #404040>Note: If you enter shipping costs for some countries, and not other countries, then shipping to the excluded countries will not be available.</font><br>
<br>
<b>Helpful Links</b><br>
<a href = "http://www.purolatorinternational.com/trade-regulations" target = "_blank" class = "body">www.purolatorinternational.com/trade-regulations</a> - learn about shipping to Canada.<br />

<a href = "http://www.export.gov/mexico/doingbusinessinmexico/documentationandlogistics/index.asps" target = "_blank" class = "body">www.export.gov/mexico/doingbusinessinmexico/documentationandlogistics/index.asp</a> - learn about shipping to Mexico.<br />



</font>
</td></tr>




<% else %>
<tr><td class = body colspan = 2>
<b>Co-Owners</b><br />
If this animal(s) have any co-owners you can enter their information below:
</td></tr>
<tr>
		<td  align = "right" class = "body2" >1st Co-owner's Ranch Name:&nbsp;</td>
		<td  valign = "bottom"  class = "body" align = "left"> <input type=text name='CoOwnerBusiness1' value='<%=CoOwnerBusiness1%>' class = "formbox" > </td>
	</tr>
	<tr>
		<td  align = "right" class = "body2" >1st Co-owner's Name:&nbsp;</td>
		<td  valign = "bottom"  class = "body" align = "left"> <input type=text name='CoOwnerName1' value='<%=CoOwnerName1%>' class = "formbox" > </td>
	</tr>

	<tr>
		<td  align = "right" class = "body2" >1st Co-owner link:&nbsp;</td>
		<td  valign = "bottom"  class = "body" align = "left"><input type=text name='CoOwnerLink1' value='<%=CoOwnerLink1%>' class = "formbox"0>  </td>
	</tr>
<tr>
		<td  align = "right" class = "body2" >2nd Co-owner's Ranch Name:&nbsp;</td>
		<td  valign = "bottom"  class = "body" align = "left"> <input type=text name='CoOwnerBusiness2' value='<%=CoOwnerBusiness2%>' class = "formbox" > </td>
	</tr>
	<tr>
		<td  align = "right" class = "body2" >2nd Co-owner's Name:&nbsp;</td>
		<td  valign = "bottom"  class = "body" align = "left"> <input type=text name='CoOwnerName2' value='<%=CoOwnerName2%>'  class = "formbox" > </td>
	</tr>

	<tr>
		<td  align = "right" class = "body2" >2nd Co-owner link:&nbsp;</td>
		<td  valign = "bottom"  class = "body" align = "left"><input type=text name='CoOwnerLink2' value='<%=CoOwnerLink2%>' class = "formbox">  </td>
	</tr>
<tr>
		<td  align = "right" class = "body2" >3rd Co-owner's Ranch Name:&nbsp;</td>
		<td  valign = "bottom"  class = "body" align = "left"> <input type=text name='CoOwnerBusiness3' value='<%=CoOwnerBusiness3%>' class = "formbox" > </td>
	</tr>
	<tr>
		<td  align = "right" class = "body2" >3rd Co-owner's Name:&nbsp;</td>
		<td  valign = "bottom"  class = "body" align = "left"> <input type=text name='CoOwnerName3' value='<%=CoOwnerName3%>' class = "formbox" > </td>
	</tr>

	<tr>
		<td  align = "right" class = "body2" >3rd Co-owner link:&nbsp;</td>
		<td  valign = "bottom"  class = "body" align = "left"><input type=text name='CoOwnerLink3'  value='<%=CoOwnerLink3%>' class = "formbox" >  </td>
	</tr>
    <% end if %>



</table>
</td>
</tr>
</table>

<table width = "90%" border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
	<td  align = "center">
			<Input type = Hidden name='TotalCount' Value = <%=TotalCount%> >
            <input type = "hidden" name="SpeciesID" Value = "<%= SpeciesID%>"> 	
			<div align = "center"><br />
				<input type="submit" class = "regsubmit2" value="SUBMIT PRICING CHANGES"  >
	    </div>
        <br />
		</td>
</tr>
</table></form>
</td>
</tr>
</table>

<% end if 
connLOA.close
set connLOA = nothing %>
</body>
</html>