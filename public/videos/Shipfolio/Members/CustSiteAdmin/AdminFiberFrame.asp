<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="style.css">
 <base target="_self" />
<!--#Include file="AdminGlobalVariables.asp"-->
</head>
<body>
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

<% 


ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
end if

sql = "select ID from Fiber where ID = " & ID
'response.write (sql)
rs.Open sql, conn, 3, 3   
rowcount = 1

Recordcount = rs.recordcount 
rs.close



sql = "select  ID from Fiber where (len(SampleDateYear) > 1 or len(Average) > 0 or len(StandardDev) > 0 or len(GreaterThan30) > 0 or len(COV) > 0 or len(CF) > 0  or len(curve) > 0  or len(ShearWeight) > 0 or len(BlanketWeight) > 0 or len(Length) > 0 or len(CrimpPerInch) > 0)  and ID = " & ID 
'response.write (sql)
rs.Open sql, conn, 3, 3   
rowcount = 1

filledRecordcount = rs.recordcount
rs.close


if Recordcount > (filledRecordcount + 5) then
deletecount = Recordcount - (filledRecordcount + 6)
d = 1

sql=" select * from fiber where id =" & ID & " order by FiberID DESC"
if rs.state = 0 then
else
rs.close
end if
rs.Open sql, conn, 3, 3  
lastFiberid = rs("FiberID")
Query =  "Delete * from Fiber where FiberID=" & lastFiberid 
Conn.Execute(Query) 
while d < deletecount
d = d + 1
rs.movenext
lastFiberid = rs("FiberID")
Query =  "Delete * from Fiber where FiberID=" & lastFiberid 
'Conn.Execute(Query) 
wend
rs.close
end if


if Recordcount  =filledRecordcount then
Query =  "INSERT INTO Fiber (ID)" 
Query =  Query & " Values ('" &  ID & "')"
Conn.Execute(Query) 
Query =  "INSERT INTO Fiber (ID)" 
Query =  Query & " Values ('" &  ID & "')"
Conn.Execute(Query) 
end if
If RecordCount  < 5 Then
    NeedToAdd = 5 - RecordCount
    if rs.state = 0 then
    else
	rs.close
    end if
	i = 1
	While i < NeedToAdd
		Query =  "INSERT INTO Fiber (ID)" 
		Query =  Query + " Values ('" &  ID & "')"
        Conn.Execute(Query)
 		NeedToAdd = NeedToAdd - 1
	wend
End If 
if rs.state = 0 then
else	
rs.close
end if

%>
 <!--#Include virtual="/administration/adminDetailDBInclude.asp"-->
<% If Len(ID) > 0 and ShowLOA = True then %>
	<!--#Include virtual="/Administration/Transfers/GatherAnimalData.asp"-->
	<!--#Include virtual="/Administration/Transfers/TransferMovedata.asp"-->
<% end if %><%
Dim SampleDateDay(1000)
Dim SampleDateMonth(1000)
Dim SampleDateYear(1000)
Dim FiberID(1000)
Dim SampleAge(1000)
Dim Average(1000)
Dim StandardDev(1000)
Dim COV(1000)
Dim GreaterThan30(1000)
Dim CF(1000)
Dim Curve(1000)
Dim ShearWeight(1000)
Dim BlanketWeight(1000)
Dim Length(1000)
Dim CrimpPerInch(1000)
if mobiledevice = True or screenwidth < 800 and x = 1789 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"  >
<tr><td class = "roundedtop" align = "center">
<a name="Fiber"></a><H2><div align = "left"><% If AdministrationID  = 2 then %>
Fibre 
<% else %>
Fiber 
<% end if %> Facts</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center" valign = "top">
<% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Fiber Changes Have Been Made.</b></font></div>
<% end if %>



