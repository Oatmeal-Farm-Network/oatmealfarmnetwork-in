<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<% Current = "Ranches"%>
<!--#Include virtual="/includefiles/globalvariables.asp"-->
<% 
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

tempCurrentPeopleID=Request.querystring("PeopleID") 
If Not Len(tempCurrentPeopleID)> 0 and Len(CurrentPeopleID)> 0 Then 
	response.redirect("ranchhome.asp?Peopleid=" & CurrentPeopleID)
End if


If Not Len(CurrentPeopleID)> 0 Then 
	Response.Redirect("/Default.asp")
End if
If CurrentPeopleID = 1016 Then 
	'Response.Redirect("/Brokering/Default.asp")
End if


%>
<title><%= BusinessName %></title>
<meta name="Title" content=" <%= BusinessName %>">
<meta name="description" content=" Animals for Sale at <%= BusinessName %> in <%= AddressCity %>, <%= AddressState %>." >
<meta name="robots" content="index,follow">
<meta name="rating" content="Safe for kids">
<meta name="revisit-after" content="1">
<meta name="Googlebot" content="index,follow">
<meta name="robots" content="All">
<meta name="subject" content="Livestock" >

<%	Set rs = Server.CreateObject("ADODB.Recordset")
RanchAboutUsText = ""

sql = "select RanchpageLayout.PageName, RanchpageLayout2.* from RanchpageLayout, RanchpageLayout2 where RanchpageLayout.PageLayoutID  = RanchpageLayout2.PageLayoutID  and RanchpageLayout.PageName = 'About Us' and RanchpageLayout.PeopleID = " & PeopleID & " and BlockNum = 1"
rs.Open sql, conn, 3, 3
if not rs.eof then
RanchAboutUsText = RanchAboutUsText & "" & rs("PageText") & "<BR><BR>"
end if
rs.close

sql = "select RanchpageLayout.PageName, RanchpageLayout2.* from RanchpageLayout, RanchpageLayout2 where RanchpageLayout.PageLayoutID  = RanchpageLayout2.PageLayoutID  and RanchpageLayout.PageName = 'About Us' and RanchpageLayout.PeopleID = " & PeopleID & " and BlockNum = 2 "
rs.Open sql, conn, 3, 3
if not rs.eof then
RanchAboutUsText = RanchAboutUsText & "" & rs("PageText") & "<BR><BR>"
end if
rs.close

sql = "select RanchpageLayout.PageName, RanchpageLayout2.* from RanchpageLayout, RanchpageLayout2 where RanchpageLayout.PageLayoutID  = RanchpageLayout2.PageLayoutID  and RanchpageLayout.PageName = 'About Us' and RanchpageLayout.PeopleID = " & PeopleID & " and BlockNum = 3"
rs.Open sql, conn, 3, 3
if not rs.eof then
RanchAboutUsText = RanchAboutUsText & "" & rs("PageText") & "<BR><BR>"
end if
rs.close

sql = "select RanchpageLayout.PageName, RanchpageLayout2.* from RanchpageLayout, RanchpageLayout2 where RanchpageLayout.PageLayoutID  = RanchpageLayout2.PageLayoutID  and RanchpageLayout.PageName = 'About Us' and RanchpageLayout.PeopleID = " & PeopleID & " and BlockNum = 4"
rs.Open sql, conn, 3, 3
if not rs.eof then
RanchAboutUsText = RanchAboutUsText & "" & rs("PageText") & "<BR><BR>"
end if
rs.close

sql = "select RanchpageLayout.PageName, RanchpageLayout2.* from RanchpageLayout, RanchpageLayout2 where RanchpageLayout.PageLayoutID  = RanchpageLayout2.PageLayoutID  and RanchpageLayout.PageName = 'About Us' and RanchpageLayout.PeopleID = " & PeopleID & " and BlockNum = 5"
rs.Open sql, conn, 3, 3
if not rs.eof then
RanchAboutUsText = RanchAboutUsText & "" & rs("PageText") & "<BR>"
end if
rs.close


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


str1 = lcase(Image1)
str2 = "livestockofamerica.com"
If InStr(str1,str2) > 0 Then
Image1= Replace(str1, str2 , "livestockoftheworld.com")
End If  

str1 = lcase(Image1)
str2 = "uploads"
str3 = "http://"
If  len(str1) > 3 and Not(InStr(str1,str2) > 0) and Not(InStr(str1,str3) > 0) Then
Image1 = "http://www.livestockoftheworld.com/Uploads/" & Image1
End If 

str1 = lcase(Image1)
str2 = "uploads"
str3 = "http://"
If  len(str1) > 3 and Not(InStr(str1,str3) > 0) Then
Image1 = "http://www.livestockoftheworld.com/" & Image1
End If 


str1 = lcase(Image2)
str2 = "livestockofamerica.com"
If InStr(str1,str2) > 0 Then
Image2= Replace(str1, str2 , "livestockoftheworld.com")
End If  

str1 = lcase(Image2)
str2 = "uploads"
str3 = "http://"
If  len(str1) > 3 and Not(InStr(str1,str2) > 0) and Not(InStr(str1,str3) > 0) Then
Image2 = "http://www.livestockoftheworld.com/Uploads/" & Image2
End If 

str1 = lcase(Image2)
str2 = "uploads"
str3 = "http://"
If  len(str1) > 3 and Not(InStr(str1,str3) > 0) Then
Image2 = "http://www.livestockoftheworld.com/" & Image2
End If 


