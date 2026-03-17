<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!--#Include virtual="/GlobalVariables.asp"-->
<% SetLocale("en-us") 
CurrentPeopleID=Request.Form("CurrentPeopleID") 
If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.QueryString("CurrentPeopleID") 
End if
If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.QueryString("PeopleID") 
End if
If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.querystring("custID") 
End if
If Not Len(CurrentPeopleID)> 0 Then 
	Response.Redirect("/Default.asp")
End if

PeopleID = CurrentPeopleID
sql = "select  * from People where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
	RanchHomeText = rs("RanchHomeText")
	BusinessID   = rs("BusinessID")
	AddressID  = rs("AddressID")
	Logo = rs("Logo")
	Header = rs("Header")
	str1 = RanchHomeText
str2 = vblf
end if 
rs.close
if len(BusinessID) > 0 then
else
response.Redirect("/default.asp")
end if
if len(BusinessID) > 0 then
sql = "select  BusinessName from Business where BusinessID= " & BusinessID
rs.Open sql, conn, 3, 3
If not rs.eof then
BusinessName = rs("BusinessName")
end if 
rs.close
end if
if len(AddressID) > 0 then
sql = "select  * from Address where AddressID= " & AddressID
rs.Open sql, conn, 3, 3
If not rs.eof then
AddressCity = rs("AddressCity")
AddressState = rs("AddressState")
end if 
rs.close
end if
%>
<title><%= BusinessName %></title>
<meta name="Title" content=" <%= BusinessName %>">
<meta name="description" content=" Animals for Sale at <%= BusinessName %> in <%= AddressCity %>, <%= AddressState %> .  " >
<meta name="robots" content="index,follow">
<meta name="rating" content="Safe for kids">
<meta name="revisit-after" content="1">
<meta name="Googlebot" content="index,follow">
<meta name="robots" content="All">
<meta name="subject" content="Livestock" >
<link rel="stylesheet" type="text/css" href="/style.css">
<% 
sql = "select * from RanchSiteDesign where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
MenuBackgroundColor = rs("MenuBackgroundColor")
MenuColor = rs("MenuColor")
MenuFontMouseOverColor = rs("MenuFontMouseOverColor")
TitleColor = rs("TitleColor")
PageBackgroundColor = rs("PageBackgroundColor")
PageTextColor = rs("PageTextColor")
LayoutStyle = rs("LayoutStyle")
PageTextMouseOverColor = rs("PageTextMouseOverColor")
End If
rs.close 
if PageBackgroundColor= "Black" Then
TitleColor = "white"
PageTextColor = "white"
end if 
%>
<style type="text/css">
H2 {font: 20pt arial; color: <%=TitleColor %>}
H3 {font: 12pt arial; color: <%=TitleColor %>}
H4 {font: 12pt arial; 
	color: <%=MenuBackgroundColor%>;
	line-height : 10px;
	font-weight: normal;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	margin: 0;
	padding: 0;
	top: 0;
    left: 0;
    border-right: 0;
    border-bottom: 0; }
		.Body {font: 10pt arial; color: black}
		A.Body {font: 10pt arial; color: brown}
		A.Body:hover { color: brown}
			.Heading {font: 10pt arial; color: <%=MenuBackgroundColor%>}
		A.Heading {font: 10pt arial; color: <%=MenuFontMouseOverColor %>}


ul.LinkedList { display: block; 
    list-style-type : none; 
	padding: 0px 0px 0px 0px;
	border: 0px 0px 0px  0px;
	margin: 0px 0px 0px  0px;
}

li 
{ line-height : 22px;
  	padding: 0px 0px 0px 0px;
	border: 0px 0px 0px  0px;
	margin: 0px 0px 0px  0px;
}

/* ul.LinkedList ul { display: none; } */
.HandCursorStyle { cursor: pointer; cursor: hand; }  /* For IE */
  </style>
<script type="text/JavaScript">
          // Add this to the onload event of the BODY element
      function addEvents() {
          activateTree(document.getElementById("LinkedList1"));
          activateTree(document.getElementById("LinkedList2"));
      }

      // This function traverses the list and add links 
      // to nested list items
      function activateTree(oList) {
         
          // Add the click-event handler to the list items
          if (oList.addEventListener) {
              oList.addEventListener("click", toggleBranch, false);
          } else if (oList.attachEvent) { // For IE
              oList.attachEvent("onclick", toggleBranch);
          }
          // Make the nested items look like links
          addLinksToBranches(oList);
      }
 // This is the click-event handler
function toggleBranch(event) {
          var oBranch, cSubBranches;
          if (event.target) {
              oBranch = event.target;
          } else if (event.srcElement) { // For IE
              oBranch = event.srcElement;
          }
cSubBranches = oBranch.getElementsByTagName("ul");
if (cSubBranches.length > 0) {
 if (cSubBranches[0].style.display == "block") {
 cSubBranches[0].style.display = "none";
} else {
cSubBranches[0].style.display = "block";
}
}
}
 // This function makes nested list items look like links
