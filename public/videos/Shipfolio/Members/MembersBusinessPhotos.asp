<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalvariables.asp"--> 
<title><%=Sitenamelong %> Membersistration</title>
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<% Current2 = "Business"
Current3 = "Photos" %> 
<!--#Include file="MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If   	
%>
<!--#Include file="MembersBusinessTabsInclude.asp"-->
<table width = "<%=screenwidth %>" height = "300"  class = "roundedtopandbottom" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
<td class = "body" valign = "top" width = "600" align = "left">

<% 
Dim BFSIDArray(2000)
Dim BFSNameArray(2000)

BFSID= Request.QueryString("BFSID") 
		If Len(BFSID) > 0 Then
		else
			BFSID= Request.Form("BFSID") 
		End If 
Session("BFSID")= BFSID

sql2 = "select BFSID, BFSName from BusinessForSale  where peopleID = " & session("peopleid") & " order by BFSname"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 

 If Len(BFSID) = 0 Then 
	While Not rs2.eof  
		BFSIDArray(acounter) = rs2("BFSID")
		BFSNameArray(acounter) = rs2("BFSName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
recordcount = acounter	
rs2.close
set rs2=nothing
set conn = Nothing
%>
<h1>Upload Business Photos</h1>
<% if recordcount < 2 then %> 
You currently do not have any businesses listed.
<% else %>
<form action="MembersBusinessPhotos.asp" method = "post" name = "edit2">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
			   <tr>
				
				 <td class = "body">Businesses:
					<select size="1" name="BFSID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=BFSIDArray(count)%>">
							<%=BFSNameArray(count)%>
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
		  	
<% 
end if
Else %>
	
 <!-- #include file="MembersBusinessPhotoFormInclude.asp" -->
 <% End if %>
	</td>
			  </tr>
		    </table>
  <!-- #include virtual="/Footer.asp" -->
 </Body>
</HTML>
