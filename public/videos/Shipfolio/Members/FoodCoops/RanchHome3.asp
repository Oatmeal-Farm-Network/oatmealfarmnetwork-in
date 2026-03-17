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
	Response.Redirect("Default.asp")
End if
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
response.Redirect("default.asp")
end if
sql = "select  BusinessName from Business where BusinessID= " & BusinessID
rs.Open sql, conn, 3, 3
If not rs.eof then
BusinessName = rs("BusinessName")
end if 
rs.close
sql = "select  * from Address where AddressID= " & AddressID
rs.Open sql, conn, 3, 3
If not rs.eof then
AddressCity = rs("AddressCity")
AddressState = rs("AddressState")
end if 
rs.close
if len(AddressState) > 1 then
  sql = "SELECT * from States where StateAbbreviation =  '" & AddressState & "'"
'response.write (sql)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql, conn, 3, 3   
if not rs2.eof then
StateName = trim(rs2("StateName"))
StateAbbreviation = rs2("StateAbbreviation")
Nicknames = rs2("Nicknames") 
end if
rs2.close
end if
%>
<title><%=StateName %> Animals | <%= BusinessName %></title>
<meta name="Title" content="<%=StateName %> Animals | <%= BusinessName %>">
<meta name="description" content="<%=StateName %> Animals (Animals for Sale) at <%= BusinessName %> in <%= AddressCity %>, <%= AddressState %> presented by Livestock of America - Online Animal marketplace.  " >
<meta name="robots" content="index,follow">
<meta name="rating" content="Safe for kids">
<meta name="revisit-after" content="1">
<meta name="Googlebot" content="index,follow">
<meta name="robots" content="All">
<link rel="shortcut icon" href="/infinityknot.ico" > 
<link rel="icon" href="http://www.Animalinfinity.com/infinityknot.ico" > 
<meta name="subject" content="<%=StateName %> Animals, <%=StateName %> Animals for Sale" >
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

if len(Image1) > 4 then
str1 = lcase(Image1)
str2 = "uploads"
str3 = "http://"
If Not(InStr(str1,str2) > 0) and Not(InStr(str1,str3) > 0) Then
Image1 = "http://www.AlpacaInfinity.com/Uploads/" & Image1
End If 
str1 = lcase(Image1)
str2 = "uploads"
str3 = "http://"
If  InStr(str1,str2) > 0 and Not(InStr(str1,str3) > 0) Then
Image1 = "http://www.AlpacaInfinity.com/" & Image1
End If 
end if

if len(Image2) > 4 then
str1 = lcase(Image2)
str2 = "uploads"
str3 = "http://"
If Not(InStr(str1,str2) > 0) and Not(InStr(str1,str3) > 0) Then
Image2 = "http://www.AlpacaInfinity.com/Uploads/" & Image2
End If 
str1 = lcase(Image2)
str2 = "uploads"
str3 = "http://"
If  InStr(str1,str2) > 0 and Not(InStr(str1,str3) > 0) Then
Image2 = "http://www.AlpacaInfinity.com/" & Image2
End If 
end if

if len(Image3) > 4 then
str1 = lcase(Image3)
str2 = "uploads"
str3 = "http://"
If Not(InStr(str1,str2) > 0) and Not(InStr(str1,str3) > 0) Then
Image3 = "http://www.AlpacaInfinity.com/Uploads/" & Image3
End If 
str1 = lcase(Image3)
str2 = "uploads"
str3 = "http://"
If  InStr(str1,str2) > 0 and Not(InStr(str1,str3) > 0) Then
Image3 = "http://www.AlpacaInfinity.com/" & Image3
End If 
end if

if len(Image4) > 4 then
str1 = lcase(Image4)
str2 = "uploads"
str3 = "http://"
If Not(InStr(str1,str2) > 0) and Not(InStr(str1,str3) > 0) Then
Image4 = "http://www.AlpacaInfinity.com/Uploads/" & Image4
End If 
str1 = lcase(Image4)
str2 = "uploads"
str3 = "http://"
If  InStr(str1,str2) > 0 and Not(InStr(str1,str3) > 0) Then
Image4 = "http://www.AlpacaInfinity.com/" & Image4
End If 
end if

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

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" >
	<tr>
	<td class = "roundedtopandbottom" align = "left" >
	 <% if TotalAllStuds > 0 or TotalHuacayas > 0 or TotalSuris > 0 then 
	 aboutuswidth = "450"
	 else
	 aboutuswidth = "680"
	 end if
	 %>
<table width = "989" border="0"  cellspacing="3" cellpadding="3" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" height = "200" align = "center">		<tr>
<td width = "<%=aboutuswidth %>" valign = "top"><%
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
<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  ><tr><td class = "roundedtop" align = "left">
<H1><div align = "left"><% If Len(RanchHomeheading) > 1 Then %>
<%=RanchHomeheading%>
<% Else %>
<%=BusinessName%>
<% End if %></div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "left">
<table  border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" width = "<%=aboutuswidth %>">	
<tr><td class = "body">
<% If Len(Image1) > 1 Then %>
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
<tr><td><% If Len(Image2) > 1 Then %>
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
<% if TotalSuris > 0 or TotalHuacayas > 0then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  ><tr><td class = "roundedtop" align = "left">
<h2>Animals for Sale</h2>
 </td></tr>
<tr><td class = "roundedBottom" align = "left">
<table  border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "left" width = "450">	
<tr><td>
<style>
    ul 
{ 
    list-style-type: none; 
} 
</style>
<ul id="LinkedList1" class="LinkedList">
<% if TotalHuacayas > 0 then %>
 <B>Huacayas</B>
 <%  If not rs.State = adStateClosed Then
rs.close
End If   
if CurrentPeopleID = 1016 then
 sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Experienced Male' and PublishForSale = true and breed = 'huacaya' and AGBrokered = True order by Price desc" 
else
 sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Experienced Male' and PublishForSale = true and breed = 'huacaya' and PeopleID= " & CurrentPeopleID & " order by Price desc"
end if 
	rs.Open sql, conn, 3, 3
	If not rs.eof Then %>
	<li >Experienced Huacaya Males - Herdsires (<%=rs.recordcount %>)
    <ul>
    <% while not rs.eof %>
    
    <% AnimalName =rs("FullName")
	 if len(AnimalName) > 1 then