function addLinksToBranches(oList) {
var cBranches = oList.getElementsByTagName("li");
var i, n, cSubBranches;
if (cBranches.length > 0) {
for (i = 0, n = cBranches.length; i < n; i++) {
cSubBranches = cBranches[i].getElementsByTagName("ul");
if (cSubBranches.length > 0) {
addLinksToBranches(cSubBranches[0]);
cBranches[i].className = "HandCursorStyle";
cBranches[i].style.color = "brown";
cSubBranches[0].style.color = "black";
cSubBranches[0].style.cursor = "auto";
 }
 }
 }
 }
</script>
<%	Set rs = Server.CreateObject("ADODB.Recordset")
sql = "select  People.* from People where People.PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
 WebLink = rs("WebLink")
RanchHomeText = rs("RanchHomeText")
If Len(RanchHomeText) > 1 Then
Else
RanchHomeText  = " "
End If 
News = rs("RanchHomeText2")
PageText1 = rs("RanchHomeText")
PageText2 = rs("RanchHomeText2")
PageText3 = rs("RanchHomeText3")
PageText4 = rs("RanchHomeText4")
Image1= rs("RanchHomeImage1")
Image2= rs("RanchHomeImage2")
Image3= rs("RanchHomeImage3")
Image4= rs("RanchHomeImage4")
ImageOrientation1= rs("RanchHomeImageOrientation1")
ImageOrientation2= rs("RanchHomeImageOrientation2")
ImageOrientation3= rs("RanchHomeImageOrientation3")
ImageOrientation4= rs("RanchHomeImageOrientation4")
RanchHomeheading= rs("RanchHomeheading")
RanchAboutUsText = rs("RanchAboutUsText") & "<br><br>" &  rs("RanchAboutUsText2")& "<br><br>" &  rs("RanchAboutUsText3") & "<br><br>" &  rs("RanchAboutUsText4")
PeopleFirstName = rs("PeopleFirstName")
PeopleMiddleInitial  = rs("PeopleMiddleInitial")
PeopleLastName	= rs("PeopleLastName")
str1 =News
str2 = vblf
If InStr(str1,str2) > 0 Then
	News= Replace(str1, str2 , "</br>")
End If  
str1 = News
str2 = vbtab
If InStr(str1,str2) > 0 Then
	News= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  
str1 =RanchAboutUsText
str2 = vblf
If InStr(str1,str2) > 0 Then
	RanchAboutUsText= Replace(str1, str2 , "</br>")
End If  
str1 = RanchAboutUsText
str2 = vbtab
If InStr(str1,str2) > 0 Then
	RanchAboutUsText= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  
str1 = WebLink
str2 = "http://"
If InStr(str1,str2) > 0 Then
	WebLink= Replace(str1,  str2, "")
End If 
str1 = Aboutusheading
str2 = vblf
If InStr(str1,str2) > 0 Then
	Aboutusheading= Replace(str1, str2 , "</br>")
End If  
str1 = Aboutusheading
str2 = vbtab
If InStr(str1,str2) > 0 Then
	Aboutusheading= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  
rs.close
End If 
If Not(ImageOrientation1 = "Left") then
 ImageOrientation1 = "Right"
End if
%>
</head>
<BODY onload="addEvents();" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<!--#Include file="RanchHeader.asp"-->
 <% Current3 = "FarmHome" %>
 <!--#Include file="RanchPagesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" width = "100%">
	<tr>
	<td class = "roundedtopandbottom" align = "left" valign = "top">
	 <%

	 aboutuswidth = screenwidth -300
     aboutuswidth= screenwidth -300
	 %>
<table width = "<%=aboutuswidth %>" border="0"  cellspacing="3" cellpadding="3" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" height = "200" align = "center">		<tr>
<td width = "<%=aboutuswidth %>" valign = "top">
<%
str1 = lcase(Image1)
str2 = "uploads"
str3 = "http://"
If  len(str1) > 3 and Not(InStr(str1,str2) > 0) and Not(InStr(str1,str3) > 0) Then
Image1 = "http://www.livestockofamerica.com/Uploads/" & Image1
End If 

str1 = lcase(Image1)
str2 = "uploads"
str3 = "http://"
If  len(str1) > 3 and Not(InStr(str1,str3) > 0) Then
Image1 = "http://www.livestockofamerica.com/" & Image1
End If 

