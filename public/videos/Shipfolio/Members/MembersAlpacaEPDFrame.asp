<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="MembersGlobalVariables.asp"-->
<style type="text/css">
.blink_text {
-webkit-animation-name: blinker;
-webkit-animation-duration: 2s;
-webkit-animation-timing-function: linear;
-webkit-animation-iteration-count: 1;

-moz-animation-name: blinker;
-moz-animation-duration: 2s;
-moz-animation-timing-function: linear;
-moz-animation-iteration-count: 1;

 animation-name: blinker;
 animation-duration: 2s;
 animation-timing-function: linear;
 animation-iteration-count: 1;

 color: green;
}

@-moz-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@-webkit-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }
 </style>
</head>
<body>
<a name="EPD"></a>
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center"  width = "100%" ><tr><td class = "roundedtopandbottom" align = "left">
<H2><div align = "left">EPDs</div></H2>
<% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your EPD Changes Have Been Made.</b></font></div>
<% end if %>

<% RecordCount = request.QueryString("RecordCount")
ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
end if
Set rs2 = Server.CreateObject("ADODB.Recordset")
sql = "select * from EPDAlpacas where AnimalID = " & ID
rs2.Open sql, conn, 3, 3   
	
if rs2.eof then
Query =  "INSERT INTO EPDAlpacas (AnimalID)" 
Query =  Query & " Values ('" &  ID & "')"
if len(ID) > 0 then
Conn.Execute(Query) 
end if
if rs2.state = 0 then
else
rs2.close
end if

sql = "select * from EPDAlpacas where AnimalID = " & ID
rs2.Open sql, conn, 3, 3   
end if

If RecordCount  < 11 Then
	NeedToAdd = 12 - RecordCount
	i = 1
	While i < NeedToAdd
		Query =  "INSERT INTO EPDAlpacas (AnimalID)" 
		Query =  Query & " Values ('" &  ID & "')"

Conn.Execute(Query) 
		NeedToAdd = NeedToAdd - 1
	wend
	
'sql = "select Animals.FullName, EPDAlpacas.* from Animals, EPDAlpacas where  EPDAlpacas.AnimalID = " & ID
'response.write (sql)

 '   rs.Open sql, conn, 3, 3   
	'rowcount = 1
'Recordcount = RecordCount +1
End If 
%>
<form action= 'MembersAlpacaEPDHandleForm.asp' method = "post" name = "fiberform">
<%
if Not rs2.eof  then
 AnimalID=   rs2("AnimalID")


SDAFD =   rs2("SDAFD")
SDAFDAcc =   rs2("SDAFDAcc")
SDAFDRank =   rs2("SDAFDRank")
SDAFDRank2 =   rs2("SDAFDRank2")
SDAFDPercent =   rs2("SDAFDPercent")

if len(SDAFDRank) > 0 and len(SDAFDRank2) > 0 then
if SDAFDRank > 0 and SDAFDRank2 > 0 then
SDAFDPercent = left((SDAFDRank /SDAFDRank2) * 100, 3)
end if
end if

if len(SDAFDPercent) < 1then
if cint(SDAFDPercent) = 0 then
SDAFDPercent = ""
end if
end if


SF =   rs2("SF")
SFAcc =   rs2("SFAcc")
SFRank =   rs2("SFRank")
SFRank2 =   rs2("SFRank2")
SFRankPercent = rs2("SFRankPercent")

if len(SFRank) > 0 and len(SFRank2) > 0 then
if SFRank > 0 and SFRank2 > 0 then
SFRankPercent = left((SFRank / SFRank2) * 100, 3)
end if
end if

if len(SFRankPercent)< 1 then
if cint(SFRankPercent) = 0 then
SFRankPercent = ""
end if
end if


AFD =   rs2("AFD")
AFDAcc =   rs2("AFDAcc")
AFDRank =   rs2("AFDRank")
AFDRank2 =   rs2("AFDRank2")
AFDPercent = rs2("AFDPercent")
'response.write("AFDPercent1 =" & AFDPercent  )


if len(AFDRank) > 0 and len(AFDRank2) > 0 then
if AFDRank > 0 and AFDRank2 > 0 then
AFDPercent = left((AFDRank / AFDRank2) * 100, 3)
end if
end if


if len(AFDPercent) > 0 then
else
AFDPercent = 0
end if

if len(AFDPercent) = 1 then
if cint(AFDPercent) = 0 then
AFDPercent = ""
end if
end if



