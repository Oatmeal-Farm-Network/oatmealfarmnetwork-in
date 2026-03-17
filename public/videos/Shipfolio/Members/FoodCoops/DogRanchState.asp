<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<!--#Include virtual="/GlobalVariables.asp"-->
<% SetLocale("en-us") 
PeopleID = 2 
State=Request.QueryString("State")
if len(state) < 1 then
State=Request.Form("State")
end if
if len(state) < 1 then
response.redirect("AllStates.asp")
end if 
sql = "SELECT * from States where StateAbbreviation =  '" & State & "'"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
StateName = trim(rs("StateName"))
rs.close
%>
<title><%=StateName %> Working Dog Ranches | <%=StateName %> Working Dog Farms | <%=StateName %> Working Dog Breeders | Dog Working Ranches in <%=StateName %> with Dog for sale.</title>
<meta name="Title" content="<%=StateName %> Dog Ranches | <%=StateName %> Dog Farms | <%=StateName %> Dog Breeders | Dog Ranches in <%=StateName %> with Dog for sale."/>
<meta name="description" content="<%=StateName %> Dog Ranches | Dog Farms in <%=StateName %> with Dog for sale." />
<meta name="robots" content="index, follow"/>
<meta name="keywords" content="<%=StateName %> Dog ranches,
Working dogs,
<%=StateName %> Working dogs,
working dogs in <%=StateName %>,
<%=StateName %> cows,
<%=StateName %> Dog Farms,
<%=StateName %> Dog for sale,
<%=StateName %> Dog breeders,
Dog ranches in <%=StateName %>,
Dog Farms in <%=StateName %>, 
Dog for sale in <%=StateName %>,
Dog breeders in <%=StateName %>,
alpakas in <%=StateName %> />
<meta name="robots" content="index, follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="7 days"/>
<meta name="Googlebot" content="index, follow"/>
<meta name="robots" content="All"/>
<meta name="subjects" content="<%=StateName %> Dog farms" />
<link rel="stylesheet" type="text/css" href="/style.css">

