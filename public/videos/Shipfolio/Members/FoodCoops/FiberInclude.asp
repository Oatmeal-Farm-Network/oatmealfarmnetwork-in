<% sql2 = "select  * from Fiber where Fiber.ID = " & ID & " order by SampleDateYear DESC, Average DESC,  StandardDev DESC ,  COV DESC, GreaterThan30 DESC , Blanketweight DESC, Shearweight DESC"

				Set rs2 = Server.CreateObject("ADODB.Recordset")
				rs2.Open sql2, conn, 3, 3 
	if not rs2.eof  then
		if ( len(trim(rs2("Average"))) >1 or len(trim(rs2("StandardDev"))) >1 or len(trim(rs2("COV"))) >1 or len(trim(rs2("GreaterThan30"))) >1 	or len(trim(rs2("Blanketweight"))) >1 or len(trim(rs2("Shearweight"))) >1	) then 
		
	
		%>

<a name = "Ancestry"></a>
<table border="0" cellspacing="0" cellpadding ="0" width = "<%=screenwidth - 30 %>" align = "center" >
<tr>
<td align= "center" class = "body roundedtop"><h2>
<% If AdministrationID  = 2 then %>
Fibre Stats
<% else %>
Fiber Stats
<% end if %>
</h2>	</td>
</tr>
<tr>
<td class = "body roundedBottom" align ="left" >

<% While Not rs2.eof  
 	SampleDateMonth	= rs2("SampleDateMonth") 
 	SampleDateDay	= rs2("SampleDateDay") 
	SampleDateYear	= rs2("SampleDateYear") 
	Average	= rs2("Average") 
	StandardDev	= rs2("StandardDev") 
	COV	= rs2("COV")
	GreaterThan30	= rs2("GreaterThan30")
	Blanketweight	= rs2("Blanketweight")
	Shearweight	= rs2("Shearweight")
	CF	= rs2("CF")
	Length	= rs2("Length")
	Curve= rs2("Curve")
	CrimpPerInch= rs2("CrimpPerInch")
	
	if len(Average) > 0 or len(StandardDev) > 0 or len(COV) > 0 or len(GreaterThan30) > 0 or len(Blanketweight) > 0 or len(Shearweight) > 0 or len(CF) > 0 or len(Length) > 0 or len(Curve) > 0 or len(Curve) > 0 or len(CrimpPerInch) > 0 then 
str1 = lcase(Average)
str2 = " micron"
If InStr(str1,str2) > 0 Then
	Average= Replace(str1, str2 , "&#x3BC;")
End If  
	
str1 = lcase(Average)
str2 = "micron"
If InStr(str1,str2) > 0 Then
	Average= Replace(str1, str2 , "&#x3BC;")
End If  
	
	str1 = lcase(StandardDev)
str2 = " micron"
If InStr(str1,str2) > 0 Then
	StandardDev= Replace(str1, str2 , "&#x3BC;")
End If  
	
str1 = lcase(StandardDev)
str2 = "micron"
If InStr(str1,str2) > 0 Then
	StandardDev= Replace(str1, str2 , "&#x3BC;")
End If  

str1 = lcase(COV)
str2 = " micron"
If InStr(str1,str2) > 0 Then
	COV= Replace(str1, str2 , "&#x3BC;")
End If  
	
str1 = lcase(COV)
str2 = "micron"
If InStr(str1,str2) > 0 Then
	COV= Replace(str1, str2 , "&#x3BC;")
End If  
	
str1 = lcase(GreaterThan30)
str2 = " micron"
If InStr(str1,str2) > 0 Then
	GreaterThan30= Replace(str1, str2 , "&#x3BC;")
End If  
	
str1 = lcase(GreaterThan30)
str2 = "micron"
If InStr(str1,str2) > 0 Then
	GreaterThan30= Replace(str1, str2 , "&#x3BC;")
End If 
	
	
	If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
