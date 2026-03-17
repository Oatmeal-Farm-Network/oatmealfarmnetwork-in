<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="AdminGlobalVariables.asp"--> 
<% PagelayoutID =Request.Querystring("PagelayoutID" ) 
If Len(PagelayoutID) = 0 then
	PagelayoutID=Request.Form("PagelayoutID") 
End If

if len(Pagename) > 0 then
else
 Pagename = request.QueryString("Pagename")
End if
if len(Pagename) > 0 then
else
 'Pagename = session("PageName")
end if
 %>	
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&PagelayoutID=' + PagelayoutID);">
<% end if %>

<% Current3 = "PageContent" %>
<!--#Include File="AdminHeader.asp"--><br /> 
<% if mobiledevice = False  then %>

<% if PageName = "Farm Store" then 
Current3 = "Header" %>
<!--#Include file="AdminProductsTabsInclude.asp"-->
<% end if %>
<% end if %>
<% peopleID = session("PeopleID")

Pagelayoutid = request.querystring("Pagelayoutid")
if len(Pagelayoutid) < 2 then
else
PageName = request.querystring("PageName")
end if


if len(PagelayoutID) > 0 then
 sql = "select * from Pagelayout where PagelayoutID = " & PagelayoutID & "" 
else
 sql = "select * from Pagelayout where PageName = '" & PageName & "'"
end if
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
PagelayoutID= rs("PagelayoutID")   
PageGroupID = rs("PageGroupID")
PageName = rs("PageName")
session("PageName") = PageName
PageTitle = rs("PageTitle")
CurrentLinkName= rs("LinkName")
PagetextA = rs("Pagetext")
ShowPage = rs("ShowPage")
TopImage= rs("TopImage")
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
rs.close


dim ImageOrientation(100)	
dim PageText(100)
dim Image(100)
dim ImageCaption(100)
dim PageLayout2ID(100)
 sql = "select * from Pagelayout2 where PagelayoutID = " & PagelayoutID & ""	
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
i = 0
while not rs.eof
TotalTextBlocks = rs.recordcount
i = i + 1
PageText(i) = rs("PageText")
Image(i)= rs("Image")
ImageCaption(i)= rs("ImageCaption")
PageLayout2ID(i)=rs("PageLayout2ID")
ImageOrientation(i)=rs("ImageOrientation")
if ImageCaption(i) = "0" then
   ImageCaption(i) = ""
end if
if ((len(PageText(i) ) > 0 or len(Image(i)) > 0) and i = TotalTextBlocks)  then


Query =  "INSERT INTO PageLayout2 ( PageLayoutID,  BlockNum)" 
Query =  Query & " Values (" &  PageLayoutID & " ,"
Query =  Query &  " " & i + 1  & ")" 

response.Write("Query=" & Query )
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
Conn.Execute(Query) 
Conn.Close
Set Conn = Nothing 
response.Redirect("AdminPageData.asp?PageLayoutID=" & PagelayoutID & "#Textblock" & i)

end if


str1 =  ImageCaption(i)
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption(i)= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption(i)
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption(i)= Replace(str1,  str2, "'")
End If 


str1 = PageText(i)
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText(i)= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText(i)
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText(i)= Replace(str1,  str2, " ")
End If 

str1 = PageText(i)
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText(i)= Replace(str1,  str2, "'")
End If 

str1 = PageText(i)
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText(i)= Replace(str1, str2 , vbCrLf)
End If  

rs.movenext
wend

if len(PageGroupID)> 0 then
sqlg = "select * from PageGroups where pagegroupavailable = true and PageGroupID = " & PageGroupID
Set rsg = Server.CreateObject("ADODB.Recordset")
rsg.Open sqlg, conn, 3, 3 
if not rsg.eof then
PageGroupTitle = rsg("PageGroupTitle")
end if
rsg.close 
end if 


if TotalTextBlocks < 6 then


Query =  "INSERT INTO PageLayout2 ( PageLayoutID,  BlockNum)" 
Query =  Query & " Values (" &  PageLayoutID & " ,"
Query =  Query &  " " & i + 1  & ")" 

