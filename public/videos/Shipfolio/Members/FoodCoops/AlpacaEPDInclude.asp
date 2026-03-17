<a name="EPD"></a>
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center"   ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">EPDs</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" valign = "top" width = "<%=screenwidth %>">
<% sql = "select Animals.FullName, EPDAlpacas.* from Animals, EPDAlpacas where  EPDAlpacas.AnimalID = " & ID
'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
rowcount = 1
filledRecordcount = rs.RecordCount +1
						
sql = "select Animals.FullName, EPDAlpacas.* from Animals, EPDAlpacas where  EPDAlpacas.AnimalID = " & ID

'response.write (sql)
    Set rs2= Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
	rowcount = 1
	
	Recordcount = rs2.RecordCount +1
if recordcount  = filledRecordcount then
		Query =  "INSERT INTO EPDAlpacas (AnimalID)" 
		Query =  Query & " Values ('" &  ID & "')"

'response.write(query)
%>
<!--#Include virtual="/Conn.asp"-->
<% 
Query =  "INSERT INTO EPDAlpacas (IDAnimalID)" 
		Query =  Query & " Values ('" &  ID & "')"
Conn.Execute(Query) 
end if
rs2.close



If rs.RecordCount  < 11 Then
	NeedToAdd = 12 - rs.RecordCount
	rs.close
	i = 1
	While i < NeedToAdd
		Query =  "INSERT INTO EPDAlpacas (AnimalID)" 
		Query =  Query & " Values ('" &  ID & "')"

Conn.Execute(Query) 
		NeedToAdd = NeedToAdd - 1
	wend
	
sql = "select Animals.FullName, EPDAlpacas.* from Animals, EPDAlpacas where  EPDAlpacas.AnimalID = " & ID
'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
	Recordcount = rs.RecordCount +1


End If 
'Recordcount = rs.RecordCount +1
%>
<form action= 'AdminEDPHandleForm.asp' method = "post" name = "fiberform">
<%
if Not rs.eof  then
 AnimalID=   rs("AnimalID")
AFD =   rs("AFD")
AFDAcc =   rs("AFDAcc")
AFDRank =   rs("AFDRank")
SDAFD =   rs("SDAFD")
SDAFDAcc =   rs("SDAFDAcc")
SDAFDRank =   rs("SDAFDRank")
SF =   rs("SF")
SFAcc =   rs("SFAcc")
SFRank =   rs("SFRank")
PercentFGreaterThan30 = rs("PercentFGreaterThan30")
percentFgreaterThan30Acc =   rs("percentFgreaterThan30Acc")
percentFGreaterThan30Rank =   rs("percentFGreaterThan30Rank")
MC =   rs("MC")
MCAcc =   rs("MCAcc")
MCRank =   rs("MCRank")
SDMC =   rs("SDMC")
SDMCAcc =   rs("SDMCAcc")
SDMCRank =   rs("SDMCRank")
PercentM =   rs("PercentM")
PercentMAcc =   rs("PercentMAcc")
PercentMRank =   rs("PercentMRank")
MSL =   rs("MSL")
MSLAcc =   rs("MSLAcc")
MSLRank =   rs("MSLRank")
FW =   rs("FW")
FWAcc =   rs("FWAcc")
FWRank =   rs("FWRank")
BW =   rs("BW")
BWAcc =   rs("BWAcc")
EPDDate =   rs("EPDDate")
 end if
