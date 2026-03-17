
<!--#Include virtual="/HeaderLinksInclude.asp"-->
			&nbsp;<b>Farm Store</b><br>

		&nbsp;<a class = "menu"  href = "#Yarns" >Yarns</a><br>
		&nbsp;<a class = "menu" href = "#clothing" >Clothing</a> <br>
			&nbsp;<a class = "menu" href = "#other" >Other</a> <br>


<% conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
					"Data Source=" & server.mappath(databasepath) & ";" & _
					"User Id=;Password=;" 

			sql = "select * from sfCategories where not(catID=16) order by catName"

			
			'response.write(sql)
					Set rs = Server.CreateObject("ADODB.Recordset")
					 rs.Open sql, conn, 3, 3 
					While Not rs.eof	
						CategoryID = rs("CatID")
						CategoryName = rs("catName")%>
						&nbsp;&nbsp;<a href = "store.asp?catID=" & CategoryID class = "menu"><%=CategoryName%></a><br>
					<% rs.movenext
					wend
				rs.Close %>

<% sql = "select * from sfCategories where catID=16"

			
			'response.write(sql)
					Set rs = Server.CreateObject("ADODB.Recordset")
					 rs.Open sql, conn, 3, 3 
					if Not rs.eof then
						CategoryID = rs("CatID")
						CategoryName = rs("catName")%>
						&nbsp;&nbsp;<a href = "store.asp?catID=" & CategoryID class = "menu"><%=CategoryName%></a><br>
					<% 
					End if
				rs.Close %>

			</td>
			<td  valign = "top" width = "630" align = "left">

	