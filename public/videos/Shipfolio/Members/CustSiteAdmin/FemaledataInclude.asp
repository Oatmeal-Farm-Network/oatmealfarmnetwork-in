<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			<H2>Breeding Record<br>
			<img src = "images/underline.jpg"></H2>
			To make changes to your data, make your changes in the table below then select the "Submit Changes" button at the bottom of the page.<br><br>
		</td>
	</tr>
</table>



<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "SELECT * FROM Animals, FemaleData, Ancestors where (Animals.Category = 'Dam' or Animals.Category = 'Maiden') and Animals.ID=Ancestors.ID And FemaleData.ID=Animals.ID ORDER BY  Animals.FullName"


'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim TempID(200)
	dim TemprpID(200)
	dim TempFullName(200)
	dim TempBred(200)
	dim TempBredTo(200)
	dim TempServiceSireID(200)
	dim TempRecentProgenyID(200)
	dim TempDueDate(200)
	dim TempSSName(200)
	dim TempSSID(200)
	dim TempExternalStudID(200)
	dim TempSSXName(200)
	dim TempSSXID(200)
	dim TemprpName(200)
	dim TempShowRecentCria(200)
	dim TempShowCurrentStud(200)
	dim TempCriaLink(200)

Recordcount = rs.RecordCount +1
%>

<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "700">
	<tr>
		<th width = "100" class = "body"><b>Alpaca's Name</b></th>
		<th width = "120" class = "body"><b>Bred</b></th>
		<th class = "body"><b>Other Studs</b></th>
		<th class = "body"><b>External Stud</b></th>
		<th class = "body"><b>Due Date</b></th>


	</tr>

	
