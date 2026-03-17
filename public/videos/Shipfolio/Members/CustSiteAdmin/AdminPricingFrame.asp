<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
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
<% ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
end if
%>
 <!--#Include virtual="/administration/adminDetailDBInclude.asp"-->
<% If Len(ID) > 0 then %>
	<!--#Include virtual="/Administration/Transfers/GatherAnimalData.asp"-->
	<!--#Include virtual="/Administration/Transfers/TransferMovedata.asp"-->
<% end if %>

<% if mobiledevice = True or screenwidth < 600 then %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
 <tr>
    <td class = "roundedtop" align = "left">
		<H2><div align = "left"> <a name="Pricing"></a>Pricing</div></H2>
    </td>
 </tr>
 <tr>
    <td class = "roundedBottom" align = "center">
<% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Pricing Changes Have Been Made.</b></font></div>
<% end if %>
<form action= 'AdminPricingHandleForm.asp' method = "post" name = "pricingform"> 
     		<input type = "hidden" name="ID" Value = "<%=  ID%>">  	
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "100%">

		<% If trim(category) = "Experienced Male" Or trim(category) = "Inexperienced Male" Then 
			'response.write("StudFee=" & StudFee )
            
            'If Len(StudFee) < 2 Then
			'	StudFee = ""
			'End If
		%>
		<tr><td class = "body2" align = "right"><b>
      <td class = "body" height = "30" align = "left">
		<a class="tooltip" href="#"><b>Stud Fee:</b><span class="custom info"><em>Stud Fee</em>If you set the stud fee as $0 it will show the stud fee as "Call For Fee".</span></a>
        
        </b>&nbsp;</td>
			<td class = "body" align = "left">
					<%=Currencycode %><input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
					name='StudFee' size=10 maxlength=10 Value= "<%= StudFee%>">
				</td>
		</tr>
		<tr >
			<td class = "body2"  align = "right"><b>Offer Pay What You Can?:</b>&nbsp;</td>
			<td class = "body" align = "left">
			<% 		
		if PayWhatYouCanStud = "Yes" Or PayWhatYouCanStud = True Then %>
			Yes<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "Yes" checked>
			No<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "Yes" >
			No<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "No" checked>
		<% End If %>
		</td>
		</tr>
	<tr>

	<% Else %>
				<input type=hidden  name='StudFee'  Value= "">
	<% End If %>

    <tr >
		<td  class="body2" align = "right"><b>For Sale?:</b>&nbsp;</td>
			<td class = "body" align = "left">
		<div class="button-holder">
		<% 		
		if ForSale = "Yes" Or ForSale = True Then %>
			Yes<input TYPE="RADIO" name="ForSale" Value = "Yes" id="radio-2-1"  checked class="regular-radio big-radio"><label for="radio-2-1"></label><img src = "images/px.gif" width = "5" height = "1" />
			No<input TYPE="RADIO" name="ForSale" Value = "No"  id="radio-2-2" class="regular-radio big-radio"><label for="radio-2-2"></label>
		<% Else %>
			Yes<input TYPE="RADIO" name="ForSale" Value = "Yes" id="radio-2-1"  class="regular-radio big-radio"><label for="radio-2-1"></label><img src = "images/px.gif" width = "5" height = "1" />
			No<input TYPE="RADIO" name="ForSale" Value = "No"  id="radio-2-2" class="regular-radio big-radio" checked><label for="radio-2-2"></label>
		<% End If %></div>
		</td>
</tr>
<tr >
	<td class = "body2"  align = "right"><b>OBO?:</b>&nbsp;</td>
		<td class = "body" align = "left">
				<div class="button-holder">	
				
		<% 		
		if OBO = "Yes" Or OBO = True Then %>
			Yes<input TYPE="RADIO" name="OBO" Value = "Yes" checked  id="radio-3-1"  checked class="regular-radio big-radio"><label for="radio-3-1"></label>
			No<input TYPE="RADIO" name="OBO" Value = "No"  id="radio-3-2"  checked class="regular-radio big-radio" ><label for="radio-3-2">
		<% Else %>
			Yes<input TYPE="RADIO" name="OBO" Value = "Yes" >
			No<input TYPE="RADIO" name="OBO" Value = "No" checked>
		<% End If %>
		</div>
		</td>
		</tr>
		<tr>
			<td class = "body2" align = "right" ><b>Price:</b>&nbsp;</td>
				<td class = "body" align = "left">
		<%=Currencycode %><input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
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
	<% If discount > 0 And price > 0 then
			DiscountPrice = FormatCurrency(Price  - (Price * Discount/100) )
		Else
		DiscountPrice = "N/A"
		
		End if%>
	<%= (DiscountPrice)%></big>
	
	</td>	
	</tr>
