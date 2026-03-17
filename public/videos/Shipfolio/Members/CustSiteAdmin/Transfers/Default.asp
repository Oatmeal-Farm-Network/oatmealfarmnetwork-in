<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
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
</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if 
AdminHome = True %>
<!--#Include file="AdminHeader.asp"--> 
<%
If Request.Querystring("UpdatePages" ) = "True" Then
dim LinkOrderarray(1000)
dim pagelayoutidarray(1000)
dim PagegroupIDarray(1000)
totallinecount = request.form("totallinecount")
rowcount =0

pagegroupcount =1
while rowcount < cint(totallinecount)
rowcount =rowcount +1
	LinkOrderarraycount = "LinkOrder(" & rowcount & ")"
	LinkOrderarray(rowcount)=Request.Form(LinkOrderarraycount) 

   PagegroupIDcount = "PagegroupID(" & rowcount & ")"
PagegroupIDarray(rowcount)=Request.Form(PagegroupIDcount) 

    pagelayoutidarraycount = "pagelayoutid(" & rowcount & ")"
	pagelayoutidarray(rowcount)=Request.Form(pagelayoutidarraycount) 



if rowcount > 1 then
    if PagegroupIDarray(rowcount) = PagegroupIDarray(rowcount - 1) then
        pagegroupcount  = pagegroupcount  + 1


      '  if LinkOrderarray(rowcount) =  LinkOrderarray(rowcount - 1)  then
      '       LinkOrderarray(rowcount) = LinkOrderarray(rowcount) + 1
      '  end if



     else
         pagegroupcount  = 1
        LinkOrderarray(rowcount)= 1
     end if


end if

  'response.write("linkorderx = " & LinkOrderarray(rowcount) & "<br>")
  'response.write("pagegroupcount= " & pagegroupcount & "<br>")
  if len(LinkOrderarray(rowcount)) > 0 then
  else
  LinkOrderarray(rowcount) = 1
  end if
      '  if cint(LinkOrderarray(rowcount)) > cint(pagegroupcount) then
      ' LinkOrderarray(rowcount) =  pagegroupcount 
       ' response.write("switch<br>")
      '  end if


if len(LinkOrderarray(rowcount)) < 1 then
else


Query =  " UPDATE pageLayout Set "
Query =  Query & " LinkOrder = " & LinkOrderarray(rowcount) & " "
Query =  Query & " where pagelayoutid = " & pagelayoutidarray(rowcount) & " ;"
Conn.Execute(Query) 
end if

Wend



ShowPages = request.Form("ShowPages")
'response.write("showPages=" & ShowPages)
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

end if 
 response.redirect("Default.asp")
end if

sql2 = "select * from AutoTransfers where ReceivingwebsiteName = 'Livestock Of America'"
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
screenwidth = screenwidth -15
%>
<% if mobiledevice = False  then %>
<% if screenwidth < 989 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth  %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth  %>">
<% end if %>
<tr><td class = "roundedtop" align = "left">
<H1>Administration Dashboard</H1></td></tr>
<tr><td class = "roundedBottom" align = "center" >
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" >
<tr><td  align = "center" >
<% end if %>
<% if mobiledevice = False and ScreenWidth > 768 and showLOA = True then %>
<table border = "0" cellspacing="0" cellpadding = "0"  ><tr>

<td class = "body" valign = "top">

<table border = "0" cellspacing="0" cellpadding = "0" align = "right" >
<tr><td class = "roundedtop" align = "left">
<H3><div align = "left">Log Into Livestock Of America</div></H3>
</td></tr>
<tr><td class = "roundedBottom" align = "center" class = "body" height = "82">
<% if mobiledevice = False or SmallMobile = True   then %>
<form action= "http://www.LivestockOfAmerica.com/handleLogin.asp" method = "post" target = "_blank">
<% else %>
<form action= "http://www.LivestockOfAmerica.com/handleLogin.asp" method = "post">
<% end if %>
<table>
<tr>
<td Class = "body" align = "right">
Email:
</td>
<td class = "body" align = "left">
<input type=text  name=UID value = "<%=AIEmail%>" SIZE = "36" >
</td>
<td rowspan= "2">
<input type=submit value = "Login"  size = "170" class = "regsubmit2"  <%=Disablebutton %>>
</td>
</tr>
<tr>
<td Class = "body" align = "right">
Password:
</td>
<td class = "body" align = "left">
<input type= password name=password value = "<%=AIPassword%>" SIZE = "12">
</td>
</tr>
</table>
</form>
</td>
  </tr>
</table>
</td>

<td width = "10"></td>

<td class = "body" valign = "top">

<table border = "0" cellspacing="0" cellpadding = "0" align = "right" ><tr><td class = "roundedtop" >
<H3><div align = "left">Auto-Transfer to Livestock Of America</div></H3>
</td></tr>
<tr><td class = "roundedBottom" align = "center" class = "body" height = "82">
<form  action="/Administration/Transfers/setautoupdate.asp" method = "post" name="myform">
<center><a class="tooltip" href="#"><b>Auto-Transfer:</b><span class="custom info">If the auto-transfer is set 'On' then your animal information will automatically be updated to Livestock Of America every time you make changes. <br /></span></a>
<% if AutoTransfer = "Yes" Or AutoTransfer = True Then %>
On<input TYPE="RADIO" name="AutoTransfer" Value = "Yes" checked>
Off<input TYPE="RADIO" name="AutoTransfer" Value = "No" >
<% Else %>
On<input TYPE="RADIO" name="AutoTransfer" Value = "Yes" >
Off<input TYPE="RADIO" name="AutoTransfer" Value = "No" checked>
<% End If %><input type=hidden name= "SendingPage" value = "/administration/Default.asp"  >
<input type=submit value = "Set Auto-Transfer"  size = "310" class = "regsubmit2"  <%=Disablebutton %>></center>
</form>
</td>
  </tr>
