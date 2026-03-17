<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title><%=Sitenamelong %> Administration</title>
<meta name="Title" content="<%=Sitenamelong %> Administration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<!--#Include file="AdminGlobalVariables.asp"-->
<% Current2 = "SiteAdmin" 
Current3 = "SiteAdminHome" %> 
<!--#Include file="adminHeader.asp"-->

<% If not rs.State = adStateClosed Then
rs.close
End If

 If Request.Querystring("UpdatePages" ) = "True" Then
ShowPages = request.Form("ShowPages")

sqlp = "select * from pageLayout "

 Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sqlp, conn, 3, 3   
if not rs.eof then
 Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
 while Not rs.eof 
 PageName = rs("PageName")
str1 = ShowPages 
str2 = PageName


If InStr(str1, str2) > 0 or PageName = "Home Page" Then
Query =  " UPDATE pageLayout Set "
Query =  Query & " ShowPage = True"
Query =  Query & " where PageName = '" & PageName & "' ;"
DataConnection.Execute(Query) 

else
Query =  " UPDATE pageLayout Set "
Query =  Query & " ShowPage = False"
Query =  Query & " where  PageName = '" & PageName & "' ;" 
DataConnection.Execute(Query) 
End If  

 rs.movenext
wend 

DataConnection.Close
Set DataConnection = Nothing 
 end if 
end if



sql2 = "select * from people where peopleID = 667;" 
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
 If Not rs2.eof Then

AIEmail = rs2("AIEmail")
AIPassword = rs2("AIPassword")
End If 
' End Update Pages 

Current4 = "PageAdmin"
Current3 = "EditPages"
%>

<!--#Include file="SiteAdminTabsInclude.asp"-->
<!--#Include file="SiteAdminTabsIncludeBottom.asp"--> 
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" bgcolor = "white" width = "100%">
<tr><td class = "roundedtopandbottom" align = "left">
<H1><div align = "left">Website Administration</div></H1>

<table border = "0" bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td  valign = "top" class = "body">
<table border = "0" width = "800"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td width = "575" valign = "top" class = "body">

<table border = "0" cellspacing="0" cellpadding = "0" align = "right" ><tr><td class = "roundedtop" align = "left">
		<H3><div align = "left">Key</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<table border = "0" cellpadding = "0" cellspacing="0"  align = "right">
 <tr>
  <td class = "body" width = "30" align = "right"><img src= "images/edit.gif" alt = "edit" height = "18"  border = "0"></td>
 <td class = "body" width=  "35">Edit</td>
   <td class = "body" width = "30" align = "right"><img src = "images/Photo.gif" height = "18" border = "0" alt = "Upload Photos"></td>
 <td class = "body" width=  "40" align = "left">Photos</td>
    <td class = "body" width = "30" align = "right"><img src = "images/seo-icon.png" height = "18" border = "0" alt = "Upload Photos"></td>
 <td class = "body" width=  "40" align = "left">SEO</td>
   </tr>
</table>
</td>
</tr>
</table>

<%  
row = "even"
sql2 = "select * from PageLayout where PageAvailable = Yes order by PageName, PageGroupID "
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if not  rs2.eof then
 acounter = 1
recordcount = rs2.recordcount
%>
<form  name=UpdatePagesform method="post" action="siteadminHome.asp?UpdatePages=True">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr><td class = "roundedtop" align = "left">
 
<table  border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "body" width = '<%=screenwidth -710%>'><b>Page Name</b></td>
<td class = "body2" width = "170" align = "center"><b>Menu Title</b></td>
<td class = "body2" width = "100" align = "center"><b>Page Type</b></td>
<% if MenuDropdowns  = "Yes" or MenuDropdowns = True then %>
<td class = "body2" width = "190" align = "center"><b>Page Group</b></td>
<% end if %>
<td class = "Body2" width = "100" align = "center"><b>Display</b></td>
<td class = "body2" width = "160" align = "center"><b>Options</b></td></tr></table>
</td></tr>
 <tr><td class = "roundedBottom" align = "center" width = "100%"> 
 <table border = "0" cellpadding=0 cellspacing=0  width = "100%" align = "center" >
