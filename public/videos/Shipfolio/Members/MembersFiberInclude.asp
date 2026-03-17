
<a name="Fiber"></a>
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center"   ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Fiber Facts</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" valign = "top" width = "<%=screenwidth %>">
<%
						
	sql = "select Animals.FullName, Fiber.* from Animals, Fiber where (length(fiber.SampleDate) > 1 or length(fiber.Average) > 1 or length(fiber.StandardDev) > 1 or length(fiber.GreaterThan30) > 1) and Animals.ID = Fiber.ID and animals.ID = " & ID
'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
rowcount = 1
	
filledRecordcount = rs.RecordCount +1
		
			
						
sql2 = "select Animals.FullName, Fiber.* from Animals, Fiber where Animals.ID = Fiber.ID and animals.ID = " & ID 

'response.write (sql)
    Set rs2= Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
	rowcount = 1
	
	Recordcount = rs2.RecordCount +1
if recordcount  = filledRecordcount then
		Query =  "INSERT INTO Fiber (ID)" 
		Query =  Query + " Values ('" &  ID & "')"
'response.write(query)
%>
<!--#Include virtual="/Conn.asp"-->
<% 
Query =  "INSERT INTO Fiber (ID)" 
		Query =  Query + " Values ('" &  ID & "')"
Conn.Execute(Query) 
end if
rs2.close



If rs.RecordCount  < 11 Then
	NeedToAdd = 12 - rs.RecordCount
	rs.close
	i = 1
	While i < NeedToAdd
		Query =  "INSERT INTO Fiber (ID)" 
		Query =  Query + " Values ('" &  ID & "')"

Conn.Execute(Query) 
		NeedToAdd = NeedToAdd - 1
	wend
	
	sql = "select Animals.FullName, Fiber.* from Animals, Fiber where Animals.ID = Fiber.ID and animals.ID = " & ID & " Order by SampleDateYear desc, SampleDateMonth desc, SampleDateYear desc, Average Desc, StandardDev desc,  COV desc, GreaterThan30 desc "
'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
	Recordcount = rs.RecordCount +1


End If 
'Recordcount = rs.RecordCount +1
%>
	<form action= 'MembersFiberHandleForm.asp' method = "post" name = "fiberform">
<%
Dim FiberID(1000)
Dim SampleDateDay(1000)
Dim SampleDateMonth(1000)
Dim SampleDateYear(1000)
Dim SampleAge(1000)
Dim Average(1000)
Dim StandardDev(1000)
Dim COV(1000)
Dim GreaterThan30(1000)
Dim CF(1000)
Dim Curve(1000)
Dim ShearWeight(1000)
Dim BlanketWeight(1000)
Dim Length(1000)
Dim CrimpPerInch(1000)
blankcount = 0
StopSub = False
 While  Not rs.eof  and StopSub = false
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

 if len(trim(SampleAge(rowcount))) > 0 or len(trim(Average(rowcount))) > 0 or len(trim(StandardDev(rowcount))) > 0 or len(trim(COV(rowcount))) > 0 or len(trim(GreaterThan30(rowcount))) > 0 or len(trim(CF(rowcount))) > 0 or  len(trim(Curve(rowcount))) > 0 or len(trim(ShearWeight(rowcount))) > 0 or len(trim(BlanketWeight(rowcount))) > 0 or len(trim(Length(rowcount))) > 0 or len(trim(CrimpPerInch(rowcount))) > 0 then
 else
blankcount = blankcount + 1
if blankcount > 6 then
StopSub  = True