</table>
</td>
<td width = "10"></td>
<td valign = "top">

<table border = "0" cellspacing="0" cellpadding = "0" align = "right" ><tr><td class = "roundedtop" align = "left">
<H3><div align = "left">Key</div></H3>
</td></tr>
<tr><td class = "roundedBottom" align = "center" height ="83">
<table border = "0" cellpadding = "0" cellspacing="0"  align = "right">
 <tr>
<td class = "body2" width = "30" align = "right"><img src= "images/edit.gif" alt = "edit" height = "18"  border = "0"></td>
<td class = "body" width=  "35">Edit</td>
<td class = "body2" width = "30" align = "right"><img src = "images/Photo.gif" height = "18" border = "0" alt = "Upload Photos"></td>
<td class = "body" width=  "40" align = "left">Photos</td></tr>
<tr>
<td class = "body2" width = "30" align = "right"><img src = "images/seo-icon.png" height = "18" border = "0" alt = "Upload Photos"></td>
<td class = "body" width=  "40" align = "left">SEO</td>
<td class = "body2" width = "30" align = "right"><%
convertpages = false
 if AddPages = True and convertpages = true and  AddPages = True then %><img src = "images/ConvertIcon.png" height = "18" border = "0" alt = "Convert To A Different type of Page or Animal"><% end if %></td>
<td class = "body" width=  "40" align = "left"><% if AddPages = True and convertpages = true and  AddPages = True then %>Convert Type<% end if %></td>
<td></td>
</tr>
</table><br />
</td>
 </tr>
</table>
</td>
<td width = "13"></td>
  </tr>
  <tr><td colspan = "3" height = "16"></td></tr>
</table>
 <% end if %>  
 <a name="pages"></a>
 <% Current3 = "ListOfPages" %>
<!--#Include file="AdminPagesTabsInclude.asp"-->
<%
pagenamewidth = screenwidth -710
menutitlewidth  = 170
 if Showpagegroups = True then 
 showpageorder  = True
rs2.close %>
<form  name=UpdatePagesform method="post" action="Default.asp?UpdatePages=True">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr><td class = "roundedtop" align = "left">

<table><tr><td class = "body" width = '<%=pagenamewidth%>'><b>Page Name</b></td>
<td class = "body2" width = "<%=menutitlewidth %>" align = "center"><b>Menu Title</b></td>
<% if (MenuDropdowns  = "Yes" or MenuDropdowns = True) and addpages = True and not (showpageorder  = True) then %>
<td class = "body2" width = "100" align = "center"><b>Page Type</b></td>
<% else 
if showpageorder  = True then%>
<td class = "body2" width = "190" align = "right"><b>Page Order</b></td>
<% 
end if
end if %>
<td class = "Body2" width = "100" align = "center"><b>Display</b></td>
<td class = "body2" width = "150" align = "center"><b>Options</b></td></tr></table>
</td></tr>
 <tr><td class = "body  roundedBottom" align = "center" width = "100%"> 
 <% if  AddPages = True then %>
  To change Page Group titles and order select the <a href = "/Administration/AdminPageGroups.asp" Class = "body">Page Groups tab.</a>
  <% end if %>
 <table width= "100%">

<%
 sql3 = "select * from Pagegroups where pagegroupavailable = true order by PageGrouporder"	
acounter = 1
Set rs3 = Server.CreateObject("ADODB.Recordset")
rs3.Open sql3, conn, 3, 3 
While Not rs3.eof 
PageGroupTitle = rs3("PageGroupTitle")
PageGroupID = rs3("PageGroupID") 
 %>
<tr bgcolor = "#e6e6e6" ><td class = "body" colspan = "5" height = "20"><b><%=PageGroupTitle%> Page Group</b></td></tr>
<%
 row = "odd"
 sql2 = "select * from Pagelayout where PageAvailable = True and PageGroupID = " & PageGroupID & " order by linkOrder"
rs2.Open sql2, conn, 3, 3 
  
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
<tr bgcolor = "#e6e6e6">
<% Else 
row = "even"%>

<tr >
<%End If %>
<% if PageGroupID = 19 then %>
<td class= "body"  width = '<%=screenwidth -710%>'>
<a href = "/ADMINISTRATION/BlogAdmin/Default.asp#CatID<%=BlogCatID %>" class = "body">Blog Admin</a><br>
<% sqlb = "select * from BlogCategories order by BlogCategoryOrder " 
Set rsb = Server.CreateObject("ADODB.Recordset")
rsb.Open sqlb, conn, 3, 3 
CatCounter= 0
While Not rsb.eof 
BlogCatID = rsb("BlogCatID")
BlogCategoryName = rsb("BlogCategoryName")%>
<a href = "/ADMINISTRATION/BlogAdmin/Default.asp#CatID<%=BlogCatID %>" class = "body"><%=BlogCategoryName%></a><br>
<% rsb.movenext
Wend
rsb.close
%>
</td>
<td class= "body"  width = '170'>
<% sqlb = "select * from BlogCategories order by BlogCategoryOrder " 
rsb.Open sqlb, conn, 3, 3 
CatCounter= 0
While Not rsb.eof 
BlogCatID = rsb("BlogCatID")
BlogCategoryName = rsb("BlogCategoryName") %>
<%=BlogCategoryName%> Blog<br />

