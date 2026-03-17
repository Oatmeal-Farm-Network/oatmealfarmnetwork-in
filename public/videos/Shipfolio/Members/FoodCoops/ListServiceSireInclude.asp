
<%
'response.write("bred=true") 
if bred = true then 


if len(ServiceSireID) > 0 and (not ServiceSireID = 0) then
			
			sqls = "select Animals.FullName, Animals.*, colors.*, Photos.* from Animals, Photos, Colors where Animals.ID =  colors.ID and  Animals.ID = Photos.ID and animals.ID =" & ServiceSireID
			'response.write(sqls)
			Set rss = Server.CreateObject("ADODB.Recordset")
			rss.Open sqls, conn, 3, 3 

			ServiceSireName = rss("Animals.FullName")
			ServiceSireColor1 = rss("Color1")
			ServiceSireImage 	=  rss("Photo1")
			CurrentXStudARI = rss("Animals.ARI")
			If Len(ServiceSireImage) < 3 Then
				ServiceSireImage = "/uploads/ImageNotAvailable.jpg" 
			end If 

			rss.close
			set rss=nothing
			set conns = nothing
			sireclick =  "<a href ='StudDetails.asp?ID=" & ServiceSireID & "&DetailType=Sire' 	class = 'body'><img src=""" & ServiceSireImage & """ border=0  width=115></a>"
			sirenameclick = "<a href ='StudDetails.asp?ID=" & ServiceSireID & "&DetailType=Sire' 	class = 'body' >" & ServiceSireName & "</a>"



		else if Len(ExternalStudID) > 0 and (not ExternalStudID = 0) then 

			conn6 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
			"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			sql6 = "select * from ExternalStud where ExternalStudID =" & ExternalStudID
'response.write(sql6)
			Set rs6 = Server.CreateObject("ADODB.Recordset")
			rs6.Open sql6, conn6, 3, 3 

			CurrentXStudID = rs6("ExternalStudID")
			ServiceSireName = rs6("AlpacaName")
			ServiceSireColor = rs6("ServiceSireColor")
			CurrentXStudLink = rs6("ServiceSireLink")
			CurrentXStudARI = rs6("ServiceSireARI")
			CurrentXStudImage =  rs6("ServiceSireImage")

			rs6.close
			set rs6=nothing
			set conn6 = nothing
			
			If Len(CurrentXStudImage) < 3 Then
				CurrentXStudImage = "/uploads/ImageNotAvailable.jpg" 
			end If 



			
			if len(CurrentXStudLink) > 1 then
				sireclick = "<a href = ""http://"& CurrentXStudLink &""" border = 0 target = 'blank'><img src ="""& CurrentXStudImage &"""  width=""115"" border = 0 ></a>"
				sirenameclick = "<a href = ""http://"& CurrentXStudLink &""" border = 0 class = 'body' target = 'blank'>" & ServiceSireName & "</a>"

			else
				sireclick = "<img src ="""& CurrentXStudImage &""" width=""115"" border = 0 >"
				sirenameclick =  ServiceSireName 
			end if



			
			end if
		end if


%>

			<tr>
				<td class = "body" align = "right" >Service Sire:<img src = "images/px.gif" width = "3" alt = "Mowry Mountain Alpacas" /></td>
				<td  class = "body"><%=sirenameclick%></td>
			</tr>
			<% If DueDateMonth > 0 or len(DueDateYear) > 3 Then %>
			<tr>
				<td class = "body" align = "right">Due Date:<img src = "images/px.gif" width = "3" alt = "Mowry Mountain Alpacas" /></td>
				<td  class = "body"><%=DueDateMonth%> /<%=DueDateYear%>
			</tr>
			<% End If %>
								



<%end if%>
