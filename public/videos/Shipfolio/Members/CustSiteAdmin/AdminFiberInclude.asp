<%

Dim SampleDateDay(1000)
Dim SampleDateMonth(1000)
Dim SampleDateYear(1000)

 if mobiledevice = True or screenwidth < 800 then %>
 
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"  >
 <tr>
    <td class = "roundedtop" align = "center">
		<a name="Fiber"></a><H2><div align = "left">Fiber Facts</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" valign = "top">
<%

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
						
			Set rs = Server.CreateObject("ADODB.Recordset")				
	sql = "select Animals.*, Fiber.* from Animals, Fiber where (len(fiber.SampleDateDay) > 0 or len(fiber.Average) > 1 or len(fiber.StandardDev) > 1 or len(fiber.GreaterThan30) > 1) and   Animals.ID = Fiber.ID and animals.ID = " & ID

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
	filledRecordcount = rs.RecordCount +1
		
			
						
sql = "select Animals.FullName, Fiber.* from Animals, Fiber where Animals.ID = Fiber.ID and animals.ID = " & ID 

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
	Recordcount = rs.RecordCount +1
if recordcount  = filledRecordcount then
		Query =  "INSERT INTO Fiber (ID)" 
		Query =  Query + " Values ('" &  ID & "')"

'response.write(query)
	
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
Query =  "INSERT INTO Fiber (ID)" 
		Query =  Query + " Values ('" &  ID & "')"
		DataConnection.Execute(Query) 

end if




If rs.RecordCount  < 11 Then
	NeedToAdd = 12 - rs.RecordCount
	rs.close
	i = 1
	While i < NeedToAdd
		Query =  "INSERT INTO Fiber (ID)" 
		Query =  Query + " Values ('" &  ID & "')"
		NeedToAdd = NeedToAdd - 1
	wend
	
	sql = "select Animals.FullName, Fiber.* from Animals, Fiber where Animals.ID = Fiber.ID and animals.ID = " & ID & " Order by SampleDateYear desc,  SampleDateMonth desc,  SampleDateYear desc, Average"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
	Recordcount = rs.RecordCount +1


End If 
'Recordcount = rs.RecordCount +1
%>
	<form action= 'AdminFiberHandleForm.asp' method = "post" name = "fiberform">
<%
	 
 While  Not rs.eof         
	 FiberID(rowcount) =   rs("FiberID")
	 SampleDateDay(rowcount) =   rs("SampleDateDay")
	  SampleDateMonth(rowcount) =   rs("SampleDateMonth")
	   SampleDateYear(rowcount) =   rs("SampleDateYear")
	 SampleAge(rowcount) =   rs("SampleAge")
	 Average(rowcount) =   rs("Average")
	 StandardDev(rowcount) =   rs("StandardDev")
	 COV(rowcount) =  rs("COV")
	 GreaterThan30(rowcount) =   rs("GreaterThan30")
	 CF(rowcount) =  rs("CF")
	 Curve(rowcount) =   rs("Curve")
	 ShearWeight(rowcount) =   rs("ShearWeight")
	 BlanketWeight(rowcount) =   rs("BlanketWeight")
	 Length(rowcount) =   rs("Length")
	 CrimpPerInch(rowcount) =   rs("CrimpPerInch")


%>

<% If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
		 If row = "even" Then %>
	<table border = "0" width = "100%"  align = "center" bgcolor ="#e6e6e6" cellpadding = "0" cellspacing = "0">
<% Else %>
	<table border = "0" width = "100%"  align = "center" cellpadding = "0" cellspacing = "0">