<% rsb.movenext 
Wend
rsb.close
%>
</td>

<% else %>
<td class= "body"  width = '<%=screenwidth -710%>'>
<a href = "<%=EditLinkName %>" class = "body"><%=rs2("PageName")%></a>
</td>
<td class= "body"  width = '170'>
<%=rs2("LinkName")%>
</td>
<% end if %>
<% 
if showpageorder  = True then%>
<td class= "body2"  align ="center" width = "190">




<%
 LinkOrder = rs2("LinkOrder") 
 if LinkOrder = 0 then
 LinkOrder = 1
 end if
pageGroupID = rs2("pageGroupID") 
' if LinkOrder =  previouslinkorder  and  (cint(PageGroupID)  = cint(previouspageGroupID)) then
 ' LinkOrder = LinkOrder +1
 'end if

 'previouslinkorder  = linkOrder 
  previouspageGroupID  = pageGroupID %>
<select size="1" name="LinkOrder(<%=linecount%>)">
<% if len(LinkOrder) > 0 then %>
<option name = "AID1" value="<%=LinkOrder %>">
	<%=LinkOrder %>
</option>
<option  value="0">1</option>
<% else %>
<option name = "AID1" value="">--</option>
<% end if %>
<% count = 2
while count < (TotalPages+1) %>
<option name = "AID1" value="<%=count %>">
<%=count %>
</option>
<% count = count + 1
wend %>
</select>
<input type="hidden" name="pagelayoutid(<%=linecount%>)" value="<%=rs2("pagelayoutid") %>" >

<input type="hidden" name="pagegroupid(<%=linecount%>)" value="<%=pagegroupID %>" >
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
<a href = "AdminHomePage.asp" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "AdminEditSEO.asp?PageName=<%= rs2("PageName") %>" class = "body"><img src= "images/seo-icon.png" alt = "edit" height ="14" border = "0"></a>
 <% if SlideshowAvailable = True then %>
|&nbsp;<a href = "/Administration/AdminGalleryEditImages.asp?GalleryCatID=3" ><img src = "images/Photo.gif" height = "18" border = "0" alt = "Slideshow Photos"></a>
<% end if %>



<% else %>
<a href = "<%=EditLinkName %>" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "AdminPageDelete.asp?PageLayoutID=<%= rs2("PageLayoutID") %>" class = "body"><img src= "images/Delete.gif" alt = "edit" height ="14" border = "0"></a>

|&nbsp;<a href = "AdminEditSEO.asp?PageName=<%= rs2("PageName") %>" class = "body"><img src= "images/seo-icon.png" alt = "edit" height ="14" border = "0"></a>
<% if not(Pagetype = "Basic") and  AddPages = True and convertpages = true then %>
|&nbsp;<a href = "AdminConvertPage.asp?PageName=<%= rs2("PageName") %>&PageLayoutId=<%= rs2("PageLayoutId") %>" class = "body"><img src= "images/ConvertIcon.png" alt = "Convert Page Type" height ="14" border = "0"></a>

<% end if %>
<% end if %>
</td>
</tr>

<%catcounter  = catcounter  +1
 rs2.movenext
wend
rs2.close %>

<% rs3.movenext
wend
rs3.close
%>
<tr>
<td align = "center" colspan = "6">
<input type="hidden" name="totallinecount" value="<%=linecount%>" >

	<input type=submit value = "Update" class = "regsubmit2"  <%=Disablebutton %>></form>
</td>
</tr>
</table>
</td></tr></table>
<% else %>
 <%  
row = "even"
sql2 = "select * from PageLayout where PageAvailable = Yes order by LinkOrder,  PageName, PageGroupID "

Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if not  rs2.eof then
'response.write("showpageorder =" & showpageorder )
 acounter = 1
recordcount = rs2.recordcount
showpageorder = True
if showpageorder  = False then
pagenamewidth = screenwidth -610
menutitlewidth = 210
else
pagenamewidth = screenwidth -710
menutitlewidth = 170
end if


 %>


<form  name=UpdatePagesform method="post" action="Default.asp?UpdatePages=True">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr><td class = "roundedtop" align = "left">
 
<table><tr><td class = "body" width = '<%=pagenamewidth%>'><b>Page Name</b></td>
<td class = "body2" width = "<%=menutitlewidth %>" align = "center"><b>Menu Title</b></td>
<% if (MenuDropdowns  = "Yes" or MenuDropdowns = True) and addpages = True then %>
<td class = "body2" width = "100" align = "center"><b>Page Type</b></td>
<td class = "body2" width = "190" align = "center"><b>Page Group</b></td>
<% else 
if showpageorder  = True then%>
<td class = "body2" width = "190" align = "right"><b>Page Order</b></td>
<% 
end if
end if %>
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
<td class= "body" height=  30 width = '<%=screenwidth -710%>'>
<a href = "<%=EditLinkName %>" class = "body"><%=rs2("PageName")%></a>
</td>
<td class= "body"  width = '170'>
<%=rs2("LinkName")%>
</td>

