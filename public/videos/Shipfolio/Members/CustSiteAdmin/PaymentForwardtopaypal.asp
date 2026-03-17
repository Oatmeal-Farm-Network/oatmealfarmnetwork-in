<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
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

rowcount =1
itemcount = 1
%>
<form action="https://www.paypal.com/cgi-bin/webscr" method="POST" >
<input type="hidden" name="cmd" value="_cart">
<input type="hidden" name="business" value="<%=PaypalEmail%>">
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
<input type="hidden" name="upload" value="1">
<input type="hidden" name="item_name_<%=itemcount %>" value="<%=tempprodname %>">
<input type="hidden" name="quantity_<%=itemcount %>" value = <%=Quantity(rowcount) %>>
<input type="hidden" name="color_<%=itemcount %>" value = <%=color(rowcount) %>>
<input type="hidden" name="amount_<%=itemcount %>" value="<%=totalprice(rowcount) %>">


<table border = "0" cellpadding = "5" cellspacing = "5" width = "515" align = "center" >
  <tr>
  <td valign = "top" align = "center">
  <table border = "0" cellpadding = "0" cellspacing = "0" width = "515">
  <tr>
  <td height = "50" valign = "top" class = "tableborder">
  <table border = "0" cellpadding = "15" cellspacing = "0" width = "500"><tr><td>
  <h1><div align = "left"><big>CHECKOUT</big></div></h1>
  </td></tr>  </table>
  </td>
  </tr>
  <TR>
    <TD ALIGN = "CENTER" class = "roundedtopandbottom">

<form  name="orderform" method="post" action="CheckoutPage2.asp?existing=true&odrdttmpSessionID=<%=odrdttmpSessionID%>">
<table border = "0" width = "500" align = "center"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=5>
<tr>
  <td class = "body" colspan = "2" >
  <h2>Existing Customer?</h2>
  If you have shopped with us in the past, please enter your Email address below: 
  </td>
</tr>
<tr>
		<td   class = "body" align = "right"  valign = "top">
			Email: &nbsp;
			<input name="Email"  size = "45" value = "<%=Email%>"><br>
			</td>
  <td class = "body" colspan = "2" align = "right">
 <div align = "right"><INPUT TYPE="submit" value="Submit" class = "regsubmit2"></div></td>
</tr>
</table>
</form>
</td>
</tr>
<tr><td>

<br />


<br />
<table border = "0" bordercolor = "#abacab" width = "500" align = "center"   cellpadding=0 cellspacing=0 class = "roundedtopandbottom">
  <TR>
    <TD ALIGN = "CENTER">
   	 <table border = "0" bordercolor = "#abacab" width = "500" align = "center" cellpadding=0 cellspacing=0>
   	 		  <tr><td height = "10" colspan = "2"><img src = "images/px.gif"></td></tr>
	<tr>
		<td class = "body" colspan = "2" >
		<H2>Contact Information</H2>
				<font class = "small" color = "grey">(* Indicates Required Fields)</font>
<!-- Example begin -->
<form  name="ME" method="post" action="CheckoutPage3.asp?existing=true&odrdttmpSessionID=<%=odrdttmpSessionID%>">
</td></tr>
<% if len(Message) > 10 then %><br>

<font color = "red">
<b><%=Message%></b>
</font>
<% end if %>
		</td>
	</tr>
	
<tr>
    <td class = "body2" align = "right" valign = "top">First Name: &nbsp;</td>
    <td class = "small"><input type="text" name="custFirstName" value="<%=custFirstName %>"size="30" maxlength="40"><br>
    <font color= "grey"></font>
    
    </td>
  </tr> 
  <tr>
    <td class = "body2" align = "right" valign = "top">Last Name:  &nbsp;</td>
    <td class = "small"><input type="text" name="custLastName" value="<%=custLastName %>" size="30" maxlength="40"><br>
</td>
  </tr>
  <tr>    
    <td class = "body2" align = "right">Phone Number:  &nbsp;</td>
    <td><input type="text" name="custPhone" value="<%=custPhone %>" size="30" maxlength="40">
   </td>
  </tr> 