<%
sql = "select Count(*) as count, Fiber.* from Fiber where (len(SampleDateYear) > 1 or len(Average) > 0 or len(StandardDev) > 0 or len(GreaterThan30) > 0 or len(COV) > 0 or len(CF) > 0  or len(curve) > 0  or len(ShearWeight) > 0 or len(BlanketWeight) > 0 or len(Length) > 0 or length(CrimpPerInch) > 0)  and ID = " & ID 
 Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
rowcount = 1

%>
<form action= 'AdminFiberHandleForm.asp' method = "post" name = "fiberform">
<%
While  Not rs.eof 
FiberID(rowcount) =   rs("FiberID")
SampleDateDay(rowcount) =   rs("SampleDateDay")
SampleDateMonth(rowcount) =   rs("SampleDateMonth")
SampleDateYear(rowcount) =   rs("SampleDateYear")
SampleAge(rowcount) =   rs("SampleAge")
Average(rowcount) =   rs("Average")
StandardDev(rowcount) =   rs("StandardDev")
COV(rowcount) =  rs("COV")
GreaterThan30(rowcount) =   rs("GreaterThan30")
CF(rowcount) =  rs("CF")
Curve(rowcount) =   rs("Curve")
ShearWeight(rowcount) =   rs("ShearWeight")
BlanketWeight(rowcount) =   rs("BlanketWeight")
Length(rowcount) =   rs("Length")
CrimpPerInch(rowcount) =   rs("CrimpPerInch")
If row = "even" Then
row = "odd"
Else
row = "even"
End if
If row = "even" Then %>
<table border = "0" width = "100%"  align = "center" bgcolor ="#e6e6e6" cellpadding = "0" cellspacing = "0">
<% Else %>
<table border = "0" width = "100%"  align = "center" cellpadding = "0" cellspacing = "0">
<% End If %>
<tr ><td class = "body2" align= "right"><b>Year:</b>&nbsp;</td>
<td class = "body" ><input type = "hidden" name="IDArray(<%=rowcount%>)"  value="<%=ID%>" ><input type = "hidden" name="FiberID(<%=rowcount%>)" value="<%=FiberID(rowcount)%>" ><input type = "hidden" name="FullName(<%=rowcount%>)"  >
<select size="1" name="SampleDateYear(<%=rowcount%>)" class = "regsubmit2 body">
<option value="<%=SampleDateYear(rowcount)%>" selected><%=SampleDateYear(rowcount)%></option>
<option value=""> --</option>	
<% currentyear = year(date) 
For yearv= currentyear To 1983 step -1  %>
	
<option value="<%=yearv%>"><%=yearv%></option>		
<% Next %></select>
</td>
<td class = "body2" align= "right">
<b>AFD:</b>&nbsp;
</td>
<td class = "body" >
<input name="Average(<%=rowcount%>)"  size = "5" value="<%=Average(rowcount)%>" class = "regsubmit2 body">
</td></tr>
<tr><td class = "body2" align= "right">
<b>CF:</b>&nbsp;
</td>
<td class = "body" >
<input name="CF(<%=rowcount%>)" value="<%= CF(rowcount)%>"   size = "5" class = "regsubmit2 body">
</td>
<td class = "body2" align= "right">
<b>SD:</b>&nbsp;
</td>
<td class = "body"  >
<input name="StandardDev(<%=rowcount%>)"  size = "5" value="<%=StandardDev(rowcount)%>" class = "regsubmit2 body">
</td></tr>
<tr><td class = "body2" align= "right">
<b>Crimps/Inch:</b>&nbsp;
</td>
<td class = "body"  >
 <input name="CrimpPerInch(<%=rowcount%>)" value="<%= CrimpPerInch(rowcount)%>"   size = "5" class = "regsubmit2 body">