if len(RanchHomeText) > 1 then
For loopi=1 to Len(RanchHomeText)
    spec = Mid(RanchHomeText, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
    	RanchHomeText= Replace(RanchHomeText,  spec, " ")
   end if
 Next
end if
 if len(RanchHomeText) > 1  or Len(Image1) > 1 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  width="<%=aboutuswidth  %>" ><tr><td class = "roundedtop" align = "left" >
<H1><div align = "left"><% If Len(RanchHomeheading) > 1 Then %>
<%=RanchHomeheading%>
<% Else %>
<%=BusinessName%>
<% End if %></div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "left">
<table  border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" width = "<%=aboutuswidth %>">	
<tr><td class = "body">
<% If Len(Image1) > 1 Then
str1 = lcase(Image1) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Image1=  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  

%>
<img src = "<%=Image1%>" border = "0" align = "right" width = "200" Hspace="10" Vspace="10"/>
<% End If %> 
<br />
 <% If Len(RanchHomeText) > 12 Then %>
<font color = "<%=PageTextColor %>" >	<%=RanchHomeText%>
<% End If %>
<% If Len(RanchHomeText) < 12 And Len(RanchAboutUsText) > 12 Then %>
<% If Len(News) > 12 Then %>
<%=left(RanchAboutUsText, 600) %>
<% If Len(RanchAboutUsText) > 600 Then %>
...<br/><div align = "right"><a href = "ranchaboutus.asp?CurrentPeopleID=<%=CurrentPeopleID%>" class = "body">Read More.</a>&nbsp;</div>
<% end if %>
<% Else %>
<%=left(RanchAboutUsText, 1500) %>
<% If Len(RanchAboutUsText)> 1500 Then %>
...<br/><div align = "right"><a href = "ranchaboutus.asp?CurrentPeopleID=<%=CurrentPeopleID%>" class = "body">Read More.</a>&nbsp;</div>
<% end if %>
<% End If %>
<% End If %>
<br/><br/></font>
   </td>
  </tr>
</table></td>
  </tr>
</table>
<% End If %>  
<% If Len(trim(News)) > 15 Then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  ><tr><td class = "roundedtop" align = "left">
<H2><div align = "left">News</div></H2></td></tr>
<tr><td class = "roundedBottom" align = "left">
<table  border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" width = "<%=aboutuswidth %>">	
<tr><td><% If Len(Image2) > 1 Then 
str1 = lcase(Image2) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Image2=  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  %>
<img src = "<%=Image2%>" border = "0" align = "right" width = "200" Hspace="20" Vspace="10">
<% End If %>
<%=News%>
   </td>
  </tr>
</table>   
  </td>
  </tr>
</table>
    <br />   
<% End If %>
<% if totalanimals > 0 then %>
<tr><td valign = "top">
<table width = "<%=screenwidth -280%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Livestock for Sale</font></h2></td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% Layout = 3
Sortby  = " FullName"
 if totalAlpacas > 0 then %>
<a name= "Alpacas"></a>
<table width = "<%=screenwidth -280%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Alpacas for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">
<table width = "100%" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center">
<% 
CurrentspeciesId = 2
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Male' or category = 'Proven Male' ) and speciesID = " & CurrentspeciesId 
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Male' or category = 'Proven Male' ) order by " & Sortby 
end if 

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b> Experienced Males for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Male' or category = 'Unproven Male' )   and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Male' or category = 'Unproven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Inexperienced Males for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire" %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Female' or category = 'Proven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Female' or category = 'Proven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Experienced Females for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Female' or category = 'Unproven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Female' or category = 'Unproven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Inexperienced Females for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Non-Breeder' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Non-Breeder' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Non-Breeding / Fiber / Pet Quality Animals for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%  DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
</td></tr></table>

<% end if%>

<% if totalCattle > 0 then %>
<tr><td><a name= "Cattle"></a>
<table width = "<%=screenwidth -280%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Cattle for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">
<table width = "100%" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center">
<% 
CurrentspeciesId = 8
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Male' or category = 'Proven Male' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Male' or category = 'Proven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Experienced Males for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Male' or category = 'Unproven Male' )   and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Male' or category = 'Unproven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Inexperienced Males for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Female' or category = 'Proven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Female' or category = 'Proven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><tr><td><br><b>Experienced Males for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Dam"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Female' or category = 'Unproven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Female' or category = 'Unproven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Inexperienced Females for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "dam"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Non-Breeder' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Non-Breeder' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Non-Breeding / Fiber / Pet Quality Animals for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%  DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
</td></tr></table>
<% end if%>

<% if totalDogs > 0 then %>
<tr><td><a name= "Dogs"></a>
<table width = "<%=screenwidth -280%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Working Dogs for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">
<table width = "100%" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center">
<% 
CurrentspeciesId = 3
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Male' or category = 'Proven Male' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Male' or category = 'Proven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Experienced Males for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Male' or category = 'Unproven Male' )   and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Male' or category = 'Unproven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Inexperienced Males for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Female' or category = 'Proven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Female' or category = 'Proven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Experienced Females for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Dam"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Female' or category = 'Unproven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Female' or category = 'Unproven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Inexperienced Females for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Dam"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Non-Breeder' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Non-Breeder' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Non-Breeding / Fiber / Pet Quality Animals for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%  DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
</td></tr></table>

<% end if%>