%>
<input type = "hidden" name="AnimalID" value="<%=AnimalID%>" >
<table border = "0" width = "100%"  align = "center">
<tr bgcolor = "#EEDD99">
<td class = "body2" align = 'right'><div align ="right"><b>Trait</b></div></td>
<td class = "body2" align = 'center'><div align ="center"><b>Value</b></div></td>
<td class = "body2"><div align ="center"><b>Accuracy</b></div></td>
<td class = "body2" align = 'center'><div align ="center"><b>Rank</b></div></td>
</tr>
<tr>
<td class = "body2" align = "right"><a class="tooltip" href="#">AFD<span class="custom info"><em><div align = "left">Average Fiber Diameter (microns)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="AFD"  size = "5" value="<%=AFD%>"></td>
<td class = "body2" align = "center"><input name="AFDAcc" value="<%= AFDAcc%>"   size = "5"></td>
<td class = "body2" align = "center"><input name="AFDRank" value="<%= AFDRank%>"   size = "15"></td>
</tr>
<tr bgcolor = "#EEDD99">
<td class = "body2" align = "right"><a class="tooltip" href="#">SD AFD<span class="custom info"><em><div align = "left">Standard Deviation (microns)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="SDAFD"  size = "5" value="<%=SDAFD%>"></td>
<td class = "body2" align = "center"><input name="SDAFDAcc" value="<%= SDAFDAcc%>"   size = "5"></td>
<td class = "body2" align = "center"><input name="SDAFDRank" value="<%= SDAFDRank%>"   size = "15"></td>
</tr>
<tr>
<td class = "body2" align = "right"><a class="tooltip" href="#">%F>30m:<span class="custom info"><em><div align = "left">Percent of Fibers larger than 30 microns (%)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="PercentFGreaterThan30"  size = "5" value="<%=PercentFGreaterThan30%>"></td>
<td class = "body2" align = "center"><input name="percentFgreaterThan30Acc" value="<%=percentFgreaterThan30Acc%>"   size = "5"></td>
<td class = "body2" align = "center"><input name="percentFGreaterThan30Rank" value="<%=percentFGreaterThan30Rank%>"   size = "15"></td>
</tr>
<tr bgcolor = "#EEDD99">
<td class = "body2" align = "right"><a class="tooltip" href="#">SF<span class="custom info"><em><div align = "left">Spin Fineness (microns)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="SF"  size = "5" value="<%=SF%>"></td>
<td class = "body2" align = "center"><input name="SFAcc" value="<%=SFAcc%>"   size = "5"></td>
<td class = "body2" align = "center"><input name="SFRank" value="<%= SFRank%>"   size = "15"></td>
</tr>
<tr>
<td class = "body2" align = "right"><a class="tooltip" href="#">FW:<span class="custom info"><em><div align = "left">Fleece Weight</div></em></span></a></td>
<td class = "body2" align = "center"><input name="FW"  size = "5" value="<%=FW%>"></td>
<td class = "body2" align = "center"><input name="FWAcc" value="<%=FWAcc%>"   size = "5"></td>
<td class = "body2" align = "center"><input name="FWRank" value="<%=FWRank%>"   size = "15"></td>
</tr>
<tr bgcolor = "#EEDD99">
<td class = "body2" align = "right"><a class="tooltip" href="#">SL:<span class="custom info"><em><div align = "left">Mean Staple Length (mm)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="MSL"  size = "5" value="<%=MSL%>"></td>
<td class = "body2" align = "center"><input name="MSLAcc" value="<%=MSLAcc%>"   size = "5"></td>
<td class = "body2" align = "center"><input name="MSLRank" value="<%=MSLRank%>"   size = "15"></td>
</tr>


<tr>
<td class = "body2" align = "right"><a class="tooltip" href="#">MC:<span class="custom info"><em><div align = "left">Mean Curvature (deg/mm)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="MC"  size = "5" value="<%=MC%>"></td>
<td class = "body2" align = "center"><input name="MCAcc" value="<%=MCAcc%>"   size = "5"></td>
<td class = "body2" align = "center"><input name="MCRank" value="<%=MCRank%>"   size = "15"></td>
</tr>
<tr bgcolor = "#EEDD99">
<td class = "body2" align = "right"><a class="tooltip" href="#">SD C:<span class="custom info"><em><div align = "left">Standard Deviation of Curvature</div></em></span></a></td>
<td class = "body2" align = "center"><input name="SDMC"  size = "5" value="<%=SDMC%>"></td>
<td class = "body2" align = "center"><input name="SDMCAcc" value="<%=SDMCAcc%>"   size = "5"></td>
<td class = "body2" align = "center"><input name="SDMCRank" value="<%=SDMCRank%>"   size = "15"></td>
</tr>
<tr>
<td class = "body2" align = "right"><a class="tooltip" href="#">%M:<span class="custom info"><em><div align = "left">Percent Medullation (%)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="PercentM"  size = "5" value="<%=PercentM%>"></td>
<td class = "body2" align = "center"><input name="PercentMAcc" value="<%=PercentMAcc%>"   size = "5"></td>
<td class = "body2" align = "center"><input name="PercentMRank" value="<%=PercentMRank%>"   size = "15"></td>
</tr>
</table>
<%
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