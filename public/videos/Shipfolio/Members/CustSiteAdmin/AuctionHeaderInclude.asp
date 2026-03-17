<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from AuctionHeader where FieldID = 1"


    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

Title = rs("FieldContent")

 sql = "select * from AuctionHeader where FieldID = 0"
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

Text = rs("FieldContent")
'response.write (text)

 sql = "select * from AuctionHeader where FieldID = 2"
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

Text2 = rs("FieldContent")
'response.write (text)

    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   


%>
<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0   align = "center"  valign = "top" >
	<tr>
		<td class = "body">
		<h2>Our Pricing Policy<br><img src = "images/Line.jpg" width = "200" height = "2"></h2>

			<%=Text2%>
			<br><br>
			<h2>...The Fine Print<br><img src = "images/Line.jpg" width = "200" height = "2"></h2>

			<%=Text%>
		</td>
	</tr>
</table>