For loopi=1 to Len(AnimalName)
    spec = Mid(AnimalName, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
    	AnimalName= Replace(AnimalName,  spec, " ")
   end if
Next
end if
%>
<li><a class="tooltip" href="#"><b>&#8734;</b><span class="custom info"><% if len(rs("Photo1"))> 1 then %><img src="<%=rs("Photo1") %>" alt="<%=AnimalName %>" width="80"  /><% end if %>
<table width = "190" align = "center" cellpadding = "0" cellspacing = "0">
<tr><td>
<em><%=AnimalName %></em>
<% 
Pricecomments = rs("PriceComments")
Sold = rs("Sold")
response.write("sold=" & sold)

If Len(PriceComments) > 2 Then %>
 <div align = "left"><b><%=PriceComments%></b></div><br>
<%End If %>
<% If Sold = 1 Then %>
<br><font color = "#6a9ac6" ><b>SOLD</b></font><br>
<% End if %>
<% If SalePending= True Then %>
<br><font color = "#6a9ac6" ><b>Sale Pending</b></font><br>
<% End if %>
<% If Len(rs("StudFee")) > 2 And Sold = 0  Then %>
<b>Stud Fee:</b>
&nbsp;<b><%=formatcurrency(rs("StudFee"),0)%></b><br>
<%End If %>
<% If Len(rs("Price")) > 2 And Sold = 0  Then %>
<b>Price:</b>&nbsp;<b><%=formatcurrency(rs("Price"),0)%></b><br>
<%End If %>
<% If Len(rs("Discount")) > 1 Then %>
Discount:&nbsp;<b><font color ="#990000"><%=rs("Discount")%>%</font>
Discount Price: <font color ="#990000"> <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %></font></b><br>
<% end if %>
 DOB: <%=rs("DOBMonth")%>/<%=rs("DOBDay")%>/<%=rs("DOBYear")%><br>	
Breed: <%=rs("Breed")%><br>
Category:&nbsp;<%=rs("Category")%><br>
Color: <% If Len(rs("Color1")) > 1 Then %>
<%=rs("Color1")%><% end if %>
<% If Len(rs("Color2")) > 1 Then %>/<%=rs("Color2")%>
<% end if %>
<% If Len(rs("Color3")) > 1 Then %>
		<br><img src = "images/px.gif" width = "22" height = "2"><br>/<%=rs("Color3")%>
<% end if %>
<% If Len(rs("Color4")) > 1 Then %>
		<br>/<%=rs("Color4")%>
<% end if %>
<% If Len(rs("Color5")) > 1 Then %>
		<br>/<%=rs("Color5")%>
 <% end if %>	
</td></tr></table>
</span></a>
<a href = "Details.asp?ID=<%=rs("ID") %>&CurrentPeopleID=<%=CurrentpeopleID %>" class = "body"><%=rs("FullName") %></a> <%=rs("Color1") %>&nbsp;  <% if len(rs("Price")) > 2 then%>
	    <% if len(rs("Discount")) > 1   then %>
	       <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %>
	       <% else %>
	       <%=formatcurrency(rs("Price"),2) %>
	    <% end if %>
	   <% end if %>
	    <% if rs("OBO") = True then %>
	    <a class="tooltip" href="#"><b>OBO</b><span class="custom info"><img src="/images/logoTip.png" alt="Screen Tip" height="48" width="48" /><em>About OBO</em>By offering OBO the seller is willing to consider any offers that are made; however, that does not mean that they have to accept an offer.</span></a>
<% end if %>
</li>
	 <% rs.movenext 
	 wend %>
	 </ul>
	</li>
   <% end if
   rs.close %>
<% if CurrentPeopleID = 1016 then 
    sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Inexperienced Male' and PublishForSale = true and breed = 'huacaya' and AGBrokered= True  order by Price desc"
    else
 sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Inexperienced Male' and PublishForSale = true and breed = 'huacaya' and PeopleID= " & CurrentPeopleID & " order by Price desc"
 end if
rs.Open sql, conn, 3, 3
	If not rs.eof Then %>
	<li >Inexperienced Huacaya Males - Jr. Herdsires & Juvenile Males (<%=rs.recordcount %>)
    <ul>
    <% while not rs.eof %>
	    <li><a class="tooltip" href="#"><b>&#8734;</b><span class="custom info"><% if len(rs("Photo1"))> 1 then %><img src="<%=rs("Photo1") %>" alt="<%=rs("FullName") %>" width="80"  /><% end if %>
	<table width = "190" align = "center" cellpadding = "0" cellspacing = "0">
	<tr><td>
	<em><%=rs("FullName") %></em>
<% If Len(PriceComments) > 2 Then %>
 <div align = "left"><b><%=rs("PriceComments")%></b></div><br>
<%End If %>
<% If Sold = True Then %>
<br><font color = "#6a9ac6" ><b>SOLD</b></font><br>
<% End if %>
<% If SalePending= True Then %>
<br><font color = "#6a9ac6" ><b>Sale Pending</b></font><br>
<% End if %>
<% If Len(rs("StudFee")) > 2 And Sold = False  Then %>
<b>Stud Fee:</b>
&nbsp;<b><%=formatcurrency(rs("StudFee"),0)%></b><br>
<%End If %>
<% If Len(rs("Price")) > 2 And Sold = False  Then %>
<b>Price:</b>&nbsp;<b><%=formatcurrency(rs("Price"),0)%></b><br>
<%End If %>
<% If Len(rs("Discount")) > 1 Then %>
Discount:
&nbsp;<b><font color ="#990000"><%=rs("Discount")%>%</font>
Discount Price: <font color ="#990000"> <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %></font></b><br>
<% end if %>
 DOB: <%=rs("DOBMonth")%>/<%=rs("DOBDay")%>/<%=rs("DOBYear")%><br>	
Breed: <%=rs("Breed")%><br>
Category:&nbsp;<%=rs("Category")%><br>
Color: <% If Len(rs("Color1")) > 1 Then %>
<%=rs("Color1")%><% end if %>
<% If Len(rs("Color2")) > 1 Then %>/<%=rs("Color2")%>
<% end if %>
<% If Len(rs("Color3")) > 1 Then %>
		<br><img src = "images/px.gif" width = "22" height = "2"><br>/<%=rs("Color3")%>
<% end if %>
<% If Len(rs("Color4")) > 1 Then %>
		<br>/<%=rs("Color4")%>
<% end if %>
<% If Len(rs("Color5")) > 1 Then %>
		<br>/<%=rs("Color5")%>
 <% end if %>	
</td></tr></table>
  </span></a>
 <a href = "Details.asp?ID=<%=rs("ID") %>&CurrentPeopleID=<%=CurrentpeopleID %>" class = "body"><%=rs("FullName") %></a> <%=rs("Color1") %>&nbsp;  <% if len(rs("Price")) > 2 then%>
	    <% if len(rs("Discount")) > 1   then %>
	       <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %>
	       <% else %>
	       <%=formatcurrency(rs("Price"),2) %>
	    <% end if %>
	   <% end if %>
	    <% if rs("OBO") = True then %>
	    <a class="tooltip" href="#"><b>OBO</b><span class="custom info"><img src="/images/logoTip.png" alt="AI Screen Tip" height="48" width="48" /><em>About OBO</em>By offering OBO the seller is willing to consider any offers that are made; however, that does not mean that they have to accept an offer.</span></a>
	    <% end if %>
</li>
	 <% rs.movenext 
	 wend %>
	 </ul>
	</li>
   <% end if
   rs.close  
      if CurrentPeopleID = 1016 then
      sql = "select distinct * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Experienced Female' and PublishForSale = true and breed = 'huacaya' and AGBrokered= True order by Price desc"
      else
 sql = "select distinct * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Experienced Female' and PublishForSale = true and breed = 'huacaya' and PeopleID= " & CurrentPeopleID & " order by Price desc"
end if
	rs.Open sql, conn, 3, 3
	If not rs.eof Then %>
	<li >Experienced Huacaya Females - Dams (<%=rs.recordcount %>)
    <ul>
    <% Oldname = "oldname"
    Newname = "newname"
    while not rs.eof 
    Oldname = rs("FullName")
    if not (Oldname = Newname) then %>
<li><a class="tooltip" href="#"><b>&#8734;</b><span class="custom info"><% if len(rs("Photo1"))> 1 then %><img src="<%=rs("Photo1") %>" alt="<%=rs("FullName") %>" width="80"  /><% end if %>
	<table width = "190" align = "center" cellpadding = "0" cellspacing = "0">
	<tr><td>
	<em><%=rs("FullName") %></em>
<% If Len(PriceComments) > 2 Then %>
 <div align = "left"><b><%=rs("PriceComments")%></b></div><br>
<%End If %>
<% If Sold = True Then %>
<br><font color = "#6a9ac6" ><b>SOLD</b></font><br>
<% End if %>
<% If SalePending= True Then %>
			<br><font color = "#6a9ac6" ><b>Sale Pending</b></font><br>
<% End if %>
<% If Len(rs("StudFee")) > 2 And Sold = False  Then %>
<b>Stud Fee:</b>
&nbsp;<b><%=formatcurrency(rs("StudFee"),0)%></b><br>
<%End If %>

<% If Len(rs("Price")) > 2 And Sold = False  Then %>
<b>Price:</b>&nbsp;<b><%=formatcurrency(rs("Price"),0)%></b><br>
<%End If %>
<% If Len(rs("Discount")) > 1 Then %>
Discount:
&nbsp;<b><font color ="#990000"><%=rs("Discount")%>%</font>
Discount Price: <font color ="#990000"> <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %></font></b><br>
<% end if %>
 DOB: <%=rs("DOBMonth")%>/<%=rs("DOBDay")%>/<%=rs("DOBYear")%><br>	
Breed: <%=rs("Breed")%><br>
Category:&nbsp;<%=rs("Category")%><br>

Color: <% If Len(rs("Color1")) > 1 Then %>
		<%=rs("Color1")%><% end if %>
<% If Len(rs("Color2")) > 1 Then %>/<%=rs("Color2")%>
<% end if %>
<% If Len(rs("Color3")) > 1 Then %>
		<br><img src = "images/px.gif" width = "22" height = "2"><br>/<%=rs("Color3")%>
<% end if %>
<% If Len(rs("Color4")) > 1 Then %>
		<br>/<%=rs("Color4")%>
<% end if %>
<% If Len(rs("Color5")) > 1 Then %>
		<br>/<%=rs("Color5")%>
 <% end if %>	
 <br>
 </td></tr></table>
  </span></a>
<a href = "details.asp?ID=<%=rs("ID") %>&CurrentPeopleID=<%=CurrentpeopleID %>" class = "body"><%=rs("FullName") %></a> <%=rs("Color1") %>&nbsp;  <% if len(rs("Price")) > 2 then%>
	    <% if len(rs("Discount")) > 1   then %>
	       <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %>
	       <% else %>
	       <%=formatcurrency(rs("Price"),2) %>
	    <% end if %>
	   <% end if %>
	    <% if rs("OBO") = True then %>
	    <a class="tooltip" href="#"><b>OBO</b><span class="custom info"><img src="/images/logoTip.png" alt="About OBO" height="48" width="48" /><em>About OBO</em>By offering OBO the seller is willing to consider any offers that are made; however, that does not mean that they have to accept an offer.</span></a>
 <% end if %>
</li>
<% end if
Newname = rs("FullName") 
rs.movenext 
 wend %>
</ul>
</li>
<% end if
   rs.close 
 if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Inexperienced Female' and PublishForSale = true and breed = 'huacaya' and AGBrokered= True order by Price desc"
else
sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Inexperienced Female' and PublishForSale = true and breed = 'huacaya' and PeopleID= " & CurrentPeopleID & " order by Price desc"

end if 

	rs.Open sql, conn, 3, 3
	If not rs.eof Then %>
	<li >Inexperienced Huacaya Females - Maidens (<%=rs.recordcount %>)
    <ul>
    <% while not rs.eof %>
	    <li><a class="tooltip" href="#"><b>&#8734;</b><span class="custom info"><% if len(rs("Photo1"))> 1 then %><img src="<%=rs("Photo1") %>" alt="<%=rs("FullName") %>" width="80"  /><% end if %>
	<table width = "190" align = "center" cellpadding = "0" cellspacing = "0">
	<tr><td>
	<em><%=rs("FullName") %></em>
<% If Len(PriceComments) > 2 Then %>
 <div align = "left"><b><%=rs("PriceComments")%></b></div><br>
<%End If %>
<% If Sold = True Then %>
<br><font color = "#6a9ac6" ><b>SOLD</b></font><br>
<% End if %>
<% If SalePending= True Then %>
			<br><font color = "#6a9ac6" ><b>Sale Pending</b></font><br>
<% End if %>
<% If Len(rs("StudFee")) > 2 And Sold = False  Then %>
<b>Stud Fee:</b>
&nbsp;<b><%=formatcurrency(rs("StudFee"),0)%></b><br>
<%End If %>

<% If Len(rs("Price")) > 2 And Sold = False  Then %>
<b>Price:</b>&nbsp;<b><%=formatcurrency(rs("Price"),0)%></b><br>
<%End If %>
<% If Len(rs("Discount")) > 1 Then %>
Discount:
&nbsp;<b><font color ="#990000"><%=rs("Discount")%>%</font>
Discount Price: <font color ="#990000"> <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %></font></b><br>
<% end if %>
 DOB: <%=rs("DOBMonth")%>/<%=rs("DOBDay")%>/<%=rs("DOBYear")%><br>	
Breed: <%=rs("Breed")%><br>
Category:&nbsp;<%=rs("Category")%><br>

Color: <% If Len(rs("Color1")) > 1 Then %>
		<%=rs("Color1")%><% end if %>
<% If Len(rs("Color2")) > 1 Then %>/<%=rs("Color2")%>
<% end if %>
<% If Len(rs("Color3")) > 1 Then %>
		<br><img src = "images/px.gif" width = "22" height = "2"><br>/<%=rs("Color3")%>
<% end if %>
<% If Len(rs("Color4")) > 1 Then %>
		<br>/<%=rs("Color4")%>
<% end if %>
<% If Len(rs("Color5")) > 1 Then %>
		<br>/<%=rs("Color5")%>
 <% end if %>	
 <br>
 </td></tr></table>
  </span></a>
	    
	    <a href = "details.asp?ID=<%=rs("ID") %>&CurrentPeopleID=<%=CurrentpeopleID %>" class = "body"><%=rs("FullName") %></a> <%=rs("Color1") %>&nbsp;  <% if len(rs("Price")) > 2 then%>
	    <% if len(rs("Discount")) > 1   then %>
	       <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %>
	       <% else %>
	       <%=formatcurrency(rs("Price"),2) %>
	    <% end if %>
	   <% end if %>
	    <% if rs("OBO") = True then %>
	    <a class="tooltip" href="#"><b>OBO</b><span class="custom info"><img src="/images/logoTip.png" alt="About OBO Screen Tip" height="48" width="48" /><em>About OBO</em>By offering OBO the seller is willing to consider any offers that are made; however, that does not mean that they have to accept an offer.</span></a>
	    <% end if %>
</li>
	 <% rs.movenext 
	 wend %>
	 </ul>
	</li>
   <% end if
   rs.close %>
   
   
   <% if CurrentPeopleID = 1016 then
       sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Non-Breeder' and PublishForSale = true and breed = 'huacaya' and AGBrokered= True  order by Price desc"
   else
    sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Non-Breeder' and PublishForSale = true and breed = 'huacaya' and PeopleID= " & CurrentPeopleID & " order by Price desc"
end if
	rs.Open sql, conn, 3, 3
	If not rs.eof Then %>
	<li >Non-Breeding Huacayas (<%=rs.recordcount %>)
    <ul>
    <% while not rs.eof %>
	    <li><a class="tooltip" href="#"><b>&#8734;</b><span class="custom info"><% if len(rs("Photo1"))> 1 then %><img src="<%=rs("Photo1") %>" alt="<%=rs("FullName") %>" width="80"  /><% end if %>
	<table width = "190" align = "center" cellpadding = "0" cellspacing = "0">
	<tr><td>
	<em><%=rs("FullName") %></em>
<% If Len(PriceComments) > 2 Then %>
 <div align = "left"><b><%=rs("PriceComments")%></b></div><br>
<%End If %>
<% If Sold = True Then %>
<br><font color = "#6a9ac6" ><b>SOLD</b></font><br>
<% End if %>
<% If SalePending= True Then %>
			<br><font color = "#6a9ac6" ><b>Sale Pending</b></font><br>
<% End if %>
<% If Len(rs("StudFee")) > 2 And Sold = False  Then %>
<b>Stud Fee:</b>
&nbsp;<b><%=formatcurrency(rs("StudFee"),0)%></b><br>
<%End If %>

<% If Len(rs("Price")) > 2 And Sold = False  Then %>
<b>Price:</b>&nbsp;<b><%=formatcurrency(rs("Price"),0)%></b><br>
<%End If %>
<% If Len(rs("Discount")) > 1 Then %>
Discount:
&nbsp;<b><font color ="#990000"><%=rs("Discount")%>%</font>
Discount Price: <font color ="#990000"> <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %></font></b><br>
<% end if %>
 DOB: <%=rs("DOBMonth")%>/<%=rs("DOBDay")%>/<%=rs("DOBYear")%><br>	
Breed: <%=rs("Breed")%><br>
Category:&nbsp;<%=rs("Category")%><br>

Color: <% If Len(rs("Color1")) > 1 Then %>
		<%=rs("Color1")%><% end if %>
<% If Len(rs("Color2")) > 1 Then %>/<%=rs("Color2")%>
<% end if %>
<% If Len(rs("Color3")) > 1 Then %>
		<br><img src = "images/px.gif" width = "22" height = "2"><br>/<%=rs("Color3")%>
<% end if %>
<% If Len(rs("Color4")) > 1 Then %>
		<br>/<%=rs("Color4")%>
<% end if %>
<% If Len(rs("Color5")) > 1 Then %>
		<br>/<%=rs("Color5")%>
 <% end if %>	
 <br>
 </td></tr></table>
  </span></a>
	    
	    <a href = "details.asp?ID=<%=rs("ID") %>&CurrentPeopleID=<%=CurrentpeopleID %>" class = "body"><%=rs("FullName") %></a> <%=rs("Color1") %>&nbsp;  <% if len(rs("Price")) > 2 then%>
	    <% if len(rs("Discount")) > 1   then %>
	       <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %>
	       <% else %>
	       <%=formatcurrency(rs("Price"),2) %>
	    <% end if %>
	   <% end if %>
	    <% if rs("OBO") = True then %>
	    <a class="tooltip" href="#"><b>OBO</b><span class="custom info"><img src="/images/logoTip.png" alt="Or Best Offer" height="48" width="48" /><em>About OBO</em>By offering OBO the seller is willing to consider any offers that are made; however, that does not mean that they have to accept an offer.</span></a>
	    <% end if %>
</li>
	 <% rs.movenext 
	 wend %>
	 </ul>
	</li>
   <% end if
   rs.close %>

  <% end if 
  If not rs.State = adStateClosed Then
  rs.close
End If  
 
 if TotalSuris > 0 then %>
 <B>Suris</B>
   <% 
 if CurrentPeopleID = 1016 then
   sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Experienced Male' and PublishForSale = true and breed = 'suri' and AGBrokered=True  order by Price desc"
else
sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Experienced Male' and PublishForSale = true and breed = 'suri' and PeopleID= " & CurrentPeopleID & " order by Price desc"
end if
	rs.Open sql, conn, 3, 3
	If not rs.eof Then %>
	<li >Experienced Suri Males - Herdsires (<%=rs.recordcount %>)
    <ul>
    <% while not rs.eof %>
     <% AnimalName =rs("FullName")
	 if len(AnimalName) > 1 then
For loopi=1 to Len(AnimalName)
    spec = Mid(AnimalName, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
    	AnimalName= Replace(AnimalName,  spec, " ")
   end if
 Next
end if %>
<li><a class="tooltip" href="#"><b>&#8734;</b><span class="custom info"><% if len(rs("Photo1"))> 1 then %><img src="<%=rs("Photo1") %>" alt="<%=AnimalName %>" width="80"  /><% end if %>
	<table width = "190" align = "center" cellpadding = "0" cellspacing = "0">
	<tr><td>
	<em><%=AnimalName %></em>
<% If Len(PriceComments) > 2 Then %>
 <div align = "left"><b><%=rs("PriceComments")%></b></div><br>
<%End If %>
<% If Sold = True Then %>
<br><font color = "#6a9ac6" ><b>SOLD</b></font><br>
<% End if %>
<% If SalePending= True Then %>
			<br><font color = "#6a9ac6" ><b>Sale Pending</b></font><br>
<% End if %>
<% If Len(rs("StudFee")) > 2 And Sold = False  Then %>
<b>Stud Fee:</b>
&nbsp;<b><%=formatcurrency(rs("StudFee"),0)%></b><br>
<%End If %>

<% If Len(rs("Price")) > 2 And Sold = False  Then %>
<b>Price:</b>&nbsp;<b><%=formatcurrency(rs("Price"),0)%></b><br>
<%End If %>
<% If Len(rs("Discount")) > 1 Then %>
Discount:
&nbsp;<b><font color ="#990000"><%=rs("Discount")%>%</font>
Discount Price: <font color ="#990000"> <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %></font></b><br>
<% end if %>
 DOB: <%=rs("DOBMonth")%>/<%=rs("DOBDay")%>/<%=rs("DOBYear")%><br>	
Breed: <%=rs("Breed")%><br>
Category:&nbsp;<%=rs("Category")%><br>

Color: <% If Len(rs("Color1")) > 1 Then %>
		<%=rs("Color1")%><% end if %>
<% If Len(rs("Color2")) > 1 Then %>/<%=rs("Color2")%>
<% end if %>
<% If Len(rs("Color3")) > 1 Then %>
		<br><img src = "images/px.gif" width = "22" height = "2"><br>/<%=rs("Color3")%>
<% end if %>
<% If Len(rs("Color4")) > 1 Then %>
		<br>/<%=rs("Color4")%>
<% end if %>
<% If Len(rs("Color5")) > 1 Then %>
		<br>/<%=rs("Color5")%>
 <% end if %>	
 <br>
 </td></tr></table>
  </span></a>
 <a href = "details.asp?ID=<%=rs("ID") %>&CurrentPeopleID=<%=CurrentpeopleID %>" class = "body"><%=AnimalName %></a> <%=rs("Color1") %>&nbsp;  <% if len(rs("Price")) > 2 then%>
	    <% if len(rs("Discount")) > 1   then %>
	       <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %>
	       <% else %>
	       <%=formatcurrency(rs("Price"),2) %>
	    <% end if %>
	   <% end if %>
	    <% if rs("OBO") = True then %>
	    <a class="tooltip" href="#"><b>OBO</b><span class="custom info"><img src="/images/logoTip.png" alt="Price Or Best Offer" height="48" width="48" /><em>About OBO</em>By offering OBO the seller is willing to consider any offers that are made; however, that does not mean that they have to accept an offer.</span></a>
 <% end if %>
</li>
	 <% rs.movenext 
	 wend %>
	 </ul>
	</li>
   <% end if
   rs.close 
 if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Inexperienced Male' and PublishForSale = true and breed = 'suri' and AGBrokered=True  order by Price desc"
else
sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Inexperienced Male' and PublishForSale = true and breed = 'suri' and PeopleID= " & CurrentPeopleID & " order by Price desc"
end if
rs.Open sql, conn, 3, 3
	If not rs.eof Then %>
	<li >Inexperienced Suri Males - Jr. Herdsires & Juvenile Males (<%=rs.recordcount %>)
    <ul>
    <% while not rs.eof %>
	    <li><a class="tooltip" href="#"><b>&#8734;</b><span class="custom info"><% if len(rs("Photo1"))> 1 then %><img src="<%=rs("Photo1") %>" alt="<%=rs("FullName") %>" width="80"  /><% end if %>
	<table width = "190" align = "center" cellpadding = "0" cellspacing = "0">
	<tr><td>
	<em><%=rs("FullName") %></em>
<% If Len(PriceComments) > 2 Then %>
 <div align = "left"><b><%=rs("PriceComments")%></b></div><br>
<%End If %>
<% If Sold = True Then %>
<br><font color = "#6a9ac6" ><b>SOLD</b></font><br>
<% End if %>
<% If SalePending= True Then %>
			<br><font color = "#6a9ac6" ><b>Sale Pending</b></font><br>
<% End if %>
<% If Len(rs("StudFee")) > 2 And Sold = False  Then %>
<b>Stud Fee:</b>
&nbsp;<b><%=formatcurrency(rs("StudFee"),0)%></b><br>
<%End If %>

<% If Len(rs("Price")) > 2 And Sold = False  Then %>
<b>Price:</b>&nbsp;<b><%=formatcurrency(rs("Price"),0)%></b><br>
<%End If %>
<% If Len(rs("Discount")) > 1 Then %>
Discount:
&nbsp;<b><font color ="#990000"><%=rs("Discount")%>%</font>
Discount Price: <font color ="#990000"> <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %></font></b><br>
<% end if %>
 DOB: <%=rs("DOBMonth")%>/<%=rs("DOBDay")%>/<%=rs("DOBYear")%><br>	
Breed: <%=rs("Breed")%><br>
Category:&nbsp;<%=rs("Category")%><br>

Color: <% If Len(rs("Color1")) > 1 Then %>
		<%=rs("Color1")%><% end if %>
<% If Len(rs("Color2")) > 1 Then %>/<%=rs("Color2")%>
<% end if %>
<% If Len(rs("Color3")) > 1 Then %>
		<br><img src = "images/px.gif" width = "22" height = "2"><br>/<%=rs("Color3")%>
<% end if %>
<% If Len(rs("Color4")) > 1 Then %>
		<br>/<%=rs("Color4")%>
<% end if %>
<% If Len(rs("Color5")) > 1 Then %>
		<br>/<%=rs("Color5")%>
 <% end if %>	
 <br>
 </td></tr></table>
  </span></a>
 <a href = "details.asp?ID=<%=rs("ID") %>&CurrentPeopleID=<%=CurrentpeopleID %>" class = "body"><%=rs("FullName") %></a> <%=rs("Color1") %>&nbsp;  <% if len(rs("Price")) > 2 then%>
	    <% if len(rs("Discount")) > 1   then %>
	       <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %>
	       <% else %>
	       <%=formatcurrency(rs("Price"),2) %>
	    <% end if %>
	   <% end if %>
	    <% if rs("OBO") = True then %>
	    <a class="tooltip" href="#"><b>OBO</b><span class="custom info"><img src="/images/logoTip.png" alt="Livestock of America Or Best Offer Screen Tip" height="48" width="48" /><em>About OBO</em>By offering OBO the seller is willing to consider any offers that are made; however, that does not mean that they have to accept an offer.</span></a>
	    <% end if %>
</li>
	 <% rs.movenext 
	 wend %>
	 </ul>
	</li>
   <% end if
   rs.close 
 if CurrentPeopleID = 1016 then
 sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Experienced Female' and PublishForSale = true and breed = 'suri' and AGBrokered= True order by Price desc"
 else
sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Experienced Female' and PublishForSale = true and breed = 'suri' and PeopleID= " & CurrentPeopleID & " order by Price desc"
end if
	rs.Open sql, conn, 3, 3
	If not rs.eof Then %>
	<li >Experienced Suri Females - Dams (<%=rs.recordcount %>)
    <ul>
    <% while not rs.eof %>
	    <li><a class="tooltip" href="#"><b>&#8734;</b><span class="custom info"><% if len(rs("Photo1"))> 1 then %><img src="<%=rs("Photo1") %>" alt="<%=rs("FullName") %>" width="80"  /><% end if %>
	<table width = "190" align = "center" cellpadding = "0" cellspacing = "0">
	<tr><td>
	<em><%=rs("FullName") %></em>
<% If Len(PriceComments) > 2 Then %>
 <div align = "left"><b><%=rs("PriceComments")%></b></div><br>
<%End If %>
<% If Sold = True Then %>
<br><font color = "#6a9ac6" ><b>SOLD</b></font><br>
<% End if %>
<% If SalePending= True Then %>
			<br><font color = "#6a9ac6" ><b>Sale Pending</b></font><br>
<% End if %>
<% If Len(rs("StudFee")) > 2 And Sold = False  Then %>
<b>Stud Fee:</b>
&nbsp;<b><%=formatcurrency(rs("StudFee"),0)%></b><br>
<%End If %>

<% If Len(rs("Price")) > 2 And Sold = False  Then %>
<b>Price:</b>&nbsp;<b><%=formatcurrency(rs("Price"),0)%></b><br>
<%End If %>
<% If Len(rs("Discount")) > 1 Then %>
Discount:
&nbsp;<b><font color ="#990000"><%=rs("Discount")%>%</font>
Discount Price: <font color ="#990000"> <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %></font></b><br>
<% end if %>
 DOB: <%=rs("DOBMonth")%>/<%=rs("DOBDay")%>/<%=rs("DOBYear")%><br>	
Breed: <%=rs("Breed")%><br>
Category:&nbsp;<%=rs("Category")%><br>
Color: <% If Len(rs("Color1")) > 1 Then %>
		<%=rs("Color1")%><% end if %>
<% If Len(rs("Color2")) > 1 Then %>/<%=rs("Color2")%>
<% end if %>
<% If Len(rs("Color3")) > 1 Then %>
		<br><img src = "images/px.gif" width = "22" height = "2"><br>/<%=rs("Color3")%>
<% end if %>
<% If Len(rs("Color4")) > 1 Then %>
		<br>/<%=rs("Color4")%>
<% end if %>
<% If Len(rs("Color5")) > 1 Then %>
		<br>/<%=rs("Color5")%>
 <% end if %>	
 <br>
 </td></tr></table>
  </span></a>
<a href = "details.asp?ID=<%=rs("ID") %>&CurrentPeopleID=<%=CurrentpeopleID %>" class = "body"><%=rs("FullName") %></a> <%=rs("Color1") %>&nbsp;  <% if len(rs("Price")) > 2 then%>
	    <% if len(rs("Discount")) > 1   then %>
	       <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %>
	       <% else %>
	       <%=formatcurrency(rs("Price"),2) %>
	    <% end if %>
	   <% end if %>
	    <% if rs("OBO") = True then %>
	    <a class="tooltip" href="#"><b>OBO</b><span class="custom info"><img src="/images/logoTip.png" alt="Screen Tip - OBO" height="48" width="48" /><em>About OBO</em>By offering OBO the seller is willing to consider any offers that are made; however, that does not mean that they have to accept an offer.</span></a>
	    <% end if %>
</li>
	 <% rs.movenext 
	 wend %>
	 </ul>
	</li>
   <% end if
   rs.close 
 if CurrentPeopleID = 1016 then
sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Inexperienced Female' and PublishForSale = true and breed = 'suri' and AGBrokered= True order by Price desc"
else
sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Inexperienced Female' and PublishForSale = true and breed = 'suri' and PeopleID= " & CurrentPeopleID & " order by Price desc"
end if
	rs.Open sql, conn, 3, 3
	If not rs.eof Then %>
	<li >Inexperienced Suri Females - Maidens (<%=rs.recordcount %>)
    <ul>
    <% while not rs.eof %>
	    <li><a class="tooltip" href="#"><b>&#8734;</b><span class="custom info"><% if len(rs("Photo1"))> 1 then %><img src="<%=rs("Photo1") %>" alt="<%=rs("FullName") %>" width="80"  /><% end if %>
	<table width = "190" align = "center" cellpadding = "0" cellspacing = "0">
	<tr><td>
	<em><%=rs("FullName") %></em>
<% If Len(PriceComments) > 2 Then %>
 <div align = "left"><b><%=rs("PriceComments")%></b></div><br>
<%End If %>
<% If Sold = True Then %>
<br><font color = "#6a9ac6" ><b>SOLD</b></font><br>
<% End if %>
<% If SalePending= True Then %>
			<br><font color = "#6a9ac6" ><b>Sale Pending</b></font><br>
<% End if %>
<% If Len(rs("StudFee")) > 2 And Sold = False  Then %>
<b>Stud Fee:</b>
&nbsp;<b><%=formatcurrency(rs("StudFee"),0)%></b><br>
<%End If %>
<% If Len(rs("Price")) > 2 And Sold = False  Then %>
<b>Price:</b>&nbsp;<b><%=formatcurrency(rs("Price"),0)%></b><br>
<%End If %>
<% If Len(rs("Discount")) > 1 Then %>
Discount:
&nbsp;<b><font color ="#990000"><%=rs("Discount")%>%</font>
Discount Price: <font color ="#990000"> <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %></font></b><br>
<% end if %>
 DOB: <%=rs("DOBMonth")%>/<%=rs("DOBDay")%>/<%=rs("DOBYear")%><br>	
Breed: <%=rs("Breed")%><br>
Category:&nbsp;<%=rs("Category")%><br>
Color: <% If Len(rs("Color1")) > 1 Then %>
		<%=rs("Color1")%><% end if %>
<% If Len(rs("Color2")) > 1 Then %>/<%=rs("Color2")%>
<% end if %>
<% If Len(rs("Color3")) > 1 Then %>
		<br><img src = "images/px.gif" width = "22" height = "2"><br>/<%=rs("Color3")%>
<% end if %>
<% If Len(rs("Color4")) > 1 Then %>
		<br>/<%=rs("Color4")%>
<% end if %>
<% If Len(rs("Color5")) > 1 Then %>
		<br>/<%=rs("Color5")%>
 <% end if %>	
 <br>
 </td></tr></table>
  </span></a>
 <a href = "details.asp?ID=<%=rs("ID") %>&CurrentPeopleID=<%=CurrentpeopleID %>" class = "body"><%=rs("FullName") %></a> <%=rs("Color1") %>&nbsp;  <% if len(rs("Price")) > 2 then%>
	    <% if len(rs("Discount")) > 1   then %>
	       <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %>
	       <% else %>
	       <%=formatcurrency(rs("Price"),2) %>
	    <% end if %>
	   <% end if %>
	    <% if rs("OBO") = True then %>
	    <a class="tooltip" href="#"><b>OBO</b><span class="custom info"><img src="/images/logoTip.png" alt="Livestock for Sale OBO" height="48" width="48" /><em>About OBO</em>By offering OBO the seller is willing to consider any offers that are made; however, that does not mean that they have to accept an offer.</span></a>
	    <% end if %>
</li>
	 <% rs.movenext 
	 wend %>
	 </ul>
	</li>
   <% end if
   rs.close 
if CurrentPeopleID = 1016 then
  sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Non-Breeder' and PublishForSale = true and breed = 'suri' and AGBrokered= True  order by Price desc"
 else
 sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Non-Breeder' and PublishForSale = true and breed = 'suri' and PeopleID= " & CurrentPeopleID & " order by Price desc"
end if

	rs.Open sql, conn, 3, 3
	If not rs.eof Then %>
	<li >Non-Breeding Suris (<%=rs.recordcount %>)
    <ul>
    <% while not rs.eof %>
	    <li><a class="tooltip" href="#"><b>&#8734;</b><span class="custom info"><% if len(rs("Photo1"))> 1 then %><img src="<%=rs("Photo1") %>" alt="<%=rs("FullName") %>" width="80"  /><% end if %>
	<table width = "190" align = "center" cellpadding = "0" cellspacing = "0">
	<tr><td>
	<em><%=rs("FullName") %></em>
<% If Len(PriceComments) > 2 Then %>
 <div align = "left"><b><%=rs("PriceComments")%></b></div><br>
<%End If %>
<% If Sold = True Then %>
<br><font color = "#6a9ac6" ><b>SOLD</b></font><br>
<% End if %>
<% If SalePending= True Then %>
			<br><font color = "#6a9ac6" ><b>Sale Pending</b></font><br>
<% End if %>
<% If Len(rs("StudFee")) > 2 And Sold = False  Then %>
<b>Stud Fee:</b>
&nbsp;<b><%=formatcurrency(rs("StudFee"),0)%></b><br>
<%End If %>

<% If Len(rs("Price")) > 2 And Sold = False  Then %>
<b>Price:</b>&nbsp;<b><%=formatcurrency(rs("Price"),0)%></b><br>
<%End If %>
<% If Len(rs("Discount")) > 1 Then %>
Discount:
&nbsp;<b><font color ="#990000"><%=rs("Discount")%>%</font>
Discount Price: <font color ="#990000"> <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %></font></b><br>
<% end if %>
 DOB: <%=rs("DOBMonth")%>/<%=rs("DOBDay")%>/<%=rs("DOBYear")%><br>	
Breed: <%=rs("Breed")%><br>
Category:&nbsp;<%=rs("Category")%><br>

Color: <% If Len(rs("Color1")) > 1 Then %>
		<%=rs("Color1")%><% end if %>
<% If Len(rs("Color2")) > 1 Then %>/<%=rs("Color2")%>
<% end if %>
<% If Len(rs("Color3")) > 1 Then %>
		<br><img src = "images/px.gif" width = "22" height = "2"><br>/<%=rs("Color3")%>
<% end if %>
<% If Len(rs("Color4")) > 1 Then %>
		<br>/<%=rs("Color4")%>
<% end if %>
<% If Len(rs("Color5")) > 1 Then %>
		<br>/<%=rs("Color5")%>
 <% end if %>	
 <br>
 </td></tr></table>
  </span></a>
	    
	    <a href = "details.asp?ID=<%=rs("ID") %>&CurrentPeopleID=<%=CurrentpeopleID %>" class = "body"><%=rs("FullName") %></a> <%=rs("Color1") %>&nbsp;
    
	    <% if len(rs("Price")) > 2 then%>
	    <% if len(rs("Discount")) > 1   then %>
	       <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %>
	       <% else %>
	       <%=formatcurrency(rs("Price"),2) %>
	    <% end if %>
	   <% end if %>
	    <% if rs("OBO") = True then %>
	    <a class="tooltip" href="#"><b>OBO</b><span class="custom info"><img src="/images/logoTip.png" alt="Livestock for Sale Screen Tip" height="48" width="48" /><em>About OBO</em>By offering OBO the seller is willing to consider any offers that are made; however, that does not mean that they have to accept an offer.</span></a>
	    <% end if %>
</li>
	 <% rs.movenext 
	 wend %>
	 </ul>
	</li>
   <% end if
   rs.close %>
</ul>
<% end if %>
<br />
</td>
  </tr>
</table>   
  </td>
  </tr>
</table>      
<% end if %>
<% if TotalAllStuds > 0  then %>
<br>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  ><tr><td class = "roundedtop" align = "left">
<h2>Studs</h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left">
<table  border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "left" width = "450">	
<tr><td>
<style>
    ul 
{ 
    list-style-type: none; 
} 
</style>
<ul id="LinkedList2" class="LinkedList">
 <% if HTotalStuds > 0  then %>
<b>Huacaya Studs</b>
   <% 
 If not rs.State = adStateClosed Then
  rs.close
End If  
  if CurrentPeopleID = 1016 then
    sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Experienced Male' and PublishStud = true and breed = 'huacaya' and Brokered= True  order by Studfee desc"
     else
   sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Experienced Male' and PublishStud = true and breed = 'huacaya' and PeopleID= " & CurrentPeopleID & " order by Studfee desc"
end if
	rs.Open sql, conn, 3, 3
	If not rs.eof Then %>
	<li >Huacaya Herdsires (<%=rs.recordcount %>)
    <ul>
    <% while not rs.eof %>
	    <li><a class="tooltip" href="#"><b>&#8734;</b><span class="custom info"><% if len(rs("Photo1"))> 1 then %><img src="<%=rs("Photo1") %>" alt="<%=rs("FullName") %>" width="80"  /><% end if %>
	<table width = "190" align = "center" cellpadding = "0" cellspacing = "0">
	<tr><td>
	<em><%=rs("FullName") %></em>

<% If Sold = True Then %>
<br><font color = "#6a9ac6" ><b>SOLD</b></font><br>
<% End if %>
<% If SalePending= True Then %>
			<br><font color = "#6a9ac6" ><b>Sale Pending</b></font><br>
<% End if %>
<% If Len(rs("StudFee")) > 2 And Sold = False  Then %>
<b>Stud Fee:</b>
&nbsp;<b><%=formatcurrency(rs("StudFee"),0)%></b><br>
<%End If %>

<% If Len(rs("Price")) > 2 And Sold = False  Then %>
<b>Price:</b>&nbsp;<b><%=formatcurrency(rs("Price"),0)%></b><br>
<%End If %>
<% If Len(rs("Discount")) > 1 Then %>
Discount:
&nbsp;<b><font color ="#990000"><%=rs("Discount")%>%</font>
Discount Price: <font color ="#990000"> <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %></font></b><br>
<% end if %>
 DOB: <%=rs("DOBMonth")%>/<%=rs("DOBDay")%>/<%=rs("DOBYear")%><br>	
Breed: <%=rs("Breed")%><br>
Category:&nbsp;<%=rs("Category")%><br>

Color: <% If Len(rs("Color1")) > 1 Then %>
		<%=rs("Color1")%><% end if %>
<% If Len(rs("Color2")) > 1 Then %>/<%=rs("Color2")%>
<% end if %>
<% If Len(rs("Color3")) > 1 Then %>
		<br><img src = "images/px.gif" width = "22" height = "2"><br>/<%=rs("Color3")%>
<% end if %>
<% If Len(rs("Color4")) > 1 Then %>
		<br>/<%=rs("Color4")%>
<% end if %>
<% If Len(rs("Color5")) > 1 Then %>
		<br>/<%=rs("Color5")%>
 <% end if %>	
 <br>
 </td></tr></table>
  </span></a>
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
 if CurrentPeopleID = 1016 then
          sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Inexperienced Male' and PublishStud = true and breed = 'huacaya' and Brokered= True   order by Studfee desc"
     else
     sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Inexperienced Male' and PublishStud = true and breed = 'huacaya' and PeopleID= " & CurrentPeopleID  & " order by Studfee desc"
end if
	rs.Open sql, conn, 3, 3
	If not rs.eof Then %>
	<li >Huacaya Jr. Herdsires (<%=rs.recordcount %>)
    <ul>
    <% while not rs.eof %>
	    <li><a class="tooltip" href="#"><b>&#8734;</b><span class="custom info"><% if len(rs("Photo1"))> 1 then %><img src="<%=rs("Photo1") %>" alt="<%=rs("FullName") %>" width="80"  /><% end if %>
	<table width = "190" align = "center" cellpadding = "0" cellspacing = "0">
	<tr><td>
	<em><%=rs("FullName") %></em>

<% If Sold = True Then %>
<br><font color = "#6a9ac6" ><b>SOLD</b></font><br>
<% End if %>
<% If SalePending= True Then %>
			<br><font color = "#6a9ac6" ><b>Sale Pending</b></font><br>
<% End if %>
<% If Len(rs("StudFee")) > 2 And Sold = False  Then %>
<b>Stud Fee:</b>
&nbsp;<b><%=formatcurrency(rs("StudFee"),0)%></b><br>
<%End If %>

<% If Len(rs("Price")) > 2 And Sold = False  Then %>
<b>Price:</b>&nbsp;<b><%=formatcurrency(rs("Price"),0)%></b><br>
<%End If %>
<% If Len(rs("Discount")) > 1 Then %>
Discount:
&nbsp;<b><font color ="#990000"><%=rs("Discount")%>%</font>
Discount Price: <font color ="#990000"> <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %></font></b><br>
<% end if %>
 DOB: <%=rs("DOBMonth")%>/<%=rs("DOBDay")%>/<%=rs("DOBYear")%><br>	
Breed: <%=rs("Breed")%><br>
Category:&nbsp;<%=rs("Category")%><br>

Color: <% If Len(rs("Color1")) > 1 Then %>
		<%=rs("Color1")%><% end if %>
<% If Len(rs("Color2")) > 1 Then %>/<%=rs("Color2")%>
<% end if %>
<% If Len(rs("Color3")) > 1 Then %>
		<br><img src = "images/px.gif" width = "22" height = "2"><br>/<%=rs("Color3")%>
<% end if %>
<% If Len(rs("Color4")) > 1 Then %>
		<br>/<%=rs("Color4")%>
<% end if %>
<% If Len(rs("Color5")) > 1 Then %>
		<br>/<%=rs("Color5")%>
 <% end if %>	
 <br>
 </td></tr></table>
  </span></a>
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
    %>
<% rs.close
end if 

%> 
   <% if STotalStuds > 0 then %>
<b>Suri Studs</b>

  <% 
   if CurrentPeopleID = 1016 then
    sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Experienced Male' and PublishStud = true and breed = 'suri' and AGBrokered= True  order by Studfee desc"
   
   else
   sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Experienced Male' and PublishStud = true and breed = 'suri' and PeopleID= " & CurrentPeopleID  & " order by Studfee desc"
end if
	rs.Open sql, conn, 3, 3
	If not rs.eof Then %>
	<li >Suri Herdsires (<%=rs.recordcount %>)
    <ul>
    <% while not rs.eof %>
	    <li><a class="tooltip" href="#"><b>&#8734;</b><span class="custom info"><% if len(rs("Photo1"))> 1 then %><img src="<%=rs("Photo1") %>" alt="<%=rs("FullName") %>" width="80"  /><% end if %>
	<table width = "190" align = "center" cellpadding = "0" cellspacing = "0">
	<tr><td>
	<em><%=rs("FullName") %></em>

<% If Sold = True Then %>
<br><font color = "#6a9ac6" ><b>SOLD</b></font><br>
<% End if %>
<% If SalePending= True Then %>
			<br><font color = "#6a9ac6" ><b>Sale Pending</b></font><br>
<% End if %>
<% If Len(rs("StudFee")) > 2 And Sold = False  Then %>
<b>Stud Fee:</b>
&nbsp;<b><%=formatcurrency(rs("StudFee"),0)%></b><br>
<%End If %>

<% If Len(rs("Price")) > 2 And Sold = False  Then %>
<b>Price:</b>&nbsp;<b><%=formatcurrency(rs("Price"),0)%></b><br>
<%End If %>
<% If Len(rs("Discount")) > 1 Then %>
Discount:
&nbsp;<b><font color ="#990000"><%=rs("Discount")%>%</font>
Discount Price: <font color ="#990000"> <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %></font></b><br>
<% end if %>
 DOB: <%=rs("DOBMonth")%>/<%=rs("DOBDay")%>/<%=rs("DOBYear")%><br>	
Breed: <%=rs("Breed")%><br>
Category:&nbsp;<%=rs("Category")%><br>

Color: <% If Len(rs("Color1")) > 1 Then %>
		<%=rs("Color1")%><% end if %>
<% If Len(rs("Color2")) > 1 Then %>/<%=rs("Color2")%>
<% end if %>
<% If Len(rs("Color3")) > 1 Then %>
		<br><img src = "images/px.gif" width = "22" height = "2"><br>/<%=rs("Color3")%>
<% end if %>
<% If Len(rs("Color4")) > 1 Then %>
		<br>/<%=rs("Color4")%>
<% end if %>
<% If Len(rs("Color5")) > 1 Then %>
		<br>/<%=rs("Color5")%>
 <% end if %>	
 <br>
 </td></tr></table>
  </span></a>
  <a href = "StudDetails.asp?ID=<%=rs("ID") %>&CurrentPeopleID=<%=CurrentpeopleID %>" class = "body"><%=rs("FullName") %></a> <%=rs("Color1") %>&nbsp;<% If Len(rs("StudFee")) > 2 And Sold = False  Then %><b><%=formatcurrency(rs("StudFee"),0)%> Fee</b>
<%End If %>
<% if rs("PayWhatYouCanStud") = True then %><a class="tooltip" href="#"><b><small>Pay What You Can</small></b><span class="custom info"><img src="/images/logoTip.png" alt="Livestock of America Pay What You Can Screen Tip" height="48" width="48" /><em>About Pay What You Can</em>By offering <i>Pay What You Can</i> the owner is willing to consider any offer on this stud's breeding based upon what they can afford; however, that does not mean that that have to accept an offer, if they don't want to.</span></a>
	    <% end if %>
</li>
	 <% rs.movenext 
	 wend %>
	 </ul>
	</li>
   <% end if
   rs.close 
if CurrentPeopleID = 1016 then
        sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Inexperienced Male' and PublishStud = true and breed = 'huacaya' and AGBrokered= True  order by Studfee desc"
            else
    sql = "select * from Animals, Pricing, Colors, Photos where Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and Category  = 'Inexperienced Male' and PublishStud = true and breed = 'huacaya' and PeopleID= " & CurrentPeopleID  & " order by Studfee desc"
end if
	rs.Open sql, conn, 3, 3
	If not rs.eof Then %>
	<li >Suri Jr. Herdsires (<%=rs.recordcount %>)
    <ul>
    <% while not rs.eof %>
	    <li><a class="tooltip" href="#"><b>&#8734;</b><span class="custom info"><% if len(rs("Photo1"))> 1 then %><img src="<%=rs("Photo1") %>" alt="<%=rs("FullName") %>" width="80"  /><% end if %>
	<table width = "190" align = "center" cellpadding = "0" cellspacing = "0">
	<tr><td>
	<em><%=rs("FullName") %></em>

<% If Sold = True Then %>
<br><font color = "#6a9ac6" ><b>SOLD</b></font><br>
<% End if %>
<% If SalePending= True Then %>
			<br><font color = "#6a9ac6" ><b>Sale Pending</b></font><br>
<% End if %>
<% If Len(rs("StudFee")) > 2 And Sold = False  Then %>
<b>Stud Fee:</b>
&nbsp;<b><%=formatcurrency(rs("StudFee"),0)%></b><br>
<%End If %>

<% If Len(rs("Price")) > 2 And Sold = False  Then %>
<b>Price:</b>&nbsp;<b><%=formatcurrency(rs("Price"),0)%></b><br>
<%End If %>
<% If Len(rs("Discount")) > 1 Then %>
Discount:
&nbsp;<b><font color ="#990000"><%=rs("Discount")%>%</font>
Discount Price: <font color ="#990000"> <%=Formatcurrency(rs("Price") - (rs("Price")*(rs("Discount")/100)),0) %></font></b><br>
<% end if %>
 DOB: <%=rs("DOBMonth")%>/<%=rs("DOBDay")%>/<%=rs("DOBYear")%><br>	
Breed: <%=rs("Breed")%><br>
Category:&nbsp;<%=rs("Category")%><br>
Color: <% If Len(rs("Color1")) > 1 Then %>
		<%=rs("Color1")%><% end if %>
<% If Len(rs("Color2")) > 1 Then %>/<%=rs("Color2")%>
<% end if %>
<% If Len(rs("Color3")) > 1 Then %>
		<br><img src = "images/px.gif" width = "22" height = "2"><br>/<%=rs("Color3")%>
<% end if %>
<% If Len(rs("Color4")) > 1 Then %>
		<br>/<%=rs("Color4")%>
<% end if %>
<% If Len(rs("Color5")) > 1 Then %>
		<br>/<%=rs("Color5")%>
 <% end if %>	
 <br>
 </td></tr></table>
  </span></a>
  <a href = "StudDetails.asp?ID=<%=rs("ID") %>&CurrentPeopleID=<%=CurrentpeopleID %>" class = "body"><%=rs("FullName") %></a> <%=rs("Color1") %>&nbsp;<% If Len(rs("StudFee")) > 2 And Sold = False  Then %><b><%=formatcurrency(rs("StudFee"),0)%> Fee</b>
<%End If %>
<% if rs("PayWhatYouCanStud") = True then %><a class="tooltip" href="#"><b><small>Pay What You Can</small></b><span class="custom info"><img src="/images/logoTip.png" alt="Animal Screen Tip" height="48" width="48" /><em>About Pay What You Can</em>By offering <i>Pay What You Can</i> the owner is willing to consider any offer on this stud's breeding based upon what they can afford; however, that does not mean that that have to accept an offer, if they don't want to.</span></a>
	    <% end if %>
</li>
	 <% rs.movenext 
	 wend %>
	 </ul>
	</li>
   <% end if
   rs.close %> 
 <% end if %>
</ul>
   </td>
  </tr>
</table>   
   </td>
  </tr>
</table>  
 <% end if %>

</td>
<td width = "30%" valign = "top">
 <% if TotalHuacayas > 0 or TotalSuris > 0 then %>
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
	if CurrentPeopleID = 1016 then
	sql = "select * from Animals, Pricing, Photos where Animals.ID = Pricing.ID  and sold = false and  Animals.ID=Photos.ID and PublishForsale = true and forsale = True  and AGBrokered= True"
		else
		 sql = "select * from Animals, Pricing, Photos where Animals.ID = Pricing.ID  and sold = false and  Animals.ID=Photos.ID and PublishForsale = true and forsale = True  and PeopleID= " & CurrentPeopleID
		end if
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
						<font color = "<%=PageTextColor %>" >No Featured Animals.<br/><br/></font>
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
<% end if %>
	</td>
		</tr>
</table>
<%  if TotalAllStuds> 0  then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  ><tr><td class = "roundedtop" align = "left">
<H2><div align = "left">Featured Stud</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "left">
<table  border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" width = "190">			
<%	NoHerdsireslisted = True
	'response.Write("FeaturedHerdsire=" & FeaturedHerdsire )
	If FeaturedHerdsire = 0 Then
if CurrentPeopleID = 1016 then
  sql = "SELECT distinct Animals.*, Pricing.*, Photos.* FROM Animals, Pricing, Photos, People WHERE Animals.ID=Pricing.ID  And Animals.ID=Photos.ID And Animals.PeopleID=People.PeopleID     and len(Photo1) > 3   and sold = false and len(studfee)> 1 and (Category = 'Experienced Male' or Category = 'Inexperienced Male') and Brokered = True"
  else
sql = "SELECT distinct Animals.*, Pricing.*, Photos.* FROM Animals, Pricing, Photos, People WHERE Animals.ID=Pricing.ID  And Animals.ID=Photos.ID And Animals.PeopleID=People.PeopleID     and len(Photo1) > 3   and sold = false and len(studfee)> 1 and People.PeopleID = " & CurrentPeopleID & " and (Category = 'Experienced Male' or Category = 'Inexperienced Male') "
end if
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