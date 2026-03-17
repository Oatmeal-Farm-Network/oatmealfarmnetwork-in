<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="John Andresen">
    <title>Harvest Hub</title>
<!--#Include file="MembersGlobalVariables.asp"-->
<link rel="stylesheet" href="/members/Membersstyle.css">

</head>
<body >
<% Current1="Animals"
Current2 = "EditAnimals" 
Current3 = "Pricing" %> 
<!--#Include file="MembersHeader.asp"-->

<% 
if len(animalID) < 1 then
Response.redirect("default.asp#Animals")
end if


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
Conn.Execute(Query) 

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
Conn.Execute(Query) 
else
Query =  " UPDATE sfShipping Set ShippingCost1 = Null" 
Query =  Query & " where ShipID = " & ShipID & ";" 
Conn.Execute(Query) 

end if

if len(ShippingCost2) >0 then
Query =  " UPDATE sfShipping Set ShippingCost2 = " &  ShippingCost2 & " "
Query =  Query & " where ShipID = " & ShipID & ";" 
Conn.Execute(Query) 
else
Query =  " UPDATE sfShipping Set ShippingCost2 = Null "
Query =  Query & " where ShipID = " & ShipID & ";"
Conn.Execute(Query) 

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

Conn.Execute(Query) 

end if


sql = "select * from sfShipping where AnimalID=" & animalID

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
 if rs.eof then 
 
Query =  "INSERT INTO sfshipping (animalID)"  
Query =  Query & " Values (" &  animalID & ")"
'response.write("Query=" & Query)

Conn.Execute(Query) 

rs.close
end if

if rs.state = 0 then
else
rs.close
end if
sql = "select NumberofAnimals, CoOwnerName1, CoOwnerLink1, CoOwnerBusiness1, CoOwnerName2, CoOwnerLink2, CoOwnerBusiness2, CoOwnerName3, CoOwnerLink3, CoOwnerBusiness3 from Animals where animalID=" & animalID
rs.Open sql, conn, 3, 3
NumberofAnimals = rs("NumberofAnimals")
if len(NumberofAnimals) > 0 then
else
NumberofAnimals = 1
end if
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

sql = "select * from Pricing where animalid=" & animalid
rs.Open sql, conn, 3, 3
If rs.eof then
Query =  "INSERT INTO Pricing (animalid)" 
Query =  Query & " Values (" &  animalid & ")"

'response.write("Query=" & Query )
Conn.Execute(Query) 
rs.close

sql = "select * from Pricing where animalid=" & animalid
rs.Open sql, conn, 3, 3
End If 
EmbryoPrice  = rs("EmbryoPrice") 
SemenPrice  = rs("SemenPrice") 
Price = rs("Price")
Price2=rs("Price2") 
'response.write("price2=" & price2)
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
rs.close
%>




<div class="container roundedtopandbottom">

    <form action= 'membersPricingHandleForm.asp?category=<%=category %>' method = "post"  action="/articles/articles/javascript/checkNumeric.asp?animalid=<%=animalid%>" name = "pricingform">
	    <input type = "hidden" name="animalid" Value = "<%=  animalid%>">
        <div class="col">
            <div class="card-header">
               <!--#Include file="MembersJumpLinks.asp"-->
            </div>
         <div class="card-header">
            <h4 class="mb-0">Pricing</h4>
            <% changesmade = request.querystring("changesmade")
            if changesmade = "True" then %>
            <font class="blink_text"><b>Your Pricing Changes Have Been Made.</b></font>   
            <% end if %>
            <br>
        </div>

        <div class ="container">
 <div class = "row" >
     <div class="col-12">
		For Sale?
        <% if ForSale = "True" Or ForSale = 1 Then %>
			Yes &nbsp;<input TYPE="RADIO" name="ForSale" Value = "1" checked >
			No &nbsp;<input TYPE="RADIO" name="ForSale" Value = "0" >
		<% Else %>
			Yes &nbsp;<input TYPE="RADIO" name="ForSale" Value = "1" />
			No &nbsp;<input TYPE="RADIO" name="ForSale" Value = "0" checked >
		<% End If %>
		<br>
	</div>
