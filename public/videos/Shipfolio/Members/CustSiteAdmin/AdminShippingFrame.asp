<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="style.css">
<% administration = True %>
<!--#Include virtual="/Conn.asp"-->
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


</head>
<body >
<% Set rsA = Server.CreateObject("ADODB.Recordset")

screenwidth = request.querystring("screenwidth")

ProdID = request.QueryString("ProdID")
ServicesID= request.QueryString("ServicesID")
AddSendToCountry = request.Form("AddSendToCountry")
ShippingCost1= request.Form("ShippingCost1")
Update=request.QueryString("Update")

ShippingCost2= request.Form("ShippingCost2")
ShipID = request.Form("ShipID")

Delete=request.querystring("Delete")




Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = 'United States of America'" 
'response.write("Query=" & Query )
rsA.Open Query, conn, 3, 3  
If not rsA.eof Then

else
Query =  "INSERT INTO sfshipping (ProdID, ShippingToCountry)"  
 Query =  Query & " Values (" &  ProdID & ", 'United States of America' )"

Conn.Execute(Query) 

end if 
rsA.close

Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = 'Canada'" 

rsA.Open Query, conn, 3, 3  
If not rsA.eof Then
else
Query =  "INSERT INTO sfshipping (ProdID, ShippingToCountry)"  
 Query =  Query & " Values (" &  ProdID & ", 'Canada' )"
'response.write("Query=" & Query )
Conn.Execute(Query) 

end if 
rsA.close

Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = 'Mexico'" 

rsA.Open Query, conn, 3, 3  
If not rsA.eof Then

else
Query =  "INSERT INTO sfshipping (ProdID, ShippingToCountry)"  
 Query =  Query & " Values (" &  ProdID & ", 'Mexico' )"
'response.write("Query=" & Query )
Conn.Execute(Query) 

end if 
rsA.close

Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = 'Other'" 

rsA.Open Query, conn, 3, 3  
If not rsA.eof Then

else
Query =  "INSERT INTO sfshipping (ProdID, ShippingToCountry)"  
 Query =  Query & " Values (" &  ProdID & ", 'Other' )"
'response.write("Query=" & Query )
Conn.Execute(Query) 

end if 
rsA.close



sqlA= "select AdministrationID from SiteDesign"
rsA.Open sqlA, conn, 3, 3   
If Not rsA.eof Then
AdministrationID = rsA("AdministrationID")
end if
rsA.close

sqlA= "select * from Administration where AdministrationID =" & AdministrationID 
rsA.Open sqlA, conn, 3, 3   
If Not rsA.eof Then
AdminHeaderImage = rsA("AdminHeaderImage")
AdminAuthor = rsA("AdminAuthor")
AdminTitle= rsA("AdminTitle")
Admincurrency= rsA("Admincurrency")
Admindateformat= rsA("Admindateformat")
Copyrightname= rsA("Copyrightname")
CopyrightLink= rsA("CopyrightLink")
Currencycode=rsA("AdminCurrencyCode")
PaypalCurrencyCode = rsA("PaypalCurrencyCode")
SetLocale(rsA("LocalCode"))
End If 
rsA.close

 

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
   'response.Redirect("AdminShippingFrame.asp?ProdID=" & ProdID & "&Update=True" )
else
   'response.Redirect("AdminShippingFrame.asp?ServicesID=" & ServicesID & "&Update=True"  )
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
    'response.Redirect("AdminShippingFrame.asp?ProdID=" & ProdID & "&Update=True"  )
else
    'response.Redirect("AdminShippingFrame.asp?ServicesID=" & ServicesID & "&Update=True"  )
end if
end if

if len(AddSendToCountry) > 0 then
if len(ProdID)> 0 then
    Query =  "INSERT INTO sfshipping (ProdID, ShippingToCountry)"  
    Query =  Query & " Values (" &  prodID & ", '" & AddSendToCountry & "' )"
 ELSE
 Query =  "INSERT INTO sfshipping (ServicesID, ShippingToCountry)"  
    Query =  Query & " Values (" &  ServicesID & ", '" & AddSendToCountry & "' )"
end if
Conn.Execute(Query) 