<% if MenuDropdowns  = "Yes" or MenuDropdowns = True then %>
<td class= "body2"  align ="left" width = "100"><%= PageType %></td>
<td class= "body2"  align ="left" width = "190"><%= PageGroupTitle %></td>
<% else 
if showpageorder  = True then%>
<td class= "body2"  align ="center" width = "190">




<%
 LinkOrder = rs2("LinkOrder") 
%>
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
<a href = "AdminHomePage.asp" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "AdminEditSEO.asp?PageName=<%= rs2("PageName") %>" class = "body"><img src= "images/seo-icon.png" alt = "edit" height ="14" border = "0"></a>
 <% if SlideshowAvailable = True then %>
|&nbsp;<a href = "/Administration/AdminGalleryEditImages.asp?GalleryCatID=3" ><img src = "images/Photo.gif" height = "18" border = "0" alt = "Slideshow Photos"></a>
<% end if %>



<% else %>
<a href = "<%=EditLinkName %>" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "AdminPageDelete.asp?PageLayoutID=<%= rs2("PageLayoutID") %>" class = "body"><img src= "images/Delete.gif" alt = "edit" height ="14" border = "0"></a>

|&nbsp;<a href = "AdminEditSEO.asp?PageName=<%= rs2("PageName") %>" class = "body"><img src= "images/seo-icon.png" alt = "edit" height ="14" border = "0"></a>
<% if not(Pagetype = "Basic") and  AddPages = True then %>
|&nbsp;<a href = "AdminConvertPage.asp?PageName=<%= rs2("PageName") %>&PageLayoutId=<%= rs2("PageLayoutId") %>" class = "body"><img src= "images/ConvertIcon.png" alt = "Convert Page Type" height ="14" border = "0"></a>

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

<input type=submit value = "Update" class = "regsubmit2" <%=Disablebutton %> >
 </form>
</td>
</tr>
</table>


<% end if %>
<% if Showpagegroups  = False then %>
</td>
</tr>
</table>
<% end if %>
<br />
<% if LivestockAvailable = True then %>

<% Current3="AlpacasHome" %> 
<!--#Include file="AdminAnimalsTabsInclude.asp"-->
<table width = "<%=screenwidth %>"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
<tr> 
 <% if mobiledevice = False  then  %> 
<td width = "100%" valign = "top" class = "body">

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left"><a name = "animals"></a>
<% if mobiledevice = False  then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>" class = "roundedTop">
<tr ><td class = "body" align = "center" height = "23" ><b>Your Animals</b></td>
<td class = "body" align = "center" height = "23" width = "220"><b>Species</b></td>
<td class = "body2" align = "right" height = "23" width = "180"><b>Category</b></td>
<td class = "body2" align = "right" height = "23" width = "250"><b>Price(Discount)</b></td>
<td class = "body" align = "center" width = "100"><b>Options</b></td></tr>
</table>
<% else %>

 <% end if%>
  </td></tr>
<tr><td class = "roundedBottom" align = "center"  height = "55">
<% else %>
 <td width = "100%" valign = "top" class = "body">
 
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td  align = "left"> <a name="Animals"></a><H1>Animals</H1></td></tr>
<tr><td  align = "center"  height = "55">
<% end if %>

<% sql = "select distinct animals.*, Pricing.* from animals, Pricing where Animals.ID = Pricing.ID order by Sold Desc, speciesID, FullName"

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
rowcount = 1
dim ID(40000) 
dim Name(40000) 
dim Species(40000) 
dim Breed(40000) 
dim ForSale(40000) 
dim ARI(40000) 
dim DOBday(40000) 
dim DOBMonth(40000) 
dim DOBYear(40000) 
dim Color(40000) 
dim Category(40000) 
dim CLAA(40000) 
dim Price(40000)
dim Sold(40000)
dim Discount(40000)
dim DiscountPrice(40000)

Recordcount = rs.RecordCount +1
%>

<% if rs.eof Then %>
<blockquote>Currently you do not have any animals listed. To add animals please us the <a href = "AdminAnimalAdd1.asp" class = "body"><b>Add an Animal wizard.</b></a></blockquote>
<% else %>

<table border = "0" bordercolor = "#e6e6e6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">


<% row = "odd"
 While  Not rs.eof  
If row = "even" Then
row = "odd"
Else
row = "even"
End if
ID(rowcount) =   rs("ID")
SpeciesID = rs("SpeciesID")

Set rsss = Server.CreateObject("ADODB.Recordset")

sqlss = "select * from SpeciesAvailable  where SpeciesID= " & SpeciesID 
rsss.Open sqlss, conn, 3, 3 
if not rsss.eof then
Species(rowcount) =   rsss("Species")
end if
rsss.close
Name(rowcount) =   rs("FullName")
DOBday(rowcount) =   rs("DOBday")
DOBmonth(rowcount) =   rs("DOBmonth")
DOByear(rowcount) =   rs("DOByear")
Category(rowcount) =   rs("Category")
Price(rowcount)=   rs("Price")
Sold(rowcount)=   rs("Sold")
Discount(rowcount)=   rs("Discount")
if Discount(rowcount) > 0 then
DiscountPrice(rowcount) = Price(rowcount) - (Price(rowcount) * (Discount(rowcount)/100))
else
DiscountPrice(rowcount) = "N/A"
end if
 If row = "even" Then %>
