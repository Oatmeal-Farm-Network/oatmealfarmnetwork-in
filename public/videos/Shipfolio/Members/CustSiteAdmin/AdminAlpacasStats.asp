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
<!--#Include file="AdminHeader.asp"--> 
<% Current3 = "AnimalStats"  %> 
 <!--#Include file="AdminAnimalsTabsInclude.asp"-->
<% if screenwidth < 989 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth -35 %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -35 %>">
<% end if %><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Animal Statistics</div></H1>
</td></tr>
<tr><td class = "roundedBottom body" align = "center" width  "100%">
The statistics below show the number of page hits each animal has received over a set period of time.<br /><br />
<table border = "0" width = "100%"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td   height = "300" valign = "top">

<%  sql = "select distinct Pricing.*, animals.ID, FullName from Animals, Pricing where Animals.ID =Pricing.ID  order by FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3  
    
    if rs.eof then %>

Currently you do not have any animals entered. To add anmals please select the <a href = "AdminAnimalAdd1.asp" class = "body">Add an Animal</a> tab.
      
<%	else 
	rowcount = 1
dim ID(99999) 
dim ProdID(99999)
dim PackageID(99999)
dim Name(99999)  
dim Price(99999) 
dim StudFee(99999) 
dim ForSale(99999) 
dim ShowOnWebsite(99999) 
dim Discount(99999)

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
<div id='interstitial' align = "center">
   <img src="/administration/images/Loading.gif" width="50" height="50" alt="Loading ... Please wait... " />
</div>

<script language="javascript">
    setTimeout('interstitial.style.display="none";', 30000);
</script>

<%
response.flush
%>
<table width = "100%"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
	  <td>
<table width = "100%"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr  bgcolor = "dddddd">
			<td class = "body2" align = "center" width = "380"><b>Name</b></td>
			<td class = "body2" align = "center" width = "65" ><b><%=year(now)-1 %></b></td>
			<td class = "body2" align = "center" width = "65" ><b><%=year(now) %>*</b></td>
			<td class = "body2" align = "center" width = "65" ><b>2 Months Ago</b></td>
			<td class = "body2" align = "center" width = "65" ><b>Last Month</b></td>
			<td class = "body2" align = "center"  width = "65" ><b><%=  MonthName(month(now)) %>*</b></td>
			<td class = "body2" align = "center"  width = "115"><b>In Last Week*</b></td>
			<td class = "body2" align = "center" ><b>Yesterday</b></td>
	</tr>

<%
row = "odd"
 While  Not rs.eof  
    If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
	ID(rowcount) =   rs("animals.ID")
	Name(rowcount) =   rs("FullName")
	Price(rowcount) =   rs("Price")
	StudFee(rowcount) =   rs("StudFee")
	ForSale(rowcount) =   rs("ForSale")
	ShowOnWebsite(rowcount) =   rs("ShowOnWebsite")
	Discount(rowcount) =   rs("Discount")
showstats = True
 If row = "even" Then %>
<tr>
<% Else %>
<tr bgcolor = "dddddd" >
<%	End If %>
		

	</td>
	<td class = "body" width = "250" align = "left">
		<a href = "AdminAnimalEdit.asp?ID=<%= ID( rowcount)%>#BasicFacts" class = "body"><%= Name( rowcount)%></a>
	</td>
		
	<td class = "body2" align = "center" >
<% 
Set rs2 = Server.CreateObject("ADODB.Recordset")
if showstats = true then
sql = "SELECT animalID FROM stats WHERE year(Statdate)=(year(DateAdd('y',1,now))-1) and AnimalID = " & ID(rowcount) 
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
sql = "select animalID from StatsYear where year(statdate)  = year(now) and AnimalID = " &		ID(rowcount) 
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
sql = "select animalID from StatsTwoMonthsAgo where year(statdate)  = year(now) and AnimalID = " &		ID(rowcount) 
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

sql = "select animalID from StatsLastMonth where year(statdate)  = year(now) and AnimalID = " &		ID(rowcount) 
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

sql = "select animalID from StatsThisMonth where year(statdate)  = year(now) and AnimalID = " &		ID(rowcount) 
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

sql = "select animalID from StatsLastWeek where year(statdate) = year(now) and AnimalID = " &		ID(rowcount) 
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

	sql = "SELECT animalID FROM stats WHERE Statdate=DateAdd('d',-1,now) and year(statdate)  = year(now) and AnimalID = " & ID(rowcount) 
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

 %>

	<tr bgcolor = "dddddd">
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
<i>* inidicates so far in this week or month.</i>
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
<br><br />
 <!--#Include virtual="/administration/adminFooter.asp"--> 
 <script language="javascript">
     interstitial.style.display = "none";
</script>
</BODY>
</HTML>