If row = "even" Then %>
<table border = "0" width = "<%=screenwidth - 30 %>"  align = "center" cellpadding = "0" cellspacing = "0">
<% Else %>
<table border = "0" width = "<%=screenwidth - 30 %>"  align = "center"  bgcolor = "#EEDD99" cellpadding = "0" cellspacing = "0">
<% End If %>
<tr>
<td class = "body2" width = "100" valign = "top" align = "center"><% if len(SampleDateMonth) > 0 then %>
<% if SampleDateMonth > 0 then %>
    <%=SampleDateMonth%>/<% end if %>
<% end if %>
<% if len(SampleDateDay) > 0 then %>
<% if SampleDateDay > 0 then %>
<%=SampleDateDay%>/<% end if %>
<% end if %>
<% if len(SampleDateYear) > 0 then %>
<% if SampleDateYear > 0 then %>
<%=SampleDateYear%><% end if %>
<% end if %></td>
<td class = "body2" valign = "top" align = "right" width = "40"><%if len(Average) > 0 then%>AFD:<% end if %></td>
<td class = "body2" width = "70" valign = "top" align = "left"><%=Average%></td>
<td class = "body2" valign = "top" align = "right" width = "90"><%if len(StandardDev) > 0 then%>SD:<% end if %></td>
<td class = "body2" width = "70" valign = "top" align = "left"><%=StandardDev%></td>
<td class = "body2" valign = "top" align = "right" width = "120"><%if len(COV) > 0 then%>COV:<% end if %></td>
<td class = "body2" width = "70" valign = "top" align = "left"><%= COV%></td>
<td class = "body2" valign = "top" align = "right" width = "80"><%if len(GreaterThan30) > 0 then%>%>30&#x3BC;<% end if %></td>
<td class = "body2" width = "70" valign = "top" align = "left"><%=GreaterThan30%></td>
<td class = "body2" valign = "top" align = "right"  width = "70" ><% if len(Curve) >0 then %>Curve:<% end if %></td>
<td class = "body2" width = "70" valign = "top" align = "left"><% if len(Curve)>0 then %><%= Curve%><% end if %></td>
</tr>

<tr>
<td class = "body2" valign = "top" align = "left" ></td>
<td class = "body2" valign = "top" align = "right"><% if len(CF)>0 then %>CF:<% end if %></td>
<td class = "body2" valign = "top" align = "left"><%= CF%></td>
<td class = "body2" valign = "top" align = "right"><% if len(CrimpPerInch)>0 then %>Crimps/Inch:<% end if %></td>
<td class = "body2" valign = "top" align = "left"><%= CrimpPerInch%></td>
<td class = "body2" valign = "top" align = "right" ><% if len(Length)>0 then %>Staple Length:<% end if %></td>
<td class = "body2" valign = "top" align = "left"><%= Length%></td>
<td class = "body2" valign = "top" align = "right"><% if len(ShearWeight)>0 then %>Shear Wt:<% end if %></td>
<td class = "body2" valign = "top" align = "left"><%= ShearWeight%></td>
<td class = "body2" valign = "top" align = "right" ><% if len(BlanketWeight)>0 then %>Blanket Wt:<% end if %></td>
<td class = "body2" valign = "top" align = "left"><%= BlanketWeight%></td>

</tr>
<tr><td colspan = "11" height = "2"></td></tr>
</table>

 
 <% End if
rs2.movenext
Wend 
%>
		  </table>

<%End if%>
<%End if%>

<% sql = "select Animals.FullName, EPDAlpacas.* from Animals, EPDAlpacas where  EPDAlpacas.AnimalID = " & ID
'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if Not rs.eof  then %>


<%  AnimalID=   rs("AnimalID")
AFD =   rs("AFD")
AFDAcc =   rs("AFDAcc")
AFDRank =   rs("AFDRank")
AFDRank2 =   rs("AFDRank2")

if len(AFDRank) > 1 and len(AFDRank2) > 1 then
AFDRankPercent = left((AFDRank /AFDRank2) * 100,2)
end if
SDAFD =   rs("SDAFD")
SDAFDAcc =   rs("SDAFDAcc")
SDAFDRank =   rs("SDAFDRank")
SDAFDRank2 =   rs("SDAFDRank2")
if len(SDAFDRank) > 1 and len(SDAFDRank2) > 1 then
SDAFDRankPercent = left((SDAFDRank /SDAFDRank2) * 100,2)
end if
SF =   rs("SF")
SFAcc =   rs("SFAcc")
SFRank =   rs("SFRank")
SFRank2 =   rs("SFRank2")
if len(SFRank) > 1 and len(SFRank2) > 1 then
SFRankPercent = left((SFRank /SFRank2) * 100,2)
end if

