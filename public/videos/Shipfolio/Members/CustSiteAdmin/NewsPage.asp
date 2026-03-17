<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ Language=VBScript %>

<HTML>
<HEAD>
 <title>Edit Your Alpaca Listing</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">
		<!--#Include virtual="/Administration/PhotosIncludeHead.asp"--> 

</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  background = "images/background.jpg">


		<!--#Include virtual="/Administration/Header.asp"--> 
		<!--#Include virtual="/administration/adminDetailDBInclude.asp"--> 
		<!--#Include virtual="/Administration/Dimensions.asp"-->

<% 

    Dim PageName(40000)


conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	
	sql2 = "select * from Pagelayout where PageAvailable = True"	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
	
		PageName(acounter) = rs2("PageName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing


 If Len(ID) = 0 Then %>
 <table width = "680" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>

		
<td class = "body" valign = "top">

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
	<tr>
		<td class = "body">
			<a name="Add"></a>
			<H1>Edit a Page's Content</H1>			
		</td>
	</tr>
</table>
			<form  action="PageMantainance.asp" method = "post">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your pages:
					<select size="1" name="PageName">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=PageName(count)%>">
							<%=PageName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Edit"  size = "210" >
				</td>
			  </tr>
		    </table>
		  </form>
<br><br><br>
</td>
</tr>
</table>

<% else  %>
 <!--#Include virtual="/administration/EditPagecontentInclude.asp"--> 

<% End if %>
<!--#Include virtual="/administration/Footer.asp"-->

 </Body>
</HTML>
