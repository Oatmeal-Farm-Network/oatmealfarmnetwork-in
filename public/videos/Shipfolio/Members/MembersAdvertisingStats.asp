<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<!--#Include file="Membersglobalvariables.asp"-->

<% 

rowcount = 1
dim AdIDArray(99999) 
dim AdTitleArray(99999)  
dim AdHitsArray(20, 99999)  
  

	StatString =""

	'sql = "select distinct ads.AdID, ClickDate from AdStats, Ads where AdStats.AdID= Ads.AdID and ads.PeopleID = " & Session("PeopleID") & " order by ClickDate"

	sql = "select distinct ads.AdID, Ads.AdTitle, ClickDate from AdStats, Ads where AdStats.AdID= Ads.AdID  and ads.PeopleID = " & Session("PeopleID") & " order by ClickDate"


	rs.Open sql, Conn, 3, 3 
	rowcount = 1
	while not rs.eof
		AdIDArray(rowcount) =   rs("AdID")

		AdTitleArray(rowcount) =   rs("AdTitle")
	rowcount = rowcount + 1
    rs.movenext
    wend 
	rs.close
	TotalAdCount = rowcount -1
	'response.write("TotalAdCount=" & TotalAdCount )
	'TotalAdCount = 19

rowcount = 1
		for monthcount =  0 to 6
			StatString = StatString & "[new Date(" & Year(DateAdd("m", -monthcount, Date)) & ", " & Month(DateAdd("m", -monthcount, Date))  & ", 0),"
			for rowcount = 1 to TotalAdCount 
				

				sql = "SELECT Count(*) as Hits FROM Adstats WHERE Month(ClickDate)= Month(DATEADD (month , -" & monthcount & " , CURRENT_TIMESTAMP )) and AdID = " &	AdIDArray(rowcount) 
			
					rs.Open sql, Conn, 3, 3 
					
					if not rs.eof then
						'response.write("hits=" &  rs("Hits") )

						AdHitsArray(monthcount, rowcount) =   rs("Hits")
							StatString = StatString & " " & AdHitsArray(monthcount, rowcount)
						if rowcount = TotalAdCount then
							StatString = StatString & "],"
						else
							StatString = StatString & ","
						end if

					end if
					rs.close
			
			next
		next
	
	
	
'	response.write("StatString=" & StatString )
	
	%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    google.charts.load('current', { packages: ['corechart', 'line'] });
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
		var data = new google.visualization.DataTable();

		
		data.addColumn('date', 'Date');
			<% for x = 1 to TotalAdCount %>
            data.addColumn('number', '<%=AdTitleArray(x) %>');
			<% next %>


        // Add your data rows here
			data.addRows([
			 
               <%=StatString %>
            // Add more rows as needed
        ]);

        var options = {
            title: 'Ad Hits Over Time',
            width: '100%',
            height: <%=TotalAdCount * 30 %>,
            curveType: 'function',
            hAxis: {
                title: 'Date'
            },
            vAxis: {
                title: 'Hits'
            }
        };

        var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
        chart.draw(data, options);
    }
</script>






</HEAD>
<body >
<% 
Current1="Ads"
Current2 = "AdStatistics"
Current3 = "Statistics" %> 
   <!--#Include file="MembersHeader.asp"-->
<!--#Include file="MembersJumpLinks.asp"-->
<br />
<% If not rs.State = adStateClosed Then
  rs.close
End If  %>
<div class =" container roundedtopandbottom">
<div class = "row">
    <div>
        <h3>Advertising Statistics</h3>
		<br /><br />
    </div>
</div>

<div class = "row">
    <div>


	<div id="chart_div"></div>
	

		  
		</div>
	</div>
<% 
Set rs2 = Server.CreateObject("ADODB.Recordset")
	'sql = "select distinct ads.AdID, ClickDate from AdStats, Ads where AdStats.AdID= Ads.AdID and ads.PeopleID = " & Session("PeopleID") & " order by ClickDate"
	sql = "select distinct ads.AdID, Ads.AdTitle, ClickDate from AdStats, Ads where AdStats.AdID= Ads.AdID and ads.PeopleID = " & Session("PeopleID") & " order by ClickDate"
'response.write("sql="  & sql )
rs.Open sql, Conn, 3, 3  
if rs.eof then %>
Currently you do not have any Ads entered. To add Ads please select the <a href = "AdminAdAdd1.asp" class = "body">Add Ad</a> tab.
<%	else 
rowcount = 1
		
%>
<% Response.Buffer = True %>
<div>
<div id='interstitial' align = "center">
   <img src="https://www.GlobalLivestockSolutions.com/images/Loading.gif" width="50" height="50" alt="Loading ... Please wait... " />
</div>
</div>

<script language="javascript">
    setTimeout('interstitial.style.display="none";', 30000);
</script>
<%
response.flush
%>

<div class ="container" width ="100%" >
	<div class ="row">
	<div class ="col-2 text-left body" style ="min-width: 120px"><b>Title</b></div>
	<div class = "col-2 text-right body2" ><b><%=year(now) %>*</b></div>
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
end if %>

<div class = "col-2 text-right body2" ><%= MonthName(OneMonthAgo) %></div>
<div class = "col-2 text-right body2"  ><%= MonthName(month(now)) %>*</div>
<div class = "col-2 text-right body2"  >In Last Week*</div>
<div class = "col-2 text-right body2"  >Yesterday</div>
</div>
<div class ="row">
   <div class = "Col-12" style="background-color: #abacab; min-height: 1px"></div>