PercentFGreaterThan30 = rs("PercentFGreaterThan30")
percentFgreaterThan30Acc =   rs("percentFgreaterThan30Acc")
percentFGreaterThan30Rank =   rs("percentFGreaterThan30Rank")
percentFGreaterThan30Rank2 =   rs("percentFGreaterThan30Rank2")
if len(percentFGreaterThan30Rank) > 1 and len(percentFGreaterThan30Rank2) > 1 then
percentFGreaterThan30RankPercent = left((percentFGreaterThan30Rank /percentFGreaterThan30Rank2) * 100,2)
end if

MC =   rs("MC")
MCAcc =   rs("MCAcc")
MCRank =   rs("MCRank")
MCRank2 =   rs("MCRank2")
if len(MCRank) > 1 and len(MCRank2) > 1 then
MCRankPercent = left((MCRank /MCRank2) * 100,2)
end if


SDMC =   rs("SDMC")
SDMCAcc =   rs("SDMCAcc")
SDMCRank =   rs("SDMCRank")
SDMCRank2 =   rs("SDMCRank2")
if len(SDMCRank) > 1 and len(SDMCRank2) > 1 then
SDMCRankPercent = left((SDMCRank /SDMCRank2) * 100,2)
end if

PercentM =   rs("PercentM")
PercentMAcc =   rs("PercentMAcc")
PercentMRank =   rs("PercentMRank")
PercentMRank2 =   rs("PercentMRank2")
if len(PercentMRank) > 1 and len(PercentMRank2) > 1 then
PercentMRankPercent = left((PercentMRank /PercentMRank2) * 100,2)
end if

MSL =   rs("MSL")
MSLAcc =   rs("MSLAcc")
MSLRank =   rs("MSLRank")
MSLRank2 =   rs("MSLRank2")
if len(MSLRank) > 1 and len(MSLRank2) > 1 then
MSLRankPercent = left((MSLRank /MSLRank2) * 100,2)
end if



FW =   rs("FW")
FWAcc =   rs("FWAcc")
FWRank =   rs("FWRank")
FWRank2 =   rs("FWRank2")
if len(FWRank) > 1 and len(FWRank2) > 1 then
FWRankPercent = left((FWRank /FWRank2) * 100,2)
end if



BW =   rs("BW")
BWAcc =   rs("BWAcc")
EPDDate =   rs("EPDDate")
 end if

 if len(AFD) > 0 or len(AFDAcc) > 0 or len(AFDRank) > 0 or len(SDAFD) > 0 or len(SDAFDAcc) > 0 or len(SDAFDRank) > 0 or len(SF) > 0 or len(SFAcc) > 0 or len(SFRank) > 0 or len(PercentFGreaterThan30) > 0 or len(percentFgreaterThan30Acc) > 0 or len(percentFGreaterThan30Rank ) > 0 or len(MC ) > 0 or len(MCAcc) > 0 or len(MCRank) > 0 or len(SDMC) > 0 or len(SDMCAcc ) > 0 or len(SDMCRank ) > 0 or len(PercentM) > 0 or len(PercentMAcc) > 0 or len(PercentMRank) > 0 or len(MSL) > 0 or len(MSLAcc) > 0 or len(MSLRank) > 0 then
%>