<% if totalDonkeys > 0 then %>
<tr><td><a name= "Donkeys"></a>
<table width = "<%=screenwidth -280%> border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Donkeys for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">
<table width = "100%" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center">
<% 
CurrentspeciesId =7
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Male' or category = 'Proven Male' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Male' or category = 'Proven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Experienced Males for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Male' or category = 'Unproven Male' )   and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Male' or category = 'Unproven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Inexperienced Males for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr><%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Female' or category = 'Proven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Female' or category = 'Proven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Experienced Females for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Female' or category = 'Unproven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Female' or category = 'Unproven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Inexperienced Females for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Non-Breeder' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Non-Breeder' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Non-Breeding / Fiber / Pet Quality Animals for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%  DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
</table>

<% end if%>

<% if totalGoats > 0 then %>
<tr><td><a name= "Goats"></a>
<table width = "<%=screenwidth -280%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Goats for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">
<table width = "100%" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center">
<% 
CurrentspeciesId = 6
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Male' or category = 'Proven Male' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Male' or category = 'Proven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Experienced Males for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Male' or category = 'Unproven Male' )   and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Male' or category = 'Unproven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Inexperienced Males for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Female' or category = 'Proven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Female' or category = 'Proven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Experienced Females for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Female' or category = 'Unproven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Female' or category = 'Unproven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Inexperienced Females for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Non-Breeder' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Non-Breeder' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Non-Breeding / Fiber / Pet Quality Animals for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%  DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
</td></tr></table>
</td></tr></table>
<% end if%>


<% if totalhorses > 0 then %>
<tr><td><a name= "Horses"></a>
<table width = "<%=screenwidth -280%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Horses for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">
<table width = "100%" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center">
<% 
CurrentspeciesId = 5
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Male' or category = 'Proven Male' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Male' or category = 'Proven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Experienced Males for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Male' or category = 'Unproven Male' )   and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Male' or category = 'Unproven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Inexperienced Males for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Female' or category = 'Proven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Female' or category = 'Proven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Experienced Females for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Female' or category = 'Unproven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Female' or category = 'Unproven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Inexperienced Females for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Non-Breeder' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Non-Breeder' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Non-Breeding / Fiber / Pet Quality Animals for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%  DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
</td></tr></table>
</td></tr></table>
<% end if%>

<% if totalllamas > 0 then %>
<tr><td><a name= "Llamas"></a>
<table width = "<%=screenwidth -280%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Llamas for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">
<table width = "100%" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center">
<% 
CurrentspeciesId = 4
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Male' or category = 'Proven Male' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Male' or category = 'Proven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Experienced Males for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Male' or category = 'Unproven Male' )   and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Male' or category = 'Unproven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Experienced Males for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Female' or category = 'Proven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Female' or category = 'Proven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><tr><td><br><b>Experienced Females for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Female' or category = 'Unproven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Female' or category = 'Unproven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Inexperienced Females for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Non-Breeder' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Non-Breeder' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Non-Breeding / Fiber / Pet Quality Animals for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%  DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
</td></tr></table>
</td></tr></table>
<% end if%>

<% if totalPigs > 0 then %>
<tr><td><a name= "Pigs "></a>
<table width = "<%=screenwidth -280%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Pigs for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">
<table width = "100%" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center">

<% 
CurrentspeciesId = 12
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Male' or category = 'Proven Male' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Male' or category = 'Proven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Experienced Males for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Male' or category = 'Unproven Male' )   and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Male' or category = 'Unproven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Inexperienced Males for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Female' or category = 'Proven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Female' or category = 'Proven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><tr><td><br><b>Experienced Females for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Female' or category = 'Unproven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Female' or category = 'Unproven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Inexperienced Females for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Non-Breeder' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Non-Breeder' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Non-Breeding / Fiber / Pet Quality Animals for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%  DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
</td></tr></table>

<% end if%>




<% if totalSheep > 0 then %>
<tr><td><a name= "Sheep"></a>
<table width = "<%=screenwidth -280%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Sheep for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">
<table width = "100%" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center">
<% 
CurrentspeciesId = 10
if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Male' or category = 'Proven Male' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Male' or category = 'Proven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Experienced Males for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Male' or category = 'Unproven Male' )   and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Male' or category = 'Unproven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Inexperienced Males for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Female' or category = 'Proven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Female' or category = 'Proven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><tr><td><br><b>Experienced Females for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Female' or category = 'Unproven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Female' or category = 'Unproven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Inexperienced Females for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%   
DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Non-Breeder' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Non-Breeder' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<tr><td><br><b>Non-Breeding / Fiber / Pet Quality Animals for Sale</b></td></tr>
<tr><td bgcolor = "black" height = "1" width = "100%"></td></tr>
<%  DetailType = "Sire"  %>
<!--#Include file="HomeDetailInclude3.asp"--> 
<% end if%>
</td></tr></table>
<% end if%> 
  </td></tr></table>
  </td></tr></table>
    </td></tr></table>
<% end if %>
<% if TotalAllStuds > 0  then %>
<br>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  ><tr><td class = "roundedtop" align = "left">
<h2>Studs</h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left">
<table  border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "left" width = "<%=aboutuswidth %>">	
<tr><td>
<style>
    ul 
{ 
    list-style-type: none; 
} 
</style>
<ul id="LinkedList2" class="LinkedList">
 <% if xTotalAllStuds > 0  then %>
   <% 
 If not rs.State = adStateClosed Then
  rs.close
