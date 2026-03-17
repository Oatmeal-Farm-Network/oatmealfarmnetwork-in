<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title><%=Sitenamelong %> Membersistration</title>
<meta name="Title" content="<%=Sitenamelong %> Membersistration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>


</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="MembersGlobalVariables.asp"-->
<% Current2="AniamlsHome"
Current3 = "UploadAlpacaEDP" %> 
<!--#Include file="MembersHeader.asp"-->
<!--#Include file="MembersAnimalsTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width="<%=screenwidth %>" ><tr><td class = "roundedtopandbottom" align = "left">
<H1><div align = "left">EPDs</div></H1>
<table border = "0" bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td  valign = "top" class = "body">
<table border = "0" width = "800"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td width = "475" valign = "top" class = "body">
<%   sql = "select Animals.FullName, animals.SpeciesID, EPDAlpacas.* from Animals, EPDAlpacas where  EPDAlpacas.AnimalID = EPDAlpacas.animalID and  PeopleID = " & Session("PeopleID") & " order by FullName"
'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  
if rs.eof then %>
Currently you do not have any animals listed. To add animals please select the <a href = "MembersAnimalAdd1.asp" class = "body">Add Animals</a> tab.
<% else    
rowcount = 1
dim ID(99999) 
dim AnimalID(99999) 
dim AFD(99999) 
dim AFDAcc(99999) 
dim AFDRank(99999) 
dim SDAFD(99999) 
dim SDAFDAcc(99999) 
dim SDAFDRank(99999) 
dim SF(99999) 
dim SFAcc(99999) 
dim SFRank(99999) 
dim PercentFGreaterThan30(99999) 
dim percentFgreaterThan30Acc(99999) 
dim percentFGreaterThan30Rank(99999) 
dim MC(99999) 
dim MCAcc(99999) 
dim MCRank(99999) 
dim SDMC(99999) 
dim SDMCAcc(99999) 
dim SDMCRank(99999) 
dim PercentM(99999) 
dim PercentMAcc(99999) 
dim PercentMRank(99999) 
dim MSL(99999) 
dim MSLAcc(99999) 
dim MSLRank(99999) 
dim FW(99999) 
dim FWAcc(99999) 
dim FWRank(99999) 
dim BW(99999) 
dim BWAcc(99999) 
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "right" ><tr><td class = "roundedtop" align = "left">
		<H3><div align = "left">Key</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<table border = "0" cellpadding = "0" cellspacing="0"  align = "right">
 <tr>
 
  <td class = "body" width = "30" align = "right"><img src= "images/edit.gif" alt = "edit" height = "18"  border = "0"></td>
 <td class = "body" width=  "35">Edit</td>
 
   <td class = "body" width = "30" align = "right"></td>
 <td class = "body" width=  "40" align = "left"></td>
   
    <td></td>
    
    </tr>
</table>
</td>
</tr>
</table>
<table width = "900"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
<td><br><br>
<table width = "900"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr bgcolor = "antiquewhite">
<td class = "body" align = "center" ><b>Name</b></td>
<td class = "body2" align = "center" ><b><a class="tooltip" href="#">AFD<span class="custom info"><em><div align = "left">Average Fiber Diameter (microns)</div></em></span></a></b></td>
<td class = "body2" align = "center" ><b><a class="tooltip" href="#">SD AFD<span class="custom info"><em><div align = "left">Standard Deviation (microns)</div></em></span></a></b></td>
<td class = "body2" align = "center" ><b><a class="tooltip" href="#">%F>30m:<span class="custom info"><em><div align = "left">Percent of Fibers larger than 30 microns (%)</div></em></span></a></b></td>
<td class = "body2" align = "center" ><b><a class="tooltip" href="#">SF<span class="custom info"><em><div align = "left">Spin Fineness (microns)</div></em></span></a></b></td>
<td class = "body2" align = "center" ><b><a class="tooltip" href="#">FW:<span class="custom info"><em><div align = "left">Fleece Weight</div></em></span></a></b></td>
<td class = "body2" align = "center" ><b><a class="tooltip" href="#">SL:<span class="custom info"><em><div align = "left">Mean Staple Length (mm)</div></em></span></a></b></td>
<td class = "body2" align = "center" ><b><a class="tooltip" href="#">MC:<span class="custom info"><em><div align = "left">Mean Curvature (deg/mm)</div></em></span></a></b></td>
<td class = "body2" align = "center" ><b><a class="tooltip" href="#">SD C:<span class="custom info"><em><div align = "left">Standard Deviation of Curvature</div></em></span></a></b></td>
<td class = "body2" align = "center" ><b><a class="tooltip" href="#">%M:<span class="custom info"><em><div align = "left">Percent Medullation (%)</div></em></span></a></b></td>
</tr>
<%
row = "odd"
 While  Not rs.eof  
    If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if