<br>
<a name="EPD"></a>
<table border="0" cellspacing="2" width = "<%=screenwidth - 30 %>" align = "center" >
<tr>
<td align= "center" class = "body"><h2>EPDs</h2>	</td>
</tr>
<tr>
<td class = "body" align ="left" bgcolor = "black" height = "1" colspan = "3"></td>
</tr>
</table>
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 30 %>"  ><tr><td  align = "left">
<input type = "hidden" name="AnimalID" value="<%=AnimalID%>" >
<table border = "0" width = "100%"  align = "center">
<tr bgcolor = "#EEDD99">
<td class = "body2" align = 'right'><div align ="right"><b>Trait</b></div></td>
<%
show1percent = False
if (AFDRankPercent < 1.1 and AFDRankPercent >0) or ( SDAFDRankPercent  < 1.1 and SDAFDRankPercent > 0) or (SFRankPercent < 1.1 and SFRankPercent > 0) or (percentFGreaterThan30RankPercent < 1.1 and percentFGreaterThan30RankPercent> 0) or  (MCRankPercent < 1.1 and MCRankPercent> 0) or (SDMCRankPercent < 1.1 and SDMCRankPercent> 0) or  (PercentMRankPercent < 1.1 and PercentMRankPercent > 0) or  ( MSLRankPercent  < 1.1 and MSLRankPercent > 0 ) or (FWRankPercent  < 1.1 and FWRankPercent > 0) then%>
<% show1percent = True %>
<td class = "body2" align = "center" width = 75><b>
<a class="tooltip" href="#">%1<span class="custom info"><em><div align = "left">Ranked at 1% or better for a trait.</div></em></span></a>

<% end if %>
<td class = "body2" align = 'center'><div align ="center"><b>Value</b></div></td>
<td class = "body2"><div align ="center"><b>Accuracy</b></div></td>
<td class = "body2" align = 'center' ><div align ="center"><b>Rank</b></div></td>
</tr>
<tr>
<td class = "body2" align = "right"><a class="tooltip" href="#">AFD<span class="custom info"><em><div align = "left">Average Fiber Diameter (microns)</div></em></span></a></td>

<% if show1percent = True then %>
<td class = "body2" align = "center">
<%if SDAFDRankPercent < 1.1 then%>
<font color = maroon size = 5>&#x2714</font>
<% end if %>
</td>
<% end if %>

<td class = "body2" align = "center"><%=AFD%></td>
<td class = "body2" align = "center"><%= AFDAcc%></td>
<td class = "body2" align = "center"><%= AFDRank%>
<%if len(AFDRank2)> 0 then %>
 of <%=AFDRank2%>
 <% end if %>
</td>
</tr>
<tr bgcolor = "#EEDD99">

<td class = "body2" align = "right"><a class="tooltip" href="#">SD AFD<span class="custom info"><em><div align = "left">Standard Deviation (microns)</div></em></span></a></td>
<% if show1percent = True then %>
<td class = "body2" align = "center">
<%if SDAFDRankPercent < 1.1 then%>
<font color = maroon size = 5>&#x2714</font>
<% end if %>
</td>
<% end if %>
<td class = "body2" align = "center"><%=SDAFD%></td>
<td class = "body2" align = "center"><%= SDAFDAcc%></td>
<td class = "body2" align = "center"><%= SDAFDRank%> 
<%if len(SDAFDRank2)> 0 then %>
 of <%=SDAFDRank2%>
 <% end if %>
</td>
</tr>
<tr>

<td class = "body2" align = "right"><a class="tooltip" href="#">%F>30m:<span class="custom info"><em><div align = "left">Percent of Fibers larger than 30 microns (%)</div></em></span></a></td>
<% if show1percent = True then %>
<td class = "body2" align = "center">
<%if percentFGreaterThan30RankPercent < 1.1 then%>
<font color = maroon size = 5>&#x2714</font>
<% end if %>
</td>
<% end if %>

<td class = "body2" align = "center"><%=PercentFGreaterThan30%></td>
<td class = "body2" align = "center"><%=percentFgreaterThan30Acc%></td>
<td class = "body2" align = "center"><%=percentFGreaterThan30Rank%> 
<%if len(percentFGreaterThan30Rank2)> 0 then %>
 of <%=percentFGreaterThan30Rank2%>
 <% end if %>
</td>

</tr>
<tr bgcolor = "#EEDD99">
<td class = "body2" align = "right"><a class="tooltip" href="#">SF:<span class="custom info"><em><div align = "left">Spin Fineness (microns)</div></em></span></a></td>
<% if show1percent = True then %>
<td class = "body2" align = "center">
<%if SFRankPercent < 1.1 then%>
<font color = maroon size = 5>&#x2714</font>
<% end if %>
</td>
<% end if %>
<td class = "body2" align = "center"><%=SF%></td>
<td class = "body2" align = "center"><%=SFAcc%></td>
<td class = "body2" align = "center"><%= SFRank%>
<%if len(SFRank2)> 0 then %>
 of <%=FWRank2%>
 <% end if %>
