<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalvariables.asp"-->
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" >
<% Current2="Packages"
   Current3="PackagesStats" %> 
<!--#Include file="MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If   
%>
<br />
<!--#Include file="MembersPackagesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Package Statistics</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />
<table border = "0" width = "<%=screenwidth %>"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td width = "475" valign = "top">

<%  
sql = "select * from Packagestats where PeopleId = " & session("PeopleId") & " order by PackageName "
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

<table border = "0" width = "<%=screenwidth %>"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td width = "<%=screenwidth %>" valign = "top">

<%  sql = "select distinct PackageID, PackageName from Packagestats where length(PackageName) > 0 and PeopleID = " & Session("PeopleID") & " order by PackageName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, Conn, 3, 3   
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
<table width = "<%=screenwidth %>"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
	  <td>
<table width = "<%=screenwidth %>"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr bgcolor = "antiquewhite">
			<td class = "body" align = "center" width = "380"><b>Package Name</b></td>
			<td class = "body" align = "center" width = "65" bgcolor = "antiquewhite"><b><%=year(now)-1 %></b></td>
			<td class = "body" align = "center" width = "65" bgcolor = "antiquewhite"><b><%=year(now) %>*</b></td>
			<td class = "body" align = "center" width = "65" bgcolor = "antiquewhite"><b><%= monthname(TwoMonthsAgo) %></b></td>
			<td class = "body" align = "center" width = "65" bgcolor = "antiquewhite"><b><%= monthname(OneMonthAgo) %></b></td>
			<td class = "body" align = "center"  width = "65" bgcolor = "antiquewhite"><b>In Last Month</b></td>
			<td class = "body" align = "center"  bgcolor = "antiquewhite" width = "115"><b>In Last Week</b></td>
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
	Packageid(rowcount) =   rs("Packageid")
	 PackageName(rowcount) =   rs("PackageName")
showstats = True
 If row = "even" Then %>
<tr>
<% Else %>
<tr bgcolor = "antiquewhite" >
<%	End If %>
		

	</td>
	<td class = "body" width = "250" align = "left">
		<a href = "AddaPackageStep4.asp?PackageID=<%= PackageID( rowcount)%>" class = "body"><%= PackageName( rowcount)%></a>
	</td>
		
	<td class = "body" align = "center" >
<% 
Set rs2 = Server.CreateObject("ADODB.Recordset")
if showstats = true then
sql = "SELECT Count(*) as count FROM packagestats WHERE Year(date(Statdate))= Year(DATE_ADD( NOW( ) , INTERVAL -1 Year )) and Packageid = " & Packageid(rowcount)
	rs2.Open sql, Conn, 3, 3   	
	If Not rs2.eof then	
    HitsLastYear = 	cLng(rs2("count"))	
	TotalHitsLastYear  = TotalHitsLastYear + cLng(rs2("count"))
	Else
		HitsLastYear = 0									
	End If 
	rs2.close 
	end if
	%>
    <%=HitsLastYear %>
			</td>
	<td class = "body" align = "center" >
	<% 
	if showstats = true then
sql = "SELECT Count(*) as count FROM packagestats WHERE Year(date(Statdate))= Year(NOW( )) and Packageid = " & Packageid(rowcount)
	rs2.Open sql, Conn, 3, 3   	
	If Not rs2.eof then		
        HitsThisYear = cLng(rs2("count"))
		TotalHitsThisYear   = TotalHitsThisYear +  cLng(rs2("count"))
	Else
		TotalHitsThisYear = 0									
	End If 
	rs2.close 
end if %>
 <%=HitsThisYear  %>
			</td>
<td class = "body" align = "center" >
<% 

if showstats = true then

sql = "SELECT Count(*) as count FROM packagestats WHERE Month(date(Statdate))= Month(DATE_ADD( NOW( ) , INTERVAL -2 Month )) and Packageid = " & Packageid(rowcount) 
rs2.Open sql, Conn, 3, 3   	
If Not rs2.eof then	
HitsTwoMonthsAgo = cLng(rs2("count"))
TotalHitsTwoMonthsAgo = TotalHitsTwoMonthsAgo + cLng(rs2("count"))
Else
HitsTwoMonthsAgo = 0							
End If 
rs2.close
end if %>
<%=HitsTwoMonthsAgo %>
</td>
	<td class = "body" align = "center" >
<% 
if showstats = true then

sql = "SELECT Count(*) as count FROM packagestats WHERE Month(date(Statdate))= Month(DATE_ADD( NOW( ) , INTERVAL -1 Month )) and Packageid = " & Packageid(rowcount) 
	rs2.Open sql, Conn, 3, 3   	
	If Not rs2.eof then
    HitsLastMonth = cLng(rs2("count"))			
	TotalHitsLastMonth = TotalHitsLastMonth + cLng(rs2("count"))
	Else
	HitsLastMonth = 0							
	End If 
	rs2.close
	end if %>
<%=HitsLastMonth %>

</td>				
<td class = "body" align = "center" >
<% 
if showstats = true then

sql = "SELECT  Count(*) as count FROM packagestats WHERE date(statdate) >  ADDDATE(curdate(), -30) and Packageid = " & Packageid(rowcount) 
	rs2.Open sql, Conn, 3, 3   	
	If Not rs2.eof then	
    HitsThisMonth =	cLng(rs2("count"))
		TotalHitsThisMonth  = TotalHitsThisMonth + cLng(rs2("count"))
	Else
		HitsThisMonth = 0								
	End If 
	rs2.close
	
	end if %>
    <%=HitsThisMonth %>
</td>
<td class = "body" align = "center" >
<% 
if showstats = true then

sql = "SELECT Count(*) as count FROM packagestats WHERE date(statdate) > ADDDATE(curdate(), -8) and Packageid = " & Packageid(rowcount) 


	rs2.Open sql, Conn, 3, 3   	
	If Not rs2.eof then	
    	HitsThisWeek = cLng(rs2("count"))
		TotalHitsThisWeek  = TotalHitsThisWeek + cLng(rs2("count"))
	Else
		HitsThisWeek  = 0							
	End If 
	rs2.close

	end if
	%>
    <%=HitsThisWeek  %>
			</td>
			<td class = "body" align = "center" >

<% 
' if showstats = true then

sql = "SELECT  Count(*) as count FROM packagestats WHERE date(statdate) =  ADDDATE(curdate(), -1) and Packageid = " & Packageid(rowcount) 
	rs2.Open sql, Conn, 3, 3   	
	If Not rs2.eof then			
		Yesterdayhits = cLng(rs2("count"))
		TotalHitsYesterday = TotalHitsYesterday + cLng(rs2("count"))
	Else
		Yesterdayhits = 0								
	End If 
	rs2.close %>
 <%=Yesterdayhits  %>
</td>
<% 	rowcount = rowcount + 1
	   rs.movenext

	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set Conn = nothing

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

 <!--#Include virtual="/Footer.asp"--> 

</BODY>
</HTML>