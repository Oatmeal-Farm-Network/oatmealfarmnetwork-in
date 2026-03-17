<html>

<head>
<title>Select Cria to Show</title>
<link rel="stylesheet" type="text/css" href="style.css">

</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">



<!--#Include virtual="/Administration/Header.asp"--> 
<% 	

	Name=request.form("Name") 

			DBname= name
			str1 = name
			str2 = "'"
			If InStr(str1,str2) > 0 Then
				DBname= Replace(str1, "'", "''")
				DBName = trim(DBName)
			End If

	'response.write(Name)
		conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			Set rs = Server.CreateObject("ADODB.Recordset")
			sql = "select distinct Ancestors.*, Animals.* from Animals, Ancestors where animals.ID = Ancestors.ID  and (trim(DamName) = '"  & DBname & "'  or trim(sire) = '"  & DBname & "')"
			'response.write(sql)
			
			rs.Open sql, conn, 3, 3 
        If rs.eof Then
          Response.write(" This animal does Not have any progeny listed.")
		else
			
				
			Category = rs("Category")
			'response.write (Category)

			If Category = "Jr. Herdsire" Or Category = "Herdsire" Or Category = "Non-Breeder" Or Category = "External Stud" Or Category = "Unowned Animal" Then
                 Pronoun = "his"
				 Gender = "Male"
			Else
				Pronoun = "her"
				 Gender = "Female"
			End if
			rs.close
 %>

<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
	<tr>
		<td class = "body">
			<h2><%=name%>'s Progeny</h2>
			<img src = "images/underline.jpg"></H2>
			Below are all of <%=name%>'s progeny listed in the system. Select or unselect the ones that you would like to show up on <%=Pronoun%> detail page, then press the "Submit Changes" button on the bottom of this page.



<form action= 'ShowCriasHandleForm.asp' method = "post">
	

<%
			DBname= Name
			str1 = Name
			str2 = "'"
			If InStr(str1,str2) > 0 Then
				DBname= Replace(str1, "'", "''")
				DBName = trim(DBName)
			End If
			Set rsCria = Server.CreateObject("ADODB.Recordset")
			sqlCria = "select distinct Ancestors.ID, Animals.*, Photos.ListPageImage from Animals, Ancestors, Photos where animals.ID = Ancestors.ID and animals.ID = Photos.ID and  (trim(DamName) = '"  & DBname & "'  or trim(sire) = '"  & DBname & "')"
			'response.write(sqlCria)

			rsCria.Open sqlCria, conn, 3, 3 
		
			if not rsCria.eof then %>
			<table  border="1"   cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center">
				<tr>
					<td align = "center" class = "body" >
						Show 
					</td>
					<td align = "center" class = "body" >
						Name & Color
					</td>
					<td align = "center" class = "body" >
						Image
					</td>
				</tr>
				<%
				Counter = 1
				rowcount = 1
				while not rsCria.eof 
				CriaName 	= trim(rsCria("FullName"))
				CriaID 	= rsCria("Animals.ID")
				Color 	= rsCria("Color")

				%>
				<input type=hidden name = "ID(<%=rowcount%>)" value = "<%=CriaID%>">
				<input type=hidden name = "Gender(<%=rowcount%>)" value = "<%=Gender%>">
				<tr>
					<td class = "body" align = "center">
						<% If Gender = "Male" then%>
								<%							
								if rsCria("ShowWithSire") = True then %>
									<input TYPE="checkbox" name="ShowWithSire(<%=rowcount%>)"  checked>
								<% else %>
									<input TYPE="checkbox" name="ShowWithSire(<%=rowcount%>)"  >
								<%end if%>
						<% Else %>
								<%if rsCria("ShowWithDam") = True then %>
									<input TYPE="checkbox" name="ShowWithDam(<%=rowcount%>)" checked>
								<% else %>
									<input TYPE="checkbox" name="ShowWithDam(<%=rowcount%>)" >
								<%end if%>
						<% End if %>

					</td>
					<td class = "body" >
						<%=CriaName%><br>Color: <%=Color%><br>
						Gender: <%=Gender%>
					</td>
					<td class = "body" >
						<% If Len(rsCria("ListPageImage")) > 3 then %>
							<img src= "/uploads/Listpage/<%=rsCria("ListPageImage") %>" width = "50">
						<%else%>
							No Image
						<%End if%>
					</td>
				</tr>
			<%	rowcount = rowcount + 1
			counter = counter +1
			rsCria.movenext
			Wend
			
			TotalCount = rowcount %>
		<%end if
		rsCria.close
		set rsCria=nothing
		%>
		<tr>
			<td colspan = "3" align = "center">

			
					<input type=hidden name = "TotalCount" value = "<%=TotalCount %>">
					<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
<% 
End if


dim aID(40000)
dim aName(40000)

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select Animals.ID, Animals.FullName from Animals order by Fullname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		aID(acounter) = rs2("ID")
		aName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
	<tr>
		<td class = "body">
			<H2>Select a different Dam or Sire</H2>
			Select a different dam or sire who's cria you want to show...or not.
			<form action= 'ShowCrias.asp' method = "post">
			

			
				<input type = "hidden" name="PhotoType" value= "ListPage">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td>
					<b>Alpaca's Name</b><br>
					<select size="1" name="Name">
					<option name = "Name" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "Name" value="<%=aName(count)%>">
							<%=aName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<td>
					<br>
					<input type=submit value = "Edit" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>
</body>
</html>