</div>
<%=HSpacer %>

    
<div class = "row" >
     <div class="col-12">
		Sold?
		<% if Sold = "True" Or Sold = 1 Then %>
			Yes &nbsp;<input TYPE="RADIO" name="Sold" Value = "1" checked >
			No &nbsp;<input TYPE="RADIO" name="Sold" Value = "0" >
		<% Else %>
			Yes &nbsp;<input TYPE="RADIO" name="Sold" Value = "1" >
			No &nbsp;<input TYPE="RADIO" name="Sold" Value = "0" checked >
		<% End If %>
		
		</div>
	</div>
    <%=HSpacer %>


   
<% if SpeciesSalesType="Fowl" and (Category = "Preborn Male" or Category = "Preborn Female" or Category = "Preborn Baby" or Category = "Preborn Males" or Category = "Preborn Females" or Category = "Preborn Babies") then %>

<% else %>

<div class = "row" >
     <div class="col-12">
     Price
		<%=Currencycode %><input type="number" id="typeNumber" name='price' size=6 maxlength=6 Value= "<%= Price%>" class = "formbox" onKeypress="return checkInput(event);"><%=CurrencyType %>
        <br><small>Numbers only.</small>
		</div>
	</div>
        <%=HSpacer %>
<div class = "row" >
     <div class="col-12">

		Free?
		<% 		
		if Free = "1" or Free = 1 Then %>
			Yes<input TYPE="RADIO" name="Free" Value = "1" checked>
			No<input TYPE="RADIO" name="Free" Value = "0" >
		<% Else %>
			Yes<input TYPE="RADIO" name="Free" Value = "1" >
			No<input TYPE="RADIO" name="Free" Value = "0" checked>
		<% End If %>
		<br>
	</div>
</div>
            <%=HSpacer %>
<div class = "row" >
     <div class="col-12">
		% Discount 
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
				</select> Off
	</div>
</div>
            <%=HSpacer %>
<div class = "row" >
     <div class="col-12">
		Discount Price
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
</div>	
	</div>
<%=HSpacer %>
<% showfoundation = False
if showfoundation = True then %>
<div class = "row" >
     <div class="col-12">Show On Foundation Page?&nbsp;
		<% 
		If Foundation = 0 then %>
		Yes<input TYPE="RADIO" name="Foundation" Value = "1" class = "formbox">
		No<input TYPE="RADIO" name="Foundation" Value = "0" checked class = "formbox"> 
		<% else %>
		Yes<input TYPE="RADIO" name="Foundation" Value = "1" checked class = "formbox">
		No<input TYPE="RADIO" name="Foundation" Value = "0" class = "formbox"> 
		<% end if %>
	</div>
</div>
 <%=HSpacer %>
<% end if %>
<% end if %>




<% If (category = 4 or category = 3 or trim(category) = "Experienced Male" Or trim(category) = "Inexperienced Male") and (not SpeciesSalesType = "Fowl") Then 	%>
         <div class = "row" >
            <div class="col-12">
             Stud Fee          
                <%=Currencycode %> <input type="number" id="typeNumber" class ="formbox" maxlength="8" size="4" max = 10000000 name="StudFee" value="<%=StudFee%>" /><br />
                <label class="form-label" for="typeNumber"> <small>Numbers only. If you set the stud fee as 0 it will show the stud fee as "Call For Price".</small></label>
          
           <% if StudFee = "0" then %><font color ="#abacab">$0 ="Call For Price"</font><% end if %></span>

            </div>
        </div>
<%=HSpacer %>

        <% showpwyc = false 
        if showpwyc = true then%>

        <div class = "row" >
            <div class="col-12">
		        <a class="tooltip" href="#"><b>Offer Pay What You Can Stud Breedings?:</b><span class="custom info"><em>About Pay What You Can </em>By offering <i>Pay What You Can</i>you are adding the ability for potential buyers to make you an offer on a  Stud Breeding based upon what they can afford; however, that does not mean that you have to accept an offer, if you don't want to.</span></a>
		        <br />
		        <% if PayWhatYouCanStud = "True" Or PayWhatYouCanStud = 1 Then %>
			        Yes<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "1" checked class = "formbox">
			        No<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "0" class = "formbox" >
		        <% Else %>
			        Yes<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "1" class = "formbox" >
			        No<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "0" checked class = "formbox">
		        <% End If %>
		        <br><br>
		</div>
		</div>
        <%=HSpacer %>
     <% end if %>
	
