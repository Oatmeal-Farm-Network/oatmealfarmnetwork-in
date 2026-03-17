<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Reports Administration Home Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">


<!--#Include file="ReportsHeader.asp"--> 
 <table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  width = "700" bgcolor = "#eeeeee">
			<tr>
		<td align = "center"  colspan = "2"><img src = "images/ReportsHeader.jpg"></td>
	</tr>
		<tr>
		    <td class = "body" valign = "top" align = "left"><blockquote>
			<br><br>Below is the report(s) that are currently available:
			<br>
			<br>
			
			<a href = "ReportSaleList.asp" class = "body" target = "blank">Printable Complete Sales List</a><br>
			<br><br>
			
<% 
dim idarray(10000)
dim alpacaname(10000)
If Len(ID) > 0 then
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 

			 sql2 = "select * from Photos where ID = " &  ID & ";" 
			'response.write(sql2)
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3   
			 If rs2.eof Then

					Query =  "INSERT INTO Photos (ID)" 
					Query =  Query & " Values (" &  ID & ")"

					'response.write(Query)
					
					Set DataConnection = Server.CreateObject("ADODB.Connection")

					DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
					DataConnection.Execute(Query) 
		

		DataConnection.Close
		Set DataConnection = Nothing 
	End If 
End if

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	
	sql2 = "select Animals.ID, Animals.FullName from Animals  order by Fullname"
	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ID")
		alpacaName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>
 <table width = "400"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		
<td class = "body" valign = "top">

			<form  action="reportanimalsalespage2.asp" method = "post" target="_blank">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<b>Select an Animal below to create an individual sales page.</b>
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=alpacaName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Create Sales Page" style="background-image: url('images/background.jpg'); border-width:1px" size = "210" class = "Submit" >
				</td>
			  </tr>
		    </table>
		  </form>
<br><br><br>
</td>
</tr>
</table>
			
			
			
			
			</blockquote>

			
			</td>
			<td bgcolor = "#dedede" width = "250" height = "200" class = "body" valign = "top">
			
				<br><h2>Printing Suggestion</h2>You may need to make changes to your browsers page setup settings to perfect how your reports look up to you.<br><br>
				
				In Internet explorer go to Print>Page Setup to make changes to the page settings.
				</td>

		</tr>
	</table>
<br><br><br>
<br><br><br>

 <!--#Include file="Footer.asp"--> 
</BODY>
</HTML>