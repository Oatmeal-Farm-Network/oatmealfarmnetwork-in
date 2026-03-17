<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>


<!--#Include file="MembersGlobalVariables.asp"-->


<% 

rowcount = 1
dim ProdIDArray(99999) 
dim ProdNameArray(99999)  
dim ProdHitsArray(20, 99999)  
dim NameArray(99999) 

	StatString =""

	sql= "select ProdID, Prodname from sfProducts where PeopleID = " & session("PeopleID") & " order by Prodname "
	rs.Open sql, Conn, 3, 3 
	rowcount = 1
	while not rs.eof
		ProdIDArray(rowcount) =   rs("ProdID")
		ProdNameArray(rowcount) =   rs("Prodname")
	rowcount = rowcount + 1
    rs.movenext
    wend 
	rs.close
	TotalProdCount = rowcount -1
	'response.write("TotalProdCount=" & TotalProdCount )
	'TotalProdCount = 19

rowcount = 1
		for monthcount =  0 to 6
			StatString = StatString & "[new Date(" & Year(DateAdd("m", -monthcount, Date)) & ", " & Month(DateAdd("m", -monthcount, Date))  & ", 0),"
			for rowcount = 1 to TotalProdCount 
				

				sql = "SELECT Count(*) as Hits FROM productstats WHERE Month(Statdate)= Month(DATEADD (month , -" & monthcount & " , CURRENT_TIMESTAMP )) and ProdID = " & ProdIDArray(rowcount) 
				'response.write("<BR>sql=" & sql)
					rs.Open sql, Conn, 3, 3 
					
					if not rs.eof then
						'response.write("hits=" &  rs("Hits") )

						ProdHitsArray(monthcount, rowcount) =   rs("Hits")
							StatString = StatString & " " & ProdHitsArray(monthcount, rowcount)
						if rowcount = TotalProdCount then
							StatString = StatString & "],"
						else
							StatString = StatString & ","
						end if

					end if
					rs.close
			
			next
		next
	
	
	
	'response.write("StatString=" & StatString )
	
	%>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    google.charts.load('current', { packages: ['corechart', 'line'] });
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
        var data = new google.visualization.DataTable();


        data.addColumn('date', 'Date');
			<% for x = 1 to TotalProdCount %>
                data.addColumn('number', '<%=ProdNameArray(x) %>');
			<% next %>





            // Add your data rows here
            data.addRows([
			 
               <%=StatString %>
            // Add more rows as needed
        ]);

        var options = {
            title: 'Product Hits Over Time',
            width: '80%',
            height: <%=TotalProdCount * 35 %>,
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


</head>
<body >




<% Current1="Products"
Current2 = "ProductStatistics" 
Current3 = "Statistics" %> 
<!--#Include file="MembersHeader.asp"-->
<!--#Include file="MembersProductJumpLinks2.asp"-->
<div class ="container roundedtopandbottom">
<div>
   <div>
    <H1>Product Statistics</H1>
   </div>
</div>
<% 
sql= "select ProdID, Prodname from sfProducts where PeopleID = " & session("PeopleID") & " order by Prodname "

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, Conn, 3, 3 
    if rs.eof then %>
	<div>
      <div>
        Currently you do not have any products listed. To add products please <A href = "membersPlaceClassifiedAd0.asp" class = "body">click here</A>.
    </div>
    </div>
<%	else
      
rowcount = 1


TotalHitsLastYear  = 0	
TotalHitsThisYear  = 0	
TotalHitsTwoMonthsAgo  = 0	
TotalHitsLastMonth  = 0	
TotalHitsThisMonth  = 0	
TotalHitsThisWeek  = 0	
TotalHitsYesterday = 0	
TotalHitsYesterday = 0			

%>


<div>

	<div class = "row">
    <div>


	<div id="chart_div"></div>
	

		  
		</div>
	</div>

<% Response.Buffer = True %>

<div id='interstitial'>
   <center><img src="https://www.GlobalLivestockSolutions.com/images/Loading.gif" width="50" height="50" alt="Loading ... Please wait... " /></center>
</div>
</div>

<script language="javascript">
    setTimeout('interstitial.style.display="none";', 30000);
</script>

<%
response.flush
Set rs2 = Server.CreateObject("ADODB.Recordset")
%>

<div class ="container" width = "100%">
<div class ="row">
	<div class ="col" = "475" valign = "top">

<%
if rs.state = 0 then
else
rs.close
end if
sql= "select ProdID, Prodname from sfProducts where PeopleID = " & session("PeopleID") & " order by Prodname "
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
<% if month(now) = 1 then
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
end if  %>
<table width = "100%" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
	  <td>
<table width = "100%" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=5>
	<tr >
			<td class = "body" align = "center" width = "380"><b>Name</b></td>
			<td class = "body" align = "center" width = "65" ><b><%=year(now)-1 %></b></td>
			<td class = "body" align = "center" width = "65" ><b><%=year(now) %>*</b></td>
			<td class = "body" align = "center" width = "65" ><b><%=left(monthname(TwoMonthsAgo),3) %> </b></td>
			<td class = "body" align = "center" width = "65" ><b><%= left(monthname(OneMonthAgo),3) %></b></td>
			<td class = "body" align = "center" width = "115"><b>< 2 Weeks*</b></td>
			<td class = "body" align = "center" ><b>Yesterday</b></td>
	</tr>
	<tr >
	    <td colspan="7" height="1px" style="background-color: #abacab; min-height: 1px"></td>
    </tr>
<%
row = "odd"
 While  Not rs.eof  
    If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
ProdIDArray(rowcount) =   rs("ProdID")
NameArray(rowcount) =   rs("Prodname")
showstats = True
 If row = "even" Then %>
<tr>
<% Else %>
<tr  >
<%	End If %>
</td>
<td class = "body" width = "250" align = "left">
<a href = "MembersAdEdit2.asp?prodID=<%= ProdIDArray(rowcount)%>#BasicFacts" class = "body"><%= NameArray(rowcount)%></a>
</td>
<td class = "body" align = "center" >
<% 
if showstats = true then
sql = "SELECT Count(*) as count FROM productstats WHERE Year(Statdate)= Year(CURRENT_TIMESTAMP) and ProdID = " & ProdIDArray(rowcount)
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
			</td>
	<td class = "body" align = "center" >
	<% 
	if showstats = true then
sql = "SELECT Count(*) as count FROM productstats WHERE Year(Statdate)= Year(CURRENT_TIMESTAMP) and ProdID = " & ProdIDArray(rowcount)
	rs2.Open sql, Conn, 3, 3   	
	If Not rs2.eof then			
		response.write(cLng(rs2("count")))
		TotalHitsThisYear  = TotalHitsThisYear  + cLng(rs2("count"))
	Else
		response.write("0")									
	End If 
	rs2.close 
	
	end if %>
			</td>
<td class = "body" align = "center" >
<% 

if showstats = true then
sql = "SELECT Count(*) as count FROM productstats WHERE Month(Statdate)= Month(DATEADD (month , -2 , CURRENT_TIMESTAMP )) and ProdID = " & ProdIDArray(rowcount) 
	rs2.Open sql, Conn, 3, 3   	
	If Not rs2.eof then			
		response.write(cLng(rs2("count")))
		TotalHitsTwoMonthsAgo = TotalHitsTwoMonthsAgo + cLng(rs2("count"))
	Else
		response.write("0")									
	End If 
	rs2.close
	end if %>
			</td>
	<td class = "body" align = "center" >
<% 
if showstats = true then
sql = "SELECT Count(*) as count FROM productstats WHERE Month(Statdate)= Month(DATEADD (month , -1 , CURRENT_TIMESTAMP )) and ProdID = " &	prodIDArray(rowcount) 
	rs2.Open sql, Conn, 3, 3   	
	If Not rs2.eof then			
		response.write(cLng(rs2("count")))
		TotalHitsLastMonth = TotalHitsLastMonth + cLng(rs2("count"))
	Else
		response.write("0")									
	End If 
	rs2.close
	end if %>
			</td>				
			

			<td class = "body" align = "center" >
<% 
if showstats = true then
sql = "SELECT Count(*) as count FROM productstats WHERE statdate =  DATEADD (day , -14 , CURRENT_TIMESTAMP ) and ProdID = " & prodIDArray(rowcount)
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
</td>
<td class = "body" align = "center" >

<% sql = "SELECT  Count(*) as count FROM productstats WHERE statdate =  DATEADD (day , -7 , CURRENT_TIMESTAMP ) and ProdID = " & prodIDArray(rowcount) 
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
</td>
</tr>
	<tr >
	       <td colspan="7" height="1px" style="background-color: #abacab; min-height: 1px"></td>
    </tr>
<% rowcount = rowcount + 1
rs.movenext
Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing  %>



	<tr >
			<td class = "body" align = "Right" ><b>Totals:</b></td>
			<td class = "body" align = "center" ><b><%=TotalHitsLastYear %></b></td>
			<td class = "body" align = "center" ><b><%=TotalHitsThisYear %></b></td>
			<td class = "body" align = "center" ><b><%=TotalHitsTwoMonthsAgo %></b></td>
			<td class = "body" align = "center" ><b><%=TotalHitsLastMonth %></b></td>
			<td class = "body" align = "center" ><b><%=TotalHitsThisWeek %></b></td>
			<td class = "body" align = "center" ><b><%=TotalHitsYesterday %></b></td>
	</tr>
</table>

<br>

</div>
</div>
</div>
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
<% end if 
%>


    </div>
</div>
 <script language="javascript">
     interstitial.style.display = "none";
</script>
 <!--#Include file="membersFooter.asp"--> 
</BODY>
</HTML>