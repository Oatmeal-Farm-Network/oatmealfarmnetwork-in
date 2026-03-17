<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Female Data Edit Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">


</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include virtual="/administration/Header.asp"--> 

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
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from FemaleWebView where category = 'Female Cria' or category = 'Dam' or category = 'Maiden' order by FullName"


'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ID(300)
	dim FullName(300)
	dim Bred(300)
	dim BredTo(300)
	dim ServiceSireID(300)
	dim RecentProgenyID(300)
	dim DueDate(300)
	dim SSName(300)
	dim SSID(300)
	dim ExternalStudID(300)
	dim SSXName(300)
	dim SSXID(300)
	dim rpName(300)
	dim rpID(300)

Recordcount = rs.RecordCount +1
%>

<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
	<tr>
		<th width = "100">Alpaca's Name</th>
		<th width = "120">Bred</th>
		<th >Your Studs (Including External Studs Maintained on your Site*)</th>
		<th >Externeal Stud</th>
		<th >DueDate</th>
	</tr>

	
<%
	conn2 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
	sql2 = "select Animals.ID, Animals.FullName from Animals where Category = 'Herdsire' or Category = 'Jr. Herdsire' or Category = 'External Stud' order by Animals.FullName"

	studcounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn2, 3, 3 
	
	While Not rs2.eof  
		SSID(studcounter) = rs2("ID")
		SSName(studcounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		studcounter = studcounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn2 = nothing

	conn4 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
	sql4 = "select ExternalStudID, AlpacaName from ExternalStud order by AlpacaName"

	Set rs4 = Server.CreateObject("ADODB.Recordset")
	rs4.Open sql4, conn4, 3, 3 
	Xstudcounter = 1
	While Not rs4.eof  
		SSXID(xstudcounter) = rs4("ExternalStudID")
		SSXName(xstudcounter) = rs4("AlpacaName")

		Xstudcounter = Xstudcounter +1
		rs4.movenext
	Wend		
	
	rs4.close
	set rs4=nothing
	set conn4 = nothing


	conn8 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
	sql8 = "select ID, FullName from Animals order by Animals.FullName"

	Set rs8 = Server.CreateObject("ADODB.Recordset")
	rs8.Open sql8, conn8, 3, 3 
	rpcounter = 1
	While Not rs8.eof  
		rpID(rpcounter) = rs8("ID")
		rpName(rpcounter) = rs8("FullName")

		rpcounter = rpcounter +1
		rs8.movenext
	Wend		
	
	rs8.close
	set rs8=nothing
	set conn8 = nothing




 While  Not rs.eof         
	 ID(rowcount) =   rs("Animals.ID")
	 FullName(rowcount) =   rs("FullName")
	 Bred(rowcount) =   rs("Bred")
	 ExternalStudID(rowcount) =   rs("ExternalStudID")
	 ServiceSireID(rowcount) =   rs("ServiceSireID")
	 DueDate(rowcount) =   rs("DueDate")

	str1 = ServiceSireID(rowcount) 
	If  str1= "0"  Then
		ServiceSireID(rowcount) = ""
	End If

	str2 = RecentProgenyID(rowcount) 
	If  str2= "0"  Then
		RecentProgenyID(rowcount) = ""
	End If



%>

	<form action= 'Femalehandleform.asp' method = "post">
	<tr >
		<td >
			<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  ID( rowcount)%>" >
			<input type = "hidden" name="FullName(<%=rowcount%>)" value= "<%=  FullName(rowcount)%>">
			<%=  FullName( rowcount)%></td>
		<% if Bred(rowcount) = "True" then %>
		<td width = "120" nowrap>True<input TYPE="RADIO" name="Bred(<%=rowcount%>)" Value = "True" checked>
			False<input TYPE="RADIO" name="Bred(<%=rowcount%>)" Value = "False" >
		</td>
		<% else %>
			<td width = "120" nowrap>True<input TYPE="RADIO" name="Bred(<%=rowcount%>)" Value = "True" >
			False<input TYPE="RADIO" name="Bred(<%=rowcount%>)"Value = "False" checked>
		</td>
	<%end if%>
		
			
	<td width = "100">
        <% 
		
		if len(ServiceSireID(rowcount)) > 0 or not ServiceSireID(rowcount) = "" then
			
			conn3 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
			"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
			sql3 = "select Animals.ID, Animals.FullName from Animals, MaleData where Animals.ID =" & ServiceSireID( rowcount)

			Set rs3 = Server.CreateObject("ADODB.Recordset")
			rs3.Open sql3, conn3, 3, 3 

			CurrentStudID = rs3("ID")
			CurrentStudName = rs3("FullName")
			
			rs3.close
			set rs3=nothing
			set conn3 = nothing

		else 
			CurrentStudID = 0
			CurrentStudName = "N/A"
		end if
		%>


		<select size="1" name="ServiceSireID(<%=rowcount%>)" width = "100">
		<option value= "<%=CurrentStudID%>" selected><%= CurrentStudName%></option>
		<option value= "" >N/A</option>
		<% count = 1
			while count < studcounter
			response.write(count)
		%>
			<option value="<%=SSID(count)%>" ><%=SSName(count)%></option>
		<% 	count = count + 1
			wend %>
		</select>

		</td>

		<td width = "100">

		<% 
			if len(ExternalStudID(rowcount)) > 1  and not ExternalStudID(rowcount) = "" or  ExternalStudID(rowcount) > 0 then
			conn6 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
			"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
			sql6 = "select * from ExternalStud where ExternalStudID =" & ExternalStudID(rowcount)

			Set rs6 = Server.CreateObject("ADODB.Recordset")
			rs6.Open sql6, conn6, 3, 3 

			CurrentXStudID = ExternalStudID(rowcount)
			CurrentXStudName = rs6("AlpacaName")
			
			rs6.close
			set rs6=nothing
			set conn6 = nothing

		else CurrentXStudID = ""
			CurrentXStudName = "N/A"
		end if
		%>


       		<select size="1" name="XServiceSireID(<%=rowcount%>)" width = "100">
			<option value= "<%=CurrentXStudID%>" selected><%= CurrentXStudName%></option>
			<option value= "" >N/A</option>
			<% count = 1
				while count < xstudcounter
			%> 
				<option value="<%=SSXID(count)%>"><%=SSXName(count)%></option>
			<% 	count = count + 1
				wend %>
			</select>

		</td>



		
		
		<td width = "170"><input name="DueDate(<%=rowcount%>)" value="<%= DueDate(rowcount)%>"   width = "170">
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
		<td colspan = "5" align = "center" valign = "middle">
			<img src = "images/underline.jpg"><br>
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
<tr>
	<td class = "body" colspan = "5">
		* Sometimes you might want to include information about a stud that you use but you don't want users to be sent to another website to get that information. In that situation add that stud to this system as if it was one of your own studs but set the category to "External Stud".<br><br><br>
	</td>
</tr>
</table>
 

 
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>