end if

if len(ProdID)> 0 then
sql = "select * from sfShipping where ProdID=" & ProdID
else
sql = "select * from sfShipping where ServicesID=" & ServicesID
end if
		
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
 if rs.eof then 
 
 if len(ProdID)> 0 then 
Query =  "INSERT INTO sfshipping (ProdID)"  
Query =  Query & " Values (" &  prodID & ")"
else
Query =  "INSERT INTO sfshipping (ServicesID)"  
Query =  Query & " Values (" &  ServicesID & ")"
end if

Conn.Execute(Query) 

rs.close
end if


%>

<a name="Top"></a>
<table width = "100%" border =0 cellpadding = 0 cellspacing = 0>
<tr><td class = "body" colspan = "6">
<% if Update = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Shipping Changes Have Been Made.</b></font></div>
<% end if %>



<% showaddcountry = false
if showaddcountry = True then%>


<% if len(ProdID)> 0 then %>
<form method="POST" action="AdminShippingFrame.asp?prodid=<%= Prodid %>" >
<% else %>
<form method="POST" action="AdminShippingFrame.asp?Servicesid=<%= Servicesid %>" >
<% end if %>
<b>Add Location:</b>  
<select name="AddSendToCountry" onchange="submit();">
<option value="">Select a Country That You Ship To</option>
<option value="United States of America">United States of America</option>
<option value="Afganistan">Afghanistan</option>
<option value="Albania">Albania</option>
<option value="Algeria">Algeria</option>
<option value="American Samoa">American Samoa</option>
<option value="Andorra">Andorra</option>
<option value="Angola">Angola</option>
<option value="Anguilla">Anguilla</option>
<option value="Antigua &amp; Barbuda">Antigua &amp; Barbuda</option>
<option value="Argentina">Argentina</option>
<option value="Armenia">Armenia</option>
<option value="Aruba">Aruba</option>
<option value="Australia">Australia</option>
<option value="Austria">Austria</option>
<option value="Azerbaijan">Azerbaijan</option>
<option value="Bahamas">Bahamas</option>
<option value="Bahrain">Bahrain</option>
<option value="Bangladesh">Bangladesh</option>
<option value="Barbados">Barbados</option>
<option value="Belarus">Belarus</option>
<option value="Belgium">Belgium</option>
<option value="Belize">Belize</option>
<option value="Benin">Benin</option>
<option value="Bermuda">Bermuda</option>
<option value="Bhutan">Bhutan</option>
<option value="Bolivia">Bolivia</option>
<option value="Bonaire">Bonaire</option>
<option value="Bosnia &amp; Herzegovina">Bosnia &amp; Herzegovina</option>
<option value="Botswana">Botswana</option>
<option value="Brazil">Brazil</option>
<option value="British Indian Ocean Ter">British Indian Ocean Ter</option>
<option value="Brunei">Brunei</option>
<option value="Bulgaria">Bulgaria</option>
<option value="Burkina Faso">Burkina Faso</option>
<option value="Burundi">Burundi</option>
<option value="Cambodia">Cambodia</option>
<option value="Cameroon">Cameroon</option>
<option value="Canada">Canada</option>
<option value="Canary Islands">Canary Islands</option>
<option value="Cape Verde">Cape Verde</option>
<option value="Cayman Islands">Cayman Islands</option>
<option value="Central African Republic">Central African Republic</option>
<option value="Chad">Chad</option>
<option value="Channel Islands">Channel Islands</option>
<option value="Chile">Chile</option>
<option value="China">China</option>
<option value="Christmas Island">Christmas Island</option>
<option value="Cocos Island">Cocos Island</option>
<option value="Colombia">Colombia</option>
<option value="Comoros">Comoros</option>
<option value="Congo">Congo</option>
<option value="Cook Islands">Cook Islands</option>
<option value="Costa Rica">Costa Rica</option>
<option value="Cote DIvoire">Cote D'Ivoire</option>
<option value="Croatia">Croatia</option>
<option value="Cuba">Cuba</option>
<option value="Curaco">Curacao</option>
<option value="Cyprus">Cyprus</option>
<option value="Czech Republic">Czech Republic</option>
<option value="Denmark">Denmark</option>
<option value="Djibouti">Djibouti</option>
<option value="Dominica">Dominica</option>
<option value="Dominican Republic">Dominican Republic</option>
<option value="East Timor">East Timor</option>
<option value="Ecuador">Ecuador</option>
<option value="Egypt">Egypt</option>
<option value="El Salvador">El Salvador</option>
<option value="Equatorial Guinea">Equatorial Guinea</option>
<option value="Eritrea">Eritrea</option>
<option value="Estonia">Estonia</option>
<option value="Ethiopia">Ethiopia</option>
<option value="Falkland Islands">Falkland Islands</option>
<option value="Faroe Islands">Faroe Islands</option>
<option value="Fiji">Fiji</option>
<option value="Finland">Finland</option>
<option value="France">France</option>
<option value="French Guiana">French Guiana</option>
<option value="French Polynesia">French Polynesia</option>
<option value="French Southern Ter">French Southern Ter</option>
<option value="Gabon">Gabon</option>
<option value="Gambia">Gambia</option>
<option value="Georgia">Georgia</option>
<option value="Germany">Germany</option>
<option value="Ghana">Ghana</option>
<option value="Gibraltar">Gibraltar</option>
<option value="Great Britain">Great Britain</option>
<option value="Greece">Greece</option>
<option value="Greenland">Greenland</option>
<option value="Grenada">Grenada</option>
<option value="Guadeloupe">Guadeloupe</option>
<option value="Guam">Guam</option>
<option value="Guatemala">Guatemala</option>
<option value="Guinea">Guinea</option>
<option value="Guyana">Guyana</option>
<option value="Haiti">Haiti</option>
<option value="Hawaii">Hawaii</option>
<option value="Honduras">Honduras</option>
<option value="Hong Kong">Hong Kong</option>
<option value="Hungary">Hungary</option>
<option value="Iceland">Iceland</option>
<option value="India">India</option>
<option value="Indonesia">Indonesia</option>
<option value="Iran">Iran</option>
<option value="Iraq">Iraq</option>
<option value="Ireland">Ireland</option>
<option value="Isle of Man">Isle of Man</option>
<option value="Israel">Israel</option>
<option value="Italy">Italy</option>
<option value="Jamaica">Jamaica</option>
<option value="Japan">Japan</option>
<option value="Jordan">Jordan</option>
<option value="Kazakhstan">Kazakhstan</option>
<option value="Kenya">Kenya</option>
<option value="Kiribati">Kiribati</option>
<option value="Korea North">Korea North</option>
<option value="Korea Sout">Korea South</option>
<option value="Kuwait">Kuwait</option>
<option value="Kyrgyzstan">Kyrgyzstan</option>
<option value="Laos">Laos</option>
<option value="Latvia">Latvia</option>
<option value="Lebanon">Lebanon</option>
<option value="Lesotho">Lesotho</option>
<option value="Liberia">Liberia</option>
<option value="Libya">Libya</option>
<option value="Liechtenstein">Liechtenstein</option>
<option value="Lithuania">Lithuania</option>
<option value="Luxembourg">Luxembourg</option>
<option value="Macau">Macau</option>
<option value="Macedonia">Macedonia</option>
<option value="Madagascar">Madagascar</option>
<option value="Malaysia">Malaysia</option>
<option value="Malawi">Malawi</option>
<option value="Maldives">Maldives</option>
<option value="Mali">Mali</option>
<option value="Malta">Malta</option>
<option value="Marshall Islands">Marshall Islands</option>
<option value="Martinique">Martinique</option>
<option value="Mauritania">Mauritania</option>
<option value="Mauritius">Mauritius</option>
<option value="Mayotte">Mayotte</option>
<option value="Mexico">Mexico</option>
<option value="Midway Islands">Midway Islands</option>
<option value="Moldova">Moldova</option>
<option value="Monaco">Monaco</option>
<option value="Mongolia">Mongolia</option>
<option value="Montserrat">Montserrat</option>
<option value="Morocco">Morocco</option>
<option value="Mozambique">Mozambique</option>
<option value="Myanmar">Myanmar</option>
<option value="Nambia">Nambia</option>
<option value="Nauru">Nauru</option>
<option value="Nepal">Nepal</option>
<option value="Netherland Antilles">Netherland Antilles</option>
<option value="Netherlands">Netherlands (Holland, Europe)</option>
<option value="Nevis">Nevis</option>
<option value="New Caledonia">New Caledonia</option>
<option value="New Zealand">New Zealand</option>
<option value="Nicaragua">Nicaragua</option>
<option value="Niger">Niger</option>
<option value="Nigeria">Nigeria</option>
<option value="Niue">Niue</option>
<option value="Norfolk Island">Norfolk Island</option>
<option value="Norway">Norway</option>
<option value="Oman">Oman</option>
<option value="Pakistan">Pakistan</option>
<option value="Palau Island">Palau Island</option>
<option value="Palestine">Palestine</option>
<option value="Panama">Panama</option>
<option value="Papua New Guinea">Papua New Guinea</option>
<option value="Paraguay">Paraguay</option>
<option value="Peru">Peru</option>
<option value="Phillipines">Philippines</option>
<option value="Pitcairn Island">Pitcairn Island</option>
<option value="Poland">Poland</option>
<option value="Portugal">Portugal</option>
<option value="Puerto Rico">Puerto Rico</option>
<option value="Qatar">Qatar</option>
<option value="Republic of Montenegro">Republic of Montenegro</option>
<option value="Republic of Serbia">Republic of Serbia</option>
<option value="Reunion">Reunion</option>
<option value="Romania">Romania</option>
<option value="Russia">Russia</option>
<option value="Rwanda">Rwanda</option>
<option value="St Barthelemy">St Barthelemy</option>
<option value="St Eustatius">St Eustatius</option>
<option value="St Helena">St Helena</option>
<option value="St Kitts-Nevis">St Kitts-Nevis</option>
<option value="St Lucia">St Lucia</option>
<option value="St Maarten">St Maarten</option>
<option value="St Pierre &amp; Miquelon">St Pierre &amp; Miquelon</option>
<option value="St Vincent &amp; Grenadines">St Vincent &amp; Grenadines</option>
<option value="Saipan">Saipan</option>
<option value="Samoa">Samoa</option>
<option value="Samoa American">Samoa American</option>
<option value="San Marino">San Marino</option>
<option value="Sao Tome &amp; Principe">Sao Tome &amp; Principe</option>
<option value="Saudi Arabia">Saudi Arabia</option>
<option value="Senegal">Senegal</option>
<option value="Serbia">Serbia</option>
<option value="Seychelles">Seychelles</option>
<option value="Sierra Leone">Sierra Leone</option>
<option value="Singapore">Singapore</option>
<option value="Slovakia">Slovakia</option>
<option value="Slovenia">Slovenia</option>
<option value="Solomon Islands">Solomon Islands</option>
<option value="Somalia">Somalia</option>
<option value="South Africa">South Africa</option>
<option value="Spain">Spain</option>
<option value="Sri Lanka">Sri Lanka</option>
<option value="Sudan">Sudan</option>
<option value="Suriname">Suriname</option>
<option value="Swaziland">Swaziland</option>
<option value="Sweden">Sweden</option>
<option value="Switzerland">Switzerland</option>
<option value="Syria">Syria</option>
<option value="Tahiti">Tahiti</option>
<option value="Taiwan">Taiwan</option>
<option value="Tajikistan">Tajikistan</option>
<option value="Tanzania">Tanzania</option>
<option value="Thailand">Thailand</option>
<option value="Togo">Togo</option>
<option value="Tokelau">Tokelau</option>
<option value="Tonga">Tonga</option>
<option value="Trinidad &amp; Tobago">Trinidad &amp; Tobago</option>
<option value="Tunisia">Tunisia</option>
<option value="Turkey">Turkey</option>
<option value="Turkmenistan">Turkmenistan</option>
<option value="Turks &amp; Caicos Is">Turks &amp; Caicos Is</option>
<option value="Tuvalu">Tuvalu</option>
<option value="Uganda">Uganda</option>
<option value="Ukraine">Ukraine</option>
<option value="United Arab Erimates">United Arab Emirates</option>
<option value="United Kingdom">United Kingdom</option>
<option value="Uraguay">Uruguay</option>
<option value="Uzbekistan">Uzbekistan</option>
<option value="Vanuatu">Vanuatu</option>
<option value="Vatican City State">Vatican City State</option>
<option value="Venezuela">Venezuela</option>
<option value="Vietnam">Vietnam</option>
<option value="Virgin Islands (Brit)">Virgin Islands (Brit)</option>
<option value="Virgin Islands (USA)">Virgin Islands (USA)</option>
<option value="Wake Island">Wake Island</option>
<option value="Wallis &amp; Futana Is">Wallis &amp; Futana Is</option>
<option value="Yemen">Yemen</option>
<option value="Zaire">Zaire</option>
<option value="Zambia">Zambia</option>
<option value="Zimbabwe">Zimbabwe</option>
</select></form><font color = "#777777">When you add a location, it will automatically be added to your list below:</font></td> </tr>

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
<% 
if len(ProdId)> 0 then
sql = "select * from sfShipping where ProdID=" & ProdID & " order by ShippingCost1 desc"
else
sql = "select * from sfShipping where ServicesID=" & ServicesID & " order by ShippingCost1"
end if
	
	
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 

