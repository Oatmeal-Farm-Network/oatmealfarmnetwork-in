<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="MembersStyle.css">
<!--#Include virtual="/connloa.asp"-->
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
<!--    Begin
    function checkNumeric(objName, minval, maxval, comma, period, hyphen) {
        var numberfield = objName;
        if (chkNumeric(objName, minval, maxval, comma, period, hyphen) == false) {
            numberfield.select();
            numberfield.focus();
            return false;
        }
        else {
            return true;
        }
    }

    function chkNumeric(objName, minval, maxval, comma, period, hyphen) {
        // only allow 0-9 be entered, plus any values passed
        // (can be in any order, and don't have to be comma, period, or hyphen)
        // if all numbers allow commas, periods, hyphens or whatever,
        // just hard code it here and take out the passed parameters
        var checkOK = "0123456789$ " + comma + period;
        var checkStr = objName;
        var allValid = true;
        var decPoints = 0;
        var allNum = "";

        for (i = 0; i < checkStr.value.length; i++) {
            ch = checkStr.value.charAt(i);
            for (j = 0; j < checkOK.length; j++)
                if (ch == checkOK.charAt(j))
                    break;
            if (j == checkOK.length) {
                allValid = false;
                break;
            }
            if (ch != ",")
                allNum += ch;
        }
        if (!allValid) {
            alertsay = "Please enter only these values \""
            alertsay = alertsay + checkOK + "\" in the \"" + checkStr.name + "\" field."
            alert(alertsay);
            return (false);
        }

        // set the minimum and maximum
        var chkVal = allNum;
        var prsVal = parseInt(allNum);
        if (chkVal != "" && !(prsVal >= minval && prsVal <= maxval)) {


        }
    }
//  End -->
</script>

</head>
<body>

<% 
Set rs = Server.CreateObject("ADODB.Recordset")
Set rs2 = Server.CreateObject("ADODB.Recordset")
Set rs3 = Server.CreateObject("ADODB.Recordset")

Dim IDArray(10000)
Dim alpacaName(10000)

ProdID = request.QueryString("ProdID")
if len(ProdID) < 1 then
ProdID = Request.Form("ProdID")
end if
'response.write("ProdID=" & ProdID )

'Prodid = 17
Productid = Prodid
LivestockAvailable = True


Session("PhotoPageCount") = 0

'conn.close %>


<!--#Include virtual="/connloa.asp"-->

<%

'*******************Get Customer Location *********************
PeopleID = Session("PeopleID")
Dim CurrentCategoryID
Dim CurrentCategoryName

Dim SubCurrentCategoryID
Dim SubCurrentCategoryName

prodCategory1ID = request.querystring("prodCategory1ID")
'response.write("prodCategory1ID=" & prodCategory1ID )


if len(prodCategory1ID) > 0 then
Category1ID = prodCategory1ID
end if
prodCategory2ID = request.querystring("prodCategory2ID")
if len(prodCategory2ID) > 0 then
Category2ID = prodCategory2ID
end if
prodCategory3ID = request.querystring("prodCategory3ID")
if len(prodCategory3ID) > 0 then
Category3ID = prodCategory3ID
end if

prodSubCategory1ID = request.querystring("prodSubCategory1ID")
if len(prodSubCategory1ID) > 0 then
SubCategory1ID = prodSubCategory1ID
end if

prodSubCategory2ID = request.querystring("prodSubCategory2ID")
if len(prodSubCategory2ID) > 0 then
SubCategory2ID = prodSubCategory2ID
end if

prodSubCategory3ID = request.querystring("prodSubCategory3ID")
if len(prodSubCategory3ID) > 0 then
SubCategory3ID = prodSubCategory3ID
end if

sql = "select * from productCategoriesList, sfCategories where productCategoriesList.prodCategoryID =  sfCategories.catID and prodcategoryID > 0 and ProductID = " & ProdID & ";" 
'response.write("sql=" & sql)

rs.Open sql, connloa, 3, 3 

if not rs.eof then
	Category1= rs("CatName")
	Category1ID = rs("catID")

	SubCategory1ID = rs("prodSubCategoryId")
	
	ProductCategoriesListID1= rs("ProductCategoriesListID")
end if
'response.Write("Category1ID=" & Category1ID )

if not rs.eof then
	rs.movenext