Conn.Execute(Query) 
Conn.Close
Set Conn = Nothing 
response.Redirect("AdminPageData.asp?PageLayoutID=" & PagelayoutID & "#Textblock" & i)

end if
%>

   <% if mobiledevice = False  then %>
<% if screenwidth < 989 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth  %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>">
<% end if %>
<tr><td class = "roundedtop" align = "left">
		<H1><div align = "left"><%=PageName %> Page Content</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "100%">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth  %>" >
<tr><td align = "left">
<H1><div align = "left"><%=PageName %> Page Content</div></H1>
</td></tr>
<tr><td  align = "center" width = "100%">

<% end if %>  



<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" >
       <tr><td class = "roundedtop" align = "left">
<H1><div align = "left">Basic Facts</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" >

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center" >
<tr><td valign = "top">
<% str1 = PageTitle
str2 = "'"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "&#39")
End If 
 %>
<a name = "Top"></a>
<form action= 'AdminLinkPageHandleForm.asp' method = "post">
<input name="CatID" type= "hidden" value = "<%=TempCatID %>">
<input name="PageLayoutID" type= "hidden" value = "<%=PageLayoutID %>">
<input name="Returnpage" type= "hidden" value = "AdminUploadPDFPage.asp?pagelayoutID=<%=PageLayoutID %>">
<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="5" marginheight="0"  cellpadding=5 cellspacing=0 width = "100%" align = "left">
</td>
</tr>
<tr><td  align = "right" class = "body">
<div align = "right"><b>Page Heading:</b></div>
</td>
<td  align = "left" class = "body">
<input name="PageTitle" value= '<%=PageTitle%>' size = "60">
</td>
</tr>
<tr>
<td class = "body2" align = "right" valign = "top">
<b>Page Text</b>:<br /> (appears at the top of the page)
</td>
<td class = "body">
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
<script language="javascript1.2" type="text/javascript">
    // attach the editor to the textarea with the identifier 'textarea1'.
    WYSIWYG.attach("PageText", mysettings);
    mysettings.Width = "450px"
    mysettings.Height = "200px"
</script>
<textarea name="PageText"  ID="PageText" cols="60" rows="20"   class = "body"  ><%= PagetextA %></textarea>
</td></tr>
<tr>
<td  colspan = "2" align = "center" valign = "middle" class = "body2" >
<input type=submit value = "Update" class = "regsubmit2" >
<br>
	</td>
</tr>
</table>
</form>

	</td>
</tr>
</table>
</td></tr></table>
<br />










</td>
<td width = "50%">
<%

if servicesavailable = true then
dim ServicesIDArray(999999) 
dim ServicesNameArray(999999)
ListCounter = 0
sql = "select * from Services,  PageLayout where Services.PageLayoutId = PageLayout.PageLayoutId" 
rs.Open sql, conn, 3, 3 
while Not rs.eof 
ListCounter = ListCounter + 1
ServicesIDArray(ListCounter) = rs("Services.PagelayoutID")
ServicesNameArray(ListCounter) = rs("PageName")
rs.movenext
wend
rs.close
TotalListCounter = ListCounter
%>
<form name="myform" method="post" action= 'AdminServicesEdit2.asp?PageLayoutID=<%=PagelayoutID %>&UpdateUpselling=True' >
<table border = "0" width = "100%" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
	<tr><td class = "roundedtop" align = "right" >
		<H2><div align = "left">Upselling</div></H2>
</td></tr>
<tr><td class = "roundedBottom body" align = "center" height = "100" width = "100%" valign = "top">
The following show up as links on the bottom of your <%=pagename %> page encouraging users to check out these other services: <br />
  <table align = "center" width = "400">
  <tr>
  <td class = "body2" align = 'right'>
  Service:
  </td>
   <td width = "300">
<% if len(UpsellPageID1) > 0 then
sqlt = "select ServiceTitle from Services where PageLayoutID=" & UpsellPageID1
rst.Open sqlt, conn, 3, 3 
if Not rst.eof then
  ServiceTitle1 = rst("ServiceTitle")
