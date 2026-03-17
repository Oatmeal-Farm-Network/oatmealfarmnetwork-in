<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Language" content="en-us">
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>

<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
</HEAD>
<body >
<% Current3 = "PageContent"  %>
<!--#Include virtual="/members/MembersHeader.asp"-->
<%
PageLayoutId=Request.Querystring("PageLayoutId") 
response.write("PageLayoutId=" & len(PageLayoutId) )

If Len(PageLayoutId) > 0 then
	Pagename=Request.Querystring("pagename") 
End If

if len(PageName) > 2 then
sql = "select * from Pagelayout where Pagename='" & Pagename & "';"
else
sql = "select * from Pagelayout where PageLayoutId=" & PageLayoutId & ";"
end if
response.write("sql=" & sql)

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
PageLayoutID = rs("PageLayoutID")
PageName = rs("PageName")
PageTitle = rs("PageTitle")
PageGroupID = rs("PageGroupID")
LinkName=rs("LinkName")
ShowPage=rs("ShowPage")
if len(PageGroupID)> 0 then
sqlg = "select * from PageGroups where PageGroupID = " & PageGroupID
Set rsg = Server.CreateObject("ADODB.Recordset")
rsg.Open sqlg, conn, 3, 3 
if not rsg.eof then
PageGroupTitle = rsg("PageGroupTitle")
end if
rsg.close 
end if 


if PagelayoutID = 7 then
%>
<% Current3="LinkHeading" %> 
<!--#Include file="AdminPagesTabsInclude.asp"-->
 <!--#Include file="AdminLinksTabsInclude.asp"--> 
<% end if %>
<a name="Top"></a>
<% 
if mobiledevice = False  then 
If PageName = "About Us" Then
Response.Redirect("AdminAboutUs.asp")
End if
If PageName = "Herdsires" Then 
Current3 = "PageContent" %>
<!--#Include File="AdminPagesTabsInclude.asp"--> 
<% End if
If PageName = "Articles" Then 
Current3 = "ArticlesHeader" %>
<!--#Include file="AdminArticlesTabsInclude.asp"-->
<% End if
If PageName = "Galleries" Then 
Current3 = "GalleryHeading" %>
<!--#Include file="AdminGalleryTabsInclude.asp"-->
<% End if
If PageName = "Alpacas For Sale" Then 
Current3 = "Heading"  %>
<!--#Include file="AdminAnimalsTabsInclude.asp"-->
<% End if
If PageName = "Blog" Then 
Current3 = "PageContent"  %> 
<!--#Include virtual="/Members/CustSiteAdmin/BlogAdmin/BlogAdminTabsInclude.asp"-->
<% End if
If PageName = "Home Page" or PageName = "FAQ" Then 
Current3 = "PageContent"  %> 
<!--#Include file="AdminPagesTabsInclude.asp"-->
<% End if 
If PageName = "Farm Store" Then 
Current3 = "ProductsHeader"  %> 
<!--#Include virtual="/Members/CustSiteAdmin/AdminProductsTabsInclude.asp"-->
<% End if
If PagelayoutId = 32 Then 
Current3 = "PackagesHeader"  %> 
<!--#Include virtual="/Members/CustSiteAdmin/AdminPackagesTabsInclude.asp"-->
<% End if
End if
str1 = PageTitle
str2 = "</br>"
If InStr(str1,str2) > 0 Then
PageTitle= Replace(str1, str2 , vbCrLf)
End If  
str1 = PageTitle
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
PageTitle= Replace(str1,  str2, " ")
End If 
str1 = PageTitle
str2 = "''"
If InStr(str1,str2) > 0 Then
PageTitle= Replace(str1,  str2, "'")
End If 
Dim PageNameList(40000)
sql2 = "select * from Pagelayout2 where PageLayoutID = "	& PageLayoutID & " and BlockNum = 1"
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
PageText = rs2("PageText")
rs2.close
str1 = PageText
str2 = "</br>"
If InStr(str1,str2) > 0 Then
PageText= Replace(str1, str2 , vbCrLf)
End If  
str1 = PageText
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
PageText= Replace(str1,  str2, " ")
End If 
str1 = PageText
str2 = "''"
If InStr(str1,str2) > 0 Then
PageText= Replace(str1,  str2, "'")
End If 
sql2 = "select * from Pagelayout where PageAvailable = True"	
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
While Not rs2.eof  
PageNameList(acounter) = rs2("PageName")
acounter = acounter +1
rs2.movenext
Wend		
rs2.close
set rs2=nothing

