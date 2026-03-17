<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
 </head>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if  %>

<% Current = "admin" %>
<!--#Include file="AdminHeader.asp"-->
<% Current = "Classes"
Current3 = "Edit Addresses"  %>
<!--#Include File ="ClassesHeader.asp"--> 
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 class ="roundedtopandbottom" width = "<%=screenwidth -30%>" >
<tr><td height = "560" valign = "top">
<% If not rs.State = adStateClosed Then
rs.close
End If   	

AddressID= Request.QueryString("AddressID") 
If Len(AddressID) < 2 then
AddressID= Request.Form("AddressID") 
End If 

dim AddressIDArray(5000) 
dim AddressTitleArray(5000) 
dim PeopleFirstNameArray(5000) 
dim PeopleLastNameArray(5000) 
sql2 = "select * from Address where not(addressID = 420) and not(addressID = 419) and not(addressID = 418) order by AddressTitle"
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
While Not rs2.eof  
AddressIDArray(acounter) = rs2("AddressID")
AddressTitleArray(acounter) = rs2("AddressTitle")
acounter = acounter +1
rs2.movenext
Wend 

If Len(AddressID) < 1 then
%>
<form  action="AdminClassesAddressEdit.asp" method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr><td >
&nbsp;
</td>
<td class = "body">
<br>Select an Address:
<select size="1" name="AddressID">
<option name = "AID0" value= "" selected></option>
<% count = 1
while count < acounter
response.write(count)
%>
<option name = "AID1" value="<%=AddressIDArray(count)%>">
<%=AddressTitleArray(count)%>
</option>
<% 	count = count + 1
wend %>
</select>
<input type=submit value = "Edit" class = "regsubmit2" >
</td>
</tr>
</table>
 </form>
<%
else

 If Len(AddressID) < 1 Then
 else 
Session("AddressID")  = AddressID
end if

sql = "select distinct * from address where AddressID = " & AddressID & " order by addresstitle"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then   
AddressID = rs("AddressID")
Addresstitle = rs("addresstitle")
AddressPhone = rs("AddressPhone")
AddressApt = rs("AddressApt")
AddressCity= rs("AddressCity")
AddressState = rs("AddressState")
AddressZip = rs("AddressZip")
AddressCountry = rs("AddressCountry")
AddressStreet = rs("AddressStreet")
Addresswebsite = rs("Addresswebsite")
AddressComments  = rs("AddressComments")
AddressImage=rs("AddressImage")
end if
rs.close
 
%>

<form  action="AdminClassesAddressEdit.asp" method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr><td >
&nbsp;
</td>
<td class = "body">
<br>Select Another Address:
<select size="1" name="AddressID">
<option name = "AID0" value= "" selected></option>
<% count = 1
while count < acounter
response.write(count)
%>
<option name = "AID1" value="<%=AddressIDArray(count)%>">
<%=AddressTitleArray(count)%>
</option>
<% 	count = count + 1
wend %>
</select>
<input type=submit value = "Edit" class = "regsubmit2" >
</td>
</tr>
</table>
 </form>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<form action= 'AdminClassesAddressEdithandleform.asp' method = "post">

<tr>
<td width = "190"  class = "body2" align = "right">
Title:
		</td>
		<td  class = "body">
			<input name="AddressTitle" size = "50" value = "<%=Addresstitle %>">
		</td>
	</tr>
<tr>
<td  class = "body2" align = "right">
			Street Address:
		</td>
		<td>
			<input name="AddressStreet" size = "50" value = "<%=AddressStreet %>">
		</td>
	</tr>
	<tr>
<td  class = "body2" align = "right">
			Address 2:
		</td>
		<td>
			<input name="AddressApt" size = "50" value = "<%=Addressapt %>">
		</td>
	</tr>
	<tr>
	<td  class = "body2" align = "right">
			City:
		</td>
		<td>
			<input name="AddressCity" size = "50" value = "<%=AddressCity %>">
		</td>
	</tr>
	<tr>
<td  class = "body2" align = "right">
			State:
		</td>
		<td>
			<input name="AddressState" size = "50" value = "<%=AddressState %>">
		</td>
	</tr>
	<tr>
<td  class = "body2" align = "right">
			Zip:
		</td>
		<td>
			<input name="AddressZip" size = "50" value = "<%=AddressZip %>">
		</td>
	</tr>
<tr>
<td  class = "body2" align = "right">
			Phone:
		</td>
		<td>
			<input name="AddressPhone" size = "50" value = "<%=AddressPhone %>" >
		</td>
	</tr>
<tr>
<td  class = "body2" align = "right">
Website:
</td>
<td>
<small>http://</small><input name="AddressWebsite" size = "30" value = "<%=AddressWebsite %>">
</td>
</tr>
<tr>
<td  class = "body2" align = "right" valign = "top">
Comments:
</td>
<td>
<TEXTAREA NAME="AddressComments" cols="38" rows="7"  ><%=AddressComments %></textarea>
</td>
	</tr>
	<tr>
</table>	
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth -450%>">
<tr><td  align = "center" valign = "middle" align ="center">
<input type="hidden" value = "<%= addressID%>" name = "AddressID" >
<center><input type=submit value = "Submit Changes"  class = "regsubmit2" ></center>
</form>
</td></tr></table><br /><br />


</td>
<td valign = "top" class = "body"><img src= "/images/px.gif" height = "15" width = "442" />
<br /><br /><br /><br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtopandbottom" align = "left">
<H2><div align = "left">Address Logo</div></H2>

<table border = "0"  cellpadding=0 cellspacing=0 width = "420" height = "200" align = "center" >
<tr><td width = "420" valign = "top" class = "body"><bfr><br /></br>
<% If Len(AddressImage) > 2 Then %>
<img src = "<%=AddressImage%>" width = "100">
<% Else %>

<b>No Image</b>
<% End If %>

<td>
</tr>
<tr>
<td class=  "body">
<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminClassesAddressLogoUpdatehandle.asp?AddressID=<%=AddressID%>" >
Upload Logo: <br>Images must be in JPG, JPEG, GIF, or PNG format<br />and under 500KB in size.
<input name="attach1" type="file" size=45 class = "regsubmit2">
<center><input  type=submit value="Upload" class = "regsubmit2" ></center>
</form>

<td>
</tr>
<% If Len(AddressImage) > 2 Then %>
<tr>
    <td class = "body">
<form action= 'AdminClassesAddressRemoveLogo.asp' method = "post">
<input type = "hidden" name="AddressID" value= "<%=AddressID%>" >
<input name="ReturnPage" Value ="AdminClassesAddressEdit.asp?AddressID=<%=AddressID%>" type="hidden">
<center><input type=submit class = "regsubmit2"  value="Remove Logo"></center>
</form>
</td>
</tr>

<% End If %>
</table>

</td></tr></table>
</td>
</tr>
</table>

<% End if %>
</td></tr></table>
<!--#Include file="adminFooter.asp"--> </Body>
</HTML>