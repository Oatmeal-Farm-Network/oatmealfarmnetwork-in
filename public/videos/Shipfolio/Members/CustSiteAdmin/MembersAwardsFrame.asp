<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalVariables.asp"-->
<!--#Include virtual="/MobileWidthInclude.asp"-->
<link rel="stylesheet" type="text/css" href="/administration/style.css">
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

<% 


Set rs = Server.CreateObject("ADODB.Recordset")
category = request.QueryString("category")
ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
end if
Dim Showname(1000)
order = "even"		
	
    
sql = "select Count(*) as count from awards where ID = " & ID & " and (not(len(Placing)< 1) or not(len(Class)< 1) or not(len(AwardYear)< 2)  or not(len(Awardcomments)< 1)  or not(len(Showname)< 1)  or not(len(Judge)< 1) )  "
rs.Open sql, connLOA, 3, 3  
FilledRecordcount = rs("count")
rs.close  
 
sql = "select Count(*) as count from awards where ID = " & ID 
rs.Open sql, connLOA, 3, 3  
Recordcount = rs("count")
rs.close

if cLng(Recordcount) < cLng(FilledRecordcount) + 6 then
Query =  "INSERT INTO Awards (ID)" 
Query =  Query & " Values ('" &  ID & "')"
'response.write("Query=" & Query )
connLOA.Execute(Query) 

Query =  "INSERT INTO Awards (ID)" 
Query =  Query & " Values ('" &  ID & "')"
'response.write("Query=" & Query )
connLOA.Execute(Query) 

Query =  "INSERT INTO Awards (ID)" 
Query =  Query & " Values ('" &  ID & "')"

connLOA.Execute(Query) 
end if


if mobiledevice = True or screenwidth < 600 then %>	
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr>
    <td class = "roundedtopandbottom" align = "left">
		<a name="Awards"></a><H2><div align = "left">Awards</div></H2>

<% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Awards Changes Have Been Made.</b></font></div>
<% end if %>

<form action= 'MembersAwardsHandleForm.asp' method = "post">
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "left">
<% 
rowcount = 1
While rowcount < clng(Recordcount) + 1
AwardYear = rs("Awardyear")



	if order = "even" then
	  order = "odd"
	%>
	<tr>
	<% else 
	order = "even"%>
	<tr bgcolor = "#e6e6e6">
	<% end if %>
<td class = "body2" align = "right"><b>Year:</b>&nbsp;</td>
<td  class = "body" >

<% Awardyear = rs("Awardyear")
if len(Awardyear) > 0 then
if Awardyear = 0 then
Awardyear = ""
end if
end if

Placing = rs("Placing")
if len(Placing) > 0 then
if Placing = 0 then
Placing = ""
end if
end if
%>

	<select size="1" name="AwardYear(<%=rowcount%>)"  class = "regsubmit2 body">
	<option value="<%=Awardyear%>"><%=Awardyear%></option>
	<option value=""></option>

		<% currentyear = year(date) 
		For yearv=1983 To currentyear %>
	<option value="<%=yearv%>"><%=yearv%></option>		
	<% Next %></select>

	<input  type = "hidden" name="AwardsID(<%=rowcount%>)" value= "<%=rs("AwardsID")%>" >
</td>
</tr>
<% if order = "even" then %>
	<tr bgcolor = "#e6e6e6">
<% else %>
<tr>
<% end if %>
<td class = "body2" align = "right"><b>Class:</b>&nbsp;</td>
<td  class = "body">
	<input type=text name="AClass(<%=rowcount%>)" class = "formbox">

</td>
			</tr>
<% if order = "even" then %>
	<tr bgcolor = "#e6e6e6">
<% else %>
<tr>
<% end if %>
<td class = "body2" align = "right"><b>Placing:</b>&nbsp;</td>
<td class = "body">
	<input type = text name="<%=Placing%>"  class = "formbox">

	
</td>
</tr>
<% if order = "even" then %>
	<tr bgcolor = "#e6e6e6">
<% else %>
<tr>
<% end if %>
<td class = "body2" align = "right"><b>Show:</b>&nbsp;</td>
<td class = "body">
	<input name="Show(<%=rowcount%>)" value= "<%=rs("Showname")%>" size = "27"  class = "regsubmit2 body">
</td>
</tr>
	<% if order = "even" then %>
	<tr bgcolor = "#e6e6e6">
<% else %>
<tr>
<% end if %>
<td class = "body2" align = "right"><b>Comments:</b>&nbsp;</td>
<td class = "body">
	<input name="Awardcomments(<%=rowcount%>)" value= "<%=rs("Awardcomments")%>" size = "27" class = "regsubmit2 body">
