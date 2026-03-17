<!DOCTYPE HTML>

<HTML>
<HEAD>

<title>Blog Admin Home Page </title>     
<link rel="stylesheet" type="text/css" href="/administration/style.css">

<%
Function GetPrevMonth(iThisMonth,iThisYear)
 GetPrevMonth=month(dateserial(iThisYear,iThisMonth,1)-1)
End Function

Function GetPrevMonthYear(iThisMonth,iThisYear)
 GetPrevMonthYear=Year(dateserial(iThisYear,iThisMonth,1)-1)
End Function

Function GetNextMonth(iThisMonth,iThisYear)
 GetNextMonth=month(dateserial(iThisYear,iThisMonth+1,1))
End Function

Function GetNextMonthYear(iThisMonth,iThisYear)
 GetNextMonthYear=year(dateserial(iThisYear,iThisMonth+1,1))
End Function
%>


</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include File="BlogAdminGlobalVariables.asp"-->
<!--#Include File="BlogAdminSecurityInclude.asp"-->
<!--#Include File="BlogAdminHeader.asp"-->

<table width = "720" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
   <td class = "body" valign = "top">
      <table   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" width = "1000">
	     <tr>
		    <td width = "20"></td>
            <td width = "650" class = "body"> 
	           <table border = "0" bordercolor = "#CEBD99" width = "600" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	           <tr>
	              <td>Pages</td>
	           </tr>
	           </table>
	        <table border = "1" bordercolor = "#CEBD99" width = "600" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	        <tr bgcolor = "#CEBD99">
	            <td class = "body" >ID</td>
	            <td class = "body" >Title</td>
	            <td class = "body" >Actions</td>
	        </tr>
	       	
<% 
    order = "odd"	
    sql2 = "select * from Pagelayout where  PageAvailable = True order by LinkOrder"	
	'response.write("Sql2 =" & sql2 & "<br>")
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof 
	    if order = "even" then
	  	    order = "odd" %>
	  	    <tr bgcolor = "#CEBD99">
	    <% else
	        order = "even" %>
	 	    <tr bgcolor = "white">    
	    <% end if 	%> 
 <%  'response.Write("Pagename = " & rs2("PageName") & "<br>") %>
        <td class = "body"><%=rs2("PageLayoutID")%></td>
	    <td class = "body"><a href = "<%=rs2("EditLink")%>" class= "body" ><%=rs2("PageName")%></a></td>
	    <td class = "body"><a href = "<%=rs2("EditLink")%>" class= "body" >Edit</a></td>
	    </tr>
        <% 	
        rs2.movenext
    Wend %>
	</table>
	
<%
	If Month(now) = 1 Then
		CurrentMonth = "Jan."
	End if
	If Month(now) = 2 Then
	    CurrentMonth = "Feb."
	End If
	If Month(now) = 3 Then
		CurrentMonth = "March"
	End If
	If Month(now) = 4 Then
		CurrentMonth = "April"
	End If
	If Month(now) = 5 Then
		CurrentMonth = "May"
	End If
	If Month(now) = 6 Then
		CurrentMonth = "June"
	End If
	If Month(now) = 7 Then
		CurrentMonth = "July"
	End If
	If Month(now) = 8 Then
		CurrentMonth = "Aug."
	End If
	If Month(now) = 9 Then
		CurrentMonth = "Sept."
	End If
	If Month(now) = 10 Then
		CurrentMonth = "Oct."
	End If
	If Month(now) = 11 Then
		CurrentMonth = "Nov."
	End If
		If Month(now) = 12 Then
		CurrentMonth = "Dec."
	End if
 
	sql = "select distinct animals.*, Pricing.* from Animals, Pricing  where Animals.ID = Pricing.ID and CustID = " & Session("custID") & " order by FullName"

	'response.write("Sql = " & sql & "<br>")
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ID(40000) 
	dim	Name(40000) 
	dim	ForSale(40000) 
	dim	ARI(40000) 
	dim	DOBday(40000) 
	dim	DOBMonth(40000) 
	dim	DOBYear(40000) 
	dim	Color(40000) 
	dim	Category(40000) 
	dim	Breed(40000) 
	dim	CLAA(40000) 
	dim Price(40000)
	dim	Discount(40000)
	dim DiscountPrice(40000)