<style>
/* Main */
#menu
{
width: 100%;
margin: 0;
padding: 10px 0 0 0;
list-style: none;  
background: Green;
background: -moz-linear-gradient(Green, #111); 
background: -webkit-gradient(linear,left bottom,left top,color-stop(0, #111),color-stop(1, Green));	
background: -webkit-linear-gradient(Green, #111);	
background: -o-linear-gradient(Green, #111);
background: -ms-linear-gradient(Green, #111);
background: linear-gradient(Green, #111);
-moz-border-radius: 50px;
border-radius: 5px;
-moz-box-shadow: 0 2px 1px #9c9c9c;
-webkit-box-shadow: 0 2px 1px #9c9c9c;
box-shadow: 0 2px 1px #9c9c9c;
}

#menu li
{
float: left;
padding: 0 0 10px 0;
position: relative;
line-height: 0;
}

#menu a 
{
float: left;
height: 25px;
padding: 0 10px;
color: white;
font: 11px/20px verdana, Arial, Helvetica;
text-decoration: none;
text-shadow: 0 1px 0 #000;
}

#menu li:hover > a
{
color: #fafafa;
}

*html #menu li a:hover /* IE6 */
{
color: #fafafa;
}

#menu li:hover > ul
{
display: block;
}

/* Sub-menu */

#menu ul
{
list-style: none;
margin: 0;
padding: 0;    
display: none;
position: absolute;
top: 35px;
left: 0;
z-index: 99999;    
background: Green;
background: -moz-linear-gradient(Green, #111);
background: -webkit-gradient(linear,left bottom,left top,color-stop(0, #111),color-stop(1, Green));
background: -webkit-linear-gradient(Green, #111);    
background: -o-linear-gradient(Green, #111);	
background: -ms-linear-gradient(Green, #111);	
background: linear-gradient(Green, #111);
-moz-box-shadow: 0 0 2px rgba(255,255,255,.5);
-webkit-box-shadow: 0 0 2px rgba(255,255,255,.5);
box-shadow: 0px 5px 5px #ababab;
-moz-border-radius: 5px;
border-radius: 0px 0px 5px 5px;
}

#menu ul ul
{
top: 0;
left: 220px;
}

#menu ul li
{
float: none;
margin: 0;
padding: 0;
display: block;  
-moz-box-shadow: 0 1px 0 #111111, 0 2px 0 #777777;
-webkit-box-shadow: 0 1px 0 #111111, 0 2px 0 #777777;
box-shadow: 0 1px 0 #111111, 0 2px 0 #777777;
}

#menu ul li:last-child
{   
-moz-box-shadow: none;
-webkit-box-shadow: none;
box-shadow: none; 
}

#menu ul a
{    
padding: 5px;
height: 22px;
width: 220px;
line-height: 1;
display: block;
white-space: nowrap;
float: none;
text-transform: none;
}

*html #menu ul a /* IE6 */
{    
height: 10px;
}

*:first-child+html #menu ul a /* IE7 */
{    
height: 10px;
}

#menu ul a:hover
{
background: #ABABAB;
	background: -moz-linear-gradient(#04acec,  #0186ba);	
	background: -webkit-gradient(linear, left top, left bottom, from(#04acec), to(#0186ba));
	background: -webkit-linear-gradient(#04acec,  #0186ba);
	background: -o-linear-gradient(#04acec,  #0186ba);
	background: -ms-linear-gradient(#04acec,  #0186ba);
	background: linear-gradient(#04acec,  #0186ba);
}

#menu ul li:first-child > a
{
-moz-border-radius: 5px 5px 0 0;
border-radius: 5px 5px 0 0;
}

#menu ul li:first-child > a:after
{
content: '';
position: absolute;
left: 0px;
top: 8px;
width: 0;
height: 0;
border-left: 5px solid transparent;
border-right: 5px solid transparent;
border-bottom: 8px solid #444;
}

#menu ul ul li:first-child a:after
{
left: 8px;
top: 12px;
width: 0;
height: 0;
border-left: 0;	
border-bottom: 5px solid transparent;
border-top: 5px solid transparent;
border-right: 8px solid #444;
}

#menu ul li:first-child a:hover:after
{
border-bottom-color: #04acec; 
}

#menu ul ul li:first-child a:hover:after
{
border-right-color: #04acec; 
border-bottom-color: transparent; 	
}


#menu ul li:last-child > a
{
-moz-border-radius: 0 0 5px 5px;
border-radius: 0 0 5px 5px;
}

/* Clear floated elements */
#menu:after 
{
visibility: hidden;
display: block;
font-size: 0;
content: " ";
clear: both;
height: 0;
}

* html #menu             { zoom: 1; } /* IE6 */
*:first-child+html #menu { zoom: 1; } /* IE7 */
</style>
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center"><!--#Include virtual="/Header.asp"-->
<% Current = "Ranches" %>
<% Current2 = "RanchHome" %>
<!--#Include file="RanchHeader2.asp"--> 
<br />
<% signularanimal ="Dog" 
PageName = "Dog"
pluralanimal ="Dogs" 
directory = "/Dogs/" 
 Current3 = "RanchSearch" %>
<!--#Include virtual="AnimalTabsInclude.asp"-->
<table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  width = "<%=screenwidth %>"><tr><td width = "200" valign = "top" >
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td  align = "left" height = "1100" valign = Top>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
<H2><div align = "left">Find Ranches<br> by States / Province</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center" valign = "top">
<table   border="0" cellspacing="7" cellpadding="0" leftmargin="9" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top"  width = "250" height = "440"><tr><td align = "left" class = "body" valign = "top">
<!--#Include virtual="/ranches/ranchlistinclude.asp"-->

<br>
<br>
</td></tr></table>
</td></tr></table>
</td></tr></table>
</td>
<td width= "12"></td>
<td valign = "top">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "750"><tr><td class = "roundedtopandbottom" height = "1100" align = "left" valign = "top">
<H1><div align = "left"><%=StateName %> Dog Ranches</div></H1>
<table border = "0" width = "100%"  align = "center" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
  <tr>
   <td valign = "top" class = "body" align = "left">The ranches below are all located in <%=Trim(StateName) %>, listed in alphabetical order:
<%
sql = "SELECT DISTINCT People.PeopleId, Logo, AddressCountry, PeopleFirstname, PeopleLastname, Business.BusinessName, AddressStreet, AddressApt, AddressCity, AddressState, AddressZip FROM People, Business, animals, address WHERE animals.PeopleID = people.peopleID and speciesID = 3 and People.AddressID = Address.AddressID  and People.BusinessID = Business.BusinessID and People.AIPublish = True and People.AccessLevel > 0 and addressstate = '" & state & "' ORDER BY Business.BusinessName;" 
'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
 
If rs.eof Then %><br/><br/>
	<center><b>Currently there are no <%=StateName %> Dog ranches listed with Livestock of America.  </b><br/></center>
			

<%  End if

While Not rs.eof 
    PeopleID = rs("PeopleID")
	Logo = rs("Logo")
	PeopleFirstName = rs("PeopleFirstName")
	PeopleLastName = rs("PeopleLastName")
	'Owners = rs("Owners")
	'if len(Owners) < 1 then
	 '   Owners = PeopleFirstName & " " & PeopleLastName
	'end if
	'PeopleMiddleInitial = rs("PeopleMiddleInitial")
	PeopleLastName = rs("PeopleLastName")
	BusinessName = rs("BusinessName")
	AddressStreet = rs("AddressStreet")
	AddressApt = rs("AddressApt")
	AddressCity = rs("AddressCity")
	AddressState = rs("AddressState")
	AddressZip = rs("AddressZip")
	AddressCountry = rs("AddressCountry")
%>
<table border = "0" width = "400" height ="50" align = "center" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
<tr><td width = "83" align = "center" >
<% if Len(Logo) > 2 Then 
str1 = lcase(Logo) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Logo=  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
%>
<a href = "ranchhome.asp?CurrentPeopleID=<%=PeopleID%>" class = "body"><img src = "<%=Logo %>" border = "0" width = "80" alt = "<%=AddressState%> Alpaca for Sale at <%=BusinessName%> ranches."/></a>
<% End If %>
</td>
<td class = "body"  align = "left">	<% If Len(BusinessName) > 2 Then %>
<b><%=BusinessName%></b><br/>
<% End If %>
<% If Len(Owners) > 2 Then %>
<%=Owners%> <br/>
<% End If %>
<% If Len(AddressCity) > 2 Then %>
<%=AddressCity%>, <%=AddressState%> <br/>
<% End If %>
<center><a href = "/ranches/Ranchhome.asp?CurrentPeopleID=<%=PeopleID%>" class = "body" align = "center">Learn More About <%=trim(BusinessName)%>.</a></center><br />
</td></tr></table>
</div><% 
rs.movenext
wend
%></td>
<td class = "body" width = "200" valign = "top">
<td valign = "top" width = "200" class = " body roundedtopandbottom">
<center><a href = "/Join/#advertising" class = "body2" align = "center">Advertise Here</a></center><br>
<%
if rs.state = 0 then
else
rs.close
end if

 Query =  "Select AdID, AdImage, AdLink from Ads  where AdType='Search' and AdMonth = " & month(now) & " and adYear=" & year(now)& " and speciesID = 3 ORDER BY rand() limit 12"

rs.Open Query, conn, 3, 3
x = 0


while not rs.eof and x < 13
 x = x + 1
AdID = rs("AdID")
AdImage  = rs("AdImage") 
AdLink = rs("AdLink")
Link1=""
Link2 = ""
if len(AdLink) > 3 then
Link1=  AdLink
Link2= "http://" & AdLink
else
 Link2 = "/Ranches/RanchHome.asp?CurrentPeopleID=" & PeopleID
end if %>
<% If Len(AdImage) > 1 and Len(AdImage) < 131 then%>
<% If Len(Link2) > 1  then%>
 <a href = "<%=Link2 %>" target = "blank">
 <% end if %>
<img src = "<%= AdImage%>" width ="200" height = "200" border = "0" alt="Dogs For Sale">
<% If Len(Link2) > 1  then%>
 <a>
 <% end if %>
<% End If %>

<% rs.movenext
wend
rs.close
set rs=nothing
  set conn = nothing %>
<br>
<center><a href = "/Join/#advertising" class = "body2" align = "center">Advertise Here</a></center><br>
</td>


</td>


</tr></table> 
</td></tr></table> 
 <!--#Include virtual="/Footer.asp"--> 
</body>
</html>