</td>

		</tr>
	<%
		rowcount = rowcount + 1
	   If Not rs.eof Then
			rs.movenext
		End if
	Wend
TotalCount=rowcount 
'response.write(TotalCount)
	rs.close
  set rs=nothing
  set connLOA = nothing
%>


<tr>
	<td  align = "center" colspan = "2">
		<input type = "hidden" name="ID" value= "<%= ID%>" >
		<input type = "hidden" name="TotalCount" value= "<%= Recordcount%>" >
		<div align = "center"><input type="submit" class = "regsubmit2 body" value="Submit"  ></div>
	</td>
</tr>
</table></form>	</td>
</tr>
</table>


<% else %>

<% tempscreenwidth = request.querystring("screenwidth")
if len(tempscreenwidth) > 1 then
screenwidth = tempscreenwidth
end if

if screenwidth > 1000 then
screenwidth = 815
end if

%>

<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "100%">
<tr>
    <td class = "roundedtopandbottom" align = "left">
		<a name="Awards"></a><H2><div align = "left">Awards</div></H2>
<% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Awards Changes Have Been Made.</b></font></div>
<% end if %>
<form action= 'MembersAwardsHandleForm.asp' method = "post">
<table border = "0" width = 100% leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center">
  <tr bgcolor = "#e6e6e6" height = 40>
		<td class = "body"><div align = "center"><b>Year</b></div></td>
		<td class = "body"><div align = "center"><b>Show</b></div></td>
		<td class = "body"><div align = "center"><b>Class</b></div></td>
		<td class = "body"><div align = "center"><b>Placing</b></div></td>
		<td class = "body"><div align = "center"><b>Comments</b></div></td>
	</tr>

<% sql = "select awards.* from awards where ID = " & ID & " order by Awardyear DESC, Placing DESC, Showname DESC"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, connLOA, 3, 3   
rowcount = 1
While not rs.eof
rowcount = rowcount + 1
if order = "even" then
order = "odd"
else 
order = "even"%>
<tr bgcolor = "#e6e6e6">
<% end if %>
<td align = "center" >

<% Awardyear = rs("Awardyear")
if len(Awardyear) > 0 then
if Awardyear = 0 then
Awardyear = ""
end if
end if

Placing = rs("Placing")
if len(Placing) > 0 then
if Placing = "0" then
Placing = ""
end if
end if

tempShowName = rs("ShowName")
if len(tempShowName) > 0 then
if tempShowName = "0" then
tempShowName = ""
end if
end if



Awardcomments = rs("Awardcomments")
if len(Awardcomments) > 0 then
if Awardcomments = "0" then
Awardcomments= ""
end if
end if


TempType= rs("Type")
if len(TempType) > 0 then
if TempType = "0" then
TempType= ""
end if
end if


%>

<input type = "hidden" name="AwardsID(<%=rowcount%>)" value= "<%=rs("AwardsID")%>" >
<select size="1" name="AwardYear(<%=rowcount%>)" class = 'formbox'>
<option value="<%=AwardYear%>"><%=AwardYear%></option>
<option value=""></option>
<% currentyear = year(date) 
For yearv=1983 To currentyear %>
<option value="<%=yearv%>"><%=yearv%></option>	
<% Next %></select>
</td>
<td  align = "center" >
<% if screenwidth > 600 then
fieldwidth  = 28
fieldwidth2  = 14
end if
if screenwidth > 800 then
fieldwidth  = 30
fieldwidth2  = 20
end if
%>
<input name="Show(<%=rowcount%>)" value= "<%=tempShowName%>" size = "<%=fieldwidth %>" class = 'formbox'>
</td>
<td align = "center">
<input type = text name="AClass(<%=rowcount%>)" value= "<%=TempType%>" class = 'formbox'>

</td>
<td align = "center">
<input type = text name="Placing(<%=rowcount%>)" value= "<%=Placing%>" class = 'formbox'>
</td>
<td  align = "center">
	<input name="Awardcomments(<%=rowcount%>)" value= "<%=Awardcomments%>" size = "<%=fieldwidth2 %>" class = 'formbox'>
</td>
</tr>
<% 
rs.movenext
wend %>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "right">
<tr>
	<br />	
	<td class = "body" align = "right">
		<input type = "hidden" name="ID" value= "<%= ID%>" >
		<input type = "hidden" name="TotalCount" value= "<%= rowcount%>" >
		<div align = "center">
		<input type="submit" class = "regsubmit2" value="SUBMIT AWARDS CHANGES"  ></div>
        <BR>
	</td>
</tr>
</table></form>	</td>
</tr>
</table>

<% end if 
connLOA.close
set connLOA = nothing %>
</body>
</html>