Recordcount = rs.RecordCount +1
%>
<h1>Your Alpacas</h1>

<% if rs.eof Then %>
Currently you do not have any alpacas listed. To add animals please us the <a href = "../AdminAnimalAdd1.asp" class = "body"><b>Add An Alpaca wizard.</b></a>

<% End If %>

<table border = "1" bordercolor = "#e6e6e6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>

<%
row = "odd"
 While  Not rs.eof  
    If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
	ID(rowcount) =   rs("Animals.ID")
	'response.write("ID(rowcount) = " & ID(rowcount) & "<br>")
	 Name(rowcount) =   rs("FullName")
	 ARI(rowcount) =   rs("ARI")
	 DOBday(rowcount) =   rs("DOBday")
	 DOBmonth(rowcount) =   rs("DOBmonth")
	 DOByear(rowcount) =   rs("DOByear")
	Category(rowcount) =   rs("Category")
	
	 CLAA(rowcount)=   rs("CLAA")
	 Price(rowcount)=   rs("Price")
	Discount(rowcount)=   rs("Discount")
	DiscountPrice(rowcount) = Price(rowcount) - (Price(rowcount) * (Discount(rowcount)/100))
 Breed(rowcount)=   rs("Breed")
If CLAA(rowcount)=   "0" Then
	CLAA(rowcount)=   ""
End If

If ARI(rowcount)=   "0" Then
	ARI(rowcount)=   ""
End if


 If row = "even" Then %>
		<tr bgcolor = "#e6e6e6">
<% Else %>
<tr bgcolor = "white">

<%	End If %>

		<td class = "body" height = "80" width = "70" valign = "top" align = "right">Name:<br>
									ARI#:<br>
									CLAA#:<br>
									Breed:
									DOB:</td>

		<td class = "body" valign = "top" width = "260"><b><%= Name( rowcount)%><b><br>
									<%= ARI(rowcount)%><br>
									<%= CLAA(rowcount)%><br>
									<% = breed(rowcount)%><br>
									<% = DOBmonth(rowcount)%>/<% = DOBday(rowcount)%>/<% = DOBYear(rowcount)%></td>
		</td>
		<td class = "body" valign = "top" align = "right" width = "125">
									Full Price:<br>
									Discount:<br>
									Discount Price:<br>
									<b>Hits:</b><br>
									Yesterday:<br>
									This Month:<br><br>
									</td>
		<td class = "body" valign = "top" width = "80"><b><%= FormatCurrency(price( rowcount),00)%><br>
									<%= Discount(rowcount)%>%<br>
									<%= FormatCurrency(DiscountPrice(rowcount),00)%><b><br><br>
									<% 'response.write(Now - 1)
									 	sql = "select * from stats where Statdate = '" &  FormatDateTime(Now - 1 , 2) & "' and AnimalID = " &		ID(rowcount) 
									'response.write (sql)
									Set rsstats = Server.CreateObject("ADODB.Recordset")
									rsstats.Open sql, conn, 3, 3   	
									If Not rsstats.eof then			
										response.write(rsstats.recordcount)
									Else
										response.write("0")									
									End If 
									rsstats.close %>
									<br>
								<% 
									sql = "select * from stats where month(Statdate) = '" &  month(Now) & "' and AnimalID = " &		ID(rowcount) 
									'response.write (sql)
									Set rsstats = Server.CreateObject("ADODB.Recordset")
									rsstats.Open sql, conn, 3, 3   	
									If Not rsstats.eof then			
										response.write(rsstats.recordcount)
									Else
										response.write("0")									
									End If 
									rsstats.close

								
									 set rsstats=nothing
									%>
		</td>
		</td>
		<td class = "body" valign = "top" width = "180" align = "center"><a href = "../AdminAnimalEdit.asp?ID=<%= ID( rowcount)%>" class = "body">Edit Listing</a><br>
		<a href = "../AdminPhotos.asp?ID=<%= ID( rowcount)%>" class = "body">Upload Photos</a><br>
		<a href = "../AdminAnimalEdit.asp?ID=<%= ID( rowcount)%>#pricing" class = "body">Edit Pricing</a><br>
									</td>
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

	</tr>		
</table>

</table>

<br><br>
 <!--#Include File="BlogAdminFooter.asp"--> 
</BODY>
</HTML>