End If  

   sql = "select distinct PayWhatYouCanStud, FullName, PeopleID, animals.ID, Price, discount, Photo1, Photo2, Photo3, Photo4, Photo5, Photo6, Photo7, Photo8, Category, Color1,   DOBDay, DOBMonth, DOBYear, Sold, SalePending, Studfee from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Experienced Male' and PublishStud = true and PeopleID= " & CurrentPeopleID & " order by Studfee desc"

	rs.Open sql, conn, 3, 3
	If not rs.eof Then %>
    <ul>
    <% while not rs.eof %>
	    <li>
  <a href = "StudDetails.asp?ID=<%=rs("ID") %>&CurrentPeopleID=<%=CurrentpeopleID %>" class = "body"><%=rs("FullName") %></a> <%=rs("Color1") %>&nbsp;<% If Len(rs("StudFee")) > 2 And Sold = False  Then %><b><%=formatcurrency(rs("StudFee"),0)%> Fee</b>
<%End If %>
<% if rs("PayWhatYouCanStud") = True then %><a class="tooltip" href="#"><b><small>Pay What You Can</small></b><span class="custom info"><img src="/images/logoTip.png" alt="Screen Tip Pay What You Can" height="48" width="48" /><em>About Pay What You Can</em>By offering <i>Pay What You Can</i> the owner is willing to consider any offer on this stud's breeding based upon what they can afford; however, that does not mean that that have to accept an offer, if they don't want to.</span></a>
	    <% end if %>
</li>
	 <% rs.movenext 
	 wend %>
	 </ul>
	</li>
   <% end if
   rs.close 

     sql = "select distinct PayWhatYouCanStud, FullName, PeopleID, animals.ID, Price, discount, Photo1, Photo2, Photo3, Photo4, Photo5, Photo6, Photo7, Photo8, Category, Color1,   DOBDay, DOBMonth, DOBYear, Sold, SalePending, Studfee  from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Inexperienced Male' and PublishStud = true  and PeopleID= " & CurrentPeopleID  & " order by Studfee desc"
	rs.Open sql, conn, 3, 3
	If not rs.eof Then %>

    <ul>
    <% while not rs.eof %>
	    <li>
  <a href = "StudDetails.asp?ID=<%=rs("ID") %>&CurrentPeopleID=<%=CurrentpeopleID %>" class = "body"><%=rs("FullName") %></a> <%=rs("Color1") %>&nbsp;<% If Len(rs("StudFee")) > 2 And Sold = False  Then %><b><%=formatcurrency(rs("StudFee"),0)%> Fee</b>
<%End If %>
<% if rs("PayWhatYouCanStud") = True then %><a class="tooltip" href="#"><b><small>Pay What You Can</small></b><span class="custom info"><img src="/images/logoTip.png" alt="Pay What You Can for Livestock" height="48" width="48" /><em>About Pay What You Can</em>By offering <i>Pay What You Can</i> the owner is willing to consider any offer on this stud's breeding based upon what they can afford; however, that does not mean that that have to accept an offer, if they don't want to.</span></a>
	    <% end if %>
</li>
	 <% rs.movenext 
	 wend %>
	 </ul>
	</li>
   <% end if
   rs.close
    %>
<% end if 

%> 
   <% if totalAlpacasStuds > 0 then %>
   <tr><td><a name= "Alpaca Studs"></a>
<table width = "<%=screenwidth -280%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Alpaca Studs</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">
  
<%
Sortby =  " Price"
 if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true  and AGBrokered = True and speciesID = 2 order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true and PeopleID= " & CurrentPeopleID & " and speciesID = 2 order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><a name ="Alpacas"></a>
<%   
DetailType = "Sire" %>
<!--#Include file="HomeStudDetailInclude.asp"--> 
<% end if%>
</td></tr></table>
<% end if%>

<% if totalcattleStuds> 0 then %>
<tr><td><a name= "Cattle"></a>
<table width = "<%=screenwidth -280%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Cattle Studs</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true  and AGBrokered = True and speciesID = 8 order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true and PeopleID= " & CurrentPeopleID & " and speciesID = 8 order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><a name ="Alpacas"></a>
<%   
DetailType = "Sire" %>
<!--#Include file="HomeStudDetailInclude.asp"--> 
<% end if%>
</td></tr></table>
<% end if%>

<% if totalDogsStuds > 0 then %>
<tr><td><a name= "Dogs"></a>
<table width = "<%=screenwidth -280%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Working Dog Studs</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true  and AGBrokered = True and speciesID = 4 order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true and PeopleID= " & CurrentPeopleID & " and speciesID = 4 order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<%   
DetailType = "Sire" %>
<!--#Include file="HomeStudDetailInclude.asp"--> 
<% end if%>
</td></tr></table>
<% end if%>

