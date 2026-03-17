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
var checkOK = "0123456789$" + comma ;
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
}
}
//  End -->
</script>
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg.js"></script> 
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg-settings.js"></script>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			<a name="Add"></a><br>
			<H1>Edit Your Ranch Property for Sale</H1>
		</td>
	</tr>
</table>
<% if Numproperties > 1 or len(PropID) = 0 then %>
<form  action="EditProperty0.asp" method = "post" name = "edit1">
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
<tr><td colspan ="30">
&nbsp;
</td>
<td class = "body">
<br>Select another one of your properties:
<select size="1" name="PropID">
<option name = "AID0" value= "" selected></option>
<% count = 1
while count < acounter%>
<option name = "AID1" value="<%=PropIDArray(count)%>">
<%=PropNameArray(count)%>
</option>
<% count = count + 1
wend %>
</select>
<input type=submit value="Submit" class = "regsubmit2" >
</td></tr></table></form>
<% sql = "select * from Properties where PropID = " & PropID
rs.Open sql, conn, 3, 3   
PropName=rs("PropName" ) 
PropMLS=rs("PropMLS" ) 
propPrice=rs("propPrice" ) 
propTaxes=rs( "propTaxes" ) 
PropSqFeet=rs( "PropSqFeet" ) 
PropAcres=rs( "PropAcres" ) 
PropBedrooms=rs("PropBedrooms")
PropBathrooms=rs("PropBathrooms")
PropFirePlaces=rs("PropFirePlaces") 
PropGarage=rs("PropGarage") 
PropRoof=rs("PropRoof") 
PropDescription=rs("PropDescription") 
PropOutBuildings=rs("PropOutBuildings") 
PropForSale=rs("PropForSale") 
PropSold=rs("PropSold") 
PropStreet1=rs("PropStreet1") 
PropStreet2=rs("PropStreet2") 
PropCity=rs("PropCity") 
PropState=rs("PropState") 
PropZip=rs("PropZip") 
propStyle=rs("propStyle") 
PropYearBuilt=rs("PropYearBuilt") 
If propStyle="0" Then
propStyle=""
End if
If PropName="0" Then
		PropName=""
	End if
	If PropMLS="0" Then
			PropMLS=""
	End if
	If propPrice="0" Then
			propPrice=""
	End if
	If propTaxes="0" Then
			propTaxes=""
	End if
	If PropSqFeet="0" Then
			PropSqFeet=""
	End if
	If PropAcres="0" Then
			PropAcres=""
	End if
	If PropBedrooms="0" Then
			PropBedrooms=""
	End if
	If PropBathrooms="0" Then
			PropBathrooms=""
	End if
	If PropFirePlaces="0" Then
			PropFirePlaces=""
	End if
	If PropGarage="0" Then
			PropGarage=""
	End if
	If PropRoof="0" Then
			PropRoof=""
	End if
	If PropDescription="0" Then
			PropDescription=""
	End if
	If PropDescription="0" Then
			PropDescription=""
	End if
%>

<form  name=form method="post" action="EditaProperty2.asp">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth-20 %>">
			<tr>
				<td   class = "body" width = "100" align = "right">	
					Property Name: 
				</td>
				<td   class = "body">	
					 <input name="PropName" value = "<%=PropName %>" size = "80">
				</td>
			</tr>
			<tr>
				<td   class = "body" width = "100" align = "right">	
					For Sale?: 
				</td>
				<td   class = "body">	
					<% if  propForSale = "True" Or  propForSale = 1 Then %>
					   True<input TYPE="RADIO" name="propForSale" Value = "True" checked>
						False<input TYPE="RADIO" name="propForSale" Value = "False" > 
					<% Else %>
						True<input TYPE="RADIO" name="propForSale" Value = "True" >
						False<input TYPE="RADIO" name="propForSale" Value = "False" checked>
						
					<% End If %>

				</td>
			</tr>
	<tr>
				<td   class = "body" width = "100" align = "right">	
					Sold?: 
				</td>
				<td   class = "body">	
					<% if  propSold = "True" Or  propSold = 1 Then %>
					   True<input TYPE="RADIO" name="propSold" Value = "True" checked>
						False<input TYPE="RADIO" name="propSold" Value = "False" > 
					<% Else %>
						True<input TYPE="RADIO" name="propSold" Value = "True" >
						False<input TYPE="RADIO" name="propSold" Value = "False" checked>
						
					<% End If %>

				</td>
			</tr>
		<tr>
				<td class = "body"  align = "right">
					Street 1: 
				</td>
				<td class = "body"   >
					<input name="PropStreet1" value = "<%=PropStreet1 %>" size = "80">
				</td>
				</tr>
				<tr>
				<td class = "body"  align = "right">
					Street 2: 
				</td>
				<td class = "body"   >
					<input name="PropStreet2" value = "<%=PropStreet2 %>" size = "80">
				</td>
				</tr>