<% Else %>
    	<input type=hidden  name='StudFee'  Value= "">
<% End If %>




<% showobo = false 
   if showobo = true then%>
  <div class = "row" >
     <div class="col-12">
		
		OBO?<br />
				
		<% 		
		if OBO = "True" Or OBO = 1 Then %>
			Yes<input TYPE="RADIO" name="OBO" Value = "1" checked class = "formbox">
			No<input TYPE="RADIO" name="OBO" Value = "0" class = "formbox">
		<% Else %>
			Yes<input TYPE="RADIO" name="OBO" Value = "1" class = "formbox">
			No<input TYPE="RADIO" name="OBO" Value = "0" checked class = "formbox">
		<% End If %>
		<br>
        <small>By sellecting OBO you are adding the ability for potential buyers to make you an offer; however, that does not mean that you have to accept an offer, if you are not interested.</small>
		</div>
		</div>
<%=HSpacer %>


    <% end if %>

<% if len(NumberofAnimals) > 0 then
else
NumberofAnimals = 1
end if
%>



     





<% If SpeciesSalesType = "Fowl"  then
else %>
<div class = "row" >
     <div class="col-12">
Finance Terms<br>
<textarea name="Financeterms"  cols="40" rows="10" wrap="VIRTUAL" class = "roundedtopandbottom" ><%= Financeterms%></textarea>	
</div>
</div>
 <%=HSpacer %>
<% end if %>







<% if SpeciesSalesType="Fowl" and (Category = "Preborn Male" or Category = "Preborn Female" or Category = "Preborn Baby" or Category = "Preborn Males" or Category = "Preborn Females" or Category = "Preborn Babies") then %>
<% if SpeciesSalesType="Fowl" and (Category = "Preborn Baby" or Category = "Preborn Babies") then %>
  <div class = "row" >
    <div class="col-12"> 
           Fertilized Eggs
           <br /><center>Price</center><br />
            <% tempPrice4 = Price4
            if Price4 = "0" then
            tempPrice4  = "" 
            end if %>
		    $<input class = 'formbox'  type="number" id="typeNumber" name='price4' size=6 maxlength=6 Value= "<%= tempPrice4%>" onKeypress="return checkInput(event);"><font color="#404040">
            <br><font color=#404040>Numbers only.</font>

            Min Order<br />
            <% tempMinOrder4 = MinOrder4
            if MinOrder4 = "0" then
            tempMinOrder4  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type="number" id="typeNumber" name='MinOrder4' size=6 maxlength=6 Value= "<%= tempMinOrder4%>" onKeypress="return checkInput(event);">
        <br><font color=#404040>Numbers only.</font>
            Max Order<br />
            <% tempMaxOrder4 = MaxOrder4
            if MaxOrder4 = "0" then
            tempMaxOrder4  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type="number" id="typeNumber" name='MaxOrder4' size=6 maxlength=6 Value= "<%= tempMaxOrder4%>" onKeypress="return checkInput(event);">
        <br><font color=#404040>Numbers only.</font>

    </div>
</div>

<% end if %>
<% end if %>




<% if SpeciesSalesType="Fowl"  then %>

<% if SpeciesSalesType="Fowl" and (Category= 38 or Category= 44 or Category= 75 ) then %>
 <div class = "row" >
     <div class="col-12"> 
           <br /> Straight Run Chicks<br />
          <center>Price</center><br />
  <% tempPrice = Price
            if Price = "0" then
            tempPrice  = "" 
            end if %>
		$<input class = 'formbox' type="number" id="typeNumber" name='price' size=6 maxlength=6 Value= "<%= tempPrice%>" onKeypress="return checkInput(event);"><font color="#404040">
        <br><font color=#404040>Numbers only.</font>
            Min Order<br />