<tr bgcolor = "white">
<% Else %>

<tr bgcolor = "#e6e6e6">
<%End If %>


<% if mobiledevice = False  then %>


<td class = "body"  height = "30" align = "left" >&nbsp; <a href = "AdminAnimalEdit.asp?ID=<%= ID( rowcount)%>" class = "body"><%= Name( rowcount)%></a></td>
<td class = "body2"   align = "left" width = "220"><%= Species(rowcount) %>  </td>
<td class = "body2"   align = "left" width = "180"><%=Category(rowcount) %></td>
<td class = "body2"   align = "right" width = "250">
<%
if Sold(rowcount) = True then %>
<b>Sold</b>
<% else 
if len(Price(rowcount))> 0 then %>
<% if Price(rowcount) = 0 then %>
Call For price
<% else %>
 <%=formatcurrency(Price(rowcount)) %>
<% end if %>
<%if len(DiscountPrice(rowcount)) > 1 then 
if DiscountPrice(rowcount) = "N/A" then %>

<% else %>
(<%=formatcurrency(DiscountPrice(rowcount)) %>)
<% end if %>
  <% end if %>
<% end if %>
<% end if %><img src = "images/px.gif" width = "32" height = "1" /></td>
<td class = "body"   align = "center" width = "100"><a href = "AdminAnimalEdit.asp?ID=<%= ID( rowcount)%>" class = "body"><img src= "images/edit.gif" alt = "edit" height = "18" width = "18" border = "0"></a> &nbsp;|
<a href = "AdminPhotos.asp?ID=<%= ID( rowcount)%>" class = "body"><img src = "images/Photo.gif" height = "18" width = "18" border = "0" alt = "Upload Photos"></a></td>

<%else %>
<% if SmallMobile = False then %>
<td class = "body"  height = 30 align = "left">&nbsp; <a href = "AdminAnimalEdit.asp?ID=<%= ID( rowcount)%>" class = "body"><font size = 8><%= Name( rowcount)%></a></font></a></td>
<% else %>
<td class = "body" height = 30   align = "left">&nbsp; <a href = "AdminAnimalEdit.asp?ID=<%= ID( rowcount)%>" class = "body"><font size = 3><%= Name( rowcount)%></font></a></td>

<% end if %>
<% end if %>
</tr>
<% 
rowcount = rowcount + 1
rs.movenext
Wend
TotalCount=rowcount 
rs.close
%>
</table></form><br />
<% End If %>
</td>
</tr>
</table>
</td>
</tr><tr>
<% End If %>  
<td class = "body" valign = "top">
<% showsecondpages=false
 if showsecondpages= true then%>
<% if mobiledevice = False  then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr><td class = "roundedtop" align = "left">
<H3><div align = "left">Pages</div></H3>
</td></tr>
<tr><td class = "roundedBottom" align = "center">
<% else %>
<% if LivestockAvailable = True then %>
<!--#Include file="AdminMobileMenuInclude.asp"-->
<% end if %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr><td  align = "left">
<br /><H1><div align = "left">Pages</div></H1>
</td></tr>
<tr><td  align = "center">
<% end if 

%>



<form  name=UpdatePagesform method="post" action="Default.asp?UpdatePages=True">
 <table  border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" width = "100%" align = "center">
 
<tr>
  <td class = "body" valign = "top">
<table border = "0" bordercolor = "#CEBD99" width = "100%" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
<tr >
   <td class = "body2" align = "center" height = "23" >
  <a name="Pages"></a> <% if mobiledevice = False   then %>
   <b>Page</b></td>
   <td class = "body2" align = "center" height = "23" >
   <b>Display Page</b></td>
   <td class = "body2" align = "center" height = "23" ><b>Options</b></td>
   <% end if %>
</tr>
<% 
order = "odd"
sql2 = "select * from Pagelayout where  PageAvailable = True order by pagename"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 

While Not rs2.eof 
 PageFound = False
ShowPage = rs2("ShowPage")
 if order = "even" then
  order = "odd" %>
  <tr bgcolor = "#e6e6e6">
  
 <% else
 order = "even" %>
 <tr bgcolor = "White">
<% end if %>
 
<% if rs2("PageName") ="Photo Galleries" then
PageFound = True%> 
  <td class = "body" height = "23">&nbsp;Photo Galleries</td>
 <td class = "body2" align = "center">
  <% if ShowPage  = True then %>
  <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>" checked onchange="submit();">Yes
  <% else %>
  <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>" onchange="submit();">No
  <% end if %>
</td>
 <td class = "body" align = "center"></td>
 </tr>
  <% if order = "even" then %>
  <tr bgcolor = "white">
 <% else %>
 <tr bgcolor = "#efefef">
<% end if  %>
   <% if mobiledevice = True   then %>
   <td colspan = "3" align = "center">
 <a href = "AdminGalleryAddImage1.asp" class = "body"><small>Add Images</small></a>
<a href = "AdminGalleryEditImages.asp" class = "body" ><small>Edit Images</small></a>
<a href = "AdminGallerySetCategories.asp" class = "body" ><small>Gallery Categories</small></b></a>
   </td>
   <% end if %>
 </tr>
 <% end if %>
 