</td>
<td class = "body2" align= "right">
<b>COV:</b>&nbsp;
</td>
<td class = "body"  >
<input name="COV(<%=rowcount%>)" value="<%= COV( rowcount)%>"  size = "5" class = "regsubmit2 body">
</td></tr>
<tr><td class = "body2" align= "right">
<b>Staple&nbsp;<br />Length:</b>&nbsp;
</td>
<td class = "body"  >
<input name="Length(<%=rowcount%>)" value="<%= Length(rowcount)%>"  size = "5" class = "regsubmit2 body">
</td>
<td class = "body2" align= "right">
<b>% > 30:</b>&nbsp;
</td>
<td class = "body" >
<input name="GreaterThan30(<%=rowcount%>)"  size = "5" value="<%=GreaterThan30(rowcount)%>" class = "regsubmit2 body">
</td></tr>
<tr>	<td class = "body2" align= "right">
<b>Shear Wt:</b>&nbsp;
</td>
<td class = "body" >
<input name="ShearWeight(<%=rowcount%>)" value="<%= ShearWeight(rowcount)%>"  size = "5" class = "regsubmit2 body">
</td>
<td class = "body2" align= "right">
		    <b>Curve:</b>&nbsp;
		</td>	
		<td class = "body"  >
		 <input name="Curve(<%=rowcount%>)" value="<%= Curve(rowcount)%>"  size = "5" class = "regsubmit2 body">
		</td>
			</tr>
		<tr>
		<td class = "body2" align= "right">
		    <b>Blanket Wt:</b>&nbsp;
		</td>	
		<td class = "body"  colspan = "3">
		 <input name="BlanketWeight(<%=rowcount%>)" value="<%= BlanketWeight(rowcount)%>"   size = "5" class = "regsubmit2 body">
		</td>
	</tr>


<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
'response.write(TotalCount)
	rs.close
%>
<tr>
	<td class = "body" colspan = "4">
		<Input type = hidden name='TotalCount' value = <%=TotalCount%> >	
		<Input type =hidden name='ID' value = <%=ID%> >
		<center><input type=submit value = "Submit Fiber Changes"   Class = "regsubmit2 body" ></center>
	</td>
</tr>
</table></form>
 	</td>
</tr>
</table>

<% else %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"  >
 <tr>
    <td class = "roundedtop" align = "center">
		<a name="Fiber"></a><H2><div align = "left">
        <% If AdministrationID  = 2 then %>
Fibre 
<% else %>
Fiber 
<% end if %> Facts</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center" valign = "top">
<% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Fiber Data Changes Have Been Made.</b></font></div>
<% end if %>

<% if rs.state = 0 then
else
rs.close
end if
if conn.state = 0 then
else
conn.close
set conn = Nothing 
end if%>

<!--#Include virtual="/Conn.asp"-->
<%
sql = "select * from Fiber where ID = " & ID 
rs.Open sql, conn, 3, 3   
rowcount = 1
Recordcount = cLng(rs.recordcount)

if rs.state = 0 then
else
rs.close
end if

sql = "select Animals.FullName, Fiber.* from Animals, Fiber where Animals.ID = Fiber.ID and animals.ID = " & ID & " Order by SampleDateYear desc,  SampleDateMonth desc,  SampleDateYear desc, Average, fiber.GreaterThan30 "
rs.Open sql, conn, 3, 3 

hideform = false
if hideform = false then

%>
	<form action= 'AdminFiberHandleForm.asp' method = "post" name = "fiberform">
<%
rowcount = 1
 x = 0
 While  x < Recordcount and not rs.eof
 x = x + 1

	 FiberID(rowcount) =   rs("FiberID")
	 SampleDateDay(rowcount) =   rs("SampleDateDay")
	  SampleDateMonth(rowcount) =   rs("SampleDateMonth")
	   SampleDateYear(rowcount) =   rs("SampleDateYear")
	 SampleAge(rowcount) =   rs("SampleAge")
	 Average(rowcount) =   rs("Average")
	 StandardDev(rowcount) =   rs("StandardDev")
	 COV(rowcount) =  rs("COV")
	 GreaterThan30(rowcount) =   rs("GreaterThan30")
	 CF(rowcount) =  rs("CF")
	 Curve(rowcount) =   rs("Curve")
	 ShearWeight(rowcount) =   rs("ShearWeight")
	 BlanketWeight(rowcount) =   rs("BlanketWeight")
	 Length(rowcount) =   rs("Length")
	 CrimpPerInch(rowcount) =   rs("CrimpPerInch")