<% tempMinOrder1 = MinOrder1
            if MinOrder1 = "0" then
            tempMinOrder1  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type="number" id="typeNumber" name='MinOrder1' size=6 maxlength=6 Value= "<%= tempMinOrder1%>" onKeypress="return checkInput(event);">
        <br><font color=#404040>Numbers only.</font>
            Max Order<br />
 <% tempMaxOrder1 = MaxOrder1
            if MaxOrder1 = "0" then
            tempMaxOrder1  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type="number" id="typeNumber" name='MaxOrder1' size=6 maxlength=6 Value= "<%= tempMaxOrder1%>" onKeypress="return checkInput(event);">
        <br><font color=#404040>Numbers only.</font>

    </div>
</div>

<% end if %>
<% end if %>



<% if SpeciesSalesType="Fowl"  then %>

<% if SpeciesSalesType="Fowl"  and (Category= 38 or Category= 44 or Category= 75 )  then %>
 <div class = "row" >
     <div class="col-12"> 
            Female Chicks<br />
            <center>Price</center><br />
 <% tempPrice2 = Price2
            if Price2 = "0" then
            tempPrice2  = "" 
            end if %>
		$<input class = 'formbox' type="number" id="typeNumber"	name='price2' size=6 maxlength=6 Value= "<%= tempPrice2%>" onKeypress="return checkInput(event);"><font color="#404040">
        <br><font color=#404040>Numbers only.</font>


            Min Order<br />
 <% tempMinOrder2 = MinOrder2
            if MinOrder2 = "0" then
            tempMinOrder2  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type="number" id="typeNumber" name='MinOrder2' size=6 maxlength=6 Value= "<%= tempMinOrder2%>" onKeypress="return checkInput(event);">
        <br><font color=#404040>Numbers only.</font>
            Max Order<br />

 <% tempMaxOrder2 = MaxOrder2
            if MaxOrder2 = "0" then
            tempMaxOrder2  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type="number" id="typeNumber" name='MaxOrder2' size=6 maxlength=6 Value= "<%= tempMaxOrder2%>" onKeypress="return checkInput(event);">
        <br><font color=#404040>Numbers only.</font>
    </div>
<div>
<% end if %>
<% end if %>


<% if SpeciesSalesType="Fowl"  then %>

<% if SpeciesSalesType="Fowl"  and (Category= 38 or Category= 44 or Category= 75 )  then %>
<div class = "row" >
     <div class="col-12"> 
            <b>Male Chicks</b><br />
            <center>Price</center><br />
             <% tempPrice3 = Price3
            if Price3 = "0" then
            tempPrice3  = "" 
            end if %>
		    $<input class = 'formbox' type="number" id="typeNumber" name='price3' size=6 maxlength=6 Value= "<%= tempPrice3%>" onKeypress="return checkInput(event);"><font color="#404040">
             <br><font color=#404040>Numbers only.</font>
            Min Order<br />
            <% tempMinOrder3 = MinOrder3
            if MinOrder3 = "0" then
            tempMinOrder3  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type="number" id="typeNumber" name='MinOrder3' size=6 maxlength=6 Value= "<%= tempMinOrder3%>" onKeypress="return checkInput(event);">
        <br><font color=#404040>Numbers only.</font>
            Max Order<br />
             <% tempMaxOrder3 = MaxOrder3
            if MaxOrder3 = "0" then
            tempMaxOrder3  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type="number" id="typeNumber" name='MaxOrder3' size=6 maxlength=6 Value= "<%= tempMaxOrder3%>" onKeypress="return checkInput(event);">
        <br><font color=#404040>Numbers only.</font>
    </div>
</div>
<% end if %>
<% end if %>


<% if SpeciesSalesType="Fowl" then %>

<% if SpeciesSalesType="Fowl" and (SpeciesID=29 or SpeciesID=31 or SpeciesID=19) and (Category= 38 or Category= 44 or Category= 75 ) then %>