<% if rs2("PageName") ="Farm Store (Header)" then
PageFound = True%> 
  <td class = "body" height = "23">&nbsp;Farm Store</td>
 <td class = "body2" align = "center">
  <% if ShowPage  = True then %>
  <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>" checked>Yes
  <% else %>
  <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>" >No
  <% end if %>
</td>
 <td class = "body" align = "center"></td>
 </tr>
  <% if order = "even" then %>
  <tr bgcolor = "white">
 <% else %>
 <tr bgcolor = "#efefef">
<% end if  %>
   <td colspan = "3" align = "center">
 
 
 <a href = "AdminClassifiedAdPlace.asp" class= "body" >&nbsp;<small>Add&nbsp;</small></a>
<a href = "AdminAdEdit.asp" class= "body"  ><small>Edit&nbsp;</small></a>
<a href = "AdminListingDelete.asp" class= "body"  ><small>Delete&nbsp;</small></a>
<a href = "AdminProductPhotos.asp" class= "body" ><small>Photos&nbsp;</small></a>
<a href = "AdminSetSaleCategories.asp" class= "body" ><small>Categories&nbsp;</small></a>
<a href = "AdminStoreShippingRates.asp" class= "body" ><small>Shipping&nbsp;</small></a>
<a href = "AdminStoreMaintenance.asp" class= "body" ><small>Settings&nbsp;</small></a>

  
   </td>
 </tr>
 <% end if %>

<% if  PageFound = False then %>
 <% if mobiledevice = False  then %>

 <% if rs2("LinkName")  = "Home" then%>
  <td class = "body" height = "23" >&nbsp;&nbsp;<a href = " AdminHomePage.asp" class= "body" ><%=rs2("LinkName")%></a></td>
 <% else %>
  <td class = "body" height = "23" >&nbsp;&nbsp;<a href = "AdminPagedata.asp?PageLayoutID=<%= rs2("PageLayoutID") %>#BasicFacts" class= "body" ><%=rs2("LinkName")%></a></td>
 
 <% end if %>

<% else %>
<% if SmallMobile = False then %>
 <td class = "body" height = "55" >&nbsp;&nbsp;<a href = "AdminPagedata.asp?PageLayoutID=<%= rs2("PageLayoutID") %>#BasicFacts" class= "body" ><font size="8"><%=rs2("LinkName")%></font></a><% if rs2("LinkName")  = "Packages" then%>
<a href = "<%=rs2("EditLink")%>" class = "body">&nbsp;&nbsp;&nbsp;&nbsp;- <font size = "8">Edit</font></a>&nbsp;&nbsp;&nbsp;&nbsp;- <a href = "AdminPackagesAdd.asp" class = "body"><font size = "8">Add</font></a>
<% end if %>
 
 <% if rs2("LinkName")  = "Photo Galleries" then%>
 &nbsp;&nbsp;&nbsp;&nbsp;- <a href = "AdminGalleryAddImage1.asp" class = "body"><font size = "8">Add</font></a>
&nbsp;&nbsp;&nbsp;&nbsp;- <a href = "AdminGalleryEditImages.asp" class = "body" ><font size = "8">Edit</font></a>
&nbsp;&nbsp;&nbsp;&nbsp;- <a href = "AdminGallerySetCategories.asp" class = "body" ><font size = "8">Categories</font></b></a>
<% end if %>
</td>
 <% else %>
 
 <td class = "body" height = "55" >&nbsp;&nbsp;<a href = "<%=rs2("EditLink")%>" class= "body" ><font size="3"><%=rs2("LinkName")%></font></a>
 
 <% if rs2("LinkName")  = "Packages" then%><br />
&nbsp;&nbsp;&nbsp;&nbsp;- <a href = "AdminAdEdit2.asp?ProdID=<%= rs2("LinkName")%>" class = "body"><font size = "3">Edit</font></a>&nbsp;&nbsp;&nbsp;&nbsp;-  <a href = "AdminPackagesAdd.asp" class = "body"><font size = "3">Add</font></a>
<% end if %>
 
 
 
 <% if rs2("LinkName")  = "Photo Galleries" then%><br />
 &nbsp;&nbsp;&nbsp;&nbsp;- <a href = "AdminGalleryAddImage1.asp" class = "body"><font size = "3">Add</font></a>
&nbsp;&nbsp;&nbsp;&nbsp;- <a href = "AdminGalleryEditImages.asp" class = "body" ><font size = "3">Edit</font></a>
&nbsp;&nbsp;&nbsp;&nbsp;- <a href = "AdminGallerySetCategories.asp" class = "body" ><font size = "3">Categories</font></b></a>
<% end if %>
 </td>
 <% end if %>
<% end if %> 
<% if mobiledevice = False then %>
 <td  align = "center" >
 <% if rs2("PageName") ="Home Page" then %>
  Always
  <% else %>   
  <% if ShowPage  = True then %>
  <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>" checked>Yes
  <% else %>
  <input type="checkbox" type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>"  >No
  <% end if %>
  <% end if %></td>



  <td class = "body2" align = "center">
  
  <% if rs2("LinkName")  = "Home" then%>
  <a href = " AdminHomePage.asp" class= "body" >
 <% else %>
<a href = "<%=rs2("EditLink")%>" class= "body" >
 <% end if %>
<img src= "images/edit.gif" alt = "edit" height = "18" width = "16" border = "0"></a></td>
 <% end if  %>
 
 </tr>

 <%
 end if  
rs2.movenext
 Wend %>
  <% if mobiledevice = False   then %>
