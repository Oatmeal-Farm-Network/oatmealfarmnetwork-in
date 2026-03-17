<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="style.css">
  <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
    </head>
<body >

  
    <!--#Include File="AdminHeader.asp"--> 

    <% 
Current3="OustideAlpacaStuds"  %> 

 <!--#Include file="AdminAnimalsTabsInclude.asp"-->
<% 
Dim IDArray3(1000)
Dim alpacaName3(1000) 
		
ID= Request.Form("ID")
if len(ID) < 1 then
  ID = request.QueryString("AnimalID")
end if
'response.write("ID=")
'response.write(ID)
session("AnimalID") = ID

 If Len(ID) = 0 Or ID = "" Then 
  
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from ExternalStud order by Alpacaname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray3(acounter) = rs2("ExternalStudID")
		alpacaName3(acounter) = rs2("AlpacaName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "980"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Upload Photo of Other People's Studs</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "300" valign = "top">



<form action="AdminOutsidePhoto.asp" method = "post">
		<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center" >
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of the listed outside studs:
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray3(count)%>">
							<%=alpacaName3(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Edit"  class = "regsubmit2" >
				</td>
			  </tr>
		    </table>
		  </form>
		  <br /><br /><br />
<% Else %>
	
 <!-- #include file="AdminOutsidePhotoFormInclude.asp" -->
 <% End if %></td>
			  </tr>
		    </table>
		    </td>
			  </tr>
		    </table>
<br />
  <!-- #include file="AdminFooter.asp" -->
 </Body>
</HTML>