end if 
rst.close 
end if
%>
<select size="1" name="UpsellPageID1">
<% if len(UpsellPageID1) > 0  then 
 if not UpsellPageID1 = 0 then  %>
<option  value="<%=UpsellPageID1 %>"><%=ServiceTitle1%></option>
<% end if 
 end if %>	
<option value="0">--</option>
<% for ListCounter = 1 to TotalListCounter
if ServicesIDArray(ListCounter) = UpsellPageID1 then
else %>
<option  value="<%=ServicesIDArray(ListCounter) %>"><%=ServicesNameArray(ListCounter) %></option>
<%
end if
next %>
</select>
 </td>
</tr>
<tr>
  <td class = "body2" align = 'right'>
  Service:
  </td>
   <td>
  <% if len(UpsellPageID2) > 0 then
  sqlt = "select ServiceTitle from Services where PageLayoutID=" & UpsellPageID2
rst.Open sqlt, conn, 3, 3 
if Not rst.eof then
  ServiceTitle2 = rst("ServiceTitle")
end if 
rst.close 
end if
%>
   
<select size="1" name="UpsellPageID2">
<% if len(UpsellPageID2) > 0  then 
 if not UpsellPageID2 = 0 then  %>
<option  value="<%=UpsellPageID2 %>"><%=ServiceTitle2%></option>
<% end if 
 end if %>	
<option value="0">--</option>
<% for ListCounter = 1 to TotalListCounter
if ServicesIDArray(ListCounter) = UpsellPageID2 then
else %>
<option  value="<%=ServicesIDArray(ListCounter) %>"><%=ServicesNameArray(ListCounter) %></option>
<%
end if
next %>
</select>
 </td>
</tr>
<tr>
 <td class = "body2" align = 'right'>
  Service:
  </td>
   <td>
  <% if len(UpsellPageID3) > 0 then
  sqlt = "select ServiceTitle from Services where PageLayoutID=" & UpsellPageID3
rst.Open sqlt, conn, 3, 3 
if Not rst.eof then
  ServiceTitle3 = rst("ServiceTitle")
end if 
rst.close 
end if
%>
   
<select size="1" name="UpsellPageID3">
<% if len(UpsellPageID3) > 0  then 
 if not UpsellPageID3 = 0 then  %>
<option  value="<%=UpsellPageID3 %>"><%=ServiceTitle3%></option>
<% end if 
 end if %>	
<option value="0">--</option>
<% for ListCounter = 1 to TotalListCounter
if ServicesIDArray(ListCounter) = UpsellPageID1 then
else %>
<option  value="<%=ServicesIDArray(ListCounter) %>"><%=ServicesNameArray(ListCounter) %></option>
<%
end if
next %>
</select>
 </td>
</tr>
<tr>
<td class = "body2" align = 'right'>
  Service:
  </td>
   <td>
  <% if len(UpsellPageID4) > 0 then
  sqlt = "select ServiceTitle from Services where PageLayoutID=" & UpsellPageID4
rst.Open sqlt, conn, 3, 3 
if Not rst.eof then
  ServiceTitle4 = rst("ServiceTitle")
end if 
rst.close 
end if
%>
   
<select size="1" name="UpsellPageID4">
<% if len(UpsellPageID4) > 0  then 
 if not UpsellPageID4 = 0 then  %>
<option  value="<%=UpsellPageID4 %>"><%=ServiceTitle4%></option>
<% end if 
 end if %>	
<option value="0">--</option>
<% for ListCounter = 1 to TotalListCounter
if ServicesIDArray(ListCounter) = UpsellPageID4 then
else %>
<option  value="<%=ServicesIDArray(ListCounter) %>"><%=ServicesNameArray(ListCounter) %></option>
<%
end if
next %>
</select>
 </td>
</tr>
<tr>
<td align = "center" colspan = "2">
	<input type=submit value = "Update" class = "regsubmit2" ></form>
</td></tr>
</table>


 </td>
</tr>
</table>
<% end if %>

</td>
</tr>
</table>
<br />

<%

