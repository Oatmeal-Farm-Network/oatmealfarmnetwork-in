<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>

</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="MembersGlobalVariables.asp"-->
<% 
   Current2="AlpacasHome"
   Current3="AlpacaStats" %> 
   <!--#Include file="MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If   	%>
<br />
<!--#Include file="MembersAnimalsTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Alpaca Statistics</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center">
<br />
<table border = "0" width = "920"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td width = "475"  height = "300" valign = "top">

<%  sql = "select distinct Pricing.*, animals.ID, FullName from Animals, Pricing where Animals.ID =Pricing.ID and  PeopleID = " & Session("PeopleID") & " order by FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3  
    
    if rs.eof then %>

        Currently you do not have any alpacas entered. To add alpacas please select the <a href = "MembersAnimalAdd1.asp" class = "body">Add Alpaca</a> tab.
      
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
<div id='interstitial'>
   <img src="/images/Loading.gif" width="50" height="50" alt="Loading ... Please wait... " />
</div>

<script language="javascript">
    setTimeout('interstitial.style.display="none";', 30000);
</script>

<%
response.flush
%>
<table width = "<%=screenwidth %>"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
	  <td>
<table width = "<%=screenwidth %>"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr bgcolor = "antiquewhite">
			<td class = "body" align = "center" width = "380"><b>Name</b></td>
			<td class = "body" align = "center" width = "65" bgcolor = "antiquewhite"><b><%=year(now)-1 %></b></td>
			<td class = "body" align = "center" width = "65" bgcolor = "antiquewhite"><b><%=year(now) %>*</b></td>
			<% 
			if month(now) = 1 then
			   TwoMonthsAgo = 11
			   OneMonthAgo = 12
			end if
			if month(now) = 2 then
			   TwoMonthsAgo = 12
			   OneMonthAgo = 1
			end if
			if month(now) > 2 then
			   TwoMonthsAgo = month(now)-2
			   OneMonthAgo = month(now)-1
			end if
  %>
			<td class = "body" align = "center" width = "65" bgcolor = "antiquewhite"><b><%=MonthName(TwoMonthsAgo) %> </b></td>
			<td class = "body" align = "center" width = "65" bgcolor = "antiquewhite"><b><%=  MonthName(OneMonthAgo) %></b></td>
			<td class = "body" align = "center"  width = "65" bgcolor = "antiquewhite"><b><%=  MonthName(month(now)) %>*</b></td>
			<td class = "body" align = "center"  bgcolor = "antiquewhite" width = "115"><b>In Last Week*</b></td>
			<td class = "body" align = "center" bgcolor = "antiquewhite"><b>Yesterday</b></td>
	</tr>

<%
row = "odd"
 While  Not rs.eof  
    If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
	ID(rowcount) =   rs("ID")
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
<tr bgcolor = "antiquewhite" >
<%	End If %>
		

	</td>
	<td class = "body" width = "250" align = "left">
		<a href = "EditAlpaca.asp?ID=<%= ID( rowcount)%>#BasicFacts" class = "body"><%= Name( rowcount)%></a>
	</td>
		
	<td class = "body" align = "center" >
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
	<td class = "body" align = "center" >
	<% 
	if showstats = true then
sql = "select animalID from StatsYear where AnimalID = " &		ID(rowcount) 
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
<td class = "body" align = "center" >
<% 

if showstats = true then
sql = "select animalID from StatsTwoMonthsAgo where AnimalID = " &		ID(rowcount) 
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
	<td class = "body" align = "center" >
<% 
if showstats = true then

sql = "select animalID from StatsLastMonth where AnimalID = " &		ID(rowcount) 
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
			
	<td class = "body" align = "center" >
<% 
if showstats = true then

sql = "select animalID from StatsThisMonth where AnimalID = " &		ID(rowcount) 
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
			<td class = "body" align = "center" >
<% 
if showstats = true then

sql = "select animalID from StatsLastWeek where AnimalID = " &		ID(rowcount) 
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
			<td class = "body" align = "center" >

<% 
' if showstats = true then

	sql = "SELECT animalID FROM stats WHERE Statdate=DateAdd('d',-1,now) and AnimalID = " & ID(rowcount) 
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

	<tr bgcolor = "antiquewhite">
			<td class = "body" align = "Right" ><b>Totals:</b></td>
			<td class = "body" align = "center" ><b><%=TotalHitsLastYear %></b></td>
			<td class = "body" align = "center" ><b><%=TotalHitsThisYear %></b></td>
			<td class = "body" align = "center" ><b><%=TotalHitsTwoMonthsAgo %></b></td>
			<td class = "body" align = "center" ><b><%=TotalHitsLastMonth %></b></td>
			<td class = "body" align = "center" ><b><%=TotalHitsThisMonth %></b></td>
			<td class = "body" align = "center" ><b><%=TotalHitsThisWeek %></b></td>
			<td class = "body" align = "center" ><b><%=TotalHitsYesterday %></b></td>
	</tr>
</table>

<br>

</td>
</tr>
</table>
</td>
</tr>
</table>
* = incomplete because the period of time (week, month, year, etc.) has not finished yet.
<% end if %>


</td>
</tr>
</table>
<br>

 <!--#Include virtual="/Footer.asp"--> 
 <script language="javascript">
     interstitial.style.display = "none";
</script>
</BODY>
</HTML>