end if
end if
%>
<% If row = "even" Then
row = "odd"
Else
row = "even"
End if
If row = "even" Then %>
<table border = "0" width = "100%"  align = "center" bgcolor = "#e6e6e6">
<% Else %>
<table border = "0" width = "100%"  align = "center">
<% End If %>
<input type = "hidden" name="IDArray(<%=rowcount%>)"  value="<%=ID%>" ><input type = "hidden" name="FiberID(<%=rowcount%>)" value="<%=FiberID(rowcount)%>" ><input type = "hidden" name="FullName(<%=rowcount%>)"  ><tr >
		<td width = "160" class = "body" align= "left"><small>Sample Date:</small><br />
		
			<select size="1" name="SampleDateMonth(<%=rowcount%>)">
		<%  if len(SampleDateMonth(rowcount)) > 0 then %>
			<%  if SampleDateMonth(rowcount) > 0 then %>
					<option value="<%=SampleDateMonth(rowcount)%>" selected><%=SampleDateMonth(rowcount)%></option>	<% end if %>
					<% end if %>
					<option value="0">-</option>
					
							<option value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
					<option  value="9">9</option>
					<option  value="10">10</option>
					<option  value="11">11</option>
					<option  value="12">12</option>
				</select>/<select size="1" name="SampleDateDay(<%=rowcount%>)">
				<%  if len(SampleDateDay(rowcount)) > 0 then %>
				<%  if SampleDateDay(rowcount) > 0 then %>
					<option value="<%=SampleDateDay(rowcount)%>" selected><%=SampleDateDay(rowcount)%></option> <% end if %>
					<% end if %>
					<option value="0">-</option>
					<option value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
					<option  value="9">9</option>
					<option  value="10">10</option>
					<option  value="11">11</option>
					<option  value="12">12</option>
					<option  value="13">13</option>
					<option  value="14">14</option>
					<option  value="15">15</option>
					<option  value="16">16</option>
					<option  value="17">17</option>
					<option  value="18">18</option>
					<option  value="19">19</option>
					<option  value="20">20</option>
					<option  value="21">21</option>
					<option  value="22">22</option>
					<option  value="23">23</option>
					<option  value="24">24</option>
					<option  value="25">25</option>
					<option  value="26">26</option>
					<option  value="27">27</option>
					<option  value="28">28</option>
					<option  value="29">29</option>
					<option  value="30">30</option>
					<option  value="31">31</option>
				</select>/<select size="1" name="SampleDateYear(<%=rowcount%>)">
		<%  if len(SampleDateYear(rowcount)) > 0 then %>
		<%  if SampleDateYear(rowcount) > 0 then %>
					<option value="<%=SampleDateYear(rowcount)%>" selected><%=SampleDateYear(rowcount)%></option>
				<% end if %>	
					<% end if %>
				<option value="0">-</option>	
				
			<% currentyear = year(date) 
						response.write(currentyear)
					For yearv= currentyear To 1983 step -1  %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>
</td>
<td class = "body2" align = "right" >
<small>AFD:</small><br>
<small>CF:</small>
</td>
<td class = "body2" align = "right" >
<input name="Average(<%=rowcount%>)"  size = "3" value="<%=Average(rowcount)%>"><br>
<input name="CF(<%=rowcount%>)" value="<%= CF(rowcount)%>"   size = "3">
		</td>
		<td class = "body2" align = "right" >
<small>SD:</small><br />
<small>Crimps/Inch:</small>
		</td>
<td class = "body" align = "left" >
		   <input name="StandardDev(<%=rowcount%>)"  size = "4" value="<%=StandardDev(rowcount)%>" ><br />
		  <input name="CrimpPerInch(<%=rowcount%>)" value="<%= CrimpPerInch(rowcount)%>"   size = "4">
		</td>
		
		<td class = "body2" align = "right" >
<small>COV:</small><br>
<small>Staple Length:</small></td>
		<td class = "body" align = "left" >
			<input name="COV(<%=rowcount%>)" value="<%= COV( rowcount)%>"  size = "5"><br>
			<input name="Length(<%=rowcount%>)" value="<%= Length(rowcount)%>"  size = "5">
		</td>
		<td class = "body2" align = "right" >
<small>% > 30:</small><br />
<small>Shear Wt:</small></td>
		<td class = "body"  align = "right">
		 <input name="GreaterThan30(<%=rowcount%>)" value="<%= GreaterThan30(rowcount)%>"  size = "5"><br>
		 <input name="ShearWeight(<%=rowcount%>)" value="<%= ShearWeight(rowcount)%>"   size = "5">
		</td>
		<td class = "body2"  align = "right">
<small>Curve:</small><br>
<small>Blanket Wt:</small></td>
		<td class = "body"  align = "right">
		<input name="Curve(<%=rowcount%>)" value="<%= Curve(rowcount)%>"  size = "5"><br>
		<input name="BlanketWeight(<%=rowcount%>)" value="<%= BlanketWeight(rowcount)%>"   size = "5">
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


<table width = "800" border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0><tr><td align = "Right">
		<Input type = hidden name='TotalCount' value = <%=TotalCount%> >	
		<Input type =hidden name='ID' value = <%=ID%> >
		<input type=submit value = "Submit Changes"  size = "110" Class = "regsubmit2" >
	</td>
</tr>
</table></form>
 	</td>
</tr>
</table>

