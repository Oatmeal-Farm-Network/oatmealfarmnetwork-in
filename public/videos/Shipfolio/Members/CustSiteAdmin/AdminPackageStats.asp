<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

 <link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->

</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
    <% 
   Current2="Packages"
   Current3="PackagesStats" %> 

<!--#Include file="AdminHeader.asp"--> 
<br />
<!--#Include file="AdminPackagesTabsInclude.asp"-->
<% if screenwidth < 989 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth -35 %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -35 %>">
<% end if %>


<tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Package Statistics</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "960">
<br />

<table border = "0" width = "100%"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td  valign = "top">

<%  
sql = "select * from Package order by PackageName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
dim PackageID(99999) 
dim PackageName(99999)  
dim PackageValue(99999) 
dim BreedType(99999) 
dim PackageOBO(99999) 
dim ShowOnAPackages(99999) 
dim PackagePrice(99999)


TotalHitsLastYear  = 0	
TotalHitsThisYear  = 0	
TotalHitsTwoMonthsAgo  = 0	
TotalHitsLastMonth  = 0	
TotalHitsThisMonth  = 0	
TotalHitsThisWeek  = 0	
TotalHitsYesterday = 0	
TotalHitsYesterday = 0			

%>

<% Response.Buffer = True %>
<div id='interstitial'>
   <img src="/images/Loading.gif" width="50" height="50" alt="Loading ... Please wait... " />
</div>

<script language="javascript">
    setTimeout('interstitial.style.display="none";', 3000);
</script>

<%
response.flush
%>

<table border = "0" width = "100%"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td  valign = "top">

<%  sql = "select distinct Packageid, PackageName, PackagePrice  from Package order by PackageName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1

TotalHitsLastYear  = 0	
TotalHitsThisYear  = 0	
TotalHitsTwoMonthsAgo  = 0	
TotalHitsLastMonth  = 0	
TotalHitsThisMonth  = 0	
TotalHitsThisWeek  = 0	
TotalHitsYesterday = 0	
TotalHitsYesterday = 0			


response.flush
%>
<table width = "100%"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
	  <td>
<table width = "100%"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr >
			<td class = "body2" align = "center" width = "380" bgcolor = "#dddddd"><b>Package Name</b></td>
			<td class = "body2" align = "center" width = "65" bgcolor = "#dddddd"><b><%=year(now)-1 %></b></td>
			<td class = "body2" align = "center" width = "65" bgcolor = "#dddddd"><b><%=year(now) %>*</b></td>
			<td class = "body2" align = "center" width = "65" bgcolor = "#dddddd"><b>
<% if month(now) > 2 then %>
<%=MonthName(month(now)-2) %> 
<% else 
  if month(now) = 1 then %>
  November
  <% end if %>
<% if month(now) = 2 then %>
  December
  <% end if %>
<% end if %>
</b></td>
			<td class = "body2" align = "center" width = "65" bgcolor = "#dddddd"><b>
    
<% if month(now) > 1 then %>
<%=MonthName(month(now)-1) %> 
<% else 
  if month(now) = 1 then %>
  December
  <% end if %>
<% end if %>
</b></td>
			<td class = "body2" align = "center"  width = "65" bgcolor = "#dddddd"><b><%=  MonthName(month(now)) %>*</b></td>
			<td class = "body2" align = "center"  bgcolor = "#dddddd" width = "115"><b>In Last Week*</b></td>
			<td class = "body2" align = "center" bgcolor = "#dddddd"><b>Yesterday</b></td>
	</tr>

<%
row = "odd"
 While  Not rs.eof  
    If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
	Packageid(rowcount) =   rs("Packageid")
	 PackageName(rowcount) =   rs("PackageName")
	PackagePrice(rowcount) =   rs("PackagePrice")
showstats = True
 If row = "even" Then %>
<tr>
<% Else %>
<tr bgcolor = "#dddddd" >
<%	End If %>
		

	</td>
	<td class = "body2" width = "250" align = "left">
		<a href = "AdminAddaPackageStep4.asp?PackageID=<%= PackageID( rowcount)%>" class = "body"><%= PackageName( rowcount)%></a>
	</td>
		
	<td class = "body2" align = "center" >
<% 
Set rs2 = Server.CreateObject("ADODB.Recordset")
if showstats = true then
sql = "SELECT Packageid FROM stats WHERE year(statdate)  = year(now) and year(Statdate)=(year(DateAdd('y',1,now))-1) and Packageid = " & Packageid(rowcount) 
	rs2.Open sql, conn, 3, 3   	
	If Not rs2.eof then			
		response.write(rs2.recordcount)
		TotalHitsLastYear  = TotalHitsLastYear + rs2.recordcount
	Else
		response.write("0")									
	End If 
	rs2.close 
	end if
	%>
			</td>
	<td class = "body2" align = "center" >
	<% 
	if showstats = true then
