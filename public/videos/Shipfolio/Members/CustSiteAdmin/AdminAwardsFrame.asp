<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
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

<% dim	IDArray(9999) 
dim	alpacaName(9999)
category = request.QueryString("category")
ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
end if
%>
<% If Len(ID) > 0 and ShowLOA = True and AutoTransfer = True then %>
<!--#Include virtual="/Administration/Transfers/GatherAnimalData.asp"-->
<!--#Include virtual="/Administration/Transfers/TransferMovedata.asp"-->
<% end if %>
<!--#Include virtual="/administration/adminDetailDBInclude.asp"--> 
<% screenwidth=  screenwidth - 175 
Dim Showname(1000)
order = "even"		
		
sql2 = "select * from users where custid = 1;" 
'response.write(sql2)

 sql = "select Animals.FullName, awards.* from Animals, awards where Animals.ID = awards.ID and animals.ID = " & ID & " order by Awardyear DESC, Placing"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	Recordcount = rs.RecordCount +1
	
	
 if mobiledevice = True or screenwidth < 600 then %>	
 
 
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr>
    <td class = "roundedtop" align = "left">
		<H2><div align = "left">Awards</div></H2>
    </td><a name="Awards"></a>
</tr>
<tr>
    <td class = "roundedBottom" align = "center" width = "100%">
<% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Awards Changes Have Been Made.</b></font></div>
<% end if %>

<form action= 'AdminAwardsHandleForm.asp' method = "post">
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "left">
<% 
rowcount = 1
While  rowcount < rs.recordcount + 1
AClass =rs("AClass")
Awardyear = rs("Awardyear")
AwardsID = rs("AwardsID")
Placing = rs("Placing")
Showname = rs("Showname")
Awardcomments = rs("Awardcomments")

if order = "even" then
order = "odd"%>
	<tr>
	<% else 
	order = "even"%>
	<tr bgcolor = "#cccccc">
	<% end if %>
<td class = "body2" align = "right"><b>Year:</b>&nbsp;</td>
<td  class = "body" >
	<select size="1" name="AwardYear(<%=rowcount%>)"  class = "regsubmit2 body">
	<option value="<%=Awardyear%>"><%=Awardyear%></option>
	<option value=""></option>

		<% currentyear = year(date) 
		For yearv=1983 To currentyear %>
	<option value="<%=yearv%>"><%=yearv%></option>		
	<% Next %></select>

	<input  type = "hidden" name="AwardsID(<%=rowcount%>)" value= "<%=AwardsID%>" >
</td>
</tr>
<% if order = "even" then %>
	<tr bgcolor = "#cccccc">
<% else %>
<tr>
<% end if %>
<td class = "body2" align = "right"><b>Class:</b>&nbsp;</td>
<td  class = "body">
	<select size="1" name="AClass(<%=rowcount%>)" class = "regsubmit2 body">
	<option value="<%=AClass%>" selected><%=AClass%></option>
	<option value="Halter">Halter</option>
	<option value="Fleece">Fleece</option>
	<option value="Composite">Composite</option>
	<option value="Spin-off">Spin-off</option>
	<option value="Get of Sire">Get of Sire</option>
	<option value="Produce of Dam">Produce of Dam</option>
	<option  value=""></option>
	</select>
</td>
			</tr>
<% if order = "even" then %>
	<tr bgcolor = "#cccccc">
<% else %>
<tr>
<% end if %>
<td class = "body2" align = "right"><b>Placing:</b>&nbsp;</td>
<td class = "body">
	<select size="1" name="Placing(<%=rowcount%>)"  class = "regsubmit2 body">
	<option value="<%=Placing%>" selected><%=Placing%></option>
	<option value="Color Champion">Color Champion</option>
	<option value="Res. Color Champion">Res. Color Champion</option>
	<option value="1st Place">1st Place</option>
	<option  value="2nd Place">2nd Place</option>
	<option  value="3rd Place">3rd Place</option>
	<option  value="4th Place">4th Place</option>
	<option  value="5th Place">5th Place</option>
	<option  value="6th Place">6th Place</option>
	<option  value="7th Place">7th Place</option>
	<option  value="8th Place">8th Place</option>
	<option  value="9">9th Place</option>
	<option  value="10th Place">10th Place</option>
	<option  value="11th Place">11th Place</option>
	<option  value="12th Place">12th Place</option>
	<option value="Best Crimp">Best Crimp</option>
	<option value="Best Crimp">Judge's Choice</option>
	<option  value=""></option>
</select>
	
</td>
</tr>
<% if order = "even" then %>
	<tr bgcolor = "#cccccc">
<% else %>
<tr>
<% end if %>
<td class = "body2" align = "right"><b>Show:</b>&nbsp;</td>
<td class = "body">
	<input name="Show(<%=rowcount%>)" value= "<%=Showname%>" size = "27"  class = "regsubmit2 body">
