<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalvariables.asp"--> 

<SCRIPT LANGUAGE="JavaScript">
    function validateForm() {
        var x = document.forms["myForm"]["BFSName"].value;
        if (x == null || x == "") {
            alert("Please enter a name for your Business.");
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
var checkOK = "0123456789$" ;
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
<% Current2 = "Business"
Current3 = "AddBusiness" %> 
<!--#Include file="MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If   	
%>
<!--#Include file="MembersBusinessTabsInclude.asp"-->
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg.js"></script> 
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg-settings.js"></script>
<table width = "<%=screenwidth %>" class = "roundedtopandbottom" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0><tr>	<td>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" width = "<%=screenwidth -30%>">
<tr><td class = "body" >
<H1>Add a Business for Sale</H1>
<center>* = Required field.</center>
<form name="myForm" action="AddaBusiness2.asp" onsubmit="return validateForm()" method="post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth -30%>" align = "center">
<tr><td   class = "body" align = "right">	
Business Name:*
</td>
<td   class = "body">	
<input name="BFSName" type = "text" size = "80" id = "BFSName"></input>
</td></tr>
<tr><td class = "body"  align = "right">
For Sale?: 
</td>
<td class = "body"   >
True<input TYPE="RADIO" name="BFSForSale" Value = "True" checked>
False<input TYPE="RADIO" name="BFSForSale" Value = "False" >
</td></tr>
<tr><td class = "body"  align = "right">
Sold?: 
</td>
<td class = "body"   >
True<input TYPE="RADIO" name="BFSSold" Value = "True" >
False<input TYPE="RADIO" name="BFSSold" Value = "False" checked>
</td></tr>
<tr><td class = "body"  align = "right">
Websites : 
</td>
<td class = "body"   >
<input name="BFSWebsite1" size = "80" value = "http://"><br />
<input name="BFSWebsite2" size = "80" value = "http://"><br />
<input name="BFSWebsite3" size = "80" value = "http://"><br />
<a href = "http://www.livestockofamerica.com/Ranches/RanchHome.asp?CurrentPeopleID=<%=peopleid %>" class = "body" target = "blank">www.livestockofamerica.com/Ranches/RanchHome.asp?CurrentPeopleID=<%=peopleid %></a>
</td>
</tr>



<tr><td class = "body"  align = "right">
Street 1 : 
</td>
<td class = "body"   >
<input name="BFSStreet1" size = "80">
</td>
</tr>
<tr>
<td class = "body"  align = "right">
Street 2 : 
</td>
<td class = "body"   >
<input name="BFSStreet2" size = "80">
</td></tr>
<tr><td class = "body"  align = "right">
City : 
</td>
<td class = "body"   >
<input name="BFSCity" size = "80">
</td></tr>
<tr><td class = "body"  align = "right">
State/Provence: </td>
<td class = "body"   >
<select size="1" name="BFSState" width="125" style="width: 125px">
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
</td></tr>
<tr><td class = "body"  align = "right">
Zip: 
</td>
<td class = "body"   >
<input name="BFSZip" size = "10">
</td></tr>
<tr><td class = "body"  align = "right">
<a class="tooltip" href="#"><b>Asking Price:</b><span class="custom info"><em>The asking price for the business you are selling. </em></span></a>
</td>
<td class = "body" >
$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');" 	name='BFSAskingPrice' size=10 maxlength=10 Value= ""><b><i>(Must be a number.)</i></b>
</td></tr>
<tr><td class = "body"  align = "right"><a class="tooltip" href="#"><b>Gross Income:</b><span class="custom info"><em>All income the business received before any cost-of-sale or expenses have been deducted.</em></span></a></td>
<td class = "body" >$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');" 	name='BFSGrossIncome' size=10 maxlength=10 Value= ""><b><i>(Must be a number.)</i></b></td></tr>
<tr><td class = "body"  align = "right"><a class="tooltip" href="#"><b>Cash Flow:</b><span class="custom info"><em>Arrived at by &quot;starting with your net (before tax) profit. Then, add back in any payments made to the owner, interest and any depreciation of assets.&quot; For example, if the net profit before taxes was $100,000 and the owner was paid $70,000 then the cash flow is $170,000.</em></span></a></td>
<td class = "body" >$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');" 	name='BFSCashFlow' size=10 maxlength=10 Value= ""><b><i>(Must be a number.)</i></b></td></tr>
<tr><td class = "body"  align = "right"><a class="tooltip" href="#"><b>EBITDA:</b><span class="custom info"><em>Earnings Before Interest, Taxes, Depreciation and Amortization.</em></span></a></td>
<td class = "body" >$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');" 	name='BFSFFandE' size=10 maxlength=10 Value= ""><b><i>(Must be a number.)</i></b></td></tr>

<tr><td class = "body"  align = "right"><a class="tooltip" href="#"><b>FF&amp;E:</b><span class="custom info"><em>Furniture, Fixtures and Equipment that will remain with the business, such as a tractor, manufacturing equipment, etc.</em></span></a></td>
<td class = "body" >$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');" 	name='BFSEBITDA' size=10 maxlength=10 Value= ""><b><i>(Must be a number.)</i></b></td></tr>
<tr><td class = "body"  align = "right"><a class="tooltip" href="#"><b>Inventory:</b><span class="custom info"><em>The value of the animals, merchandise, raw materials, and finished and unfinished products which have not yet been sold.</em></span></a></td>
<td class = "body" >$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');" 	name='BFSInventory' size=10 maxlength=10 Value= ""><b><i>(Must be a number.)</i></b></td></tr>

<tr><td class = "body"  align = "right"><a class="tooltip" href="#"><b>Real Estate:</b><span class="custom info"><em>If the business has real property that can convey with the business, the value of the property may be included in the asking price or kept separate as an optional purchase. If there is no real estate price listed then the seller did not provide it.</em></span></a></td>
<td class = "body" >$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');" 	name='BFSRealEstate' size=10 maxlength=10 Value= ""><b><i>(Must be a number.)</i></b></td></tr>
<tr>

<% sql2 = "select distinct * from Properties where PeopleID = " & Session("PeopleID") & " order by PropName"
'response.write (sql)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3  
if not rs2.eof then %>
<td class = "body"  align = "right">
Property:
</td>
<td class = "body" >
<select size="1" name="PropId">
<option value="" selected>N/A</option>
<% while not rs2.eof %>
<option value="<%=rs2("PropID") %>"><%=rs2("PropName") %></option>
<% rs2.movenext
wend %>
</select>
</td>
</tr>
<% end if %>
				<td class = "body"  align = "right">
					Established:
				</td>
				<td class = "body" >
					<input type=text  	name='BFSEstablished' size=10 maxlength=10>
				</td>
			</tr>
		
			<tr>
				<td class = "body"  align = "right">
					<a class="tooltip" href="#"><b>Employees:</b><span class="custom info"><em>These are the employees in the business  - <b>does not include the owners.</b></em></span></a>
				</td>
				<td class = "Employees">
					<select size="1" name="BFSEmployees">
					<option value="0" selected>0</option>
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
                    WYSIWYG.attach("BFSDescription", mysettings);
</script>
<textarea name="BFSDescription"  cols="110" rows="20"   class = "body"  ID="BFSDescription"><%= BFSDescription %></textarea>
		</td>
	</tr>

<tr><td colspan = "2" >	
  
<center><input type=submit value = " Add Business " onclick="formcheck(); return false" class = "regsubmit2" ></center>
</td></tr></table>
</td></tr></table></form>
<!--#Include virtual="/Footer.asp"--> </Body>
</HTML>