<% if totalDonkeysStuds > 0 then %>
<tr><td><a name= "Donkeys"></a>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Donkey Studs</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true  and AGBrokered = True and speciesID = 7 order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true and PeopleID= " & CurrentPeopleID & " and speciesID = 7 order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %><a name ="Alpacas"></a>
<%   
DetailType = "Sire" %>
<!--#Include file="HomeStudDetailInclude.asp"--> 
<% end if%>
</td></tr></table>
<% end if%>

<% if totalgoatsStuds > 0 then %>
<tr><td><a name= "Goats"></a>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">GoatStuds</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true  and AGBrokered = True and speciesID = 6 order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true and PeopleID= " & CurrentPeopleID & " and speciesID = 6 order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<%   
DetailType = "Sire" %>
<!--#Include file="HomeStudDetailInclude.asp"--> 
<% end if%>
</td></tr></table>
<% end if%>


<% if totalhorsesstuds > 0 then %>
<tr><td><a name= "Horses"></a>
<table width = "<%=screenwidth -280%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Horse Studs</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true  and AGBrokered = True and speciesID = 5 order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true and PeopleID= " & CurrentPeopleID & " and speciesID = 5 order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<%   
DetailType = "Sire" %>
<!--#Include file="HomeStudDetailInclude.asp"--> 
<% end if%>
</td></tr></table>
<% end if%>

<% if totalllamasstuds > 0 then %>
<tr><td><a name= "Llamas"></a>
<table width = "<%=screenwidth -280%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">LlamaStuds</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true  and AGBrokered = True and speciesID = 4 order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true and PeopleID= " & CurrentPeopleID & " and speciesID = 4 order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<%   
DetailType = "Sire" %>
<!--#Include file="HomeStudDetailInclude.asp"--> 
<% end if%>
</td></tr></table>
<% end if%>

<% if totalpigsStuds > 0 then %>
<tr><td><a name= "Pigs "></a>
<table width = "<%=screenwidth -280%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">PigStuds</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true  and AGBrokered = True and speciesID = 12 order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true and PeopleID= " & CurrentPeopleID & " and speciesID = 12 order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<%   
DetailType = "Sire" %>
<!--#Include file="HomeStudDetailInclude.asp"--> 
<% end if%>
</td></tr></table>
<% end if%>




<% if totalSheepstuds > 0 then %>
<tr><td><a name= "Sheep"></a>
<table width = "<%=screenwidth -280%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Sheep for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true  and AGBrokered = True and speciesID = 10 order by " & Sortby
else
sql = "select * from Animals, Pricing, Colors, Photos, ancestors where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishStud = true and PeopleID= " & CurrentPeopleID & " and speciesID = 10 order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<%   
DetailType = "Sire" %>
<!--#Include file="HomeStudDetailInclude.asp"--> 

<% end if%>
</td></tr></table>
<% end if%>
</td></tr></table>
</td></tr></table>

 <% end if %>


 <% sql = "SELECT  * from Package, People, PackageAnimalCount where len(package.PeopleID) > 0 and package.PeopleID = People.PeopleID and package.ShowOnAPackages = true and package.packageid = PackageAnimalCount.packageid " & BreedsortSQL & " and People.peopleID = " & CurrentPeopleID & " order by PackagePrice Desc" 
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then %>
<br /><table width = "<%=screenwidth -260%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left">Packages</font></h2></td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">

<% While Not rs.eof  
packageid= rs("Packageid")
		Backgroundcolor = ""
		BorderColor = ""
		MouseoverColor  = ""
		adImage	  = ""
		HeaderTextFontType  = ""
		HeaderTextFontColor  = ""
		BodyTextFontType  = ""
		BodyTextFontColor  = ""
		LinkColor = ""

sql = "SELECT  ListingDesign.*, package.PackageID from ListingDesign, Package where ListingDesign.ListingDesignID = package.ListingDesignID and PackageID= " & packageid
Set rsc = Server.CreateObject("ADODB.Recordset")
rsc.Open sql, conn, 3, 3   
if rsc.eof then
	rsc.close


Query =  "INSERT INTO ListingDesign (BackgroundColor, BorderColor,  LinkMouseoverColor, image, HeaderTextFontColor,  HeaderTextFontType, BodyTextFontType, BodyTextFontColor, LinkColor)" 
	Query =  Query & " Values ('" &  BackgroundColor & "', "
	Query =  Query &   " '" & BorderColor & "' , "
	Query =  Query &   " '" & LinkMouseoverColor & "' , " 
	Query =  Query &   " '" & adImage & "' , " 
	Query =  Query &   " '" & HeaderTextFontColor & "' , " 
	Query =  Query &   " '" & HeaderTextFontType & "' , " 
	Query =  Query &   " '" & BodyTextFontType & "' , " 
	Query =  Query &   " '" & BodyTextFontColor & "' , " 
	Query =  Query &   " '" & LinkColor & "' )" 

	Conn.Execute(Query) 

	sql = "SELECT  ListingDesignID from ListingDesign order by ListingDesignID DESC"
	Set rsc = Server.CreateObject("ADODB.Recordset")
	 rsc.Open sql, conn, 3, 3   
	if Not rsc.eof then
		ListingDesignID  = rsc("ListingDesignID")
		Query =  " UPDATE Package Set ListingDesignID = " &  ListingDesignID & "" 
		Query =  Query & " where PackageID = " & PackageID & ";" 
		Conn.Execute(Query) 

	End If 
 Else
  rsc.close
 End If 
 

