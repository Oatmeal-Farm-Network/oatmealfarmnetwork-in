 <%' Stud %>

<%
	 ServiceSireID = rs("ServiceSireID") 
	
		ExternalStudID = rs("ExternalStudID")
		if len(ServiceSireID) > 0 and not ServiceSireID = 0 then
			conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(Databasepath)  & ";" & _
						"User Id=;Password=;" '& _ 
			sqls = "select Animals.FullName, Animals.Color, Photos.ListPageImage from Animals, Photos where Animals.ID = Photos.ID and Photos.ID =" & ServiceSireID


			Set rss = Server.CreateObject("ADODB.Recordset")
			rss.Open sqls, conn, 3, 3 

			ServiceSireName = rss("FullName")
			ServiceSireColor = rss("Color")
			ServiceSireImage 	= "/uploads/ListPage/" + rss("ListPageImage")
			
		

			sireclick = rss("ListPageImage")   

			LinkType = "1"
				
			rss.close
			set rss=nothing
			set conns = nothing
		else if Len(ExternalStudID) > 0 and ExternalStudID > 0  then 
			conn6 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
			"Data Source=" & server.mappath("../db/alpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
			sql6 = "select * from ExternalStud where ExternalStudID =" & ExternalStudID
'response.write(sql6)
			Set rs6 = Server.CreateObject("ADODB.Recordset")
			rs6.Open sql6, conn, 3, 3 

			CurrentXStudID = rs6("ExternalStudID")
			ServiceSireName = rs6("alpacaName")
			CurrentXStudLink = rs6("ServiceSireLink")
			ServiceSireColor = rs6("ServiceSireColor")
			CurrentXStudImage =  rs6("ServiceSireImage")
			
			
			
			LinkType = "2"
			

			If Len(CurrentXStudLink)<3 Then
				LinkType = "0"
			End If
			
			if len(CurrentXStudLink) > 1 then
				sireclick = rs6("ServiceSireImage")
			else
				sireclick = rs6("ServiceSireImage")
			end if
			rs6.close
			set rs6=nothing
			set conn6 = nothing

			end if
		end if
		%>
		<td valign = "top">
			<table>
				<tr>
					<td align=center width = "280" valign = "top">                    
						<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 style="border-style: ridge; border-color: #7B9D7C ; border-right-width: 3; border-left-width: 2; border-top-width: 2; border-bottom-width: 3" >
							<tr>
								<td>
						<% If LinkType = "1" Then %>
							<a href = "Details.asp?ID=<%=ServiceSireID%> &DetailType=Sire&Detail.x=53&Detail.y=21" class = "body"><img src= "/uploads/ListPage/<%=sireclick%>" border = "0" width = "110" ></a><% else If LinkType = "0" Then %>
							<img src= "/uploads/ListPage/<%=sireclick%>" border = "0"  width = "110"><% Else %>
							<a href = "http://<%=CurrentXStudLink%>" target = "blank"><img src= "/uploads/ListPage/<%=sireclick%>" border = "0"  width = "110"></a><% End If %><% End If  %></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td align=center width = "280" valign = "top">                          
	                     <b> <%=ServiceSireName%></b><br>
                         <%=ServiceSireColor%><br><br>
                         <BR><%=hiddenInput%></font></b>
					</td>
				</tr>
			</table>
		</td>