<% if len(DueDate) > 1 then 

if len(ServiceSireID) > 0 and (not ServiceSireID = 0) then
			
			sqls = "select Animals.FullName, Animals.Color, Photos.ListPageImage from Animals, Photos where Animals.ID = Photos.ID and Photos.ID =" & ServiceSireID
'response.write(sqls)
			Set rss = Server.CreateObject("ADODB.Recordset")
			rss.Open sqls, conn, 3, 3 

			ServiceSireName = rss("FullName")
			ServiceSireColor = rss("Color")
			ServiceSireImage 	= "/uploads/ListPage/" & rss("ListPageImage")
			If Len( ServiceSireImage) < 21 Then
				ServiceSireImage = "/uploads/ListPage/NotAvailableL.jpg" 
			end If 

			rss.close
			set rss=nothing
			set conns = nothing
			sireclick = "<a href ='Details.asp?ID=" & ServiceSireID & "&DetailType=Sire&Detail.x=53&Detail.y=21' 	class = 'body'><img src='" & ServiceSireImage & "'border=0  width=115></a>"



		else if Len(ExternalStudID) > 0 and (not ExternalStudID = 0) then 
			conn6 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
			"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			sql6 = "select * from ExternalStud where ExternalStudID =" & ExternalStudID

			Set rs6 = Server.CreateObject("ADODB.Recordset")
			rs6.Open sql6, conn6, 3, 3 

			CurrentXStudID = rs6("ExternalStudID")
			ServiceSireName = rs6("AlpacaName")
			ServiceSireColor = rs6("ServiceSireColor")
			CurrentXStudLink = rs6("ServiceSireLink")
			CurrentXStudImage = "/uploads/ListPage/" + rs6("ServiceSireImage")

			rs6.close
			set rs6=nothing
			set conn6 = nothing
			
			if len(CurrentXStudLink) > 1 then
				sireclick = "<a href = ""http://"& CurrentXStudLink &""" border = 0><img src ="""& CurrentXStudImage &"""  width=""115"" border = 0 ></a>"
			else
				sireclick = "<img src ="""& CurrentXStudImage &""" width=""115"" border = 0 >"
			end if



			
			end if
		end if


%>
<table border="0" cellspacing="2" align = "center" >
	
				<tr>
					<td align="center" valign = "top" class = "details">
					
					<% if not (gender = "male") then %>
						<div align = "left"><big><b>Service Sire</b></big><br><img src = "images/Line.jpg" alt="Alpacas at Lone Ranch Line" width = "230" height = "2"></div>


				
						<table valign="top">
							<tr>
								<td><table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 style="border-style: ridge; border-color: #7B9D7C ; border-right-width: 3; border-left-width: 2; border-top-width: 2; border-bottom-width: 3" ><tr><td><%= sireclick%></td></tr></table>
								</td>
								<td  valign="top"  class = "details">
									<%=ServiceSireName%><br>
								
								Color: <%=ServiceSireColor%><br>
								Due: <%=DueDate%><br>
							</td>
						</tr>
						
					</table>
					</td>
				</tr>
</table>

<%end if%>
<%end if%>
