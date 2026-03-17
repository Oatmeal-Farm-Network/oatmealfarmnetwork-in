	<% 	rowcount2 = 1

			if rs(PackageIDName) = 0  then
				tempPackageName = "none"
				tempPackageID =0
			else
			  'response.write(rs(PackageIDName))
				sql2 = "select * from Package where PackageID = " & tempPackageID
				Set rs2 = Server.CreateObject("ADODB.Recordset")
				'response.write(sql2)
				rs2.Open sql2, conn, 3, 3   
				if not rs2.eof then
					tempPackageName = rs2("PackageName")
					tempPackageID =rs("PackageID")
				else
					tempPackageName = "none"
					tempPackageID =0
				end if
			end if

			sql2 = "select * from Package order by PackageName"
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3   
			
			rowcount2 =0
			While  Not rs2.eof         
				PackageID(rowcount2) =   rs2("PackageID")
				PackageName(rowcount2) =   rs2("PackageName")
				rowcount2 = rowcount2 + 1
				rs2.movenext
			Wend
			TotalCount2=rowcount2 
			%>

			