%>

<% If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
		 If row = "even" Then %>
	<table border = "0" width = "100%"  align = "center" bgcolor ="#e6e6e6">
<% Else %>
	<table border = "0" width = "100%"  align = "center" ">
<% End If %>
<input type = "hidden" name="IDArray(<%=rowcount%>)"  value="<%=ID%>" ><input type = "hidden" name="FiberID(<%=rowcount%>)" value="<%=FiberID(rowcount)%>" ><input type = "hidden" name="FullName(<%=rowcount%>)"  ><tr >
<td width = "70" class = "body" align= "left">Sample Year:<br />
<select size="1" name="SampleDateYear(<%=rowcount%>)">
<% if len(SampleDateYear(rowcount)) > 2 then %>
<option value="<%=SampleDateYear(rowcount)%>" selected><%=SampleDateYear(rowcount)%></option>
<option value=""> --</option>	
<% else %>
<option value=""> </option>	
<% end if %>
<% currentyear = year(date) 
For yearv= currentyear To 1983 step -1  %>
<option value="<%=yearv%>"><%=yearv%></option>		
<% Next %></select>
		</td>
		<td class = "body2" align = "right">
			AFD:&nbsp;<input name="Average(<%=rowcount%>)"  size = "5" value="<%=Average(rowcount)%>"><br>
			CF:&nbsp;<input name="CF(<%=rowcount%>)" value="<%= CF(rowcount)%>"   size = "5">
		</td>
		<td class = "body2" align = "right" >
		    SD:&nbsp;<input name="StandardDev(<%=rowcount%>)"  size = "5" value="<%=StandardDev(rowcount)%>" ><br />
		   Crimps/Inch:&nbsp;<input name="CrimpPerInch(<%=rowcount%>)" value="<%= CrimpPerInch(rowcount)%>"   size = "5">
		</td>

		<td class = "body2" align = "right" >
			COV:&nbsp;<input name="COV(<%=rowcount%>)" value="<%= COV( rowcount)%>"  size = "5"><br>
			Staple Length:&nbsp;<input name="Length(<%=rowcount%>)" value="<%= Length(rowcount)%>"  size = "5">
		</td>
		<td class = "body2" align = "right" >
			% > 30:&nbsp;<input name="GreaterThan30(<%=rowcount%>)"  size = "5" value="<%=GreaterThan30(rowcount)%>" ><br />
			Shear Wt:&nbsp;<input name="ShearWeight(<%=rowcount%>)" value="<%= ShearWeight(rowcount)%>"  size = "5">
		</td>
		<td class = "body2"  align = "right">
		 Curve:&nbsp;<input name="Curve(<%=rowcount%>)" value="<%= Curve(rowcount)%>"  size = "5"><br>
		 Blanket Wt:&nbsp;<input name="BlanketWeight(<%=rowcount%>)" value="<%= BlanketWeight(rowcount)%>"   size = "5">
		</td>
	</tr>
</table>

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
'response.write(TotalCount)
	rs.close
%>


<table width = "100%" border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" >
<tr><td  align = "center">
		<Input type = hidden name='TotalCount' value = <%=TotalCount%> >	
		<Input type =hidden name='ID' value = <%=ID%> >
		<input type=submit value = "Submit Fiber Changes"  size = "110" class = "regsubmit2"  <%=Disablebutton %> >
	</td>
</tr>
</table></form>
<% end if %>
 	</td>
</tr>
</table>

<% end if %>
</body>
</html>
