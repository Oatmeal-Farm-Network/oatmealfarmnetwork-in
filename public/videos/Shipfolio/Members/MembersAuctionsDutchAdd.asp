<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Alpaca Infinity Membersistration</title>
<meta name="Title" content="Alpaca Infinity Membersistration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/alpacachamps/infinityknot.ico" /> 
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />

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
var checkOK = "0123456789." + comma ;
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
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="MembersGlobalVariables.asp"-->
<!--#Include virtual="/Header.asp"--> 
<!--#Include file="MembersSecurityInclude.asp"-->
<% 
Current2="Auctions"
Current3 = "AddAuction"
   
AuctionLevel=Request.Form("AuctionLevel")
Price=Request.Form("Price")
Value=Request.Form("Value")
AuctionDescription=Request.Form("Description")
PercentDecrementAmount=Request.Form("PercentDecrementAmount")
DecrementType=Request.Form("DecrementType")
PercentDecreasingPercent = Request.Form("PercentDecreasingPercent")
PercentDecreasingDollars = Request.Form("PercentDecreasingDollars")
AnimalID1= Request.Form("AnimalID1")
AnimalID2= Request.Form("AnimalID2")
AnimalID3= Request.Form("AnimalID3")
AnimalID4= Request.Form("AnimalID4")
AnimalID5= Request.Form("AnimalID5")
AnimalID6= Request.Form("AnimalID6")


if len(AnimalID1) < 1 or AnimalID1 = "None Available." then
  AnimalID1 = 0
end if
if len(AnimalID2) < 1 or AnimalID2 = "None Available." then
  AnimalID2 = 0
end if
if len(AnimalID3) < 1 or AnimalID3 = "None Available." then
  AnimalID3 = 0
end if
if len(AnimalID4) < 1 or AnimalID4 = "None Available." then
  AnimalID4 = 0
end if
if len(AnimalID5) < 1 or AnimalID5 = "None Available." then
  AnimalID5 = 0
end if
if len(AnimalID6) < 1 or AnimalID6 = "None Available." then
  AnimalID6 = 0
end if

if not AnimalID1 = 0 then
sql2 = "select FullName from Animals where ID = " & AnimalID1 
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if not rs2.eof then
	animalname1 = rs2("Fullname")
	rs2.close
   end if 
end if

if not AnimalID2 = 0 then
sql2 = "select FullName from Animals where ID = " & AnimalID2 
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if not rs2.eof then
	animalname2 = rs2("Fullname")
	rs2.close
   end if 
end if

if not AnimalID3 = 0 then
sql2 = "select FullName from Animals where ID = " & AnimalID3 
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if not rs2.eof then
	animalname3 = rs2("Fullname")
	rs2.close
   end if 
end if


if not AnimalID4 = 0 then
sql2 = "select FullName from Animals where ID = " & AnimalID4 
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if not rs2.eof then
	animalname4 = rs2("Fullname")
	rs2.close
   end if 
end if

if not AnimalID5 = 0 then
sql2 = "select FullName from Animals where ID = " & AnimalID5 
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if not rs2.eof then
	animalname5 = rs2("Fullname")
	rs2.close
   end if 
end if

if not AnimalID6 = 0 then
sql2 = "select FullName from Animals where ID = " & AnimalID6 
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if not rs2.eof then
	animalname6 = rs2("Fullname")
	rs2.close
   end if 
end if
   %> 
<!--#Include virtual="/MembersHeader.asp"-->
<br>
<!--#Include file="MembersAuctionsTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "940" valign = "top"><tr><td class = "roundedtop" align = "left" valign = "top">
		<h1><div align = "left">Add a Dutch Auction</div></h1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" valign = "top">
   <table><tr><td valign = "top">    
        <iframe src ="MembersAddDutchAuctionFrame.asp" width="660" height="700" frameborder = "0" scrolling = "no" valign = "top" align = "center" style="background-color:white">
			 <p>Your browser does not support iframes.</p>
		</iframe>
    
</td>
<td valign = "top">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "280" valign = "top"><tr><td class = "roundedtop" align = "left">
		<h2><div align = "left"> Dutch Auction Levels</div></h2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center">
        Below are listed what you get with the different Dutch Auction levels:<br />
        <br />
        <img src = "images/Purplelevel.jpg"  width ="272" height = "58" />
        <% sale = true
        if sale = True then %>
        <b>Full Price: <strike>$795</strike></b><br />
         <b>Discount Price: Only $636</b><br />
        <% else %>
         <b>Price: $795</b>
        <% end if %>
       <ul>
       <li>Up to 6 alpacas</li>
        <li>Preferred position on auction listings.</li>
        <li>6 Weekly Mass Emails for just your auction!</li>
        <li>Preferred position on weekly auction emails.</li>
         <li>Banner ads (6 weeks).</li>
          <li>Skyscraper ads (6 weeks).</li>
           <li>Logo ads (6 weeks).</li>
         </ul>
         <br />
      <img src = "images/Bluelevel.jpg"  width ="272" height = "58" />
        <% if sale = True then %>
        <b>Full Price: <strike>$495</strike></b><br />
         <b>Discount Price: Only $396</b><br />
        <% else %>
         <b>Price: $495</b>
        <% end if %>
               <ul>
       <li>Up to 4 alpacas</li>
       <li>Website auction listing.</li>
        <li>Inclusion in weekly auction emails.</li>
        <li>Skyscraper ads (6 weeks).</li>
        <li>Logo ads (6 weeks).</li>
         </ul>
         <br />
           <img src = "images/Redlevel.jpg"  width ="272" height = "58" />
        <% if sale = True then %>
        <b>Full Price: <strike>$295</strike></b><br />
         <b>Discount Price: Only $236</b><br />
        <% else %>
         <b>Price: $295</b>
        <% end if %>
               <ul>
       <li>1 alpaca</li>
        <li>Preferred position on auction listings.</li>
        <li>Inclusion in weekly auction emails.</li>
        <li>Skyscraper ads (6 weeks).</li>
        <li>Logo ads (6 weeks).</li>
         </ul>
         <br />
        <img src = "images/Yellowlevel.jpg"  width ="272" height = "58" />
                <% if sale = True then %>
        <b>Full Price: <strike>$98</strike></b><br />
         <b>Discount Price: Only $78</b><br />
        <% else %>
         <b>Price: $98</b>
        <% end if %>
        <ul>
           <li>1 alpaca.</li>
           <li>Website auction listing.</li>
           <li>Logo ads (6 weeks).</li>
         </ul><br /><br />
         
         
       </td>
	</tr>
</table>
</td>
	</tr>
</table>

<br>

 <!--#Include virtual="/Footer.asp"--> 

</BODY>
</HTML>