<% While Not rs2.eof 
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
<td class= "body2"  align ="left" width = "100"><%= PageType %></td>
<% if MenuDropdowns  = "Yes" or MenuDropdowns = True then %>
<td class= "body2"  align ="left" width = "190"><%= PageGroupTitle %></td>
<% end if %>
<td class= "body2"  align = "left" width = "100">
<% if rs2("PageName") ="Home Page" then %>
Always
<% else %>   
<% if ShowPage  = True then %>
<input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>" onchange="submit();" checked >Yes
<% else %>
 <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>"  onchange="submit();">No
<% end if %>
<% end if %></td>
<td class= "body" width = "160">
<% if rs2("PageName")  = "Home Page" then %>
<a href = "AdminHomePage.asp" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "AdminEditSEO.asp?PageName=<%= rs2("PageName") %>" class = "body"><img src= "images/seo-icon.png" alt = "edit" height ="14" border = "0"></a>
 <% if SlideshowAvailable = True then %>
|&nbsp;<a href = "/Administration/AdminGalleryEditImages.asp?GalleryCatID=3" ><img src = "images/Photo.gif" height = "18" border = "0" alt = "Slideshow Photos"></a>
<% end if %>



<% else %>
<a href = "<%=EditLinkName %>" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "AdminPageDelete.asp?PageLayoutID=<%= rs2("PageLayoutID") %>" class = "body"><img src= "images/Delete.gif" alt = "edit" height ="14" border = "0"></a>

|&nbsp;<a href = "AdminEditSEO.asp?PageName=<%= rs2("PageName") %>" class = "body"><img src= "images/seo-icon.png" alt = "edit" height ="14" border = "0"></a>
<% end if %>
</td>
</tr>

<%catcounter  = catcounter  +1
rs2.movenext
Wend
FinalCatCounter = catcounter 
end if
rs2.close%>
</table>
<table width = "900"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
<td><br><br>
<table width = "900"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr bgcolor = "antiquewhite">
<td class = "body" align = "center" ><b>User</b></td>
<td class = "body" align = "center" ><b>Access Level</b></td>
<td class = "body" align = "center" ><b>Options</b></td>
</tr>
<%  sql = "select * from People, Business where People.BusinessID = Business.BusinessID order by BusinessName"
'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  
if rs.eof then
else    
rowcount = 1
dim PeopleIDArray(99999) 
dim BusinessName(99999)  
dim Accesslevel(99999) 

row = "odd"
 While  Not rs.eof  
    If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
    
BusinessName(rowcount) =   rs("BusinessName")
Accesslevel(rowcount) =   rs("Accesslevel")
PeopleIDArray(rowcount) =   rs("PeopleID")

showstats = True
 If row = "even" Then %>
<tr>
<% Else %>
<tr bgcolor = "antiquewhite" >
<%	End If %>
		

	</td>
	<td class = "body" width = "250" align = "left">
		<a href = "SiteAdminEditUser.asp?UserID=<%= PeopleIDArray(rowcount)%>#BasicFacts" class = "body"><%= BusinessName(rowcount)%></a>
	</td>
	<td class = "body" align = "center">
	<%=Accesslevel(rowcount) %>
	</td>
		<td class = "body" align = "center" ><a href = "SiteadminEdituser.asp?userID=<%= PeopleIDArray(rowcount)%>" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a><br>
		</td>
		</tr>
<% 

		rowcount = rowcount + 1
	   rs.movenext

	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing

 %>


</table>

<br>

</td>
</tr>
</table>
</td>
</tr>

</table>
<% end if %>
</td>
</tr>
</table>

</td></tr></table>
<!--#Include virtual="/Footer.asp"--> 
</body></html>