<tr>
<td class = "body" colspan = "3" align = "center">
<center><input type="submit"  value="Submit" class = "regsubmit2"  <%=Disablebutton %>></center><br>

</td>
</tr>
<% end if %>
</table>
<% end if %>


 <% 
 if EcommerceAvailable = True then %>
 </td></tr></table><br /><a name = "Products"></a>
<% Current3 = "ProductsHome" %> 
<!--#Include file="AdminProductsTabsInclude.asp"-->
<%  if mobiledevice = False  then %>


 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
 <tr><td class = "roundedtop" align = "left">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr ><td class = "body" align = "center" height = "23" width = "<%=screenwidth - 710 %>"><b>Your Products</b></td>
<td class = "body2" align = "center" height = "23" width = "270"><b>Categories (Sub-Categories)</b></td>
 <td class = "body2" align = "center" height = "23" width = "140"><b>QTY Available</b></td>
 <td class = "body2" align = "center" height = "23" width = "200"><b>Price(Discount)</b></td>
<td class = "body2" align = "center" width = "100"><b>Options</b></td></tr>
</table>
</td></tr>
<tr><td class = "roundedBottom" align = "center">
 <% else %>
 <!--#Include file="AdminMobileMenuInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" >
<tr><td  align = "left"><H3><div align = "left">Products</div></H3>

</td></tr>
<tr><td align = "center">
 <% end if  %>

 <table  border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" width = "100%" align = "center">
 <tr>
  <td  class = "body" valign = "top">
<%
 Dim ProdName(100000)
 Dim AdType(100000)
 Dim CategoryID(100000)
Dim ProdPrice(100000) 
Dim ProdQuantityAvailable(100000)
Dim ProdCity(100000) 
Dim ProdState(100000)
Dim ProdZip(100000) 
Dim ProdPartofTown(100000)
Dim ProdYear(100000) 
Dim ProdMake(100000) 
Dim ProdModel(100000) 
Dim ProdCondition(100000) 
Dim ProdColor(100000)  
Dim ProdStartDate(100000)  
Dim ProdEndDate(100000)  
Dim ProdWeight(100000)  
Dim ProdID(100000) 
Dim prodCategoryId(100000) 
Dim prodSubCategoryId(100000)
Dim SalePrice(100000)
Dim Category1(100000)
Dim SubCategory1(100000)
Dim Category2(100000)
Dim SubCategory2(100000)
Dim Category3(100000)
Dim SubCategory3(100000)
Dim Category1ID(100000)
Dim Category2ID(100000)
Dim Category3ID(100000)
Dim SubCategory1ID(100000)
Dim SubCategory2ID(100000)
Dim SubCategory3ID(100000)

Sort=request.form("Sort") 
If Len(Sort) < 4 Then
Sort = "Prodname"
End if
  SortName = Sort
If Sort = "ProdName" Then
SortName = "Name"
End If 
If Sort = "CatName" Then
SortName = "Category"
End If 
If Sort = "ProdPrice" Then
SortName = "Price"
End If 
If Sort = "ProdQuantityAvailable" Then
SortName = "QTY Available"
End If 

sql = "select * from sfProducts order by " & Sort
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
rowcount = 1


Recordcount = rs.RecordCount +1
 if rs.eof Then %>
<blockquote>Currently you do not have any products listed. To add products please select <a href = "AdminClassifiedAdPlace.asp" class = "body"><b>Add a product.</b></a></blockquote>

<% else %>
<table border = "0" bordercolor = "#e6e6e6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth %>" align = "center">
<%
row = "odd"
 While  Not rs.eof  
If row = "even" Then
row = "odd"
Else
row = "even"
End if
ProdName(rowcount)=rs("ProdName") 
ProdPrice(rowcount) =rs("ProdPrice")
ProdID(rowcount) =rs("ProdID")
SalePrice(rowcount) =rs("SalePrice")
ProdQuantityAvailable(rowcount) =rs("ProdQuantityAvailable")
sqlpc = "select * from ProductcategoriesList where  ProductId=" & ProdID(rowcount)
Set rspc = Server.CreateObject("ADODB.Recordset")
rspc.Open sqlpc, conn, 3, 3 
if not rspc.eof then
  Category1ID(rowcount) = rspc("prodCategoryId")
  SubCategory1ID(rowcount) = rspc("prodSubCategoryId")
  rspc.movenext
end if

if not rspc.eof then
  Category2ID(rowcount) = rspc("prodCategoryId")
  SubCategory2ID(rowcount) = rspc("prodSubCategoryId")
  rspc.movenext
end if

if not rspc.eof then
  Category3ID(rowcount)= rspc("prodCategoryId")
  SubCategory3ID(rowcount) = rspc("prodSubCategoryId")
end if
rspc.close

if len(Category1ID(rowcount)) > 0 then
sqlpc = "select * from sfcategories where  catId=" & Category1ID(rowcount)
Set rspc = Server.CreateObject("ADODB.Recordset")
rspc.Open sqlpc, conn, 3, 3 
if not rspc.eof then
Category1(rowcount) = rspc("catName")
end if
rspc.close
end if

if len(Category2ID(rowcount)) > 0 then
sqlpc = "select * from sfcategories where  catId=" & Category2ID(rowcount)
Set rspc = Server.CreateObject("ADODB.Recordset")
rspc.Open sqlpc, conn, 3, 3 
if not rspc.eof then
Category2(rowcount) = rspc("catName")
end if
rspc.close
end if

