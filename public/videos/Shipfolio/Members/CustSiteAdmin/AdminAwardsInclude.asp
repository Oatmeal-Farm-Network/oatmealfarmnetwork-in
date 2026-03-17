<%
Dim Showname(1000)
order = "even"		
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
						
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


<form action= 'AdminAwardsHandleForm.asp' method = "post">
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "left">
<% 
rowcount = 1
	While  rowcount < rs.recordcount + 1
	
	If  Not rs.eof  then
		AwardsID(rowcount) =   rs("AwardsID")
	Else
		AwardsID(rowcount) = "0"
	End If

	If  Not rs.eof  then
		Awardyear(rowcount) =   rs("Awardyear")
	Else
		Awardyear(rowcount) = ""
	End If

	If Len(awardYear(rowcount)) < 2 Then
	AwardYear(rowcount) = ""
End if

	
	If  Not rs.eof then
		Showname(rowcount) =   rs("Show")
	Else
		Showname(rowcount) = ""
	End If
	
	If  Not rs.eof then
		Placing(rowcount) =   rs("Placing")
	Else
		Placing(rowcount)  = ""
	End If

	If  Not rs.eof then
		AClass(rowcount) =   rs("Type")
	Else
		AClass(rowcount)  = ""
	End If

	If  Not rs.eof then
			Awardcomments(rowcount) =   rs("Awardcomments")
	Else
		Awardcomments(rowcount)  = ""
	End If


If  AwardYear(rowcount) ="0" Then
			AwardYear(rowcount) = "" 
	End If 

	If  Showname(rowcount) ="0"   Then
		Showname(rowcount)= "" 
	End If 

	If Placing(rowcount)="0"  Then
		Placing(rowcount) = "" 
	End If 

	If AClass(rowcount)="0"  Then
		AClass(rowcount) = "" 
	End If 

	If Awardcomments(rowcount)="0"  Then
		Awardcomments(rowcount) = ""
	End If 

	if order = "even" then
	  order = "odd"
	%>
	<tr>
	<% else 
	order = "even"%>
	<tr bgcolor = "#cccccc">
	<% end if %>
				<td class = "body2" align = "right"><b>Year:</b>&nbsp;</td>
				<td  class = "body" >
					<select size="1" name="AwardYear(<%=rowcount%>)"  class = "regsubmit2 body">
					<option value="<%=Awardyear(rowcount)%>"><%=Awardyear(rowcount)%></option>
					<option value=""></option>
				
						<% currentyear = year(date) 
						For yearv=1983 To currentyear %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>

					<input  type = "hidden" name="AwardsID(<%=rowcount%>)" value= "<%=AwardsID(rowcount)%>" >
				</td>
				</tr>
				<% if order = "even" then %>
					<tr bgcolor = "#cccccc">
				<% else %>
				<tr>
				<% end if %>
				<td class = "body2" align = "right"><b>Class:</b>&nbsp;</td>
				<td  class = "body">
					<select size="1" name="AClass(<%=rowcount%>)"  class = "regsubmit2 body">
						<option value="<%=AClass(rowcount)%>" selected><%=AClass(rowcount)%></option>
						
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
					<option value="<%=Placing(rowcount)%>" selected><%=Placing(rowcount)%></option>
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
					<input name="Show(<%=rowcount%>)" value= "<%=Showname(rowcount)%>" size = "27"  class = "regsubmit2 body">
				</td>
				</tr>
					<% if order = "even" then %>
					<tr bgcolor = "#cccccc">
				<% else %>
				<tr>
				<% end if %>
				<td class = "body2" align = "right"><b>Comments:</b>&nbsp;</td>
				<td class = "body">
					<input name="Awardcomments(<%=rowcount%>)" value= "<%=Awardcomments(rowcount)%>" size = "27" class = "regsubmit2 body">
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


<% else %>



 
 
 
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 50 %>">
<tr>
    <td class = "roundedtop" align = "left">
		<H2><div align = "left">Awards</div></H2>
    </td><a name="Awards"></a>
</tr>
<tr>
    <td class = "roundedBottom" align = "center" width = "100%">


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
	While  rowcount < rs.recordcount + 1
	
	If  Not rs.eof  then
		AwardsID(rowcount) =   rs("AwardsID")
	Else
		AwardsID(rowcount) = "0"
	End If

	If  Not rs.eof  then
		Awardyear(rowcount) =   rs("Awardyear")
	Else
		Awardyear(rowcount) = ""
	End If

	If Len(awardYear(rowcount)) < 2 Then
	AwardYear(rowcount) = ""
End if

	
	If  Not rs.eof then
		Showname(rowcount) =   rs("Show")
	Else
		Showname(rowcount) = ""
	End If
	
	If  Not rs.eof then
		Placing(rowcount) =   rs("Placing")
	Else
		Placing(rowcount)  = ""
	End If

	If  Not rs.eof then
		AClass(rowcount) =   rs("Type")
	Else
		AClass(rowcount)  = ""
	End If

	If  Not rs.eof then
			Awardcomments(rowcount) =   rs("Awardcomments")
	Else
		Awardcomments(rowcount)  = ""
	End If


If  AwardYear(rowcount) ="0" Then
			AwardYear(rowcount) = "" 
	End If 

	If  Showname(rowcount) ="0"   Then
		Showname(rowcount)= "" 
	End If 

	If Placing(rowcount)="0"  Then
		Placing(rowcount) = "" 
	End If 

	If AClass(rowcount)="0"  Then
		AClass(rowcount) = "" 
	End If 

	If Awardcomments(rowcount)="0"  Then
		Awardcomments(rowcount) = ""
	End If 

	if order = "even" then
	  order = "odd"
	%>
	
	<% else 
	order = "even"%>
	<tr bgcolor = "#cccccc">
	<% end if %>
				<td  align = "center" >
					<select size="1" name="AwardYear(<%=rowcount%>)">
					<option value="<%=Awardyear(rowcount)%>"><%=Awardyear(rowcount)%></option>
					<option value=""></option>
				
						<% currentyear = year(date) 
						For yearv=1983 To currentyear %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>

					<input  type = "hidden" name="AwardsID(<%=rowcount%>)" value= "<%=AwardsID(rowcount)%>" >
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
				
					<input name="Show(<%=rowcount%>)" value= "<%=Showname(rowcount)%>" size = "<%=fieldwidth %>">
				</td>
				<td  align = "center">
					<select size="1" name="AClass(<%=rowcount%>)">
						<option value="<%=AClass(rowcount)%>" selected><%=AClass(rowcount)%></option>
						
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
					<option value="<%=Placing(rowcount)%>" selected><%=Placing(rowcount)%></option>
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
					<input name="Awardcomments(<%=rowcount%>)" value= "<%=Awardcomments(rowcount)%>" size = "<%=fieldwidth2 %>">
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
		<input type="submit" class = "regsubmit2" value="Submit"  ></div>
	</td>
</tr>
</table></form>	</td>
</tr>
</table>


<% end if %>