<%
	conn2 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
	sql2 = "select Animals.ID, Animals.FullName from Animals where Category = 'Herdsire' or Category = 'Jr. Herdsire' or Category = 'External Stud' order by Animals.FullName"

	studcounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn2, 3, 3 
	
	While Not rs2.eof  
		TempSSID(studcounter) = rs2("ID")
		TempSSName(studcounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		studcounter = studcounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn2 = nothing

	conn4 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
	sql4 = "select ExternalStudID, AlpacaName from ExternalStud order by AlpacaName"

	Set rs4 = Server.CreateObject("ADODB.Recordset")
	rs4.Open sql4, conn4, 3, 3 
	Xstudcounter = 1
	While Not rs4.eof  
		TempSSXID(xstudcounter) = rs4("ExternalStudID")
		TempSSXName(xstudcounter) = rs4("AlpacaName")

		Xstudcounter = Xstudcounter +1
		rs4.movenext
	Wend		
	
	rs4.close
	set rs4=nothing
	set conn4 = nothing


	conn8 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
	sql8 = "select ID, FullName from Animals  order by Animals.FullName"

	Set rs8 = Server.CreateObject("ADODB.Recordset")
	rs8.Open sql8, conn8, 3, 3 
	rpcounter = 1
	While Not rs8.eof  
		TemprpID(rpcounter) = rs8("ID")
		TemprpName(rpcounter) = rs8("FullName")

		rpcounter = rpcounter +1
		rs8.movenext
	Wend		
	
	rs8.close
	set rs8=nothing
	set conn8 = nothing




 While  Not rs.eof         
	 TempID(rowcount) =   rs("Animals.ID")
	 TempFullName(rowcount) =   rs("FullName")
	 TempBred(rowcount) =   rs("Bred")
	 TempExternalStudID(rowcount) =   rs("ExternalStudID")
	 TempServiceSireID(rowcount) =   rs("ServiceSireID")
	 TempDueDate(rowcount) =   rs("DueDate")
	 'ShowRecentCria(rowcount) =   rs("ShowRecentCria")
	 'ShowCurrentStud(rowcount) =   rs("ShowCurrentStud")
	' CriaLink(rowcount) =   rs("CriaLink")


	str1 = TempServiceSireID(rowcount) 
	If  str1= "0"  Then
		TempServiceSireID(rowcount) = ""
	End If

	str2 = TempRecentProgenyID(rowcount) 
	If  str2= "0"  Then
		TempRecentProgenyID(rowcount) = ""
	End If



%>

	<form action= 'Femalehandleform.asp' method = "post">
	<tr >
		<td class = "body">
			<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%= TempID( rowcount)%>" >
			<input type = "hidden" name="FullName(<%=rowcount%>)" value= "<%=  TempFullName(rowcount)%>">
			<%=  TempFullName( rowcount)%></td>
		<% if TempBred(rowcount) = "True" then %>
		<td width = "120" nowrap class = "body">True<input TYPE="RADIO" name="Bred(<%=rowcount%>)" Value = "True" checked>
			False<input TYPE="RADIO" name="Bred(<%=rowcount%>)" Value = "False" >
		</td>
		<% else %>
			<td width = "120" nowrap class = "body">True<input TYPE="RADIO" name="Bred(<%=rowcount%>)" Value = "True" >
			False<input TYPE="RADIO" name="Bred(<%=rowcount%>)"Value = "False" checked>
		</td>
	<%end if%>
		
			
	<td width = "100" class = "body">
        <% 
		'response.write("ServiceSireID(rowcount)=" & TempServiceSireID(rowcount))
		if Len(tempServiceSireID(rowcount)) < 1  Then
		CurrentStudID = 0
			CurrentStudName = "N/A"
		else
			
			conn3 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
			"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			sql3 = "select Animals.ID, Animals.FullName from Animals, MaleData where Animals.ID =" & TempServiceSireID( rowcount)
'response.write(sql3)
			Set rs3 = Server.CreateObject("ADODB.Recordset")
			rs3.Open sql3, conn3, 3, 3 

			TempCurrentStudID = rs3("ID")
			TempCurrentStudName = rs3("FullName")
			
			rs3.close
			set rs3=nothing
			set conn3 = nothing

			
		end if
		%>


		<select size="1" name="ServiceSireID(<%=rowcount%>)" width = "100">
		<option value= "<%=TempCurrentStudID%>" selected><%= TempCurrentStudName%></option>
		<option value= "" >N/A</option>
		<% count = 1
			while count < studcounter
			response.write(count)
		%>
			<option value="<%=TempSSID(count)%>" ><%=TempSSName(count)%></option>
		<% 	count = count + 1
			wend %>
		</select>

		</td>

		<td width = "90" class = "body">

		<% 
			if len(TempExternalStudID(rowcount)) > 1  and not TempExternalStudID(rowcount) = "" or  TempExternalStudID(rowcount) > 0 then
			conn6 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
			"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			sql6 = "select * from ExternalStud where ExternalStudID =" & TempExternalStudID(rowcount)

			Set rs6 = Server.CreateObject("ADODB.Recordset")
			rs6.Open sql6, conn6, 3, 3 

			CurrentXStudID = TempExternalStudID(rowcount)
			CurrentXStudName = rs6("AlpacaName")
			
			rs6.close
			set rs6=nothing
			set conn6 = nothing

		else CurrentXStudID = ""
			CurrentXStudName = "N/A"
		end if
		%>


       		<select size="1" name="XServiceSireID(<%=rowcount%>)" width = "80">
			<option value= "<%=CurrentXStudID%>" selected><%= CurrentXStudName%></option>
			<option value= "" >N/A</option>
			<% count = 1
				while count < xstudcounter
			%> 
				<option value="<%=TempSSXID(count)%>"><%=TempSSXName(count)%></option>
			<% 	count = count + 1
				wend %>
			</select>

		</td>



		
		
		<td width = "80"><input name="DueDate(<%=rowcount%>)" value="<%= TempDueDate(rowcount)%>"  size = "8">
		</td>

	</tr>
	

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing
%>

<tr>
		<td colspan = "9" align = "center" valign = "middle">
			<img src = "images/underline.jpg"><br>
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>

</table>