end if
if not rs.eof then
	Category2= rs("CatName")
	Category2ID = rs("catID")
	SubCategory2ID = rs("prodSubCategoryId")
	ProductCategoriesListID2= rs("ProductCategoriesListID")
end if
if not rs.eof then
	rs.movenext
end if
if not rs.eof then
	Category3= rs("CatName")
	Category3ID = rs("catID")
	SubCategory3ID = rs("prodSubCategoryId")
	ProductCategoriesListID3= rs("ProductCategoriesListID")
end if
rs.close


sql = "select * from sfProducts where sfProducts.ProdID = " & ProdID & ";" 
'response.write("sql=" & sql )
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, connloa, 3, 3 
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

ProdForSalex  = rs("ProdForSale")
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
ProdForSalex = rs("ProdForSale")

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
ProdDescription = rs("ProdDescription")


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

	'response.write("CurrentCategoryName=" & CurrentCategoryName )


Dim CategoryID(100,100)
Dim CatName(100,100)

Dim SubCategoryIDX(1000)
Dim SubCatName(1000)

sql = "select * from SFCategories  order by Catname " 
Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, connloa, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		CategoryID(CatCounter,0) = rs("CatID")
		CatName(CatCounter,0) = rs("CatName")
		'response.write(CatName(CatCounter,0))
		rs.movenext
	Wend
		FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0
firsttime = False
While CatCounter < FinalCatCounter
	CatCounter= CatCounter +1
	
	

	sql = "select * from SFSubCategories where CategoryID = '" & CategoryID(CatCounter,0) & "' Order by SubcategoryName"
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, connloa, 3, 3 
	If Not rs.eof Then
	SubCatCounter= 0
	If Len(SubCurrentCategoryName) > 0 And firsttime = False  Then
		firsttime = True
		Varieties =  Varieties  & " [""" & SubCurrentCategoryName & """], "
		Varieties =  Varieties  & " ["" No Sub Categories "" ," & vbCrLf
	Else
			Varieties =  Varieties  & " ["" Sub Categories "", "
	End if
	While Not rs.eof
		SubCatCounter= SubCatCounter +1
		SubCatCounter2 = SubCatCounter2  +1
		CategoryID(CatCounter,SubCatCounter) = rs("subcatId") 
		CatName(CatCounter,SubCatCounter) = rs("SubCategoryName") 

		SubCategoryIDX(SubCatCounter2) = rs("subcatId") 
		SubCatName(SubCatCounter2) = rs("SubCategoryName") 
		Varieties  = Varieties & """"  & CatName(CatCounter,SubCatCounter)  
		
