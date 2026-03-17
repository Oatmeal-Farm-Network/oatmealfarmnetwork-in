<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalvariables.asp"--> 
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<% Current2="Properties" 
Current3 = "Photos" %> 
<!--#Include file="MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If   	
%>
<!--#Include file="MembersPropertiesTabsInclude.asp"-->
<table width = "<%=screenwidth %>" height = "300"  class = "roundedtopandbottom" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
<td class = "body" valign = "top" width = "600" align = "left">

<% 
Dim PropIDArray(2000)
Dim PropNameArray(2000)

PropID= Request.QueryString("PropID") 
		If Len(PropID) > 0 Then
		else
			PropID= Request.Form("PropID") 
		End If 
Session("PropID")= PropID

sql2 = "select PropID, propName from Properties  where peopleID = " & session("peopleid") & " order by Propname"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 

If Len(PropID) = 0 Then 
While Not rs2.eof  
PropIDArray(acounter) = rs2("PropID")
PropNameArray(acounter) = rs2("propName")
acounter = acounter +1
rs2.movenext
Wend		
recordcount = acounter
rs2.close
set rs2=nothing
set conn = Nothing
%>
<h1>Upload Property Photos</h1>
<form action="PropertyPhotos.asp" method = "post" name = "edit2">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
			   <tr>
				
				 <td class = "body">Properties:
					<select size="1" name="PropID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=propIDArray(count)%>">
							<%=PropNameArray(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<div valign = "bottom" align = "center">	
			<a href="javascript:document.edit2.submit()" 
onmouseover="document.edit2.sub_but.src='images/Editon.jpg'" 
onmouseout="document.edit2.sub_but.src='images/Editoff.jpg'" 
onclick="return val_form_this_page()"><img src="images/Editoff.jpg" 
border="0" alt="Submit this form" 
name="sub_but" /></a></div>
				</td>
			  </tr>
		    </table>
		  </form>
		  	
<% Else %>
	
 <!-- #include file="PropertiesPhotoFormInclude.asp" -->
 <% End if %>
	</td>
			  </tr>
		    </table>
  <!-- #include virtual="/Footer.asp" -->
 </Body>
</HTML>