<tr>    
<td class = "body2" colspan = "2">
<H2>Billing Information</H2>
</td>
</tr>
  <tr>    
  <td class = "body2" align = "right">Email: &nbsp;</td>
    <td>
        <input type="text" name="Email" value="<%=Email %>">
</td></tr>
  <tr>    
  <td class = "body2" align = "right">Street:* &nbsp;</td>
    <td>
        <input type="text" name="Address1" value="<%=Address1 %>">
</td></tr>
  <tr>    
  <td class = "body2" align = "right"> &nbsp;</td>
    <td>
        <input type="text" name="Address2" value="<%=Address2 %>">
</td></tr>
  <tr>    
  <td class = "body2" align = "right">City:* &nbsp;</td>
    <td>
        <input type="text" name="city" value="<%=city %>">
</td></tr>
  <tr>    
  <td class = "body2" align = "right">State / Province:* &nbsp;</td>
    <td>
        <input type="text" name="state" value="<%=state %>">
</td></tr>
  <tr>    
  <td class = "body2" align = "right">Postal Code:* &nbsp;</td>
    <td>
        <input type="text" name="zip" value="<%=zip %>">
</td>
</tr>
<tr>     
 <td class = "body2" align = "right"><b>Country:*</b> &nbsp;</td>
<td class = "small">
<select size="1" name="country">
<% If Len(country) > 0 then%>
<option value="<%=country%>" selected><%=country%></option>
<% Else %>
<option value="" selected>-----</option>
<% End If %>
<option value="US">United States</option>
<option value="CA">Canada</option>			
<option value="AF">Afghanistan</option>
<option value="AX">ALand Islands</option>
<option value="AL">Albania</option>
<option value="DZ">Algeria</option>
<option value="AS">American Samoa</option>
<option value="AD">Andorra</option>
<option value="AO">Angola</option>
<option value="AI">Anguilla</option>
<option value="AQ">Antarctica</option>
<option value="AG">Antigua And Barbuda</option>
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
<option value="BO">Bolivia</option>
<option value="BA">Bosnia And Herzegovina</option>
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
<option value="CA">Canada</option>
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
<option value="CD">Congo, The Democratic Republic Of The</option>
<option value="CK">Cook Islands</option>
<option value="CR">Costa Rica</option>
<option value="CI">Cote D'Ivoire</option>
<option value="HR">Croatia</option>
<option value="CU">Cuba</option>
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
<option value=" Gg">Guernsey</option>
<option value="GN">Guinea</option>
<option value="GW">Guinea-Bissau</option>
<option value="GY">Guyana</option>
<option value="HT">Haiti</option>
<option value="HM">Heard Island And Mcdonald Islands</option>
<option value="VA">Holy See (Vatican City State)</option>
<option value="HN">Honduras</option>
<option value="HK">Hong Kong</option>
<option value="HU">Hungary</option>
<option value="IS">Iceland</option>
<option value="IN">India</option>
<option value="ID">Indonesia</option>
<option value="IR">Iran, Islamic Republic Of</option>
<option value="IQ">Iraq</option>
<option value="IE">Ireland</option>
<option value="IM">Isle Of Man</option>
<option value="IL">Israel</option>
<option value="IT">Italy</option>
<option value="JM">Jamaica</option>
<option value="JP">Japan</option>
<option value="JE">Jersey</option>
<option value="JO">Jordan</option>
<option value="KZ">Kazakhstan</option>
<option value="KE">Kenya</option>
<option value="KI">Kiribati</option>
<option value="KP">Korea, Democratic People'S Republic Of</option>
<option value="KR">Korea, Republic Of</option>
<option value="KW">Kuwait</option>
<option value="KG">Kyrgyzstan</option>
<option value="LA">Lao People'S Democratic Republic</option>
<option value="LV">Latvia</option>
<option value="LB">Lebanon</option>
<option value="LS">Lesotho</option>
<option value="LR">Liberia</option>
<option value="LY">Libyan Arab Jamahiriya</option>
<option value="LI">Liechtenstein</option>
<option value="LT">Lithuania</option>
<option value="LU">Luxembourg</option>
<option value="MO">Macao</option>
<option value="MK">Macedonia, The Former Yugoslav Republic Of</option>
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
<option value="MX">Mexico</option>
<option value="FM">Micronesia, Federated States Of</option>
<option value="MD">Moldova, Republic Of</option>
<option value="MC">Monaco</option>
<option value="MN">Mongolia</option>
<option value="MS">Montserrat</option>
<option value="MA">Morocco</option>
<option value="MZ">Mozambique</option>
<option value="MM">Myanmar</option>
<option value="NA">Namibia</option>
<option value="NR">Nauru</option>
<option value="NP">Nepal</option>
<option value="NL">Netherlands</option>
<option value="AN">Netherlands Antilles</option>
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
<option value="RE">Reunion</option>
<option value="RO">Romania</option>
<option value="RU">Russian Federation</option>
<option value="RW">Rwanda</option>
<option value="SH">Saint Helena</option>
<option value="KN">Saint Kitts And Nevis</option>
<option value="LC">Saint Lucia</option>
<option value="PM">Saint Pierre And Miquelon</option>
<option value="VC">Saint Vincent And The Grenadines</option>
<option value="WS">Samoa</option>
<option value="SM">San Marino</option>
<option value="ST">Sao Tome And Principe</option>
<option value="SA">Saudi Arabia</option>
<option value="SN">Senegal</option>
<option value="CS">Serbia And Montenegro</option>
<option value="SC">Seychelles</option>
<option value="SL">Sierra Leone</option>
<option value="SG">Singapore</option>
<option value="SK">Slovakia</option>
<option value="SI">Slovenia</option>
<option value="SB">Solomon Islands</option>
<option value="SO">Somalia</option>
<option value="ZA">South Africa</option>
<option value="GS">South Georgia And The South Sandwich Islands</option>
<option value="ES">Spain</option>
<option value="LK">Sri Lanka</option>
<option value="SD">Sudan</option>
<option value="SR">Suriname</option>
<option value="SJ">Svalbard And Jan Mayen</option>
<option value="SZ">Swaziland</option>
<option value="SE">Sweden</option>
<option value="CH">Switzerland</option>
<option value="SY">Syrian Arab Republic</option>
<option value="TW">Taiwan, Province Of China</option>
<option value="TJ">Tajikistan</option>
<option value="TZ">Tanzania, United Republic Of</option>
<option value="TH">Thailand</option>
<option value="TL">Timor-Leste</option>
<option value="TG">Togo</option>
<option value="TK">Tokelau</option>
<option value="TO">Tonga</option>
<option value="TT">Trinidad And Tobago</option>
<option value="TN">Tunisia</option>
<option value="TR">Turkey</option>
<option value="TM">Turkmenistan</option>
<option value="TC">Turks And Caicos Islands</option>
<option value="TV">Tuvalu</option>
<option value="UG">Uganda</option>
<option value="UA">Ukraine</option>
<option value="AE">United Arab Emirates</option>
<option value="GB">United Kingdom</option>
<option value="US">United States</option>
<option value="UM">United States Minor Outlying Islands</option>
<option value="UY">Uruguay</option>
<option value="UZ">Uzbekistan</option>
<option value="VU">Vanuatu</option>
<option value="VE">Venezuela</option>
<option value="VN">Viet Nam</option>
<option value="VG">Virgin Islands, British</option>
<option value="VI">Virgin Islands, U.S.</option>
<option value="WF">Wallis And Futuna</option>
<option value="EH">Western Sahara</option>
<option value="YE">Yemen</option>
<option value="ZM">Zambia</option>
<option value="ZW">Zimbabwe</option>
</select>
<br>
</td></tr>

    
<input type="image" src="http://www.paypal.com/en_US/i/btn/x-click-but01.gif" name="submit" alt="Make payments with PayPal - it's fast, free and secure!">

</td></tr>
</table>

	</form>


<% 
itemcount = itemcount + 1
end if
rowcount= rowcount +1
Wend

if foundorder = false then
response.redirect("ProductDetails.asp?prodid=" & ProdID & "&Noqty=True" )
end if
%>
</form>
<% test = True
if test = false then %>
 <SCRIPT LANGUAGE="JavaScript">document.forms[0].submit();</SCRIPT>
<% end if %>
</Body>
</HTML>

