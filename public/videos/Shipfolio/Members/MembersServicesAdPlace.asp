<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<meta name="author" content="The Andresen Group">
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="MembersGlobalVariables.asp"-->

<%
MissingLinkName = request.QueryString("MissingLinkName")
MissingServiceTitle = request.QueryString("MissingServiceTitle")
MissingServicePrice= request.QueryString("MissingServicePrice")
PageAlreadyExists= request.QueryString("PageAlreadyExists")

ServiceTitle=request.querystring("ServiceTitle") 
ServicePrice =request.querystring("ServicePrice")
SalePrice = request.querystring("SalePrice")
ProdQuantityAvailable=request.querystring("ProdQuantityAvailable")
ServiceAvailable =request.querystring("ServiceAvailable")
LinkName=request.querystring("LinkName")

if len(ServiceAvailable) > 0 then
else
ServiceAvailable = True
end if

ServiceDescription   =request.querystring("ServiceDescription")

Set rs = Server.CreateObject("ADODB.Recordset")

if len(ServiceCategoryID) > 0 then
    if ServiceCategoryID > 0 then
    sql = "select ServicesCategoryName from ServicesCategories where ServiceCategoryID= " & Category1ID
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
if not rs.eof then
    ServicesCategoryName = rs("ServicesCategoryName")
end if 
rs.close
    end if
   
end if
%>
</head>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">

<% Current3 = "AddServices" %>

<!--#Include file="MembersHeader.asp"-->


<% 
Session("Step2") = False 
Session("PhotoPageCount") = 0

%>


<SCRIPT LANGUAGE="JavaScript">
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
var checkOK = "0123456789. " + comma + period ;
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
alertsay = alertsay + checkOK +  "\"."
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


<SCRIPT LANGUAGE="JavaScript">

<!-- Begin
   var submitcount=0;
   function checkSubmit() {

      if (submitcount == 0)
      {
      submitcount++;
      document.Surv.submit();
      }
   }


function wordCounter(field, countfield, maxlimit) {
wordcounter=0;
for (x=0;x<field.value.length;x++) {
      if (field.value.charAt(x) == " " && field.value.charAt(x-1) != " ")  {wordcounter++}  // Counts the spaces while ignoring double spaces, usually one in between each word.
      if (wordcounter > 250) {field.value = field.value.substring(0, x);}
      else {countfield.value = maxlimit - wordcounter;}
      }
   }

function textCounter(field, countfield, maxlimit) {
  if (field.value.length > maxlimit)
      {field.value = field.value.substring(0, maxlimit);}
      else
      {countfield.value = maxlimit - field.value.length;}
  }
//  End -->
</script>
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Add a Service<a name="Add"></a></div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center" height = "300" valign = "top">
<blockquote><div align = "left" class = "body">Enter your information in the boxes below then select the "Save & Proceed to the Next Page ->" button at the bottom of the form to proceed to the next step.<br /><br /></div></blockquote>

<% 


if PageAlreadyExists = "True" then %>
<table width = '100%' align = 'center'><tr><td align = "left" class = "body"><font color = "maroon"><b>ERROR: A page titled <% = ServiceTitle%> already exists.</font></b></td></tr></table>
<% end if %>

<% if len(MissingServiceTitle) > 0 or len(MissingLinkName) > 0 then %>
<table width = '100%' align = 'center'><tr><td align = "left" class = "body"><font color = "maroon"><b>Missing Information!<ul>
<%  if len(MissingServiceTitle) > 0 then %>
<li>Please enter a Service Name.</li>
<% end if %>
<%  if len(MissingLinkName) > 0 then %>
<li>Please enter a menu title.</li>
<% end if %>



</ul></font></b></td></tr></table>
<% end if %>

<form name="myform" method="post" action= 'AdminServicesAdPlaceStep2.asp' >
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth -35 %>" align = "center">
  <tr>
    <td valign = "top" align = "center">
	<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=2 cellspacing=0 width = "100%">
	<tr>
	<td  align = "center" colspan = "3" valign = "top">
	
<div align = "center"><font class="body">* = Required Field</font></div>
<table border = 0>
  <tr>
	<td class = "body" width = "200"><div align = "right">
			<%  if len(MissingServiceTitle) > 0 then %>
<font color = "Maroon">
<% end if %>
Name*:&nbsp;<%  if len(MissingServiceTitle) > 0 then %>
</font>
<% end if %></div>
		</td>
		<td class ="body" align = "left" >
			<input name="ServiceTitle" value="<%=ServiceTitle %>" size = "50">
		</td>
	</tr>
	<Tr>
<td  align = "right" class = "body">
		    <div align = "right"><%  if len(MissingLinkName) > 0 then %><font color = "Maroon"><% end if %>Menu Title*:&nbsp;<%  if len(MissingLinkName) > 0 then %></font><% end if %></div>
		</td>
		<td  align = "left" class = "body">
		    <input name="LinkName" value= "<%=LinkName%>" size = "20" maxsize = "20">
		   <font color = "gray">Max. length = 20 charecters</font>
		</td>
	</Tr>
    <tr><td  class = "body" ><div align = "right">
			<%  if len(MissingServicePrice) > 0 then %><font color = "maroon"><% end if %>Price:&nbsp;<%  if len(MissingServicePrice) > 0 then %></font><% end if %></div>
		</td>
		<td class ="body" align = "left">
		$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name="ServicePrice" size=10 maxlength=10 value="<%=ServicePrice%>">

			<i><font color = "#404040">Must be a number.</font></i>
</td></tr>
<tr><td  class = "body" ><div align = "right">
			Contact for Price:&nbsp;</div>
		</td>
		<td class = "body">
			<% if  ServiceContactForPrice = "Yes" Or  ServiceContactForPrice = True Then %>
						Yes<input TYPE="RADIO" name="ServiceContactForPrice" Value = True checked>
						No<input TYPE="RADIO" name="ServiceContactForPrice" Value = False >
					<% Else %>
						Yes<input TYPE="RADIO" name="ServiceContactForPrice" Value = True >
						No<input TYPE="RADIO" name="ServiceContactForPrice" Value = False checked>
				<% End if%>
				<i><font color = "#404040">Select this if you want users to contact you for the price.</font></i>
		</td>
	</tr>
<tr><td  class = "body" ><div align = "right">
			Available:&nbsp;</div>
		</td>
		<td class = "body">
			<% if  ServiceAvailable = "Yes" Or  ServiceAvailable = True Then %>
						Yes<input TYPE="RADIO" name="ServiceAvailable" Value = True checked>
						No<input TYPE="RADIO" name="ServiceAvailable" Value = False >
					<% Else %>
						Yes<input TYPE="RADIO" name="ServiceAvailable" Value = True >
						No<input TYPE="RADIO" name="ServiceAvailable" Value = False checked>
				<% End if%>
		</td>
	</tr>
<tr><td colspan = "2" >
		<div align = "left" class = "body2">FYI: It may take up to 5 minutes for your new service to appear on your website, <br />also services will only show up when you selct them as available.</div>

		</td>
	</tr>
</table>
 </td>
 </tr>

<td  colspan = "3" align = "center" valign = "middle" class = "body" >
			<div align = "right"><input type=submit value = "Save & Proceed to the Next Page ->" class = "regsubmit2"  <%=Disablebutton %> ></div>
		</td>
</tr>
</table>	</form>
	</td>
</tr>
</table>
<br />
	
 <br><br>


<!--#Include file="MembersFooter.asp"--> </Body>
</HTML>