sql = "select Packageid from StatsYear where year(statdate)  = year(now) and Packageid = " &	Packageid(rowcount) 
	rs2.Open sql, conn, 3, 3   	
	If Not rs2.eof then			
		response.write(rs2.recordcount)
		TotalHitsThisYear  = TotalHitsThisYear  + rs2.recordcount
	Else
		response.write("0")									
	End If 
	rs2.close 
	
	end if %>
			</td>
<td class = "body2" align = "center" >
<% 

if showstats = true then
sql = "select Packageid from StatsTwoMonthsAgo where year(statdate)  = year(now) and Packageid = " &	Packageid(rowcount) 
	rs2.Open sql, conn, 3, 3   	
	If Not rs2.eof then			
		response.write(rs2.recordcount)
		TotalHitsTwoMonthsAgo = TotalHitsTwoMonthsAgo + rs2.recordcount
	Else
		response.write("0")									
	End If 
	rs2.close
	end if %>
			</td>
	<td class = "body2" align = "center" >
<% 
if showstats = true then

sql = "select Packageid from StatsLastMonth where year(statdate)  = year(now) and Packageid = " &	Packageid(rowcount) 
	rs2.Open sql, conn, 3, 3   	
	If Not rs2.eof then			
		response.write(rs2.recordcount)
		TotalHitsLastMonth = TotalHitsLastMonth + rs2.recordcount
	Else
		response.write("0")									
	End If 
	rs2.close
	end if %>
			</td>				
			
	<td class = "body2" align = "center" >
<% 
if showstats = true then

sql = "select Packageid from StatsThisMonth where year(statdate)  = year(now) and Packageid = " &	 Packageid(rowcount) 
	rs2.Open sql, conn, 3, 3   	
	If Not rs2.eof then			
		response.write(rs2.recordcount)
		TotalHitsThisMonth  = TotalHitsThisMonth  + rs2.recordcount
	Else
		response.write("0")									
	End If 
	rs2.close
	
	end if %>
			</td>
			<td class = "body2" align = "center" >
<% 
if showstats = true then

sql = "select Packageid from StatsLastWeek where year(statdate)  = year(now) and Packageid = " &	Packageid(rowcount) 
	rs2.Open sql, conn, 3, 3   	
	If Not rs2.eof then			
		response.write(rs2.recordcount)
		TotalHitsThisWeek =  TotalHitsThisWeek + rs2.recordcount
	Else
		response.write("0")									
	End If 
	rs2.close 
	end if
	%>
			</td>
			<td class = "body2" align = "center" >

<% 
' if showstats = true then

	sql = "SELECT Packageid FROM stats where year(statdate)  = year(now) and Statdate=DateAdd('d',-1,now) and Packageid = " & Packageid(rowcount) 
	rs2.Open sql, conn, 3, 3   	
	If Not rs2.eof then			
		response.write(rs.recordcount)
		Yesterdayhits = rs2.recordcount
		TotalHitsYesterday = TotalHitsYesterday + Yesterdayhits
	Else
		response.write("0")									
	End If 
	rs2.close
	
	'end if

		rowcount = rowcount + 1
	   rs.movenext

	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing

 %>

	<tr bgcolor = "#dddddd">
			<td class = "body2" align = "Right" ><b>Totals:</b></td>
			<td class = "body2" align = "center" ><b><%=TotalHitsLastYear %></b></td>
			<td class = "body2" align = "center" ><b><%=TotalHitsThisYear %></b></td>
			<td class = "body2" align = "center" ><b><%=TotalHitsTwoMonthsAgo %></b></td>
			<td class = "body2" align = "center" ><b><%=TotalHitsLastMonth %></b></td>
			<td class = "body2" align = "center" ><b><%=TotalHitsThisMonth %></b></td>
			<td class = "body2" align = "center" ><b><%=TotalHitsThisWeek %></b></td>
			<td class = "body2" align = "center" ><b><%=TotalHitsYesterday %></b></td>
	</tr>
</table>

<br>

</td>
</tr>
</table>
</td>
</tr>
<tr>
<td class = "body" align = "left">
<i>* indicates the number of hits in this time frame, so far (i.e. the hits for this year will start at 0 hits on January 1st). </i>
<br>
<br>
</td>
</tr>
</table>
</td>
</tr>
</table>
<br>

 <script language="javascript">
     interstitial.style.display = "none";
</script>
</td>
</tr>
</table>
 <!--#Include file="adminFooter.asp"--> 

</BODY>
</HTML>