while not rs.eof
if len(rs("ShippingToCountry")) > 0 then
%>
<% if len(ProdId)> 0 then %>
<form method="POST" action="AdminShippingFrame.asp?prodid=<%= Prodid %>&Update=True" > 
<% else %>
<form method="POST" action="AdminShippingFrame.asp?Servicesid=<%= Servicesid %>&Update=True" > 
<% end if %>
<tr><td class = "body">&nbsp;&nbsp;<b><%=rs("ShippingToCountry") %></b>
<input name="shipID" value="<%=rs("shipID") %>" type = "hidden">
</td><td class = "body" align = 'center' ><center>$<input name="ShippingCost1" value="<%=rs("ShippingCost1")%>" size = "4" type = "text" ></center></td>
<% if showwithanotherproduct  = True then %>
<td class = "body" align = 'center'><center>$<input name="ShippingCost2" value="<%=rs("ShippingCost2") %>" size = "4" type = "text" ></center></td>
<% end if %>

<td>
  <input type=submit value = "SUBMIT" class = "regsubmit2"  <%=Disablebutton %> >
</td>
</form>
<td align = 'center'>

<% if len(ProdId)> 0 then %>
 <form method="POST" action="AdminShippingFrame.asp?prodid=<%= Prodid %>&Delete=True" >
 <% else %>
  <form method="POST" action="AdminShippingFrame.asp?Servicesid=<%= Servicesid %>&Delete=True" >
 <% end if %>