str1 = lcase(Image3)
str2 = "livestockofamerica.com"
If InStr(str1,str2) > 0 Then
Image3= Replace(str1, str2 , "livestockoftheworld.com")
End If  

str1 = lcase(Image3)
str2 = "uploads"
str3 = "http://"
If  len(str1) > 3 and Not(InStr(str1,str2) > 0) and Not(InStr(str1,str3) > 0) Then
Image3 = "http://www.livestockoftheworld.com/Uploads/" & Image3
End If 

str1 = lcase(Image3)
str2 = "uploads"
str3 = "http://"
If  len(str1) > 3 and Not(InStr(str1,str3) > 0) Then
Image3 = "http://www.livestockoftheworld.com/" & Image3
End If 





ImageOrientation1= rs("RanchHomeImageOrientation1")
ImageOrientation2= rs("RanchHomeImageOrientation2")
ImageOrientation3= rs("RanchHomeImageOrientation3")
ImageOrientation4= rs("RanchHomeImageOrientation4")
RanchHomeheading= rs("RanchHomeheading")

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


ranchtextfound = False
%>
</head>
<body >

<!--#Include virtual="/Header.asp"-->
<% Current3 = "FarmHome" %>



</div>
<!--#Include file="RanchPagesTabsInclude.asp"-->

<%  if len(trim(PageTitle)) > 3 then
     else
     if len(trim(BusinessName)) > 2 then 
        PageTitle = " Welcome to " & BusinessName 
    else
    PageTitle = " Welcome to Our Ranch Site" 
    end if
    end if %>
<div class ="container">
    <div>
      <div class ="row">
        <div class = "col">

<%


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

<H2><%=PageTitle%></H2>
<% If Len(Image1) > 1 Then
str1 = lcase(Image1) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Image1=  Replace(str1, str2 , "http://www.livestockoftheworld.com")
End If  

%>
<img src = "<%=Image1%>" border = "0" align = "right" width = "200" Hspace="10" Vspace="10"/>
<% End If %> 
<br />
<% 
 If Len(RanchHomeText) > 12 Then
 ranchtextfound = True %>
<%=RanchHomeText%>
<% End If %>
<% If Len(RanchHomeText) < 12 And Len(RanchAboutUsText) > 12 Then %>
<% If Len(News) > 12 Then 
ranchtextfound = True %>
<%=left(RanchAboutUsText, 600) %>
<% If Len(RanchAboutUsText) > 600 Then 
ranchtextfound = True %>
...<br/><div align = "right"><a href = "ranchaboutus.asp?CurrentPeopleID=<%=CurrentPeopleID%>" class = "body">Read More.</a>&nbsp;</div>
<% end if %>
<% Else 
ranchtextfound = True %>
<%=left(RanchAboutUsText, 1500) %>
<% If Len(RanchAboutUsText)> 1500 Then
 %>
...<br/><div align = "right"><a href = "ranchaboutus.asp?CurrentPeopleID=<%=CurrentPeopleID%>" class = "body">Read More.</a>&nbsp;</div>
<% end if %>
<% End If %>
<% End If %>




        <br/><br/>
    </div>
</div>
<% End If %> 


<% If Len(trim(News)) > 15 Then 
ranchtextfound = True
%><br />
<div class ="container" >
    <div>
        <div>
            <H2><div align = "left">News</div></H2>
        </div>
     </div>
    <div>
        <div>
            <% If Len(Image2) > 1 Then 
            str1 = lcase(Image2) 
            str2 = "http://www.alpacainfinity.com"
            If InStr(str1,str2) > 0 Then
            Image2=  Replace(str1, str2 , "http://www.livestockoftheworld.com")
            End If  %>
            <img src = "<%=Image2%>" border = "0" align = "right" width = "200" Hspace="20" Vspace="10">
            <% End If %>
            <%=News%>
  
  </div>
  </div>
</div>
    <br />   
<% End If %>



<% if ranchtextfound = False then %>
<div class="container">
    <div class="row">
        <div class="col">
            <H2><%=PageTitle%></H2>
            </div></div>
            <div><div class = "roundedBottom" align = "left"  bgcolor = "<%=PageBackgroundColor %>">
            We are happy that you found us on <%=sitename %>. <% if totalAnimals > 0 or totalAnimals > 0  then%> Please <% end if %><% if totalAnimals > 0 then%>check out our <a href="RanchAllAnimalsForSale.asp?CurrentPeopleID=<%=currentpeopleID %>" class= "body">animals for sale</a><% end if %> <% if totalProducts > 0 then %> <% if totalAnimals > 0 then%> and <% end if %> <a href="RanchAllAnimalsForSale.asp?CurrentPeopleID=<%=currentpeopleID %>" class= "body">products for sale </a>.<% end if %> We look forward to hearing from you! 

    </div>
  </div>
</div>
<% end if %>

<div class="container">
    <div class="row">
        <div class="col">
  
            <b><%=BusinessName %></b><br />
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

            <a href ="RanchContactUs.asp?CurrentPeopleID=<%=PeopleID %>" class = "regsubmit2" style ="min-width:120px">CONTACT</a>
            <br /><br />
</div>
</div>
</div>
   <br /><br />
	
<!--#Include virtual="/Footer.asp"--> 
</body>
</html>