<div class = "row" >
     <div class="col-12"> 
        <h2>Flat Shipping Rate</h2>
        <% if Update = "True" then %>
        <div align = "left"><font class="blink_text"><b>Your Shipping Changes Have Been Made.</b></font></div>
        <% end if %>
        Indicate a single shipping rate for the whole order (i.e. it will be the same rate weather they order 5 eggs or 50).<br />
        
        <b>Ship to</b>
        <center><b>Cost<br />
        <% showwithanotherproduct = false
            if showwithanotherproduct  = True then %>
        <center><b>With<br />Another Item</b><a class="tooltip" href="#"><b>?</b><span class="custom info">When you add a location, it will automatically be added to your list below:</span></a></center>
        <% end if %>
        <% showdelete = false
        if showdelete = true then %>
            <center><b>Delete</b></center>
        <% end if %>
<% CountryCount = 0

Query =  "Select * From sfShipping where AnimalID = " & ID & " and ShippingToCountry = 'United States of America'" 
'response.write("Query=" & Query )
rsA.Open Query, conn, 3, 3  
If not rsA.eof Then

else
Query =  "INSERT INTO sfshipping (AnimalID, ShippingToCountry)"  
Query =  Query & " Values (" & ID & ", 'United States of America' )"

Conn.Execute(Query) 

end if 
rsA.close

Query =  "Select * From sfShipping where AnimalID = " & ID & " and ShippingToCountry = 'Canada'" 

rsA.Open Query, conn, 3, 3  
If not rsA.eof Then
else
Query =  "INSERT INTO sfshipping (AnimalID, ShippingToCountry)"  
 Query =  Query & " Values (" &  ID & ", 'Canada' )"
'response.write("Query=" & Query )
Conn.Execute(Query) 

end if 
rsA.close

Query =  "Select * From sfShipping where AnimalID = " & ID & " and ShippingToCountry = 'Mexico'" 

rsA.Open Query, conn, 3, 3  
If not rsA.eof Then

else
Query =  "INSERT INTO sfshipping (AnimalID, ShippingToCountry)"  
 Query =  Query & " Values (" &  ID & ", 'Mexico' )"
'response.write("Query=" & Query )
Conn.Execute(Query) 

end if 
rsA.close

Query =  "Select * From sfShipping where AnimalID = " & ID & " and ShippingToCountry = 'Other'" 

rsA.Open Query, conn, 3, 3  
If not rsA.eof Then

else
Query =  "INSERT INTO sfshipping (AnimalID, ShippingToCountry)"  
 Query =  Query & " Values (" &  ID & ", 'Other' )"
'response.write("Query=" & Query )
Conn.Execute(Query) 

end if 
rsA.close

sql = "select * from sfShipping where AnimalID=" & ID
'response.write("sql=" & sql)
		
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 

while not rs.eof
if len(rs("ShippingToCountry")) > 0 then
CountryCount = CountryCount + 1
%>

&nbsp;&nbsp;<b><%=rs("ShippingToCountry") %><br />
<input name="ShippingToCountry(<%=CountryCount%>)" value="<%=rs("ShippingToCountry")%>" size = "4" type = "hidden" >


<input name="shipID" value="<%=rs("shipID") %>" type = "hidden">
<center>$<input name="ShippingCost1(<%=CountryCount%>)" value="<%=rs("ShippingCost1")%>" size = "4" type = "text" ></center>
<% if showwithanotherproduct  = True then %>
<center>$<input name="ShippingCost2" value="<%=rs("ShippingCost2") %>" size = "4" type = "text" ></center>
<% end if %>

<input name="shipID" value="<%=rs("shipID") %>" type = "hidden">

<% 
end if
rs.movenext
wend  

CountryTotalCount = CountryCount
%>
  <input name="CountryTotalCount" value="<%=CountryTotalCount %>" type = "hidden">
</div>
</div>
    <%=HSpacer %>
<% end if %>


