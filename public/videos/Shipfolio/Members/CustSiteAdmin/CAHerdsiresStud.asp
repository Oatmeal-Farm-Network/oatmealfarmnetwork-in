 <%' Stud %>

<%
			StudID = 0
			ServiceSireID = 0
			ServiceSireName = ""
			ServiceSireColor = ""
			ServiceSireImage 	= ""


	sqlCria = "select Ancestors.ID, Animals.*, Photos.ListPageImage from Animals, Ancestors, Photos where animals.ID = Ancestors.ID and animals.ID = Photos.ID  and (trim(DamName) = '"  & DamName & "'  or trim(sire) = '"  & DamName & "')"
'response.write(sqlCria)

	Set rss = Server.CreateObject("ADODB.Recordset")
	rss.Open sqlCria, conn, 3, 3 

	CriaID = rss("Ancestors.ID")
	'response.write("DBname=")
	'response.write(DBname)
	rss.close
	set rss=Nothing
	
	sqls = "select Ancestors.* from Ancestors where ID =" & CriaID
	Set rss = Server.CreateObject("ADODB.Recordset")
	rss.Open sqls, conn, 3, 3 

	Sire = RSS("Sire")
	
LinkType = 0
	
	CurrentXStudLink = rss("SireLink")

		
	If Len(CurrentXStudLink)>3 And Not rss.eof Then
		
		LinkType = 2
		ServiceSireName = Sire
			ServiceSireColor = rss("SireColor")
		rss.close
		set rss=Nothing

		sqls = "select ExternalStud.* from ExternalStud where FullName ='" & Sire & "'"
		Set rss = Server.CreateObject("ADODB.Recordset")
		rss.Open sqls, conn, 3, 3 
		
	   If Not rss.eof then
		ServiceSireImage 	= "uploads/ListPage/" + rss("ServiceSireImage")
	  End if
	
	Else

		LinkType = 1
	
	
		
		sqls = "select Animals.*, Photos.ListPageImage from Animals, Photos where Animals.ID = Photos.ID and Animals.Fullname ='" & Sire & "'"
	
		
		Set rss = Server.CreateObject("ADODB.Recordset")
		rss.Open sqls, conn, 3, 3 

		If rss.eof Then
		 
			ServiceSireName = Sire
			CurrentXStudLink = ""
			LinkType = 0
			ServiceSireImage 	= "/uploads/ListPage/NotAvailableL.jpg"
			'response.write(ServiceSireImage)
		else
			StudID = rss("ID")
			ServiceSireID = rss("ID")
			ServiceSireName = rss("FullName")
			ServiceSireColor = rss("Color")
			ServiceSireImage 	= "/uploads/ListPage/" + rss("ListPageImage")

		End if
	End If
	

		%>
		<td valign = "top">
			<table>
				<tr>
					<td align=center width = "280" valign = "top"><table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 style="border-style: ridge; border-color: #7B9D7C ; border-right-width: 3; border-left-width: 2; border-top-width: 2; border-bottom-width: 3" ><tr><td><% If LinkType = 1 Then %><a href = "Details.asp?ID=<%=ServiceSireID%> &DetailType=Sire&Detail.x=53&Detail.y=21" class = "body"><img src= "<%=ServiceSireImage%>" border = "0" width = "110" ></a><% else If LinkType = 2 then%><a href = "http://<%=CurrentXStudLink%>" target = "blank"><img src= "<%=ServiceSireImage%>" border = "0"  width = "110"></a><% else  %><img src= "<%=ServiceSireImage%>" border = "0"  width = "110"><% End If  %><% End If  %></td></tr></table>		
					</td>
				</tr>
				<tr>
					<td align=center width = "280" valign = "top">                          
	                      <b><%=ServiceSireName%></b><br>
                         <%=ServiceSireColor%><br><br>
                         <BR><%=hiddenInput%></font></b>
					</td>
				</tr>
			</table>
		</td>