sql = "SELECT  ListingDesign.*, package.PackageID from ListingDesign, Package where ListingDesign.ListingDesignID = package.ListingDesignID and PackageID= " & packageid
'response.write(sql)
Set rsc = Server.CreateObject("ADODB.Recordset")
rsc.Open sql, conn, 3, 3   
sql = "SELECT  * from Package, People where cint(package.Peopleid) = cint(People.Peopleid) and packageID=" & packageID 
Set rsc = Server.CreateObject("ADODB.Recordset")
rsc.Open sql, conn, 3, 3   
 if Not rsc.eof then
PackagePrice = rsc("PackagePrice")
PackageValue = rsc("PackageValue")
PackageName = rsc("PackageName")
PackageID = rsc("PackageID")
CurrentPeopleid = rsc("Peopleid")
sql2 = "SELECT * from animals, colors, Pricing, packageanimals where colors.ID = animals.ID and pricing.ID = animals.ID and animals.id = packageanimals.animalid and packageanimals.PackageID = " & PackageID & " and animals.PeopleID = " & PeopleID
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
%>
 <a href ="/ranches/RanchPackageDetails.asp?packageid=<%=packageid %>&CurrentPeopleid=<%=CurrentPeopleid %>&TotalPrice=<%=PackageValue %>" class = "body">
<%=PackageName %></a>
<br>&nbsp;&nbsp;&nbsp;
<% if PackageValue > PackagePrice Then %>
	Full Price: <%= FormatCurrency(PackageValue,0) %>
<% End If %>
Package Price: <b><% If IsNumeric(PackagePrice) Then %>
		<%= FormatCurrency(PackagePrice,0)%>
<% Else %>
		<%= PackagePrice %>
<% End If %></b>

<% End If %>
<br />
<%
rs.movenext
Wend %>

</td></tr></Table>
<% end if %>


</td>
<td width = "200" valign = "top">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "220">
<tr>
<td class = "roundedtopandbottom Ranchmenu" align = "left" width = "220">
<% If Len(logo) > 1 and Len(logo) < 131 then%>
<% str1 = lcase(Logo) 
str2 = "/uploads/"
If  not (InStr(str1,str2) > 0) Then
Logo = "/uploads/" & Logo
End If %> 
<img src = "<%=Logo %>" width = "170" alt = "Alpacas for sale at <%=BusinessName %>" /><br />
<% else %>
<b><%=BusinessName %></b><br />
<% end if %>
<b><%=Owners %></b><br />
<% if len(AddressStreet) > 1 then %><%=AddressStreet %><br /><% end if %>
<% if len(AddressApt) > 1 then %><%=AddressApt  %><br /><% end if %>
<% if len(AddressCity) > 1 then %><%=AddressCity %>,&nbsp;<% end if %>
<% if len(AddressState) > 1 then %><%=AddressState  %>&nbsp;<% end if %>
<% if len(AddressZip) > 1 then %> <%=AddressZip %>&nbsp;<% end if %>
<% if len(AddressCountry) > 1 then %><br /><%=AddressCountry  %><% end if %>
<br />
<% if len(Phone) > 1 then %>Phone: <%=Phone  %><br /><% end if %>
<% if len(Cellphone) > 1 then %>Cell: <%=Cellphone  %><br /><% end if %>
<% if len(Fax) > 1 then %>Fax: <%=Fax  %><br /><% end if %>
<% if len(PeopleWebsite) > 1 then %><a href = "http://<%=PeopleWebsite  %>" class = "body" target = "blank">Go To Website</a><br /><% end if %>	
</td>
</tr>
</table>
<img src = "/images/px.gif" width = "200" height = "1" alt = "Animals for Sale" border ="0" />
 <% if Totalanimals > 0 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  ><tr><td class = "roundedtop" align = "left">
<H2><div align = "left">Featured Animal</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "left">
<table  border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" width = "180">					<%
FeaturedAlpaca1 = 0
		FeaturedAlpaca2 = 0
		FeaturedHerdsire = 0