</td>
</tr>
<tr>
<td class = "body2" align = "right"><a class="tooltip" href="#">FW:<span class="custom info"><em><div align = "left">Fleece Weight</div></em></span></a></td>
<% if show1percent = True then %>
<td class = "body2" align = "center">
<%if FWRankPercent < 1.1 then%>
<font color = maroon size = 5>&#x2714</font>
<% end if %>
</td>
<% end if %>
<td class = "body2" align = "center"><%=FW%></td>
<td class = "body2" align = "center"><%=FWAcc%></td>
<td class = "body2" align = "center"><%=FWRank%>
<%if len(FWRank2)> 0 then %>
 of <%=FWRank2%>
 <% end if %>
</td>
</tr>
<tr bgcolor = "#EEDD99">
<td class = "body2" align = "right"><a class="tooltip" href="#">SL:<span class="custom info"><em><div align = "left">Mean Staple Length (mm)</div></em></span></a></td>
<% if show1percent = True then %>
<td class = "body2" align = "center">
<%if MSLRankPercent < 1.1 then%>
<font color = maroon size = 5>&#x2714</font>
<% end if %>
</td>
<% end if %>
<td class = "body2" align = "center"><%=MSL%></td>
<td class = "body2" align = "center"><%=MSLAcc%></td>
<td class = "body2" align = "center"><%=MSLRank%>
<%if len(MSLRank2)> 0 then %>
 of <%=MSLRank2%>
 <% end if %>
</td>
</tr>


<tr>
<td class = "body2" align = "right"><a class="tooltip" href="#">MC:<span class="custom info"><em><div align = "left">Mean Curvature (deg/mm)</div></em></span></a></td>
<% if show1percent = True then %>
<td class = "body2" align = "center">
<%if MCRankPercent < 1.1 then%>
<font color = maroon size = 5>&#x2714</font>
<% end if %>
</td>
<% end if %>
<td class = "body2" align = "center"><%=MC%></td>
<td class = "body2" align = "center"><%=MCAcc%></td>
<td class = "body2" align = "center"><%=MCRank%>
<%if len(MCRank2)> 0 then %>
 of <%=MCRank2%>
 <% end if %>
</td>
</tr>
<tr bgcolor = "#EEDD99">
<td class = "body2" align = "right"><a class="tooltip" href="#">SD C:<span class="custom info"><em><div align = "left">Standard Deviation of Curvature</div></em></span></a></td>
<% if show1percent = True then %>
<td class = "body2" align = "center">
<%if SDMCRankPercent < 1.1 then%>
<font color = maroon size = 5>&#x2714</font>
<% end if %>
</td>
<% end if %>
<td class = "body2" align = "center"><%=SDMC%></td>
<td class = "body2" align = "center"><%=SDMCAcc%></td>
<td class = "body2" align = "center"><%=SDMCRank%>
<%if len(SDMCRank2)> 0 then %>
 of <%=SDMCRank2%>
 <% end if %>
</td>
</tr>
<tr>
<td class = "body2" align = "right"><a class="tooltip" href="#">%M:<span class="custom info"><em><div align = "left">Percent Medullation (%)</div></em></span></a></td>
<% if show1percent = True then %>
<td class = "body2" align = "center">
<%if PercentMRankPercent < 1.1 then%>
<font color = maroon size = 5>&#x2714</font>
<% end if %>
</td>
<% end if %>
<td class = "body2" align = "center"><%=PercentM%></td>
<td class = "body2" align = "center"><%=PercentMAcc%></td>
<td class = "body2" align = "center"><%=PercentMRank%> 
<%if len(PercentMRank2)> 0 then %>
 of <%=PercentMRank2%>
 <% end if %>
 </td>
</tr>
</table>

 	</td>
</tr>
</table><%
end if
rs.close
%>
<br />