<% End If %>
<tr >
		<td class = "body2" align= "right"><b>Year:</b>&nbsp;</td>
		<td class = "body" >
		<input type = "hidden" name="IDArray(<%=rowcount%>)"  value="<%=ID%>" ><input type = "hidden" name="FiberID(<%=rowcount%>)" value="<%=FiberID(rowcount)%>" ><input type = "hidden" name="FullName(<%=rowcount%>)"  >
		<select size="1" name="SampleDateYear(<%=rowcount%>)" class = "regsubmit2 body">
					<option value="<%=SampleDateYear(rowcount)%>" selected><%=SampleDateYear(rowcount)%></option>
					
				
			<% currentyear = year(date) 
						response.write(currentyear)
					For yearv= currentyear To 1983 step -1  %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>
		</td>
		<td class = "body2" align= "right">
		    <b>AFD:</b>&nbsp;
		</td>
		<td class = "body" >
			<input name="Average(<%=rowcount%>)"  size = "5" value="<%=Average(rowcount)%>" class = "regsubmit2 body">
		</td>
			</tr>
		<tr>
		<td class = "body2" align= "right">
		    <b>CF:</b>&nbsp;
		</td>
		<td class = "body" >
			<input name="CF(<%=rowcount%>)" value="<%= CF(rowcount)%>"   size = "5" class = "regsubmit2 body">
		</td>
		<td class = "body2" align= "right">
		    <b>SD:</b>&nbsp;
		</td>
		<td class = "body"  >
		   <input name="StandardDev(<%=rowcount%>)"  size = "5" value="<%=StandardDev(rowcount)%>" class = "regsubmit2 body">
		</td>
			</tr>
		<tr>
		<td class = "body2" align= "right">
		    <b>Crimps/Inch:</b>&nbsp;
		</td>
		<td class = "body"  >
		   <input name="CrimpPerInch(<%=rowcount%>)" value="<%= CrimpPerInch(rowcount)%>"   size = "5" class = "regsubmit2 body">
		</td>
        <td class = "body2" align= "right">
		    <b>COV:</b>&nbsp;
		</td>
		<td class = "body"  >
			<input name="COV(<%=rowcount%>)" value="<%= COV( rowcount)%>"  size = "5" class = "regsubmit2 body">
		</td>
			</tr>
		<tr>
		<td class = "body2" align= "right">
		    <b>Staple&nbsp;<br />Length:</b>&nbsp;
		</td>
		<td class = "body"  >
			<input name="Length(<%=rowcount%>)" value="<%= Length(rowcount)%>"  size = "5" class = "regsubmit2 body">
		</td>
		<td class = "body2" align= "right">
		    <b>% > 30:</b>&nbsp;
		</td>
		<td class = "body" >
			<input name="GreaterThan30(<%=rowcount%>)"  size = "5" value="<%=GreaterThan30(rowcount)%>" class = "regsubmit2 body">
		</td>
			</tr>
		<tr>
		<td class = "body2" align= "right">
		    <b>Shear Wt:</b>&nbsp;
		</td>
		<td class = "body" >
			<input name="ShearWeight(<%=rowcount%>)" value="<%= ShearWeight(rowcount)%>"  size = "5" class = "regsubmit2 body">
		</td>
	
		<td class = "body2" align= "right">
		    <b>Curve:</b>&nbsp;
		</td>	
		<td class = "body"  >
		 <input name="Curve(<%=rowcount%>)" value="<%= Curve(rowcount)%>"  size = "5" class = "regsubmit2 body">
		</td>
			</tr>
		<tr>
		<td class = "body2" align= "right">
		    <b>Blanket Wt:</b>&nbsp;
		</td>	
		<td class = "body"  colspan = "3">
		 <input name="BlanketWeight(<%=rowcount%>)" value="<%= BlanketWeight(rowcount)%>"   size = "5" class = "regsubmit2 body">
		</td>
	</tr>


<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
'response.write(TotalCount)
	rs.close
%>
<tr>
	<td class = "body" colspan = "4">
		<Input type = hidden name='TotalCount' value = <%=TotalCount%> >	
		<Input type =hidden name='ID' value = <%=ID%> >
		<center><input type=submit value = "Submit"   Class = "regsubmit2 body" ></center>
	</td>
</tr>
</table></form>
 	</td>
</tr>
</table>

<% else %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 35 %>"  >
 <tr>
    <td class = "roundedtop" align = "center">
		<a name="Fiber"></a><H2><div align = "left">Fiber Facts</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" valign = "top">
<%

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
						
			Set rs = Server.CreateObject("ADODB.Recordset")				
	sql = "select Animals.*, Fiber.* from Animals, Fiber where (len(fiber.SampleDateDay) > 0 or len(fiber.Average) > 1 or len(fiber.StandardDev) > 1 or len(fiber.GreaterThan30) > 1) and   Animals.ID = Fiber.ID and animals.ID = " & ID

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
	filledRecordcount = rs.RecordCount +1
		
			
						
sql = "select Animals.FullName, Fiber.* from Animals, Fiber where Animals.ID = Fiber.ID and animals.ID = " & ID 

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
	Recordcount = rs.RecordCount +1
if recordcount  = filledRecordcount then
		Query =  "INSERT INTO Fiber (ID)" 
		Query =  Query + " Values ('" &  ID & "')"

'response.write(query)
	
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
Query =  "INSERT INTO Fiber (ID)" 
		Query =  Query + " Values ('" &  ID & "')"
		DataConnection.Execute(Query) 

end if

