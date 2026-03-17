<table border="0" cellspacing="2" width = "550" align = "center" >
<tr>
				<td  colspan = "5" class = "Details">
<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
 fsql = "select * from Fiber where ID =" & ID & " order by fiberorder asc, sampledate asc"


    Set frs = Server.CreateObject("ADODB.Recordset")
    frs.Open fsql, conn, 3, 3   
	rowcount = 1
	
	Recordcount = frs.RecordCount
if  Not frs.eof  then
'if len(frs("Average")) >1 or  len(frs("StandardDev")) >1 or  len(frs("COV")) > 1 then %>

		<br><big><b>Fiber History</b></big></br><img src = "/images/Line.jpg" alt="Alpacas at Lone Ranch Line" width = "<%=bodywidth%>" height = "2">	</td>
		</tr>
	
		<tr>
			<td  valign="top"  class = "Details" align = "center" width = "80">
   					Sample Age
			</td>
			<td  valign="top"  class = "Details" align = "center">
					Average Fiber Diameter
			</td>
			<td  valign="top"  class = "Details" align = "center">
					Standard Deviation
			</td>
			<td  valign="top"  class = "Details" align = "center">
					Coefficient Of Variation
			</td>
			<td  valign="top"  class = "Details" align = "center">
					% Fiber over 30 Microns
			</td>
			</td>
		</tr>
<% 'end if
end if
While  Not frs.eof   	
		AverageFiberDiameter 	= frs("Average")
		StandardDeviation 	= frs("StandardDev")
		CoefficientOfVariation 	= frs("COV")
		FiberGreaterThan30 	= frs("GreaterThan30")
		SampleDate = frs("SampleDate")

Recordcount = frs.RecordCount
if Not frs.eof  then
%>
	
		<tr>
			<td  valign="top"  align = "center" class = "Body">
				<%=SampleDate%></td>
			<td  valign="top"  align = "center" class = "Body">
				<%=AverageFiberDiameter%></td>
			<td  valign="top" align = "center"  class = "Body">
				<%=StandardDeviation%></td>
			<td  valign="top" align = "center"  class = "Body">
				<%=CoefficientOfVariation%>
			</td>
			<td  valign="top" align = "center"  class = "Body">
				<%=FiberGreaterThan30%>
			</td>
			</td>
			<td valign="top">
			</td>
		</tr>		


<%
			rowcount = rowcount + 1
			frs.movenext
			end if
		Wend
		TotalCount=rowcount 
			frs.close
		set frs=nothing
		%>
</td>
</tr>
</table><br><br>