</td>
</tr>
	<% if order = "even" then %>
	<tr bgcolor = "#cccccc">
<% else %>
<tr>
<% end if %>
<td class = "body2" align = "right"><b>Comments:</b>&nbsp;</td>
<td class = "body">
	<input name="Awardcomments(<%=rowcount%>)" value= "<%=Awardcomments%>" size = "27" class = "regsubmit2 body">
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
  set conn = nothing
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


<% else
AClass =rs("Class")
Awardyear = rs("Awardyear")
if Awardyear = "0" then
Awardyear = ""
end if

AwardsID = rs("AwardsID")
Placing = rs("Placing")
Show = rs("Show")
Awardcomments = rs("Awardcomments")
%>


<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 50 %>">
<tr>
    <td class = "roundedtop" align = "left">
		<H2><div align = "left">Awards</div></H2>
    </td><a name="Awards"></a>
</tr>
<tr>
    <td class = "roundedBottom" align = "center" width = "100%">
<% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Awards Changes Have Been Made.</b></font></div>
<% end if %>
<form action= 'AdminAwardsHandleForm.asp' method = "post">
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
  <tr bgcolor = "#cccccc">
		<td class = "body"><div align = "center"><b>Year</b></div></td>
		<td class = "body"><div align = "center"><b>Show</b></div></td>
		<td class = "body"><div align = "center"><b>Class</b></div></td>
		<td class = "body"><div align = "center"><b>Placing</b></div></td>
		<td class = "body"><div align = "center"><b>Comments</b></div></td>
	</tr>
<% 
rowcount = 1
While rowcount < rs.recordcount + 1

AClass =rs("Class")
if AClass = "0" then
AClass = ""
end if
Awardyear = rs("Awardyear")
if Awardyear = "0" then
Awardyear = ""
end if
AwardsID = rs("AwardsID")
if AwardsID = "0" then
AwardsID = ""
end if
Placing = rs("Placing")
if Placing = "0" then
Placing = ""
end if
Show = rs("Show")
if Show = "0" then
Show = ""
end if
Awardcomments = rs("Awardcomments")
if Awardcomments = "0" then
Awardcomments = ""
end if



if order = "even" then
order = "odd"
else 
order = "even"%>
<tr bgcolor = "#cccccc">
<% end if %>
<td align = "center" >
<input  type = "hidden" name="AwardsID(<%=rowcount%>)" value= "<%=AwardsID%>" >
<select size="1" name="AwardYear(<%=rowcount%>)">
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
fieldwidth  = 38
fieldwidth2  = 29
end if
%>
<input name="Show(<%=rowcount%>)" value= "<%=Show%>" size = "<%=fieldwidth %>">
</td>
<td  align = "center">
<select size="1" name="AClass(<%=rowcount%>)">
<option value="<%=rs("Type")%>" selected><%=rs("Type")%></option>
<option value="Halter">Halter</option>
<option value="Fleece">Fleece</option>
<option value="Composite">Composite</option>
<option value="Spin-off">Spin-off</option>
<option value="Get of Sire">Get of Sire</option>
<option value="Produce of Dam">Produce of Dam</option>
<option  value=""></option>
</select>
</td>
<td  align = "center">
	<select size="1" name="Placing(<%=rowcount%>)">
	<option value="<%=Placing%>" selected><%=Placing%></option>
	<option value="Color Champion">Color Champion</option>
	<option value="Res. Color Champion">Res. Color Champion</option>
	<option value="1st Place">1st Place</option>
	<option  value="2nd Place">2nd Place</option>
	<option  value="3rd Place">3rd Place</option>
	<option  value="4th Place">4th Place</option>
	<option  value="5th Place">5th Place</option>
	<option  value="6th Place">6th Place</option>
	<option  value="7th Place">7th Place</option>
	<option  value="8th Place">8th Place</option>
	<option  value="9">9th Place</option>
	<option  value="10th Place">10th Place</option>
	<option  value="11th Place">11th Place</option>
	<option  value="12th Place">12th Place</option>
	<option value="Best Crimp">Best Crimp</option>
	<option value="Best Crimp">Judge's Choice</option>
	<option  value=""></option>
</select>
	
</td>
<td  align = "center">
	<input name="Awardcomments(<%=rowcount%>)" value= "<%=Awardcomments%>" size = "<%=fieldwidth2 %>">
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
  set conn = nothing
%>

</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "right">
<tr>
	<br />	
	<td class = "body" align = "right">
		<input type = "hidden" name="ID" value= "<%= ID%>" >
		<input type = "hidden" name="TotalCount" value= "<%= Recordcount%>" >
		<div align = "center">
		<input type="submit" class = "regsubmit2"  <%=Disablebutton %> value="Submit Awards Changes"  ></div>
	</td>
</tr>
</table></form>	</td>
</tr>
</table>

<% end if %>
</body>
</html>