for x = 1 to 1
  textblocknum = x
  TempPageText =  PageText(x)
  TempTB = "TB" & x
  TempImageOrientation = ImageOrientation(x)
  tempImageCaption  = ImageCaption(x)
  tempImage = Image(x)
  tempPageLayout2ID = PageLayout2ID(x)
  TempTextBlock = "TextBlock" & x
  ReturnPage="AdminUploadPDFPage.asp?pagelayoutID=" & PageLayoutID & "#Textblock" & x
  
  notextblock = True
   %>
      <a name= <%=TempTextBlock %> ></a>

<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
<h2>Downloadable Files</h2></td></tr>
<tr><td class = "body roundedBottom" align = "left" >
<br />
</h3>Upload forms and documents</h3> (PDF, Word, or Excel only. Max size 500KB) <br>
 <form name="frmSend" method="POST" enctype="multipart/form-data" action="UploadaDownload.asp?PageLayout2ID=<%=TempPageLayout2ID%>&filename2=<%=returnpage%>" >
<input name="attach1" type="file" size=35 class = "regsubmit2">
<input  type=submit value="Upload" class = "regsubmit2">
</form>
<%  sqld = "select * from PageLayoutDownloads where PageLayout2ID = " & tempPageLayout2ID & " order by DownloadOrder"
Set rsd = Server.CreateObject("ADODB.Recordset")
rsd.Open sqld, conn, 3, 3  
if not rsd.eof then %>
<table border = "0">
<tr>
<td width = "400" class = "body" align = "center">
<b>File Name</b>
</td>
<td width = "400" class = "body" align = "center">
<center><b>Link Title</b></center>
</td>
<td width = "35" class = "body" align = "center">
<center><b>Order</b></center>
</td>
<td width = "85" class = "body" align = "left">
</td>
</tr>
<form   action="AdminUploadLinkTitleUpdate.asp?PageDownloadsID=<%= PageDownloadsID%>&filename=<%=returnpage%>" method="POST" >
 <% 
 count = 0
 while not rsd.eof 
 count = count+1
DownloadFile=rsd("DownloadFile")
 DownloadOrder=rsd("DownloadOrder")
 DownloadTitle=rsd("DownloadTitle")
 PageDownloadsID=rsd("PageDownloadsID")
 %>
<tr><td  class = "body" align = "left" valign = "top">
<% if len(DownloadFile)> 1 then %>
<b><%=right(DownloadFile, len(DownloadFile) - 9)%></b><br>
<% end if %>
</td>
<td class = "body" align = "left" valign = "top">
<input name="DownloadTitle(<%=count %>)" type="text" size=65 value = "<%= DownloadTitle%>">
<input type = "hidden" name="filename(<%=count %>)" value= "<%=filename%>" >
</td>
<td>
<select size="1" name="DownloadOrder(<%=count %>)">
	<option value="<%=DownloadOrder%>" selected><%=DownloadOrder%></option>
	<% ordercounter = 1
	 while ordercounter < (rsd.recordcount + 1) %>									
	   		<option  value="<%=ordercounter%>"><%=ordercounter%></option>
		<% ordercounter = ordercounter + 1
		wend %>
    </select>
									
</td>
<td class = "body" align = "left" >
<input type = "hidden" name="PageDownloadsID(<%=count %>)" value= "<%=PageDownloadsID %>" >
<% if len(DownloadFile)> 1 then %>
<a href= 'RemoveUpload.asp?PageDownloadsID=<%=PageDownloadsID %>&filename=<%=returnpage%>' class = "body"><b>Remove File</b></a>
<% end if %>
</td></tr>

<%
   rsd.movenext
   wend %>
   <tr>
   <td colspan = "4" align = "center"><input type = "hidden" name="totalcount" value= "<%=count%>" >
   				<input  type=submit value="Submit" class = "regsubmit2">
   </td>
   </tr>
   </table>
   					</form>		

 <% end if 
 rsd.close
 %>
	

<br />


<% next %>
			</td>
				</tr>
	 </table>	
</td>
</tr>
</table>
<div align = "center"><a href = "#Top" class ="body">Click here to go to the top of the page.</a></center>

 <br><br />
<!--#include File="AdminFooter.asp" -->
 </Body>
</HTML>