<tr>
				<td class = "body"  align = "right">
City: 
				</td>
				<td class = "body"   >
					<input name="PropCity" value = "<%=PropCity %>" size = "80">
				</td>
				</tr>
			<tr>
				<td class = "body"  align = "right">
					State/Provence: 
				</td>
				<td class = "body"   >
                	
<select size="1" name="PropState" width="125" style="width: 125px">
<option value="<%=PropState%>"><%=PropState%></option>
<option value="AL">Alaska</option>
<option value="AL">Alaska</option>
<option  value="AK">Arkensas</option>
<option  value="AZ">Arazona</option>
<option  value="AR">Arkansas</option>
<option  value="CA">California</option>
<option  value="CO">Colorado</option>
<option  value="CT">Connecticut</option>
<option  value="DE">Delaware</option>
<option  value="DC">District of Columbia</option>
<option  value="FL">Florida</option>
<option  value="GA">Georgia</option>
<option  value="HI">Hawaii</option>
<option  value="ID">Idaho</option>
<option  value="IL">Illinois</option>
<option  value="IN">Indiana</option>
<option  value="IA">Iowa</option>
<option  value="KS">Kansas</option>
<option  value="KY">Kentucky</option>
<option  value="LA">Louisiana</option>
<option  value="ME">Maine</option>
<option  value="MD">Maryland</option>
<option  value="MA">Massachusetts</option>
<option  value="MI">Michigan</option>
<option  value="MN">Minnesota</option>
<option  value="MS">Mississippi</option>
<option  value="MO">Missouri</option>
<option  value="MT">Montana</option>
<option  value="NE">Nebraska</option>
<option  value="NV">Nevada</option>
<option  value="NH">New Hampshire</option>
<option  value="NJ">New Jersey</option>
<option  value="NM">New Mexico</option>
<option  value="NY">New York</option>
<option  value="NC">North Carolina</option>
<option  value="ND">North Dakota</option>
<option  value="OH">Ohio</option>
<option  value="OK">Oklahoma</option>
<option  value="OR">Oregon</option>
<option  value="PA">Pennsylvania</option>
<option  value="RI">Rhode Island</option>
<option  value="SC">South Carolina</option>
<option  value="SD">South Dakota</option>
<option  value="TN">Tennessee</option>
<option  value="TX">Texas</option>
<option  value="UT">Utah</option>
<option  value="VT">Vermont</option>
<option  value="VA">Virginia</option>
<option  value="WA">Washington</option>
<option  value="WV">West Virginia</option>
<option  value="WI">Wisconsin</option>
<option  value="WY">Wyoming</option>
<option  value=""></option>
<option  value="ON">Ontario</option>
<option  value="QC">Quebec</option>
<option  value="BC">British Columbia</option>
<option  value="AB">Alberta</option>
<option  value="MB">Manitoba</option>
<option  value="SK">Saskatchewan</option>
<option  value="NS">Nova Scotia</option>
<option  value="NB">New Brunswick</option>
<option  value="NL">Newfoundland</option>
<option  value="PE">Prince Edward Island</option>
<option  value="NT">Northwest Territories</option>
<option  value="YK">Yukon</option>
<option  value="NU">Nunavut</option>
</select>
</td>
</tr>
<tr>
				<td class = "body"  align = "right">
					Zip: 
				</td>
				<td class = "body"   >
					<input name="PropZip" size = "20" value = "<%=PropZip %>">
				</td>
				</tr>
				<tr>
				<td class = "body"  align = "right">
					MLS# : 
				</td>
				<td class = "body"   >
					<input name="PropMLS" value="<%=PropMLS %>" size = "20">
				</td>
				</tr>
			<tr>
				<td class = "body"  align = "right">
					Price:
				</td>
				<td class = "body" >
				$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');" 	name='PropPrice' size=10 maxlength=10 Value= "<%=propPrice %>"><b><i>(Must be a number.)</i></b>


				</td>
			</tr>
			<tr>
				<td class = "body"  align = "right">
					Taxes:
				</td>
				<td class = "body" >
					$<input type=text  	name='propTaxes' value='<%=propTaxes %>' size=10 maxlength=10>/year <b><i>(Must be a number.)</i></b>
				</td>
			</tr>
			<tr>
				<td class = "body"  align = "right">
					Square Feet:
				</td>
				<td class = "body" >
						<input name="PropSqFeet" value="<%=PropSqFeet %>"  size = "40">
				</td>
			</tr>
			<tr>
				<td class = "body"  align = "right">
					Acreage:
				</td>
				<td class = "body" >
					<input name="PropAcres" value="<%=PropAcres %>" size = "40">
				</td>
			</tr>
			<tr>
				<td class = "body"  align = "right">
					House Style:
				</td>
				<td class = "body" >
					<input name="PropStyle" value="<%=propStyle%>" size = "40">
				</td>
			</tr>
			<tr>
				<td class = "body"  align = "right">
					Year Built:
				</td>
				<td class = "body" >
					<input name="PropYearBuilt" value="<%=PropYearBuilt %>" size = "40">
				</td>
			</tr>
			<tr>
				<td class = "body"  align = "right">
					Bedrooms:
				</td>
				<td class = "body">
					<select size="1" name="PropBedrooms">
					<option value="<%=PropBedrooms%>" selected><%=PropBedrooms %></option>
					<option value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
					<option  value="9">9</option>
					<option  value="10">10</option>
					<option  value="11">11</option>
					<option  value="12">12</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class = "body"  align = "right">
				Bathrooms:
			</td>
			<td class = "body" >
			<select size="1" name="PropBathrooms">
					<option value="<%=PropBathrooms %>" selected><%=PropBathrooms %></option>
					<option value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
				</select>
		</td>
	</tr>
	<tr>
				<td class = "body"  align = "right">
					Fire Places:
				</td>
				<td class = "body" >
					<select size="1" name="PropFirePlaces">
					<option value="<%=PropFirePlaces %>" selected><%=PropFirePlaces %></option>
                    <option value="0">0</option>
					<option value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
				</select>
				</td>
			</tr>
