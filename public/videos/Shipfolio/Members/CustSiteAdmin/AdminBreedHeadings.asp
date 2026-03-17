<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Language" content="en-us">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"--> 

</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&SpeciesID =' + SpeciesID );">
<% end if %>

<%dim BreedLookupID(999)
Dim BreedForSaleTitle(999)
Dim BreedForSaleDescription(999)
Dim Breed(999)

update = request.form("update")
if update= "True" then
ID=Request.Form("ID") 
totalbreeds = request.form("totalbreeds")
totalbreeds = CInt(totalbreeds)
rowcount = 0
while (rowcount < totalbreeds )
rowcount = rowcount +1
BreedLookupIDcount = "BreedLookupID(" & rowcount & ")"
BreedLookupID(rowcount)=Request.Form(BreedLookupIDcount )
BreedForSaleTitlecount = "BreedForSaleTitle(" & rowcount & ")"
BreedForSaleTitle(rowcount)=Request.Form(BreedForSaleTitlecount )
BreedForSaleDescriptioncount = "BreedForSaleDescription(" & rowcount & ")"
BreedForSaleDescription(rowcount)=Request.Form(BreedForSaleDescriptioncount )
Breedcount = "Breed(" & rowcount & ")"
Breed(rowcount)=Request.Form(Breedcount)
Wend
rowcount = 0

while (rowcount < totalbreeds )
 rowcount= rowcount +1
str1 = BreedForSaleDescription(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
BreedForSaleDescription(rowcount)= Replace(str1, "'", "''")
End If

str1 = BreedForSaleTitle(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
BreedForSaleTitle(rowcount)= Replace(str1, "'", "''")
End If
Query =  " UPDATE SpeciesBreedlookupTable Set BreedForSaleDescription = '" &  BreedForSaleDescription(rowcount) & "', " 
Query =  Query & " BreedForSaleTitle = '" &  BreedForSaleTitle(rowcount) & "' " 
Query =  Query & " where BreedLookupID = " & BreedLookupID(rowcount) & ";" 
Conn.Execute(Query) 
wend
end if
update= "False"

SpeciesID=Request.Querystring("speciesID") 
Current3 = "PageContent"  %>
<!--#Include file="AdminHeader.asp"--> 
<!--#Include file="AdminAnimalsTabsInclude.asp"-->
<a name="Top"></a>
<% if mobiledevice = False  then %>
<% if screenwidth < 1000  then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth %>">
<% end if %>
<tr><td class = "roundedtop" align = "left">
<H1><div ><%=SpeciesPlural%> for Sale Pages Headings</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "100%">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td align = "left">
<H1><div><%=SpeciesPlural%> for Sale Pages Headings</div></H1>
</td></tr>
<tr><td  align = "center" width = "100%">
<% end if %>




<br />
<form action= 'AdminBreedheadings.asp?SpeciesID=<%=SpeciesID %>' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
<% if mobiledevice = False  then %>
<tr><td Class = "body">This is the text that shows up on the top of the <%=SpeciesPlural%> for sale pages.<br /><br /></td></tr><% end if %>
</table>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
<tr><td valign = "top">
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
<% Set rs = Server.CreateObject("ADODB.Recordset")

sql = "select * from SpeciesBreedLookupTable where speciesid = " & SpeciesID & " and BreedAvailableOnWebsite = True order by Breed Desc"
rs.Open sql, Conn, 3, 3 
i = 0
while not rs.eof
i = i + 1
BreedLookupID(i) = rs("BreedLookupID")
BreedForSaleTitle(i) = rs("BreedForSaleTitle")
BreedForSaleDescription(i) = rs("BreedForSaleDescription")
Breed(i) = rs("Breed")
rs.movenext
wend
rs.close

totalbreeds = i

i = 0
while i < totalbreeds
i = i + 1 %>
<tr><td class = "body" valign = "top"><br>
<input type = "hidden" name="BreedLookupID(<%=i%>)" value= "<%=BreedLookupID(i)%>" >
<div ><b><%=Breed(i)%> Page Heading:</b></div>
</td>
</tr>
<tr>
<td class = "body">
<input name="BreedForSaleTitle(<%=i%>)" value= "<%=BreedForSaleTitle(i)%>" size = "30">
<tr><td class = "body" valign = "top">
<div><b><%=Breed(i)%> Heading Page Text:</b></div>
</td>
</tr>
<tr>
<td class = "body">
<script language="javascript1.2" type="text/javascript">
WYSIWYG.attach("BreedForSaleDescription<%=i%>", mysettings);
mysettings.Width = "<%=screenwidth -50 %>"
mysettings.Height = "300px"
</script>
<TEXTAREA NAME="BreedForSaleDescription(<%=i%>)" ID="BreedForSaleDescription<%=i%>" cols="60" rows="40" wrap="file"><%=BreedForSaleDescription(i)%></textarea>
<font class = "body"><b>Copy and Paste</b> - Copy and pasting does not work with some browsers; however, the hotkeys CTL + C (Copy) and CTL + V (Paste) will work.</font>
</td>
</tr>

<% wend %>
<tr>
<br />	
<td class = "body" align = "right">
<input type = "hidden" name="ID" value= "<%= ID%>" >
<input type = "hidden" name="totalbreeds" value= "<%= totalbreeds%>" >
<input type = "hidden" name="update" value= "True" >
<div align = "center">
<input type="submit" class = "regsubmit2" value="Submit Changes"  ></div>
</td>
</tr>
</table></form>
</table>
</td></tr></table>
<br /><br />
<br><br>
<!--#Include file="AdminFooter.asp"--> 
</Body>
</HTML>