<% if showdelete = true then %>
  <input type=submit value = "X" class = "regsubmit2"  <%=Disablebutton %> >
<% end if %>  
  <input name="shipID" value="<%=rs("shipID") %>" type = "hidden">
  </td>
  </tr></form>

<% 
end if
rs.movenext
wend  %>

<tr>
<td colspan = 3 class = "body"><br />
<blockquote><img src="images/Important_Triangle.png" height = 20 /><b><font color = maroon> &nbsp; Required for online purchases.</font></b> If you do not set any shipping and handling costs then buyers will be directed to contact you for purchases.<br /><br />
<font color = #404040>Note: If you do not enter a shipping amount for a country, then shipping to that country will not be available.</font><br>
<br>
<b>Helpful Links</b><br>
<a href = "http://www.purolatorinternational.com/trade-regulations" target = "_blank" class = "body">www.purolatorinternational.com/trade-regulations</a> - learn about shipping to Canada.<br />

<a href = "http://www.export.gov/mexico/doingbusinessinmexico/documentationandlogistics/index.asps" target = "_blank" class = "body">www.export.gov/mexico/doingbusinessinmexico/documentationandlogistics/index.asp</a> - learn about shipping to Mexico.<br />



</blockquote>
</td></tr></table>
 </Body>
</HTML>