PercentFGreaterThan30 = rs2("PercentFGreaterThan30")
percentFgreaterThan30Acc =   rs2("percentFgreaterThan30Acc")
percentFGreaterThan30Rank =   rs2("percentFGreaterThan30Rank")
percentFGreaterThan30Rank2 =   rs2("percentFGreaterThan30Rank2")
PercentFGreaterThan30Percent =   rs2("PercentFGreaterThan30Percent")


if len(percentFGreaterThan30Rank) > 0 and len(percentFGreaterThan30Rank2) > 0 then
if percentFGreaterThan30Rank > 0 and percentFGreaterThan30Rank2 > 0 then
PercentFGreaterThan30Percent = left((percentFGreaterThan30Rank / percentFGreaterThan30Rank2) * 100, 3)
end if
end if

if len(PercentFGreaterThan30Percent) > 0 then
else
PercentFGreaterThan30Percent = 0
end if

if len(PercentFGreaterThan30Percent) = 1 then
if cint(PercentFGreaterThan30Percent) = 0 then
PercentFGreaterThan30Percent = ""
end if
end if

MC =   rs2("MC")
MCAcc =   rs2("MCAcc")
MCRank =   rs2("MCRank")
MCRank2 =   rs2("MCRank2")
MCRankPercent = rs2("MCRankPercent")


if len(MCRank) > 0 and len(MCRank2) > 0 then
if MCRank > 0 and MCRank2 > 0 then
MCRankPercent = left((MCRank / MCRank2) / 100, 3)
end if
end if

if len(MCRankPercent) = 1 then
if MCRankPercent = 0 then
MCRankPercent = ""
end if
end if

PercentMRankPercent = rs2("PercentMRankPercent")

SDMC =   rs2("SDMC")
SDMCAcc =   rs2("SDMCAcc")
SDMCRank =   rs2("SDMCRank")
SDMCRank2 =   rs2("SDMCRank2")
SDMCRankPercent =   rs2("SDMCRankPercent")


if len(SDMCRank) > 0 and len(SDMCRank2) > 0 then
if SDMCRank > 0 and SDMCRank2 > 0 then
SDMCRankPercent = left((SDMCRank / SDMCRank2) * 100, 3)
end if
end if
if len(SDMCRankPercent) = 1 then
if cint(SDMCRankPercent) = 0 then
SDMCRankPercent = ""
end if
end if

PercentM = rs2("PercentM")
PercentMAcc = rs2("PercentMAcc")
PercentMRank = rs2("PercentMRank")
PercentMRank2 = rs2("PercentMRank2")
PercentMRankPercent = rs2("PercentMRankPercent")

if len(PercentMRank) > 0 and len(PercentMRank2) > 0 then
if PercentMRank > 0 and PercentMRank2 > 0 then
PercentMRankPercent = left((PercentMRank / PercentMRank2) * 100, 3)
end if
end if

if len(PercentMRankPercent) =1 then
if cint(PercentMRankPercent) = 0 then
PercentMRankPercent = ""
end if
end if

MSL = rs2("MSL")
MSLAcc = rs2("MSLAcc")
MSLRank = rs2("MSLRank")
MSLRank2 = rs2("MSLRank2")
MSLRankpercent = rs2("MSLRankpercent")

if len(MSLRank) > 0 and len(MSLRank2) > 0 then
if MSLRank > 0 and MSLRank2 > 0 then
MSLRankpercent = left((MSLRank / MSLRank2) * 100, 3)
end if
end if

if len(MSLRankpercent) < 1 then
if cint(MSLRankpercent) = 0 then
MSLRankpercent = ""
end if
end if

FW =   rs2("FW")
FWAcc =   rs2("FWAcc")
FWRank =   rs2("FWRank")
FWRank2 =   rs2("FWRank2")
FWRankPercent =   rs2("FWRankPercent")

if len(FWRank) > 0 and len(FWRank2) > 0 then
if FWRank > 0 and FWRank2 > 0 then
FWRankpercent = left((FWRank / FWRank2) * 100, 3)
end if
end if

if len(FWRankpercent) = 1 then
if cint(FWRankpercent) = 0 then
FWRankpercent = ""
end if
end if

BW =   rs2("BW")
BWAcc =   rs2("BWAcc")
BWAccPercent =   rs2("BWAccPercent")