<% showpending = false
if showpending = true then %>
	<div class = "row" >
     <div class="col-12">
        Sale Pending?
		<% if SalePending = "1" Or SalePending = 1 Then %>
			Yes<input TYPE="RADIO" name="SalePending" Value = "1" checked class = "formbox">
			No<input TYPE="RADIO" name="SalePending" Value = "0" class = "formbox">
		<% Else %>
			Yes<input TYPE="RADIO" name="SalePending" Value = "1" class = "formbox">
			No<input TYPE="RADIO" name="SalePending" Value = "0" checked class = "formbox">
		<% End If %>
		
	</div>
</div>
<%=HSpacer %>

<% end if %>



<% 
showpricing = False
if showpricing = true then %>
<div class = "row" >
     <div class="col-12">

       Show Pricing?<small>If you don't want to display anything at all for your pricing.</small>

		
		<% 	if len(ShowPrices) > 0 then
        else
        ShowPrices = 1
        end if	
		if ShowPrices = "0" Or ShowPrices = 0 Then %>
			Yes<input TYPE="RADIO" name="ShowPrices" Value = "1" class = "formbox">
			No<input TYPE="RADIO" name="ShowPrices" Value = "0" checked class = "formbox">
		<% Else %>
			Yes<input TYPE="RADIO" name="ShowPrices" Value = "1" checked class = "formbox">
			No<input TYPE="RADIO" name="ShowPrices" Value = "0" class = "formbox">
		<% End If %>
       </div>
	</div>
    <%=HSpacer %>
<% end if %>
<% end if %>



<div class = "row" >
     <div class="col-12">
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
	Sales Comment<br>
	<textarea name="PriceComments" ID="PriceComments" cols="45" rows="2" wrap="VIRTUAL" class = "roundedtopandbottom" ><%= PriceComments%></textarea><br />
     <small>A short comment like "Great Price!" or "Great Progeny"</small>

<% If SpeciesSalesType = "Fowl"  and NumberofAnimals > 1 and (Category= 38 or Category= 44 or Category= 75 ) then %>
<br />
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
</div></div>

<%=HSpacer %>


<% else %>
<div class = "row" >
     <div class="col-12">
    <% if NumberofAnimals < 2 then %>   
         <br />
<h1>Co-Owners</h1>
    1st Co-owner's Ranch Name&nbsp; <input type=text name='CoOwnerBusiness1' value='<%=CoOwnerBusiness1%>' class = "formbox" > <br>
    1st Co-owner's Name&nbsp; <input type=text name='CoOwnerName1' value='<%=CoOwnerName1%>' class = "formbox" > <br>
	1st Co-owner link<input type=text name='CoOwnerLink1' value='<%=CoOwnerLink1%>' class = "formbox"0>  <br>
    <br>
	2nd Co-owner's Ranch Name <input type=text name='CoOwnerBusiness2' value='<%=CoOwnerBusiness2%>' class = "formbox" > <br>
    2nd Co-owner's Name<input type=text name='CoOwnerName2' value='<%=CoOwnerName2%>'  class = "formbox" > <br>
	2nd Co-owner link<input type=text name='CoOwnerLink2' value='<%=CoOwnerLink2%>' class = "formbox">  <br>
	<br>
	3rd Co-owner's Ranch Name <input type=text name='CoOwnerBusiness3' value='<%=CoOwnerBusiness3%>' class = "formbox" > <br>
	3rd Co-owner's Name <input type=text name='CoOwnerName3' value='<%=CoOwnerName3%>' class = "formbox" > <br>
	3rd Co-owner link<input type=text name='CoOwnerLink3'  value='<%=CoOwnerLink3%>' class = "formbox" >  <br>

   <% end if %>
</div>
</div>

    <% end if %>











    </div>    
 </div>
</div>
     




   
  
</div>


<%conn.close
set Conn = nothing %>


       <div class = "row" >
     <div class="col-12" align = center>
            <br />
			<Input type = Hidden name='TotalCount' Value = <%=TotalCount%> >
            <input type = "hidden" name="SpeciesID" Value = "<%= SpeciesID%>"> 	
			<input type="submit" class = "regsubmit2" value="Submit"  >
            
	  </div>
</div>
 
        
        <br />
</div>
</form>

<!--#Include file="MembersFooter.asp"-->

 </Body>
</HTML>