<% if ShowFoundationHerd = True then %>
	<tr>
		<td class = "body2"  align ="right"><b>Foundation?</b>&nbsp;</td>
			<td class = "body" align = "left">
		<div class="button-holder">	
		
		<% 
		If Foundation = False then %>
		Yes<input TYPE="RADIO" name="Foundation" Value = "Yes" id="radio-6-1"   class="regular-radio big-radio"><label for="radio-6-1"></label>
		No<input TYPE="RADIO" name="Foundation" Value = "No" checked id="radio-6-2" class="regular-radio big-radio"><label for="radio-6-2"></label> 
		<% else %>
	Yes<input TYPE="RADIO" name="Foundation" Value = "Yes" id="radio-6-1"  checked class="regular-radio big-radio"><label for="radio-6-1"></label>
		No<input TYPE="RADIO" name="Foundation" Value = "No" id="radio-6-2" class="regular-radio big-radio"><label for="radio-6-2"></label> 
		<% end if %>
		</div>
		</td>
	</tr>
	<% end if %>
	<tr>
		<td class = "body2"  align ="right"><b>Sale Pending?:</b>&nbsp;</td>
		<td class = "body" align = "left">
		<div class="button-holder">
		<% 
		if SalePending = "Yes" Or SalePending = True Then %>
			Yes<input TYPE="RADIO" name="SalePending" Value = "Yes" checked id="radio-4-1"  checked class="regular-radio big-radio"><label for="radio-4-1"></label>
			No<input TYPE="RADIO" name="SalePending" Value = "No" id="radio-4-2"   class="regular-radio big-radio"><label for="radio-4-2"></label>
		<% Else %>
						Yes<input TYPE="RADIO" name="SalePending" Value = "Yes"  id="radio-4-1"  class="regular-radio big-radio"><label for="radio-4-1"></label>
			No<input TYPE="RADIO" name="SalePending" Value = "No" id="radio-4-2"  checked class="regular-radio big-radio"><label for="radio-4-2"></label>
		<% End If %>
		</div>
		</td>
		</tr>
		<tr>
		<td class = "body2"  align ="right"><b>Sold?:</B>&nbsp;</td>
		<td class = "body" align = "left">
		<div class="button-holder">
		<% 		
		if Sold = "Yes" Or Sold = True Then %>
			<div valign = "top">Yes<input TYPE="RADIO" name="Sold" Value = "Yes" checked id="radio-5-1"  class="regular-radio big-radio"><label for="radio-5-1"></label>
			No<input TYPE="RADIO" name="Sold" Value = "No" id="radio-5-2"  class="regular-radio big-radio"><label for="radio-5-2"></label></div>
		<% Else %>
			<div valign = "top">Yes<input TYPE="RADIO" name="Sold" Value = "Yes"  id="radio-5-1"  class="regular-radio big-radio"><label for="radio-5-1"></label>
			No<input TYPE="RADIO" name="Sold" Value = "No" checked id="radio-5-2"  class="regular-radio big-radio"><label for="radio-5-2"></label></div>
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
				<input type="submit" class = "regsubmit2 body" value="Submit"  >
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
    <td class = "roundedtop" align = "left">
		<H2><div align = "left"> <a name="Pricing"></a>Pricing</div></H2>
    </td>
 </tr>
 <tr>
    <td class = "roundedBottom" align = "center">
<% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Pricing Changes Have Been Made.</b></font></div>
<% end if %>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "90%">
	<tr>
		<td width = "300" valign = "top">
	<form action= 'AdminPricingHandleForm.asp' method = "post"  action="/articles/articles/javascript/checkNumeric.asp?ID=<%=siteID%>" name = "pricingform">
	<input type = "hidden" name="ID" Value = "<%=  ID%>">
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "300">


		<% If trim(category) = "Experienced Male" Or trim(category) = "Inexperienced Male" Then 
			'If Len(StudFee) < 2 Then
			'	StudFee = ""
			'End If
		%>
		<tr>
				<td class = "body" height = "30" align = "left"><b><a class="tooltip" href="#"><b>Stud Fee:</b><span class="custom info"><em>Stud Fee</em>If you set the stud fee as $0 it will show the stud fee as "Call For Stud Fee".</span></a></b>
					<%=Currencycode %><input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
					name='StudFee' size=10 maxlength=10 Value= "<%= StudFee%>">
				</td>
		</tr>
		<tr >
				<td class = "body" height = "30" align = "left">
		<a class="tooltip" href="#"><b>Offer Pay What You Can Stud Breedings?:</b><span class="custom info"><em>About Pay What You Can </em>By offering <i>Pay What You Can</i>you are adding the ability for potential buyers to make you an offer on a  Stud Breeding based upon what they can afford; however, that does not mean that you have to accept an offer, if you don't want to.</span></a>
		<br />
		<% 		
		if PayWhatYouCanStud = "Yes" Or PayWhatYouCanStud = True Then %>
			Yes<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "Yes" checked>
			No<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "Yes" >
			No<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "No" checked>
		<% End If %>
		<br><br>
		</td>
		</tr>
	<tr>
	
		
	<% Else %>
				<input type=hidden  name='StudFee'  Value= "">
	<% End If %>

    <tr >
				<td class = "body" height = "30" align = "left">
		<b>For Sale?:</b>
		<% 		
		if ForSale = "Yes" Or ForSale = True Then %>
			Yes<input TYPE="RADIO" name="ForSale" Value = "Yes" checked>
			No<input TYPE="RADIO" name="ForSale" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="ForSale" Value = "Yes" >
			No<input TYPE="RADIO" name="ForSale" Value = "No" checked>
		<% End If %>
		<br>
		</td>
		</tr>
		 <tr >
				<td class = "body" height = "30" align = "left">
		
		<a class="tooltip" href="#"><b>OBO?:</b><span class="custom info"><em>About OBO</em>By sellecting OBO you are adding the ability for potential buyers to make you an offer; however, that does not mean that you have to accept an offer, if you are not interested.</span></a>
		
		
		<% 		
		if OBO = "Yes" Or OBO = True Then %>
			Yes<input TYPE="RADIO" name="OBO" Value = "Yes" checked>
			No<input TYPE="RADIO" name="OBO" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="OBO" Value = "Yes" >
			No<input TYPE="RADIO" name="OBO" Value = "No" checked>
		<% End If %>
		<br>
		</td>
		</tr>
		<tr>
			<td class = "body" height = "30" align = "left"><b>Price:</b>
		<%=Currencycode %><input type=text onBlur="checkNumeric(this,-5,5000000,',','.','-');"
		name='price' size=10 maxlength=10 Value= "<%= Price%>">
		</td>
	</tr>

	<tr>
			<td class = "body" height = "30" align = "left">
		<b>% Discount:</b> 
		<select size="1" name="Discount">
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
	<% If discount > 0 And price > 0 then
			DiscountPrice = FormatCurrency(Price  - (Price * Discount/100) )
		Else
		DiscountPrice = "N/A"
		
		End if%>
	<%= (DiscountPrice)%></big>
	
	</td>	
	</tr>
	<tr>
		<td   align = "left" class = "body" ><b>Show On Foundation Page?</b>&nbsp;
		<% 
		If Foundation = False then %>
		Yes<input TYPE="RADIO" name="Foundation" Value = "Yes" >
		No<input TYPE="RADIO" name="Foundation" Value = "No" checked> 
		<% else %>
		Yes<input TYPE="RADIO" name="Foundation" Value = "Yes" checked>
		No<input TYPE="RADIO" name="Foundation" Value = "No" > 
		<% end if %>
	</tr>
	
	<tr>
		<td class = "body" height = "30" align = "left"><b>Sale Pending?:</b>
		<% 'response.write("Forsale=")
		' response.write(Forsale)
		
		if SalePending = "Yes" Or SalePending = True Then %>
			Yes<input TYPE="RADIO" name="SalePending" Value = "Yes" checked>
			No<input TYPE="RADIO" name="SalePending" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="SalePending" Value = "Yes" >
			No<input TYPE="RADIO" name="SalePending" Value = "No" checked>
		<% End If %>
		
		</td>
		</tr>
		<tr>
		<td class = "body" height = "30" align = "left">
		<b>Sold?:</B>
		<% 'response.write("Forsale=")
		' response.write(Forsale)
		
		if Sold = "Yes" Or Sold = True Then %>
			Yes<input TYPE="RADIO" name="Sold" Value = "Yes" checked>
			No<input TYPE="RADIO" name="Sold" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="Sold" Value = "Yes" >
			No<input TYPE="RADIO" name="Sold" Value = "No" checked>
		<% End If %>
		
		</td>
	</tr>
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
<table>
<tr>
		<td  align = "right" class = "body2" ><b>1st Co-owner's Ranch Name:</b>&nbsp;</td>
		<td  valign = "bottom"  class = "body" align = "left"> <input type=text name='CoOwnerBusiness1' value='<%=CoOwnerBusiness1%>' size=30 > </td>
	</tr>
	<tr>
		<td  align = "right" class = "body2" ><b>1st Co-owner's Name:</b>&nbsp;</td>
		<td  valign = "bottom"  class = "body" align = "left"> <input type=text name='CoOwnerName1' value='<%=CoOwnerName1%>' size=30 > </td>
	</tr>

	<tr>
		<td  align = "right" class = "body2" ><b>1st Co-owner link:</b>&nbsp;</td>
		<td  valign = "bottom"  class = "body" align = "left">http://<input type=text name='CoOwnerLink1' value='<%=CoOwnerLink1%>' size=30>  </td>
	</tr>