EPDDate =   rs2("EPDDate")
end if
%>
<input type = "hidden" name="AnimalID" value="<%=AnimalID%>" >
<table border = "0" width = "100%"  align = "center">
<tr bgcolor = "#e6e6e6" height = 30>
<td class = "body2" align = 'right'><div align ="right"><b>Trait</b></div></td>
<td class = "body2" align = 'center'><div align ="center"><b>Value</b></div></td>
<td class = "body2"><div align ="center"><b>Accuracy</b></div></td>
<td class = "body2" align = 'center'><div align ="center"><b>Rankings</b></div></td>
<td class = "body2" align = 'center'><div align ="center"><b>Top Percent</b></div></td>
</tr>
<tr>
<td class = "body2" align = "right"><a class="tooltip" href="#">AFD<span class="custom info"><em><div align = "left">Average Fiber Diameter (microns)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="AFD" size = "5" maxlength = 9 value="<%=AFD%>" class = "formbox"></td>
<td class = "body2" align = "center"><input name="AFDAcc" value="<%= AFDAcc%>"  size = "5" maxlength = 9 class = "formbox"></td>
<td class = "body2" align = "center"><input name="AFDRank" value="<%= AFDRank%>"  size = "5" maxlength = 9 class = "formbox"> Of <input name="AFDRank2" value="<%= AFDRank2%>" size = "5" class = "formbox"></td>
<td class = "body2" align = "center"><input name="AFDPercent" value="<%= AFDPercent%>"  size = "1" maxlength = 3 class = "formbox"> %</td>
</tr>
<tr bgcolor = "#e6e6e6">
<td class = "body2" align = "right"><a class="tooltip" href="#">SD AFD<span class="custom info"><em><div align = "left">Standard Deviation (microns)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="SDAFD" size = "5" maxlength = 9 value="<%=SDAFD%>" class = "formbox"></td>
<td class = "body2" align = "center"><input name="SDAFDAcc" value="<%= SDAFDAcc%>"  size = "5" maxlength = 9 class = "formbox"></td>
<td class = "body2" align = "center"><input name="SDAFDRank" value="<%= SDAFDRank%>" size = "5" maxlength = 9 class = "formbox"> Of <input name="SDAFDRank2" value="<%= SDAFDRank2%>" size = "5" maxlength = 9 class = "formbox"></td>
<td class = "body2" align = "center"><input name="SDAFDPercent" value="<%= SDAFDPercent%>"  size = "1" maxlength = 3 class = "formbox"> %</td>




</tr>
<tr >
<td class = "body2" align = "right"><a class="tooltip" href="#">SF<span class="custom info"><em><div align = "left">Spin Fineness (microns)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="SF" size = "5" maxlength = 9 value="<%=SF%>" class = "formbox"></td>
<td class = "body2" align = "center"><input name="SFAcc" value="<%=SFAcc%>" size = "5" maxlength = 9 class = "formbox"></td>
<td class = "body2" align = "center"><input name="SFRank" value="<%= SFRank%>"  size = "5" maxlength = 9 class = "formbox"> Of <input name="SFRank2" value="<%= SFRank2%>" size = "5" maxlength = 9 class = "formbox"></td>
<td class = "body2" align = "center"><input name="SFRankPercent" value="<%= SFRankPercent%>"  size = "1" maxlength = 3 class = "formbox"> %</td>

</tr>
<tr bgcolor = "#e6e6e6">
<td class = "body2" align = "right"><a class="tooltip" href="#">%F>30m:<span class="custom info"><em><div align = "left">Percent of Fibers larger than 30 microns (%)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="PercentFGreaterThan30"  size = "5" maxlength = 9 value="<%=PercentFGreaterThan30%>" class = "formbox"></td>
<td class = "body2" align = "center"><input name="percentFgreaterThan30Acc" value="<%=percentFgreaterThan30Acc%>"  size = "5" maxlength = 9 class = "formbox"></td>
<td class = "body2" align = "center"><input name="percentFGreaterThan30Rank" value="<%=percentFGreaterThan30Rank%>"  size = "5" maxlength = 9 class = "formbox"> Of <input name="percentFGreaterThan30Rank2" value="<%=percentFGreaterThan30Rank2%>" size = "5" maxlength = 9 class = "formbox"></td>
<td class = "body2" align = "center"><input name="percentFGreaterThan30Percent" value="<%= percentFGreaterThan30Percent%>"  size = "1" maxlength = 3 class = "formbox"> %</td>

</tr>
<tr>
<td class = "body2" align = "right"><a class="tooltip" href="#">MC:<span class="custom info"><em><div align = "left">Mean Curvature (deg/mm)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="MC" size = "5" maxlength = 9 value="<%=MC%>" class = "formbox"></td>
<td class = "body2" align = "center"><input name="MCAcc" value="<%=MCAcc%>" size = "5" maxlength = 9 class = "formbox"></td>
<td class = "body2" align = "center"><input name="MCRank" value="<%=MCRank%>" size = "5" maxlength = 9 class = "formbox"> Of <input name="MCRank2" value="<%=MCRank2%>" size = "5" maxlength = 9 class = "formbox"></td>
<td class = "body2" align = "center"><input name="MCRankPercent" value="<%= MCRankPercent%>"  size = "1" maxlength = 3 class = "formbox"> %</td>

