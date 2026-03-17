<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalvariables.asp"--> 

<SCRIPT LANGUAGE="JavaScript">
    function validateForm() {
        var x = document.forms["myForm"]["PropName"].value;
        if (x == null || x == "") {
            alert("Please enter a name for your property.");
            return false;
        }
    }
</script>

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
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<% Current2="Properties"
Current3 = "AddProperty" %> 
<!--#Include file="MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If   	
%>
<!--#Include file="MembersPropertiesTabsInclude.asp"-->
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg.js"></script> 
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg-settings.js"></script>
<table width = "<%=screenwidth %>" class = "roundedtopandbottom" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0><tr>	<td>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" width = "<%=screenwidth -30%>">
<tr><td class = "body" >
<H1>Add a Ranch Property for Sale</H1>
<center>* = Required field.</center>
<form name="myForm" action="AddaProperty2.asp" onsubmit="return validateForm()" method="post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth -30%>" align = "center">
<tr><td   class = "body" align = "right">	
Property Name:*
</td>
				<td   class = "body">	
				<input name="PropName" type = "text" size = "80" id = "PropName"></input>
				</td>
			</tr>
			<tr>
				<td class = "body"  align = "right">
					For Sale?: 
				</td>
				<td class = "body"   >
					True<input TYPE="RADIO" name="PropForSale" Value = "True" checked>
						False<input TYPE="RADIO" name="PropForSale" Value = "False" >
				</td>
				</tr>
			<tr>
				<td class = "body"  align = "right">
					Street 1 : 
				</td>
				<td class = "body"   >
					<input name="PropStreet1" size = "80">
				</td>
				</tr>
				<tr>
				<td class = "body"  align = "right">
					Street 2 : 
				</td>
				<td class = "body"   >
					<input name="PropStreet2" size = "80">
				</td>
				</tr>
			<tr>
				<td class = "body"  align = "right">
					City : 
				</td>
				<td class = "body"   >
					<input name="PropCity" size = "80">
				</td>
				</tr>
				<tr>
				<td class = "body"  align = "right">
					State/Provence: 
				</td>
				<td class = "body"   >
<select size="1" name="PropState" width="125" style="width: 125px">
<option value="">Select a state or provence</option>
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
					<input name="PropZip" size = "10">
				</td>
				</tr>
			<tr>
				<td class = "body"  align = "right">
					MLS# : 
				</td>
				<td class = "body"   >
					<input name="PropMLS" size = "10">
				</td>
				</tr>
			<tr>
				<td class = "body"  align = "right">
					Price:
				</td>
				<td class = "body" >
					$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');" 	name='PropPrice' size=10 maxlength=10 Value= ""><b><i>(Must be a number.)</i></b>
				</td>
			</tr>
			<tr>
				<td class = "body"  align = "right">
					Taxes:
				</td>
				<td class = "body" >
					$<input type=text  	name='propTaxes' size=10 maxlength=10>
				</td>
			</tr>
			<tr>
				<td class = "body"  align = "right">
					Square Feet:
				</td>
				<td class = "body" >
					<input name="PropSqFeet" size = "40">
				</td>
			</tr>
			<tr>
				<td class = "body"  align = "right">
					Acreage:
				</td>
				<td class = "body" >
					<input name="PropAcres" size = "40">
				</td>
			</tr>
			<tr>
				<td class = "body"  align = "right">
					House Style:
				</td>
				<td class = "body" >
					<input name="PropStyle" size = "40">
				</td>
			</tr>
			<tr>
				<td class = "body"  align = "right">
					Year Built:
				</td>
				<td class = "body" >
					<input name="PropYearBuilt" size = "6">
				</td>
			</tr>
			<tr>
				<td class = "body"  align = "right">
					Bedrooms:
				</td>
				<td class = "body">
					<select size="1" name="PropBedrooms">
					<option value="" selected></option>
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
					<option value="" selected></option>
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
					<option value="" selected></option>
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
						<input name="PropGarage" size = "80">
				</td>
			</tr>
			<tr>
				<td class = "body"  align = "right">
						Roof:
				</td>
				<td class = "body" >
						<input name="PropRoof" size = "80">
				</td>
			</tr>
	<tr>
		<td class = "body" valign = "top" align = "left" colspan = "2">
			<br>
			Description:
		</td>
	</tr>
	<tr>
		<td colspan = "2">
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
		<td class = "body" valign = "top" align = "left" colspan = "2">
			<br>Out Buildings:
		</td>
	</tr>
	<tr>
		<td colspan = "2">
                <script type="text/javascript">
                    var mysettings = new WYSIWYG.Settings();
                    mysettings.Width = "100%";
                    mysettings.Height = "300px";
                    mysettings.ImagePopupWidth = 600;
                    mysettings.ImagePopupHeight = 245;
                    WYSIWYG.attach('PropOutBuildings', mysettings);
</script>
<textarea name="PropOutBuildings"  cols="110" rows="20"   class = "body"  ID="PropOutBuildings"><%= PropOutBuildings%></textarea>
</td></tr>
<tr><td colspan = "2" >	
  
<center><input type=submit value = " Add Property " onclick="formcheck(); return false" class = "regsubmit2" ></center>
</td></tr></table>
</td></tr></table></form>
<!--#Include virtual="/Footer.asp"--> </Body>
</HTML>