<tr>
				<td class = "body"  align = "right">
						Garages:
				</td>
				<td class = "body" >
						<input name="PropGarage" value="<%=PropGarage %>"  size = "40">
				</td>
			</tr>
			<tr>
				<td class = "body"  align = "right">
						Roof:
				</td>
				<td class = "body" >
						<input name="PropRoof" value="<%=PropRoof %>" size = "40">
</td>
</tr>
<tr>
<td class = "body" valign = "top" align = "right">
Description:
</td>
<td>
<script type="text/javascript">
var mysettings = new WYSIWYG.Settings();
mysettings.Width = "100%";
mysettings.Height = "300px";
mysettings.ImagePopupWidth = 600;
mysettings.ImagePopupHeight = 245;
WYSIWYG.attach("PropDescription", mysettings);
</script>
<textarea name="PropDescription"  cols="110" rows="20"   class = "body"  ID="PropDescription"><%= PropDescription %></textarea>
		</td>
	</tr>
	<tr>
		<td class = "body" valign = "top" align = "right">
			Out Buildings:
		</td>
<td>
 <script type="text/javascript">
var mysettings = new WYSIWYG.Settings();
mysettings.Width = "100%";
mysettings.Height = "300px";
mysettings.ImagePopupWidth = 600;
mysettings.ImagePopupHeight = 245;
WYSIWYG.attach("PropOutBuildings", mysettings);
</script>
<textarea name="PropOutBuildings"  cols="110" rows="20"   class = "body"  ID="PropOutBuildings"><%= PropOutBuildings%></textarea>
		</td>
	</tr>
</table>
<table width = "800">
	
<tr>
	<td  align = "center">
		<input type = "hidden" name="PropID" value="<%=PropID %>"  size = "40">
			<input type=submit value="Submit" class = "regsubmit2" >
	</form>

		</td>
</tr>
</table>
<% end if %>