</tr>
<tr bgcolor = "#e6e6e6">
<td class = "body2" align = "right"><a class="tooltip" href="#">SDMC:<span class="custom info"><em><div align = "left">Standard Deviation of Curvature</div></em></span></a></td>
<td class = "body2" align = "center"><input name="SDMC" size = "5" maxlength = 9 value="<%=SDMC%>" class = "formbox"></td>
<td class = "body2" align = "center"><input name="SDMCAcc" value="<%=SDMCAcc%>" class = "formbox" size = "5" maxlength = 9></td>
<td class = "body2" align = "center"><input name="SDMCRank" value="<%=SDMCRank%>" class = "formbox" size = "5" maxlength = 9> Of <input name="SDMCRank2" value="<%=SDMCRank2%>"  size = "5" maxlength = 9 class = "formbox"></td>
<td class = "body2" align = "center"><input name="SDMCRankPercent" value="<%= SDMCRankPercent%>"  size = "1" maxlength = 3 class = "formbox"> %</td>


</tr>
<tr>
<td class = "body2" align = "right"><a class="tooltip" href="#">%M:<span class="custom info"><em><div align = "left">Percent Medullation (%)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="PercentM"  size = "5" value="<%=PercentM%>" class = "formbox"></td>
<td class = "body2" align = "center"><input name="PercentMAcc" value="<%=PercentMAcc%>" size = "5" maxlength = 9 class = "formbox"></td>
<td class = "body2" align = "center"><input name="PercentMRank" value="<%=PercentMRank%>"  size = "5" maxlength = 9 class = "formbox"> Of <input name="PercentMRank2" value="<%=PercentMRank2%>"  size = "5" maxlength = 9 class = "formbox"></td>
<td class = "body2" align = "center"><input name="PercentMRankPercent" value="<%= PercentMRankPercent%>"  size = "1" maxlength = 3 class = "formbox"> %</td>

</tr>
<tr bgcolor = "#e6e6e6">
<td class = "body2" align = "right"><a class="tooltip" href="#">MSL:<span class="custom info"><em><div align = "left">Mean Staple Length (mm)</div></em></span></a></td>
<td class = "body2" align = "center"><input name="MSL" size = "5" maxlength = 9 value="<%=MSL%>" class = "formbox"></td>
<td class = "body2" align = "center"><input name="MSLAcc" value="<%=MSLAcc%>"  size = "5" maxlength = 9 class = "formbox"></td>
<td class = "body2" align = "center"><input name="MSLRank" value="<%=MSLRank%>" size = "5" maxlength = 9 class = "formbox"> Of <input name="MSLRank2" value="<%=MSLRank2%>"  size = "5" maxlength = 9 class = "formbox"></td>
<td class = "body2" align = "center"><input name="MSLRankpercent" value="<%= MSLRankpercent%>"  size = "1" maxlength = 3 class = "formbox"> %</td>


</tr>
<tr>
<td class = "body2" align = "right"><a class="tooltip" href="#">FW:<span class="custom info"><em><div align = "left">Fleece Weight</div></em></span></a></td>
<td class = "body2" align = "center"><input name="FW" size = "5" maxlength = 9 value="<%=FW%>" class = "formbox"></td>
<td class = "body2" align = "center"><input name="FWAcc" value="<%=FWAcc%>"  size = "5" maxlength = 9 class = "formbox"></td>
<td class = "body2" align = "center"><input name="FWRank" value="<%=FWRank%>"  size = "5" maxlength = 9 class = "formbox"> Of <input name="FWRank2" value="<%=FWRank2%>"  size = "5" maxlength = 9 class = "formbox"></td>
<td class = "body2" align = "center"><input name="FWRankpercent" value="<%= FWRankpercent%>"  size = "1" maxlength = 3 class = "formbox"> %</td>

</tr>






</table>
<%
rs2.close
%>
<table width = "100%" border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0><tr><td class = "body2" align = "left"><font color = #404040">Notes:<br /> Only numbers are allowed in the above fields. Any non-numerical characters will automatically be removed.<br><br />
If you enter Rankings the Top Percent will automatically be calculated. 

</font>
<Input type = hidden name='TotalCount' value = <%=TotalCount%> >	
<Input type =hidden name='ID' value = <%=ID%> >
<br />
<br />
<center><input type=submit value = "SUBMIT EPD CHANGES"  size = "110" Class = "regsubmit2" ></center>
<BR>
	</td>
</tr>
</table></form>
 	</td>
</tr>
</table>
<%conn.close
set Conn = nothing %>
</body>
</html>