</div>
<%
row = "odd"
While  Not rs.eof  
If row = "even" Then
row = "odd"
Else
row = "even"
End if
AdIDArray(rowcount) =   rs("AdID")
AdTitleArray(rowcount) =   rs("AdTitle")
showstats = True
%>
<div class ="row">
	<div class = "col-2 text-left body2" >
		<a href = "MembersEditAdBasics.asp?AdID=<%= AdIDArray( rowcount)%>#Top" class = "body"><%= AdTitleArray( rowcount)%></a>
	</div>
	<div class = "col-2 text-right body2" >
<%   
if showstats = true then
sql = "SELECT Count(*) as count FROM Adstats WHERE Year(ClickDate)= Year(CURRENT_TIMESTAMP) and AdID = " & AdIDArray(rowcount)  & " and ads.PeopleID = " & Session("PeopleID") & " order by ClickDate"

rs2.Open sql, Conn, 3, 3   	
	If Not rs2.eof then			
		response.write(cLng(rs2("count")))
		TotalHitsLastYear  = TotalHitsLastYear + cLng(rs2("count"))
	Else
		response.write("0")									
	End If 
	rs2.close 
	end if
	%>
</div>

<div class = "col-2 text-right body2"  >
<% 
if showstats = true then

sql = "SELECT  Count(*) as count FROM Adstats WHERE ClickDate =  DATEADD (month , -2 , CURRENT_TIMESTAMP )  and AdID = " &	AdIDArray(rowcount)  & " and ads.PeopleID = " & Session("PeopleID") & " order by ClickDate"
	rs2.Open sql, Conn, 3, 3   	
	If Not rs2.eof then			
		response.write(cLng(rs2("count")))
		TotalHitsLastMonth = TotalHitsLastMonth + cLng(rs2("count"))
	Else
		response.write("0")									
	End If 
	rs2.close
	end if %>
</div>				
<div class = "col-2 text-right body2" >
<% 
if showstats = true then
sql = "SELECT  Count(*) as count FROM Adstats WHERE ClickDate >  DATEADD (day , -30 , CURRENT_TIMESTAMP ) and AdID = " &	AdIDArray(rowcount)  & " and ads.PeopleID = " & Session("PeopleID") & " order by ClickDate"
	rs2.Open sql, Conn, 3, 3   	
	If Not rs2.eof then			
		response.write(cLng(rs2("count")))
		TotalHitsThisMonth  = TotalHitsThisMonth  + cLng(rs2("count"))
	Else
		response.write("0")									
	End If 
	rs2.close
	
	end if %>
</div>
<div class = "col-2 text-right body2" >
<% 
if showstats = true then

sql = "SELECT  Count(*) as count FROM Adstats WHERE ClickDate >  DATEADD (day , -8 , CURRENT_TIMESTAMP ) and AdID = " & AdIDArray(rowcount)  & " and ads.PeopleID = " & Session("PeopleID") & " order by ClickDate"
	rs2.Open sql, Conn, 3, 3   	
	If Not rs2.eof then			
		response.write(cLng(rs2("count")))
		TotalHitsThisWeek =  TotalHitsThisWeek + cLng(rs2("count"))
	Else
		response.write("0")									
	End If 
	rs2.close 
	end if
	%>
</div>
<div class = "col-2 text-right body2"  >

<% 
' if showstats = true then
sql = "SELECT  Count(*) as count FROM Adstats WHERE ClickDate >  DATEADD (day , -1 , CURRENT_TIMESTAMP ) and AdID = " & AdIDArray(rowcount)  & " and ads.PeopleID = " & Session("PeopleID") & " order by ClickDate"
	rs2.Open sql, Conn, 3, 3   	
	If Not rs2.eof then			
		response.write(cLng(rs2("count")))
		Yesterdayhits = cLng(rs2("count"))
		TotalHitsYesterday = TotalHitsYesterday + Yesterdayhits
	Else
		response.write("0")									
	End If 
	rs2.close
	
%>
	</div>
	</div>
     <div class ="row">
	    <div class = "Col-12"  style="background-color: #dddddd; min-height: 1px"></div>
      </div>

<%
		rowcount = rowcount + 1
	   rs.movenext

	Wend
TotalCount=rowcount 
	rs.close
Conn.close
set Conn = Nothing
 %>


<div class ="row">
	<div  height = 5 class = "Col-12" ></div>
</div>
<div class ="row">
	<div class = "col-2 text-right body2" ><b>Totals:</b></div>
    <div class = "col-2 text-right body2" ><b><%=TotalHitsLastYear %></b></div>
	<div class = "col-2 text-right body2" ><b><%=TotalHitsLastMonth %></b></div>
	<div class = "col-2 text-right body2" ><b><%=TotalHitsThisMonth %></b></div>
	<div class = "col-2 text-right body2" ><b><%=TotalHitsThisWeek %></b></div>
	<div class = "col-2 text-right body2" ><b><%=TotalHitsYesterday %></b></div>
</div>
</div>
<div class = "Col-12 body" >
<small>* = incomplete because the period of time has not finished yet.</small>
</div>

<% end if %>


</div>

<!--#Include file="membersFooter.asp"--> 
 <script language="javascript">
     interstitial.style.display = "none";
</script>
</body>
</HTML>