AnimalID(rowcount)=   rs("AnimalID")
AFD(rowcount)=  rs("AFD")
AFDAcc(rowcount)=  rs("AFDAcc")
AFDRank(rowcount)=  rs("AFDRank")
SDAFD(rowcount)=   rs("SDAFD")
SDAFDAcc(rowcount) =   rs("SDAFDAcc")
SDAFDRank(rowcount) =   rs("SDAFDRank")
SF(rowcount) =   rs("SF")
SFAcc(rowcount) =   rs("SFAcc")
SFRank(rowcount) =   rs("SFRank")
PercentFGreaterThan30(rowcount) = rs("PercentFGreaterThan30")
percentFgreaterThan30Acc(rowcount) =   rs("percentFgreaterThan30Acc")
percentFGreaterThan30Rank(rowcount) =   rs("percentFGreaterThan30Rank")
MC(rowcount) =   rs("MC")
MCAcc(rowcount) =   rs("MCAcc")
MCRank(rowcount) =   rs("MCRank")
SDMC(rowcount) =   rs("SDMC")
SDMCAcc(rowcount) =   rs("SDMCAcc")
SDMCRank(rowcount) =   rs("SDMCRank")
PercentM(rowcount) =   rs("PercentM")
PercentMAcc(rowcount) =   rs("PercentMAcc")
PercentMRank(rowcount) =   rs("PercentMRank")
MSL(rowcount) =   rs("MSL")
MSLAcc(rowcount) =   rs("MSLAcc")
MSLRank(rowcount) =   rs("MSLRank")
FW(rowcount) =   rs("FW")
FWAcc(rowcount) =   rs("FWAcc")
FWRank(rowcount) =   rs("FWRank")
BW(rowcount) =   rs("BW")
BWAcc(rowcount) =   rs("BWAcc")



    SpeciesName = ""
SpeciesID(rowcount) = rs("SpeciesID")
if SpeciesID(rowcount) = 2 then
SpeciesName="Alpaca" 
end if 
if SpeciesID(rowcount) = 3 then
SpeciesName="Dog"
end if 
if SpeciesID(rowcount) = 4 then
SpeciesName="Llama"
end if 
if SpeciesID(rowcount) = 5 then
SpeciesName="Horse"
end if 
if SpeciesID(rowcount) = 6 then
SpeciesName="Goat"
end if 
if SpeciesID(rowcount) = 7 then
SpeciesName="Donkey"
end if 
if SpeciesID(rowcount) = 8 then
SpeciesName="Cattle"
end if 
if SpeciesID(rowcount) = 9 then
SpeciesName="Bison"
end if 
if SpeciesID(rowcount) = 10 then
SpeciesName="Sheep"
end if 
if SpeciesID(rowcount) = 11 then
SpeciesName="Rabbit"
end if 
if SpeciesID(rowcount) = 12 then
SpeciesName="Pig"
end if 
if SpeciesID(rowcount) = 13 then
SpeciesName="Chicken"
end if 
if SpeciesID(rowcount) = 14 then
SpeciesName="Turkey"
end if 
if SpeciesID(rowcount) = 15 then
SpeciesName="Duck"
end if 
if  SpeciesID(rowcount) = 16 then
SpeciesName="Cat"
end if 
showstats = True
 If row = "even" Then %>
<tr>
<% Else %>
<tr bgcolor = "antiquewhite" >
<%	End If %>
		

	</td>
	<td class = "body" width = "250" align = "left">
		<a href = "EditAnimal.asp?ID=<%= ID( rowcount)%>#BasicFacts" class = "body"><%= Name( rowcount)%></a>
	</td>
    <td class = "body" align = "center">
		<%=AFD(rowcount) %>
	</td>
	<td class = "body" align = "center">
		<% if PublishForSale(rowcount) = True then%>&#10003;<% end if %>
	</td>
		<td class = "body" align = "center">
		<% if PublishStud(rowcount) = True then%>&#10003;<% end if %>
	</td>
		<td class = "body" align = "center">
		<% if Forsale( rowcount) = True then%>&#10003;<% end if %>
	</td>
		<td class = "body" width = "160" align = "right">
		<% if len(Price(rowcount)) > 1 then%>
		    <%= formatcurrency(Price(rowcount))%>
		    <% if Discount(rowcount)> 1 then %> 
		        (<i><%=  formatcurrency((Price(rowcount) - (Price(rowcount) * (Discount(rowcount)/100))), 2)%></i>)
		     <% end if %>
		 <% else %>    
		    Call For Price
		   <% end if %>

	</td>
			<td class = "body" width = "100" align = "right">
		   <% if StudFee(rowcount)> 1 then %>
		     <%= formatcurrency(StudFee(rowcount),2)%>
		    <% else %>
		    N/A
		    <% end if %>&nbsp;
	</td>
	
		<td class = "body" align = "center" ><a href = "Editanimal.asp?ID=<%= ID( rowcount)%>#BasicFacts" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "MembersPhotos.asp?ID=<%= ID( rowcount)%>" class = "body"><img src= "images/Photo.gif" alt = "edit" height ="14" border = "0"></a><br>
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


</table>

<br>

</td>
</tr>
</table>
</td>
</tr>

</table>
<% end if %>
</td>
</tr>
</table>
</td>
</tr>
</table>
<br>

 <!--#Include virtual="/Footer.asp"--> 

</BODY>
</HTML>