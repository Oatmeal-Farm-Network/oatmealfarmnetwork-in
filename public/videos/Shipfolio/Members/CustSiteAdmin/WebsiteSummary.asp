<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Language" content="en-us">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<title>Andresen Group Content Management System</title>  

<!--#Include virtual="/members/Membersglobalvariables.asp"-->
<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
<%
Function GetPrevMonth(iThisMonth,iThisYear)
 GetPrevMonth=month(dateserial(iThisYear,iThisMonth,1)-1)
End Function

Function GetPrevMonthYear(iThisMonth,iThisYear)
 GetPrevMonthYear=Year(dateserial(iThisYear,iThisMonth,1)-1)
End Function

Function GetNextMonth(iThisMonth,iThisYear)
 GetNextMonth=month(dateserial(iThisYear,iThisMonth+1,1))
End Function

Function GetNextMonthYear(iThisMonth,iThisYear)
 GetNextMonthYear=year(dateserial(iThisYear,iThisMonth+1,1))
End Function
%>
</head>
<body >
<% AdminHome = True %>
<% Current3 = "Summary" %> 
<!--#Include virtual="/members/MembersHeader.asp"-->
<!--#Include virtual="/members/CustSiteAdmin/WebsitedesignJumpLinks.asp"-->


<% If Request.Querystring("UpdatePages" ) = "True" Then

dim LinkOrderarray(1000)
dim pagelayoutidarray(1000)
totallinecount = request.form("totallinecount")
rowcount =0


while rowcount < cint(totallinecount)
rowcount =rowcount +1
	LinkOrderarraycount = "LinkOrder(" & rowcount & ")"
	LinkOrderarray(rowcount)=Request.Form(LinkOrderarraycount) 

    pagelayoutidarraycount = "pagelayoutid(" & rowcount & ")"
	pagelayoutidarray(rowcount)=Request.Form(pagelayoutidarraycount) 

if len(LinkOrderarray(rowcount)) < 1 then
else
Query =  " UPDATE pageLayout Set "
Query =  Query & " LinkOrder = " & LinkOrderarray(rowcount) & " "
Query =  Query & " where pagelayoutid = " & pagelayoutidarray(rowcount) & " ;"
Conn.Execute(Query) 
end if

Wend



ShowPages = request.Form("ShowPages")
sqlp = "select * from pageLayout "

 Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sqlp, conn, 3, 3   
if not rs.eof then
 
 while Not rs.eof 
 PageName = rs("PageName")
str1 = ShowPages 
str2 = PageName


If InStr(str1, str2) > 0 or PageName = "Home Page" Then
Query =  " UPDATE pageLayout Set "
Query =  Query & " ShowPage = True"
Query =  Query & " where PageName = '" & PageName & "' ;"
Conn.Execute(Query) 

else
Query =  " UPDATE pageLayout Set "
Query =  Query & " ShowPage = False"
Query =  Query & " where  PageName = '" & PageName & "' ;" 
Conn.Execute(Query) 
End If  

 rs.movenext
wend 

'Conn.Close
'Set Conn = Nothing 
 end if 
end if

sql2 = "select * from SiteDesign"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 

if Not rs2.eof then 
AutoTransfer= rs2("AutoTransfer")

end if

rs2.close


sql2 = "select * from people where peopleID = 667;" 
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
 If Not rs2.eof Then

AIEmail = rs2("AIEmail")
AIPassword = rs2("AIPassword")
End If 
' End Update Pages 



sql2 = "select * from PageLayout where peopleid = " & session("PeopleID") & " and PageAvailable = 1 order by PageGroupID, LinkOrder "
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if not  rs2.eof then
 acounter = 1
recordcount = rs2.recordcount
%>
<form  name=UpdatePagesform method="post" action="Default.asp?UpdatePages=True">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr><td class = "roundedtop" align = "left">
 
<table><tr><td class = "body" width = '<%=screenwidth -710%>'><b>Page Name</b></td>
<td class = "body2" width = "170" align = "center"><b>Menu Title</b></td>
<% if MenuDropdowns  = "Yes" or MenuDropdowns = True then %>
<td class = "body2" width = "100" align = "center"><b>Page Type</b></td>
<td class = "body2" width = "190" align = "center"><b>Page Group</b></td>
<% else %>
<td class = "body2" width = "190" align = "right"><b>Page Order</b></td>
<% end if %>
<td class = "Body2" width = "100" align = "center"><b>Display</b></td>
<td class = "body2" width = "150" align = "center"><b>Options</b></td></tr></table>
</td></tr>
 <tr><td class = "roundedBottom" align = "center" width = "100%"> 
 <table border = "0" cellpadding=0 cellspacing=0  width = "100%" align = "center" >
<% 
linecount = 0
While Not rs2.eof 
linecount = linecount + 1
TotalPages = rs2.recordcount
 PageLayoutID = rs2("PageLayoutID")

PageGroupID = rs2("PageGroupID")
PageType = rs2("PageType")
ShowPage = rs2("ShowPage")
LinkName = rs2("LinkName")
EditLinkName = rs2("EditLink")
PageAvailable  = rs2("PageAvailable")
if PageAvailable = "True" then
   PageAvailable = "Yes"
