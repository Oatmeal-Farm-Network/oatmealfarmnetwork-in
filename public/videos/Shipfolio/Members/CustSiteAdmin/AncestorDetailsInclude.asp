<%If  Ancestorname = "Unknown" Then %>
	<%=Ancestorname%><br><%=AncestorColor%><br><%=AncestorARI%>

<% else if Ancestorname <> ""  Then
			DBAncestorname = Ancestorname
			str1 = Ancestorname
			str2 = "'"
			If InStr(str1,str2) > 0 Then
				DBAncestorname= Replace(str1, "'", "''")
				DBAncestorname = trim(DBAncestorname)
			End If
			Set rsAncestor = Server.CreateObject("ADODB.Recordset")
			sqlAncestor = "select ID, FullName from Animals where trim(FullName) = '"  & DBAncestorname & "'"
			rsAncestor.Open sqlAncestor, conn, 3, 3 

			if not rsAncestor.eof then %>
				<%
				Ancestorname 	= trim(rsAncestor("FullName"))
				AncestorID 	= rsAncestor("ID")%>


				<a href = "Details.asp?ID=<%=AncestorID%>&DetailType=<%=DetailType%>&Detail.x=53&Detail.y=21" class = "Details"><%=Ancestorname %></a><br>
					<%=AncestorColor%><br>
						
					

		<%
			else if len(Ancestorname) > 1   then%>
					<% if AncestorLink = "NoLink.asp" then%>
						<%=Ancestorname%><br><%=AncestorColor%><br><%=AncestorARI%>
					<%Else If  Len(AncestorLink) > 5 then%>
							<a class = "Details" target = "_blank" href = "http://<%=AncestorLink%>" ><%=Ancestorname%></a><br><%=AncestorColor%><br><%=AncestorARI%>
								<% Else %>
										<%=Ancestorname%><br><%=AncestorColor%>

					   <%end if%>
				    	<%end if%>
			<%
		  end if
		end if
		rsAncestor.close
		set rsAncestor=nothing
		end if
end if%>
