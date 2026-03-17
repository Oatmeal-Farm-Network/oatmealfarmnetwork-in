<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalVariables.asp"-->
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" >
<% Current2="Packages"
   Current3="PackageAdLayout" %> 
<!--#Include file="MembersHeader.asp"-->
<br>
<!--#Include file="MembersPackagesTabsInclude.asp"-->

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Edit a  Package Layout</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />


<% 

Dim PackageID(2000)
Dim PackageName(2000) 

	sql2 = "select * from Package where PeopleID = " & session("PeopleID") & " order by Packagename"
	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		PackageID(acounter) = rs2("PackageID")
		PackageName(acounter) = rs2("PackageName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing


%>


 <table width = "720"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>

		
<td class = "body" valign = "top">

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
		<tr>
		<td Class = "body">
			<H2><div align = "left">Edit the Layout of Your Package Ads</H2>
			To edit select a package below and press the submit button.</div>
		</td>
	</tr>
<% If acounter > 1 Then %>
			<form  action="EditPackageLayout2.asp" method = "post" >
			    <tr>
		
				 <td class = "body">
					<br>Select one of your packages:
					<select size="1" name="PackageID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=PackageID(count)%>">
							<%=PackageName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
			<input type=submit value = "Edit" size = "110" class = "regsubmit2" >
				</td>
			  </tr>
<% Else %>
	<tr>
		<td class = "body"><br>
<font class = "body"><b>Currently you do not have any packages. To create a package please <a href= "packagesadd.asp" class = "body"><b>click here</b></a>.</font><br><br>
		</td>
	</tr>
<% End If %>
		    </table>
		  </form>
</td>
</tr>
</table>




<br><br></td>
</tr>
</table><br><br>
<!--#Include virtual="/Footer.asp"-->

 </Body>
</HTML>