%>
<a name="Top"></a>
<% if mobiledevice = False  then %>
<% if screenwidth < 1000  then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth %>">
<% end if %>
<tr><td class = "roundedtop" align = "left">
<H1><div align = "left"><%=PageName %> Heading</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "100%">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td align = "left">
<H1><div align = "left"><%=PageName %> Heading</div></H1>
</td></tr>
<tr><td  align = "center" width = "100%">
<% end if %>
<br />
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
<% if mobiledevice = False  then %>
<tr><td Class = "body">This is the text that shows up on the top of the <%=PageName %> page.<br /><br /></td></tr><% end if %>
</table>
<form action= 'AdminPageHandleForm.asp' method = "post">
<input name="PageName"  size = "60" value = "<%=rs("PageName")%>" type = "hidden">
<input name="ID"  size = "60" value = "<%=ID%>" type = "hidden">
<input name="PageLayoutID"  value = "<%=PageLayoutID%>" type = "hidden">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
<tr><td valign = "top">
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
<tr>
	<td  align = "right" class = "body">
			<div align = "right"><b>Page Name:</b></div>
		</td><td  align = "left" class = "body">
			<%=PageName%>
		</td>
</tr>
<tr>	
		<td  align = "right" class = "body">
		    <div align = "right"><b>Menu Title:*</b></div>
		</td>
		<td  align = "left" class = "body">
		    <input name="LinkName" value= "<%=LinkName%>" size = "20" maxsize = "20">
		   <font color = "gray">Max. length = 20 charecters</font>
		</td>
</tr>
<% 

if MenuDropdowns  = "Yes" or MenuDropdowns = True then %>
<tr>
<td  align = "right" class = "body">
			<div align = "right"><b>Page Group:*</b></div>
		</td>
		<td  align = "left" class = "body">
			<select size="1" name="PagegroupID">
			<% if len(PageGroupTitle) > 2 then %>
<option name = "AID1" value="<%=PageGroupID %>">
	<%=PageGroupTitle %>
</option>
<% else %>
<option name = "AID1" value="">--</option>
<% end if %>
<% count = 1
	sqlg = "select * from PageGroups order by PageGroupOrder"

	acounter = 1
	Set rsg = Server.CreateObject("ADODB.Recordset")
	rsg.Open sqlg, conn, 3, 3 
					
while not rsg.eof	%>
<option name = "AID1" value="<%=rsg("PagegroupID") %>">
	<%=rsg("PageGroupTitle") %>
</option>
<% 	rsg.movenext
wend %>
</select>
</td>
</tr>
<% end if %>
<tr>
	<td  align = "right" class = "body">
			<div align = "right"><b>Page Heading:</b></div>
		</td>
		<td  align = "left" class = "body">
					<input name="PageTitle" value= "<%=PageTitle%>" size = "30">
		</td>
</tr>

<tr><td  class = "body" ><div align = "right">
			<b>Display:</b>&nbsp;</div>
		</td>
		<td class = "body">
			<% if ShowPage = "Yes" Or  ShowPage = True Then %>
						Yes<input TYPE="RADIO" name="ShowPage" Value = True checked>
						No<input TYPE="RADIO" name="ShowPagee" Value = False >
					<% Else %>
						Yes<input TYPE="RADIO" name="ShowPage" Value = True >
						No<input TYPE="RADIO" name="ShowPage" Value = False checked>
				<% End if%>
		</td>
	</tr>
<tr><td  align = "leftt" class = "body" valign = "top" colspan = "2">
<b>Text:</b>
</td></tr>
<tr><td  align = "left" valign = "top" class = "body" colspan = "2">
<% if mobiledevice = False  then %> 

<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
<script language="javascript1.2" type="text/javascript">
WYSIWYG.attach("PageText", mysettings);
mysettings.Width = "<%=screenwidth -50 %>"
mysettings.Height = "300px"
</script>
<% end if %>
<% if SmallMobile = False  then %>
<TEXTAREA NAME="PageText" ID="PageText" cols="60" rows="40" wrap="file"><%=PageText%></textarea>
<% else %>
<TEXTAREA NAME="PageText" ID="PageText" cols="60" rows="40" wrap="file"><%=PageText%></textarea>
<% end if %>
</td></tr>
<tr><td  valign = "middle" colspan = "2" align = "center">
<input type=submit value = "Submit Changes" Class = "regsubmit2 body" >
</td></tr></table></form>
<font class = "body"><b>Copy and Paste</b> - Copy and pasting does not work with some browsers; however, the hotkeys CTL + C (Copy) and CTL + V (Paste) will work.</font>
<br />
</td></tr></table>
</td></tr></table>
<br /><br />


<!--#Include virtual ="/Members/MembersFooter.asp"--> 
</Body>
</HTML>