if len(Category3ID(rowcount)) > 0 then
sqlpc = "select * from sfcategories where  catId=" & Category3ID(rowcount)
Set rspc = Server.CreateObject("ADODB.Recordset")
rspc.Open sqlpc, conn, 3, 3 
if not rspc.eof then
Category3(rowcount) = rspc("catName")
end if
rspc.close
end if

if len(SubCategory1ID(rowcount)) > 0 then
sqlpc = "select * from sfSubcategories where  subcatId=" & SubCategory1ID(rowcount)
Set rspc = Server.CreateObject("ADODB.Recordset")
rspc.Open sqlpc, conn, 3, 3 
if not rspc.eof then
SubCategory1(rowcount) = rspc("SubCategoryName")
end if
rspc.close
end if

if len(SubCategory2ID(rowcount)) > 0 then
sqlpc = "select * from sfSubcategories where  subcatId=" & SubCategory2ID(rowcount)
Set rspc = Server.CreateObject("ADODB.Recordset")
rspc.Open sqlpc, conn, 3, 3 
if not rspc.eof then
SubCategory2(rowcount) = rspc("SubCategoryName")
end if
rspc.close
end if

if len(SubCategory3ID(rowcount)) > 0 then
sqlpc = "select * from sfSubcategories where  subcatId=" & SubCategory3ID(rowcount)
Set rspc = Server.CreateObject("ADODB.Recordset")
rspc.Open sqlpc, conn, 3, 3 
if not rspc.eof then
SubCategory3(rowcount) = rspc("SubCategoryName")
end if
rspc.close
end if

If row = "even" Then %>
<tr bgcolor = "white">
<% Else %>

<tr bgcolor = "#e6e6e6">
<%End If %>
 <% if mobiledevice = False  then %>
 

<td class = "body" valign = "top" height = "25" width = " <%=screenwidth - 710 %>" valign = "top">&nbsp;&nbsp;<a href = "AdminAdEdit2.asp?ProdID=<%= ProdID( rowcount)%>" class = "body"><%= ProdName(rowcount)%></a></td>
 <td class = "body" align = "center" width = "270" valign = "top">
 <% if len(Category1(rowcount))> 0 then %>
   <% =Category1(rowcount) %>
  <% if len(SubCategory1(rowcount))> 0 then %>
   ( <% =SubCategory1(rowcount) %>)
 <% end if %>
   
 <% end if %>
  <% if len(Category2(rowcount))> 0 then %>
   <br /><% =Category2(rowcount) %>
 <% if len(SubCategory2(rowcount))> 0 then %>
   ( <% =SubCategory2(rowcount) %>)
 <% end if %>
 <% end if %>
  <% if len(Category3(rowcount))> 0 then %>
   <br /><% =Category3(rowcount) %>
 <% if len(SubCategory3(rowcount))> 0 then %>
   ( <% =SubCategory3(rowcount) %>)
 <% end if %>
 <% end if %>
 
 </td>
<td class = "body2" align = "center" width = "140" valign = "top"><%=ProdQuantityAvailable(rowcount)  %></td>
<td class = "body2" align = "right" width = "200" valign = "top">
  <% if len(ProdPrice(rowcount)) > 0 then %>
<%=formatcurrency(ProdPrice(rowcount)) %>
<% end if %>
  <% if len(SalePrice(rowcount)) > 0 then %>
(<%=formatcurrency( SalePrice(rowcount)) %>)
<% end if %><img src = "images/px.gif" width = "10" height = "1" />
</td>
<td class = "body2" valign = "top" align = "center" width = "100" valign = "top"><a href = "AdminAdEdit2.asp?ProdID=<%= ProdID( rowcount)%>" class = "body"><img src= "images/edit.gif" alt = "edit" height = "18"  border = "0"></a> &nbsp;|
<a href = "AdminProductPhotos.asp?ID=<%= ProdID( rowcount)%>" class = "body"><img src = "images/Photo.gif" height = "18" border = "0" alt = "Upload Photos"></a></td>
<% else %>
<% if SmallMobile = False then %>
<td class = "body" valign = "top" height = "55" valign = "top">&nbsp;&nbsp;<a href = "AdminAdEdit2.asp?ProdID=<%= ProdID( rowcount)%>" class = "body"><font size = 8><%= ProdName(rowcount)%></font></a></td>
<% else %>
<td class = "body" valign = "top" height = "55" valign = "top">&nbsp;&nbsp;<a href = "AdminAdEdit2.asp?ProdID=<%= ProdID( rowcount)%>" class = "body"><font size = 3><%= ProdName(rowcount)%></font></a></td>

<% end if %>
<% end if  %>
</tr>
<% 

rowcount = rowcount + 1
   rs.movenext

Wend
TotalCount=rowcount 
rs.close

%>

</table>
<% end if %>
</td>
</tr>
<tr>
 </table>
<% end if %>





</td>
</tr>
</table>
</td>
</tr>
</table>
 <% if LivestockAvailable = False then %>
 </td>
 <td valign = "top">
<% end if %>

 </td>
</tr>
</table> 
  </td>
</tr>
</table> 
  </td>
</tr>
</table> 
   <br>

<br>
 <!--#Include file="AdminFooter.asp"--> 
</BODY>
</HTML>