sql = "select * from People where PeopleID = " & CurrentPeopleID
	'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
		If Len(rs("FeaturedAlpaca1")) > 0 then
			 FeaturedAlpaca1 = rs("FeaturedAlpaca1")
		Else
			FeaturedAlpaca1 = 0
		End if
		If Len( rs("FeaturedAlpaca2")) > 0 then
			 FeaturedAlpaca2 = rs("FeaturedAlpaca2")
		Else
			FeaturedAlpaca2 = 0
		End If
		
		If Len( rs("FeaturedHerdsire")) > 0 then
			 FeaturedHerdsire = rs("FeaturedHerdsire")
		Else
			FeaturedHerdsire = 0
		End if
	Else
		FeaturedAlpaca1 = 0
		FeaturedAlpaca2 = 0
		FeaturedHerdsire = 0
	End if
    Nothinglisted = true
	If FeaturedAlpaca1 = 0 then

		 sql = "select * from Animals, Pricing, Photos where Animals.ID = Pricing.ID  and sold = false and  Animals.ID=Photos.ID and PublishForsale = true and forsale = True  and PeopleID= " & CurrentPeopleID

		'response.write (sql)
		 Set rs = Server.CreateObject("ADODB.Recordset")
		 rs.Open sql, conn, 3, 3   
			If Not rs.eof Then
				If rs.recordcount > 1 then
					max=rs.recordcount - 1
					min=1
			
					Randomize
					my_num=int((max-min+1)*rnd+min)
					'Response.Write my_num
					For i = 0 To my_num - 1
						rs.movenext
					Next
				End if
				 FeaturedAlpaca1 = rs("ID")
				 DetailType = "Other" 
 			    Nothinglisted = False
			  End If 
			  
			  Else
			 sql = "SELECT distinct Animals.*, Pricing.*, Photos.*, People.accesslevel FROM Animals, Pricing, Photos, People WHERE Animals.ID=Pricing.ID  And Animals.ID=Photos.ID And Animals.PeopleID=People.PeopleID and forsale = true and animals.ID= " & FeaturedAlpaca1
			' response.write (sql)
			  Set rs = Server.CreateObject("ADODB.Recordset")
			rs.Open sql, conn, 3, 3   
			If Not rs.eof Then
				AnimalID1 = FeaturedAlpaca1
				 DetailType = "Other" 
				Nothinglisted = False
			End if
	End If 
			 
			 %>
			<tr>
			<td  class = "body">
			 <% If Nothinglisted = False Then %>
				
				<% Else %>
						<font color = "<%=PageTextColor %>" >No Featured animal.<br/><br/></font>
				<% End If %>
			</td>
		</tr>
			<tr>
			<td class = "body">
			 <% If Nothinglisted = False Then %>
				<!--#Include file="RanchOneAnimalDetailInclude.asp"--> 
				<% End If %>
			</td>
		</tr>
</table>
</td>
</tr>
</table>	
<% end if %>
<img src = "/images/px.gif" width = "200" height = "1" alt = "Animals for Sale" border ="0" />
<%  if TotalAllStuds> 0  then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  ><tr><td class = "roundedtop" align = "left">
<H2><div align = "left">Featured Stud</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "left">
<table  border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" width = "200">			
<%	NoHerdsireslisted = True
	'response.Write("FeaturedHerdsire=" & FeaturedHerdsire )
	If FeaturedHerdsire = 0 Then

sql = "SELECT distinct Animals.*, Pricing.*, Photos.* FROM Animals, Pricing, Photos, People WHERE Animals.ID=Pricing.ID  And Animals.ID=Photos.ID And Animals.PeopleID=People.PeopleID     and len(Photo1) > 3   and sold = false and len(studfee)> 1 and People.PeopleID = " & CurrentPeopleID & " and (Category = 'Experienced Male' or Category = 'Inexperienced Male') "

		'response.write (sql)
		 Set rs = Server.CreateObject("ADODB.Recordset")
		 rs.Open sql, conn, 3, 3   
			If Not rs.eof Then
				If rs.recordcount > 1 Then
					
					max=rs.recordcount - 1
					min=0
			
					Randomize
					my_num=int((max-min+1)*rnd+min)
					'Response.Write my_num
					For i = 0 To my_num - 1
						rs.movenext
					Next
				End if
				 FeaturedHerdsire = rs("ID")
				 DetailType = "Other" 
				 NoHerdsireslisted = False 
			  End If 
			  
			  Else
			 sql = "SELECT distinct Animals.*, Pricing.*, Photos.* FROM Animals, Pricing, Photos, People WHERE Animals.ID=Pricing.ID  And Animals.ID=Photos.ID And Animals.PeopleID=People.PeopleID  and animals.ID= " & FeaturedHerdsire
			'response.write (sql)
			  Set rs = Server.CreateObject("ADODB.Recordset")
			rs.Open sql, conn, 3, 3   
			If Not rs.eof Then
				 DetailType = "Other" 
				NoHerdsireslisted = False 
			End if
	End If 
			 
			 %>
			<tr>
			<td class = "body">
				 <% If NoHerdsireslisted = False Then %>
				<!--#Include file="RanchHerdsirelDetailInclude.asp"--> 
				<% Else %>
						No Stud services listed.
				<% End If %>
			</td>
		</tr>
</table>
</td>
</tr>
</table>
	<% End If %>


    </td>
</tr>
</table>	

</td>
</tr>
</table>	
</td>
</tr>
</table>	
<!--#Include virtual="/Footer.asp"--></body>
</html>