else
PageAvailable = "No"
end if
 if (MenuDropdowns  = "Yes" or MenuDropdowns = True) and len(PageGroupID)> 0 then 
   
sql = "select * from PageGroups where PageGroupID = " & PageGroupID & ""
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not  rs.eof then
PageGroupTitle = rs("PageGroupTitle")
end if
   else
   PageGroupTitle = ""
end if
if len(EditLinkName)> 0 then
else
if PageType  = "Standard" or len(PageType) < 3 then
 EditLinkName ="AdminPagedata.asp?PageLayoutID=" & PageLayoutID & "#BasicFacts"
end if

if PageType  = "Service" then
 EditLinkName ="AdminServicesEdit2.asp?PageLayoutID=" & PageLayoutID & "#BasicFacts"
end if
end if

'if  rs2("PageName")  = "Home Page" then
'  EditLinkName = "AdminHomePage.asp"
'end if

 If row = "even" Then 
 row = "odd"
 %>
<tr >
<% Else 
row = "even"%>

<tr bgcolor = "#e6e6e6">
<%End If %>
<td class= "body"  width = '<%=screenwidth -710%>'>
<a href = "<%=EditLinkName %>" class = "body"><%=rs2("PageName")%></a>
</td>
<td class= "body"  width = '170'>
<%=rs2("LinkName")%>
</td>

<% if MenuDropdowns  = "Yes" or MenuDropdowns = True then %>
<td class= "body2"  align ="left" width = "100"><%= PageType %></td>
<td class= "body2"  align ="left" width = "190"><%= PageGroupTitle %></td>
<% else %>
<td class= "body2"  align ="center" width = "190">




<%
 LinkOrder = rs2("LinkOrder") %>
<select size="1" name="LinkOrder(<%=linecount%>)">
<% if len(LinkOrder) > 0 then %>
<option name = "AID1" value="<%=LinkOrder %>">
	<%=LinkOrder %>
</option>
<% else %>
<option name = "AID1" value="">--</option>
<% end if %>
<% count = 1
while count < (TotalPages+1) %>
<option name = "AID1" value="<%=count %>">
<%=count %>
</option>
<% count = count + 1
wend %>
</select>
<input type="hidden" name="pagelayoutid(<%=linecount%>)" value="<%=rs2("pagelayoutid") %>" >

</td>
<% end if %>
<td class= "body2"  align = "left" width = "100">
<% if rs2("PageName") ="Home Page" then %>
Always
<% else %>   
<% if ShowPage  = True then %>
<input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>" checked >Yes
<% else %>
 <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>"  >No
<% end if %>
<% end if %></td>
<td class= "body" width = "150">
<% if rs2("PageName")  = "Home Page" then %>
<a href = "AdminHomePage.asp" class = "body">&nbsp;&nbsp;<img src= "/members/images/edit.gif" alt = "edit" height ="12" border = "0"></a>|
	&nbsp;<a href = "AdminEditSEO.asp?PageName=<%= rs2("PageName") %>" class = "body"><img src= "/members/images/seo-icon.png" alt = "edit" height ="14" border = "0"></a>
 <% if SlideshowAvailable = True then %>
|&nbsp;<a href = "/members/images/AdminGalleryEditImages.asp?GalleryCatID=3" ><img src = "/members/images/Photo.gif" height = "18" border = "0" alt = "Slideshow Photos"></a>
<% end if %>



<% else %>
<a href = "<%=EditLinkName %>" class = "body">&nbsp;&nbsp;<img src= "/members/images/edit.gif" alt = "edit" height ="12" border = "0"></a>|
&nbsp;<a href = "AdminPageDelete.asp?PageLayoutID=<%= rs2("PageLayoutID") %>" class = "body"><img src= "/members/images/Delete.gif" alt = "edit" height ="14" border = "0"></a>

|&nbsp;<a href = "AdminEditSEO.asp?PageName=<%= rs2("PageName") %>" class = "body"><img src= "/members/images/seo-icon.png" alt = "edit" height ="14" border = "0"></a>
<% if not(Pagetype = "Basic") and  AddPages = True then %>
|&nbsp;<a href = "AdminConvertPage.asp?PageName=<%= rs2("PageName") %>&PageLayoutId=<%= rs2("PageLayoutId") %>" class = "body"><img src= "/members/images/ConvertIcon.png" alt = "Convert Page Type" height ="14" border = "0"></a>

<% end if %>
<% end if %>
</td>
</tr>

<%catcounter  = catcounter  +1
rs2.movenext
Wend
FinalCatCounter = catcounter 
end if
rs2.close%>
<tr>
<td align = "center" colspan = "6">
<input type="hidden" name="totallinecount" value="<%=linecount%>" >
	<input type=submit value = "Update" class = "regsubmit2" ></form>
</td>
</tr>
</table>
<br />

 


   <br>

<br>
<!--#Include virtual ="/Members/MembersFooter.asp"--> 
</BODY>
</HTML>