If rs.RecordCount  < 11 Then
	NeedToAdd = 12 - rs.RecordCount
	rs.close
	i = 1
	While i < NeedToAdd
		Query =  "INSERT INTO Fiber (ID)" 
		Query =  Query + " Values ('" &  ID & "')"
		NeedToAdd = NeedToAdd - 1
	wend
	
	sql = "select Animals.FullName, Fiber.* from Animals, Fiber where Animals.ID = Fiber.ID and animals.ID = " & ID & " Order by SampleDateYear desc,  SampleDateMonth desc,  SampleDateYear desc, Average"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
	Recordcount = rs.RecordCount +1


End If 
'Recordcount = rs.RecordCount +1
%>
	<form action= 'AdminFiberHandleForm.asp' method = "post" name = "fiberform">
<%
 
 While  Not rs.eof         
	 FiberID(rowcount) =   rs("FiberID")
	 SampleDateDay(rowcount) =   rs("SampleDateDay")
	  SampleDateMonth(rowcount) =   rs("SampleDateMonth")
	   SampleDateYear(rowcount) =   rs("SampleDateYear")
	 SampleAge(rowcount) =   rs("SampleAge")
	 Average(rowcount) =   rs("Average")
	 StandardDev(rowcount) =   rs("StandardDev")
	 COV(rowcount) =  rs("COV")
	 GreaterThan30(rowcount) =   rs("GreaterThan30")
	 CF(rowcount) =  rs("CF")
	 Curve(rowcount) =   rs("Curve")
	 ShearWeight(rowcount) =   rs("ShearWeight")
	 BlanketWeight(rowcount) =   rs("BlanketWeight")
	 Length(rowcount) =   rs("Length")
	 CrimpPerInch(rowcount) =   rs("CrimpPerInch")


%>

<% If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
		 If row = "even" Then %>
	<table border = "0" width = "100%"  align = "center" bgcolor ="#e6e6e6">
<% Else %>
	<table border = "0" width = "100%"  align = "center" ">
<% End If %>
<input type = "hidden" name="IDArray(<%=rowcount%>)"  value="<%=ID%>" ><input type = "hidden" name="FiberID(<%=rowcount%>)" value="<%=FiberID(rowcount)%>" ><input type = "hidden" name="FullName(<%=rowcount%>)"  ><tr >
		<td width = "70" class = "body" align= "left">Sample Year:<br />
		
		<select size="1" name="SampleDateYear(<%=rowcount%>)">
					<option value="<%=SampleDateYear(rowcount)%>" selected><%=SampleDateYear(rowcount)%></option>
					
				
			<% currentyear = year(date) 
						response.write(currentyear)
					For yearv= currentyear To 1983 step -1  %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>
		</td>
		<td class = "body2" align = "right">
			AFD:&nbsp;<input name="Average(<%=rowcount%>)"  size = "5" value="<%=Average(rowcount)%>"><br>
			CF:&nbsp;<input name="CF(<%=rowcount%>)" value="<%= CF(rowcount)%>"   size = "5">
		</td>
		<td class = "body2" align = "right" >
		    SD:&nbsp;<input name="StandardDev(<%=rowcount%>)"  size = "5" value="<%=StandardDev(rowcount)%>" ><br />
		   Crimps/Inch:&nbsp;<input name="CrimpPerInch(<%=rowcount%>)" value="<%= CrimpPerInch(rowcount)%>"   size = "5">
		</td>

		<td class = "body2" align = "right" >
			COV:&nbsp;<input name="COV(<%=rowcount%>)" value="<%= COV( rowcount)%>"  size = "5"><br>
			Staple Length:&nbsp;<input name="Length(<%=rowcount%>)" value="<%= Length(rowcount)%>"  size = "5">
		</td>
		<td class = "body2" align = "right" >
			% > 30:&nbsp;<input name="GreaterThan30(<%=rowcount%>)"  size = "5" value="<%=GreaterThan30(rowcount)%>" ><br />
			Shear Wt:&nbsp;<input name="ShearWeight(<%=rowcount%>)" value="<%= ShearWeight(rowcount)%>"  size = "5">
		</td>
		<td class = "body2"  align = "right">
		 Curve:&nbsp;<input name="Curve(<%=rowcount%>)" value="<%= Curve(rowcount)%>"  size = "5"><br>
		 Blanket Wt:&nbsp;<input name="BlanketWeight(<%=rowcount%>)" value="<%= BlanketWeight(rowcount)%>"   size = "5">
		</td>
	</tr>
</table>

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
'response.write(TotalCount)
	rs.close
%>


<table width = "100%" border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" >
<tr><br />
	<td  align = "center">
		<Input type = hidden name='TotalCount' value = <%=TotalCount%> >	
		<Input type =hidden name='ID' value = <%=ID%> >
		<input type=submit value = "Submit"  size = "110" Class = "regsubmit2" >
	</td>
</tr>
</table></form>
 	</td>
</tr>
</table>

<% end if %>