rs.movenext
If Not(rs.eof) Then 
Varieties  = Varieties  &  """ , " 
End If 
	Wend
	Varieties  = Varieties & """ ]," & vbCrLf
	Else
		If SubCurrentCategoryID > 0  Then
		
		Varieties =  Varieties  & " [""" & SubCurrentCategoryName & """ ]," & vbCrLf
		
		Else
		If firsttime = False Then
			firsttime = True
				Varieties =  Varieties  & " ["" No Sub Categories "" ]," & vbCrLf
					Varieties =  Varieties  & " ["" No Sub Categories "" ]," & vbCrLf
		Else
						Varieties =  Varieties  & " ["" No Sub Categories "" ]," & vbCrLf
		End if
		
		End if
	End If 
wend

FinalSubCatCounter2 = SubCatCounter2
   		FinalSubCatCounter = CatCounter

Varietielen  = Len(Varieties)
'response.write(Varieties)
Varieties = Left(Varieties, (Varietielen-3))
Current3 = "ProductEdit"


%>


 <form action= "membersProductsGeneralStatsHandleForm.asp" method = "post" name="myform"> 

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" >
<tr><td  align = "left" class=body>
<H2>Basic Facts
<br /><font class="body"><font color = "#338333"><b>Required Fields are Shown in Green.</b></font></H2>
  
<% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Product Basic Facts Changes Have Been Made.</b></font></div>
<% end if %>

<input name="Subject" type = "hidden" value = "<%=Subject%>">
<br />
<font color=#338333><b>Product Name</b></font>&nbsp;<br>

<input name="ProdName" value="<%=ProdName %>" size = "60" class = "formbox">
<br /><br />
<a class="tooltip" href="#"><b>Product ID</b><span class="custom info"><em>Product ID</em>The product ID, or SKU, is an identifier that you may choose to use to keep track of your own products.</span></a><br>
<input name="SKU" value="<%=SKU %>" size = "60" class = "formbox"><br>

<br><b><font color=#338333>Categories*</font></b><br />

<iframe src="membersAddProductCategoriesInclude.asp?Category1ID=<%=Category1ID %>&Category2ID=<%=Category2ID %>&Category3ID=<%=Category3ID %>&SubCategory1ID=<%=SubCategory1ID %>&SubCategory2ID=<%=SubCategory2ID %>&SubCategory3ID=<%=SubCategory3ID %>" height = '250' width = '640'  frameborder= '0' seamless = Yes scrolling = no></iframe>


<% LivestockAvailable = "True"


if LivestockAvailable = "True" then 
%>

<% sql2 = "select distinct Animals.ID, Animals.FullName from Animals where peopleid = " & session("AIID") & " order by Fullname"

'response.write("sql2=" & sql2 )
acounter = 1
rs2.Open sql2, connloa, 3, 3 
if not rs2.eof then
While Not rs2.eof  
IDArray(acounter) = rs2("ID")
alpacaName(acounter) = rs2("FullName")
acounter = acounter +1
rs2.movenext
Wend
rs2.close
if len(ProdAnimalID) > 0 then
if ProdAnimalID =  0 then
ProdAnimalID =  ""
end if
end if	

if len(ProdAnimalID) > 0 then
sql2 = "select Animals.FullName from Animals where ID=" & ProdAnimalID
'acounter = 1
rs2.Open sql2, connloa, 3, 3 
if not rs2.eof then
ProdAnimalname = rs2("FullName")
end if
end if
	

set rs2=nothing %>
<br>
<b>Made In</b><br>

 <select name="ProdMadeIn" value="<%=ProdMadeIn%>"  class = "formbox">
    <% if len(ProdMadeIn) > 0 then %>
    <option value="<%=ProdMadeIn %>" selected><%=ProdMadeIn %></option>
    <% else %>
     <option value="" selected></option>
    <% end if %>
    <option value="US">United States of America</option>
    <option value="CA">Canada</option>
    <option value="MX">Mexico</option>
	<option value="AF">Afghanistan</option>
	<option value="AX">Åland Islands</option>
	<option value="AL">Albania</option>
	<option value="DZ">Algeria</option>
	<option value="AS">American Samoa</option>
	<option value="AD">Andorra</option>
	<option value="AO">Angola</option>
	<option value="AI">Anguilla</option>
	<option value="AQ">Antarctica</option>
	<option value="AG">Antigua and Barbuda</option>
	<option value="AR">Argentina</option>
	<option value="AM">Armenia</option>
	<option value="AW">Aruba</option>
	<option value="AU">Australia</option>
	<option value="AT">Austria</option>
	<option value="AZ">Azerbaijan</option>
	<option value="BS">Bahamas</option>
	<option value="BH">Bahrain</option>
	<option value="BD">Bangladesh</option>
	<option value="BB">Barbados</option>
	<option value="BY">Belarus</option>
	<option value="BE">Belgium</option>
	<option value="BZ">Belize</option>
	<option value="BJ">Benin</option>
	<option value="BM">Bermuda</option>
	<option value="BT">Bhutan</option>
	<option value="BO">Bolivia, Plurinational State of</option>
	<option value="BQ">Bonaire, Sint Eustatius and Saba</option>
	<option value="BA">Bosnia and Herzegovina</option>
	<option value="BW">Botswana</option>
	<option value="BV">Bouvet Island</option>
	<option value="BR">Brazil</option>
	<option value="IO">British Indian Ocean Territory</option>
	<option value="BN">Brunei Darussalam</option>
	<option value="BG">Bulgaria</option>
	<option value="BF">Burkina Faso</option>
	<option value="BI">Burundi</option>
	<option value="KH">Cambodia</option>
	<option value="CM">Cameroon</option>
	<option value="CV">Cape Verde</option>
	<option value="KY">Cayman Islands</option>
	<option value="CF">Central African Republic</option>
	<option value="TD">Chad</option>
	<option value="CL">Chile</option>
	<option value="CN">China</option>
	<option value="CX">Christmas Island</option>
	<option value="CC">Cocos (Keeling) Islands</option>
	<option value="CO">Colombia</option>
	<option value="KM">Comoros</option>
	<option value="CG">Congo</option>
	<option value="CD">Congo, the Democratic Republic of the</option>
	<option value="CK">Cook Islands</option>
	<option value="CR">Costa Rica</option>
	<option value="CI">Côte d'Ivoire</option>
	<option value="HR">Croatia</option>
	<option value="CU">Cuba</option>
	<option value="CW">Curaçao</option>
	<option value="CY">Cyprus</option>
	<option value="CZ">Czech Republic</option>
	<option value="DK">Denmark</option>
	<option value="DJ">Djibouti</option>
	<option value="DM">Dominica</option>
	<option value="DO">Dominican Republic</option>
	<option value="EC">Ecuador</option>
	<option value="EG">Egypt</option>
	<option value="SV">El Salvador</option>
	<option value="GQ">Equatorial Guinea</option>
	<option value="ER">Eritrea</option>
	<option value="EE">Estonia</option>
	<option value="ET">Ethiopia</option>
	<option value="FK">Falkland Islands (Malvinas)</option>
	<option value="FO">Faroe Islands</option>
	<option value="FJ">Fiji</option>
	<option value="FI">Finland</option>
	<option value="FR">France</option>
	<option value="GF">French Guiana</option>
	<option value="PF">French Polynesia</option>
	<option value="TF">French Southern Territories</option>
	<option value="GA">Gabon</option>
	<option value="GM">Gambia</option>
	<option value="GE">Georgia</option>
	<option value="DE">Germany</option>
	<option value="GH">Ghana</option>
	<option value="GI">Gibraltar</option>
	<option value="GR">Greece</option>
	<option value="GL">Greenland</option>
	<option value="GD">Grenada</option>
	<option value="GP">Guadeloupe</option>
	<option value="GU">Guam</option>
	<option value="GT">Guatemala</option>
	<option value="GG">Guernsey</option>
	<option value="GN">Guinea</option>
	<option value="GW">Guinea-Bissau</option>
	<option value="GY">Guyana</option>
	<option value="HT">Haiti</option>
	<option value="HM">Heard Island and McDonald Islands</option>
	<option value="VA">Holy See (Vatican City State)</option>
	<option value="HN">Honduras</option>
	<option value="HK">Hong Kong</option>
	<option value="HU">Hungary</option>
	<option value="IS">Iceland</option>
	<option value="IN">India</option>
	<option value="ID">Indonesia</option>
	<option value="IR">Iran, Islamic Republic of</option>
	<option value="IQ">Iraq</option>
	<option value="IE">Ireland</option>
	<option value="IM">Isle of Man</option>
	<option value="IL">Israel</option>
	<option value="IT">Italy</option>
	<option value="JM">Jamaica</option>
	<option value="JP">Japan</option>
	<option value="JE">Jersey</option>
	<option value="JO">Jordan</option>
	<option value="KZ">Kazakhstan</option>
	<option value="KE">Kenya</option>
	<option value="KI">Kiribati</option>
	<option value="KP">Korea, Democratic People's Republic of</option>
	<option value="KR">Korea, Republic of</option>
	<option value="KW">Kuwait</option>
	<option value="KG">Kyrgyzstan</option>
	<option value="LA">Lao People's Democratic Republic</option>
	<option value="LV">Latvia</option>
	<option value="LB">Lebanon</option>
	<option value="LS">Lesotho</option>
	<option value="LR">Liberia</option>
	<option value="LY">Libya</option>
	<option value="LI">Liechtenstein</option>
	<option value="LT">Lithuania</option>
	<option value="LU">Luxembourg</option>
	<option value="MO">Macao</option>
	<option value="MK">Macedonia, the former Yugoslav Republic of</option>
	<option value="MG">Madagascar</option>
	<option value="MW">Malawi</option>
	<option value="MY">Malaysia</option>
	<option value="MV">Maldives</option>
	<option value="ML">Mali</option>
	<option value="MT">Malta</option>
	<option value="MH">Marshall Islands</option>
	<option value="MQ">Martinique</option>
	<option value="MR">Mauritania</option>
	<option value="MU">Mauritius</option>
	<option value="YT">Mayotte</option>
	<option value="FM">Micronesia, Federated States of</option>
	<option value="MD">Moldova, Republic of</option>
	<option value="MC">Monaco</option>
	<option value="MN">Mongolia</option>
	<option value="ME">Montenegro</option>
	<option value="MS">Montserrat</option>
	<option value="MA">Morocco</option>
	<option value="MZ">Mozambique</option>
	<option value="MM">Myanmar</option>
	<option value="NA">Namibia</option>
	<option value="NR">Nauru</option>
	<option value="NP">Nepal</option>
	<option value="NL">Netherlands</option>
	<option value="NC">New Caledonia</option>
	<option value="NZ">New Zealand</option>
	<option value="NI">Nicaragua</option>
	<option value="NE">Niger</option>
	<option value="NG">Nigeria</option>
	<option value="NU">Niue</option>
	<option value="NF">Norfolk Island</option>
	<option value="MP">Northern Mariana Islands</option>
	<option value="NO">Norway</option>
	<option value="OM">Oman</option>
	<option value="PK">Pakistan</option>
	<option value="PW">Palau</option>
	<option value="PS">Palestinian Territory, Occupied</option>
	<option value="PA">Panama</option>
	<option value="PG">Papua New Guinea</option>
	<option value="PY">Paraguay</option>
	<option value="PE">Peru</option>
	<option value="PH">Philippines</option>
	<option value="PN">Pitcairn</option>
	<option value="PL">Poland</option>
	<option value="PT">Portugal</option>
	<option value="PR">Puerto Rico</option>
	<option value="QA">Qatar</option>
	<option value="RE">Réunion</option>
	<option value="RO">Romania</option>
	<option value="RU">Russian Federation</option>
	<option value="RW">Rwanda</option>
	<option value="BL">Saint Barthélemy</option>
	<option value="SH">Saint Helena, Ascension and Tristan da Cunha</option>
	<option value="KN">Saint Kitts and Nevis</option>
	<option value="LC">Saint Lucia</option>
	<option value="MF">Saint Martin (French part)</option>
	<option value="PM">Saint Pierre and Miquelon</option>
	<option value="VC">Saint Vincent and the Grenadines</option>
	<option value="WS">Samoa</option>
	<option value="SM">San Marino</option>
	<option value="ST">Sao Tome and Principe</option>
	<option value="SA">Saudi Arabia</option>
	<option value="SN">Senegal</option>
	<option value="RS">Serbia</option>
	<option value="SC">Seychelles</option>
	<option value="SL">Sierra Leone</option>
	<option value="SG">Singapore</option>
	<option value="SX">Sint Maarten (Dutch part)</option>
	<option value="SK">Slovakia</option>
	<option value="SI">Slovenia</option>
	<option value="SB">Solomon Islands</option>
	<option value="SO">Somalia</option>
	<option value="ZA">South Africa</option>
	<option value="GS">South Georgia and the South Sandwich Islands</option>
	<option value="SS">South Sudan</option>
	<option value="ES">Spain</option>
	<option value="LK">Sri Lanka</option>
	<option value="SD">Sudan</option>
	<option value="SR">Suriname</option>
	<option value="SJ">Svalbard and Jan Mayen</option>
	<option value="SZ">Swaziland</option>
	<option value="SE">Sweden</option>
	<option value="CH">Switzerland</option>
	<option value="SY">Syrian Arab Republic</option>
	<option value="TW">Taiwan, Province of China</option>
	<option value="TJ">Tajikistan</option>
	<option value="TZ">Tanzania, United Republic of</option>
	<option value="TH">Thailand</option>
	<option value="TL">Timor-Leste</option>
	<option value="TG">Togo</option>
	<option value="TK">Tokelau</option>
	<option value="TO">Tonga</option>
	<option value="TT">Trinidad and Tobago</option>
	<option value="TN">Tunisia</option>
	<option value="TR">Turkey</option>
	<option value="TM">Turkmenistan</option>
	<option value="TC">Turks and Caicos Islands</option>
	<option value="TV">Tuvalu</option>
	<option value="UG">Uganda</option>
	<option value="UA">Ukraine</option>
	<option value="AE">United Arab Emirates</option>
	<option value="GB">United Kingdom</option>
	<option value="UM">United States Minor Outlying Islands</option>
	<option value="UY">Uruguay</option>
	<option value="UZ">Uzbekistan</option>
	<option value="VU">Vanuatu</option>
	<option value="VE">Venezuela, Bolivarian Republic of</option>
	<option value="VN">Viet Nam</option>
	<option value="VG">Virgin Islands, British</option>
	<option value="VI">Virgin Islands, U.S.</option>
	<option value="WF">Wallis and Futuna</option>
	<option value="EH">Western Sahara</option>
	<option value="YE">Yemen</option>
	<option value="ZM">Zambia</option>
	<option value="ZW">Zimbabwe</option>
</select>
<br /><br>

<a class="tooltip" href="#"><b>From Animal</b><span class="custom info"><em>From Animal</em>If this product was made from one of your animals (usually their fiber/wool) then select the animal and a link will connect the product and animal on your website.</span></a><br>



<select size="1" name="ProdAnimalID" class = "formbox body">
<% 
if len(ProdAnimalID) > 0 then %>
<option name = "AID0" value= "<%=ProdAnimalID %>" selected><%=ProdAnimalname  %></option>
<option name = "AID0" value= "" >N/A</option>
<% else %>
<option name = "AID0" value= "" selected>N/A</option>
<% end if %>

<% count = 1
while count < acounter %>
<option name = "AID1" value="<%=IDArray(count)%>">
<%=alpacaName(count)%>
</option>
<% 	count = count + 1
wend %>
</select><br />
<br />

<% end if %>
<% end if %>




<br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" >
<tr><td class = " body" align = "center" height = "100" width = "100%" valign = "top"><br />
<H3>Materials or Ingredients</H3>
<i><font color = "#404040">List the different materials used in the creation of your product and the percent composition if appropriate (i.e. a silk and wool sweater may be 67% wool and 33% silk.)</font></i>
<table border = "0" width = "480" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
<tr><td class = "body2" align = "center" width = "100"></td>
<td class = "body2" align = "center" width = "300"><b>Type</b></td>
<td class = "body" align = "left" width = "80"><b>Percent</b></td>
</tr>
<tr><td class = "body2"  align = "right" width = "90">
Material:</td>
<td class = "body" ><input type=text name='ProdFiberType1' size=40 maxlength=60 value="<%=ProdFiberType1 %>"></td>
<td>
<input type=text name='prodFiberPercent1' size=2 maxlength=4 value="<%=prodFiberPercent1 %>" onBlur="checkNumeric(this,-5,5000,',','.','-');">%
</td></tr>
<tr><td class = "body2"  align = "right" width = "90">
Material:</td>
<td class = "body"><input type=text name='ProdFiberType2' size=40 maxlength=60 value="<%=ProdFiberType2 %>"></td>
<td>
<input type=text name='prodFiberPercent2' size=2 maxlength=4 value="<%=prodFiberPercent2 %>" onBlur="checkNumeric(this,-5,5000,',','.','-');">%
</td></tr>
<tr><td class = "body2"  align = "right" width = "90">
Material:</td>
<td class = "body"><input type=text name='ProdFiberType3' size=40 maxlength=60 value="<%=ProdFiberType3 %>"></td>
<td>
<input type=text name='prodFiberPercent3' size=2 maxlength=4 value="<%=prodFiberPercent3 %>" onBlur="checkNumeric(this,-5,5000,',','.','-');">%
</td></tr>
<tr><td class = "body2"  align = "right" width = "90">
Material:</td>
<td class = "body"><input type=text name='ProdFiberType4' size=40 maxlength=60 value="<%=ProdFiberType4 %>"></td>
<td>
<input type=text name='prodFiberPercent4' size=2 maxlength=4 value="<%=prodFiberPercent4 %>" onBlur="checkNumeric(this,-5,5000,',','.','-');">%
</td></tr>
<tr><td class = "body2"  align = "right" width = "90">
Material:</td>
<td class = "body"><input type=text name='ProdFiberType5' size=40 maxlength=60 value="<%=ProdFiberType5 %>"></td>
<td>
<input type=text name='prodFiberPercent5' size=2 maxlength=4 value="<%=prodFiberPercent5 %>" onBlur="checkNumeric(this,-5,5000,',','.','-');">%
</td></tr>
</table>
</td></tr>
<tr><td>
<br />
 <input name="ProdID" value="<%=ProdID%>" type = hidden>
<div align = "right"><input type=submit name= "button1" value = "SUBMIT BASIC FACTS" class = "regsubmit2"  <%=Disablebutton %> ></div>
</td></tr>
</table>
</td></tr>
</table>
</form>
</body>
</html>
