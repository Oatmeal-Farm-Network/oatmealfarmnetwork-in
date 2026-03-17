<!DOCTYPE HTML>
<HTML>
<HEAD>
<!--#Include File="membersGlobalVariables.asp"--> 
</HEAD>

<body >


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
 <!--#Include File="MembersHeader.asp"--> 
 <% Current3 = "PagesHome"  %>
  <!--#Include File="MembersPagesJumpLinks.asp"--> 
<%


 If Request.Querystring("UpdatePages" ) = "True" Then

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
<% if mobiledevice = False and ScreenWidth > 768 then %>
<table border = "0" cellspacing="0" cellpadding = "0"  ><tr>

<td class = "body" valign = "top">


<tr>
<td Class = "body" align = "right">
Email:
</td>
<td class = "body" align = "left">
<input type=text  name=UID value = "<%=AIEmail%>" SIZE = "36" >
</td>
<td rowspan= "2">
<input type=submit value = "Login"  size = "170" class = "regsubmit2" >
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


</td>
<td width = "10"></td>
<td valign = "top">

<table border = "0" cellspacing="0" cellpadding = "0" align = "right" ><tr><td class = "roundedtop" align = "left">
<H3><div align = "left">Key</div></H3>
</td></tr>
<tr><td class = "roundedBottom" align = "center" height ="57">
<table border = "0" cellpadding = "0" cellspacing="0"  align = "right">
 <tr>
<td class = "body2" width = "30" align = "right"><img src= "/administration/edit.gif" alt = "edit" height = "18"  border = "0"></td>
<td class = "body" width=  "35">Edit</td>
<td class = "body2" width = "30" align = "right"><img src = "/administration/Photo.gif" height = "18" border = "0" alt = "Upload Photos"></td>
<td class = "body" width=  "40" align = "left">Photos</td></tr>
<tr>
<td class = "body2" width = "30" align = "right"><img src = "/images/seo-icon.png" height = "18" border = "0" alt = "Upload Photos"></td>
<td class = "body" width=  "40" align = "left">SEO</td>
<td class = "body2" width = "30" align = "right"><% if AddPages = True and  AddPages = True then %><img src = "/administration/ConvertIcon.png" height = "18" border = "0" alt = "Convert To A Different type of Page or Animal"><% end if %></td>
<td class = "body" width=  "40" align = "left"><% if AddPages = True then %>Convert Type<% end if %></td>
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

 <%  
row = "even"
sql2 = "select * from PageLayout where PageAvailable = 1 and peopleID = " & PeopleID & " order by PageGroupID, LinkOrder "
response.write("sql2=" & sql2)
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
<a href = "AdminHomePage.asp" class = "body">&nbsp;&nbsp;<img src= "edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "AdminEditSEO.asp?PageName=<%= rs2("PageName") %>" class = "body"><img src= "/images/seo-icon.png" alt = "edit" height ="14" border = "0"></a>
 <% if SlideshowAvailable = True then %>
|&nbsp;<a href = "/Administration/AdminGalleryEditImages.asp?GalleryCatID=3" ><img src = "/images/Photo.gif" height = "18" border = "0" alt = "Slideshow Photos"></a>
<% end if %>



<% else %>
<a href = "<%=EditLinkName %>" class = "body">&nbsp;&nbsp;<img src= "edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "AdminPageDelete.asp?PageLayoutID=<%= rs2("PageLayoutID") %>" class = "body"><img src= "/images/Delete.gif" alt = "edit" height ="14" border = "0"></a>

|&nbsp;<a href = "AdminEditSEO.asp?PageName=<%= rs2("PageName") %>" class = "body"><img src= "/images/seo-icon.png" alt = "edit" height ="14" border = "0"></a>
<% if not(Pagetype = "Basic") and  AddPages = True then %>
|&nbsp;<a href = "AdminConvertPage.asp?PageName=<%= rs2("PageName") %>&PageLayoutId=<%= rs2("PageLayoutId") %>" class = "body"><img src= "/images/ConvertIcon.png" alt = "Convert Page Type" height ="14" border = "0"></a>

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
</td>
</tr>
</table><br />



<br>
 <!--#Include file="MembersFooter.asp"--> 
</BODY>
</HTML>