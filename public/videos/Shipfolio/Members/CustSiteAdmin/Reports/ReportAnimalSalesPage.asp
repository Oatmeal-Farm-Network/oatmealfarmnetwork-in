<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ Language=VBScript %>

<HTML>
<HEAD>
 <title>Animal Sales Report</title>
       <link rel="stylesheet" type="text/css" href="/administration/reports/style.css">

</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >

<!--#Include file="ReportsHeader.asp"--> 

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
 <table width = "720" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		
<td class = "body" valign = "top">

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
	<tr>
		<td class = "body">
			<a name="Add"></a>
			<H1>Select an Animal</H1>			
		</td>
	</tr>
</table>
			<form  action="reportanimalsalespage2.asp" method = "post">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your alpacas:
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
<!--#Include file="Footer.asp"-->

 </Body>
</HTML>
