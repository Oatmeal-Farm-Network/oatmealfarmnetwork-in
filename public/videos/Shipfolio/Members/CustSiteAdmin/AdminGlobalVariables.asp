<meta charset="UTF-8">
<% administration = True %>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
<% 'Global Variables
Dim DatabasePath
Dim AdministrationPath
Dim WebSiteName
Dim Slogan
Dim PhysicalPath
Dim BorderColor
dim conn, sql2, rs2, UploadPath, WebLink, LongWeblink, Style, loginpage, showonmenu, acounter, showdesign


sql2 = "select * from SiteDesign where PeopleId = " & PeopleId & ";" 
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
If Not rs2.eof Then
WebSiteName = rs2("WebSiteName")
Slogan = rs2("Slogan")
WebLink= rs2("WebLink")
AdministrationID  = rs2("AdministrationID")
End If 
rs2.close


sqlA= "select * from RanchSiteDesign where PeopleID = " & PeopleID 
response.write("sqlA=" & sqlA )
rs2.Open sqlA, conn, 3, 3   
If Not rs2.eof Then
HeaderImage = rs2("Header")
End If 
rs2.close

sql2 = "select PeopleCurrency, PeopleDateFormat, PeopleCopyrightName, PeopleCopyrightLink, PeopleCurrencyCode, PeoplePaypalCurrencyCode, PeopleLocalCode from people where PeopleId = " & PeopleId & ";" 
rs2.Open sql2, conn, 3, 3   
If Not rs2.eof Then
PeopleCurrency= rs2("PeopleCurrency")
PeopleDateFormat= rs2("PeopleDateFormat")
PeopleCopyrightname= rs2("PeopleCopyrightName")
PeopleCopyrightLink= rs2("PeopleCopyrightLink")
PeopleCurrencycode=rs2("PeopleCurrencyCode")
PeoplePaypalCurrencyCode = rs2("PeoplePaypalCurrencyCode")
PeopleLocalCode = rs2("PeopleLocalCode")
if len(rs2("PeopleLocalCode")) < 0 then
    SetLocale(PeopleLocalCode)
end if

End If 

LongWeblink =  "http://" &  request.servervariables("HTTP_HOST") 
PhysicalPath = request.servervariables("APPL_PHYSICAL_PATH")
UploadPath = request.servervariables("APPL_PHYSICAL_PATH") & "\Uploads\"
Slogan = ""
style = "Style.css"
Slogan = ""					
%>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
 <title><%=AdminTitle %></title>
 <meta name="author" content="<%=AdminAuthor %>">
 <meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="stylesheet" type="text/css" href="style.css">