<tr>
		<td  align = "right" class = "body2" ><b>2nd Co-owner's Ranch Name:</b>&nbsp;</td>
		<td  valign = "bottom"  class = "body" align = "left"> <input type=text name='CoOwnerBusiness2' value='<%=CoOwnerBusiness2%>' size=30 > </td>
	</tr>
	<tr>
		<td  align = "right" class = "body2" ><b>2nd Co-owner's Name:</b>&nbsp;</td>
		<td  valign = "bottom"  class = "body" align = "left"> <input type=text name='CoOwnerName2' value='<%=CoOwnerName2%>'  size=30 > </td>
	</tr>

	<tr>
		<td  align = "right" class = "body2" ><b>2nd Co-owner link:</b>&nbsp;</td>
		<td  valign = "bottom"  class = "body" align = "left">http://<input type=text name='CoOwnerLink2' value='<%=CoOwnerLink2%>' size=30>  </td>
	</tr>
<tr>
		<td  align = "right" class = "body2" ><b>3rd Co-owner's Ranch Name:</b>&nbsp;</td>
		<td  valign = "bottom"  class = "body" align = "left"> <input type=text name='CoOwnerBusiness3' value='<%=CoOwnerBusiness3%>' size=30 > </td>
	</tr>
	<tr>
		<td  align = "right" class = "body2" ><b>3rd Co-owner's Name:</b>&nbsp;</td>
		<td  valign = "bottom"  class = "body" align = "left"> <input type=text name='CoOwnerName3' value='<%=CoOwnerName3%>' size=30 > </td>
	</tr>

	<tr>
		<td  align = "right" class = "body2" ><b>3rd Co-owner link:</b>&nbsp;</td>
		<td  valign = "bottom"  class = "body" align = "left">http://<input type=text name='CoOwnerLink3'  value='<%=CoOwnerLink3%>' size=30>  </td>
	</tr>
</table>
</td>
</tr>
</table>

<table width = "90%" border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
	<td  align = "center">
			<Input type = Hidden name='TotalCount' Value = <%=TotalCount%> >

			<div align = "center">
				<input type="submit" class = "regsubmit2" value="Submit Pricing Changes"  >
	    </div>
		</td>
</tr>
</table></form>
</td>
</tr>
</table>

<% end if %>
</body>
</html>