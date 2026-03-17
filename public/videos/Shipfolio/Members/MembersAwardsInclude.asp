<%
Dim Showname(1000)
Dim AwardsID(1000)
Dim Awardyear(1000)
dim Placing (1000)
Dim AClass(1000) 
Dim Awardcomments(1000) 
						
sql2 = "select * from users where custid = 1;" 
'response.write(sql2)

 sql = "select Animals.FullName, awards.* from Animals, awards where Animals.ID = awards.ID and animals.ID = " & ID & " order by Awardyear DESC, Placing"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	Recordcount = rs.RecordCount +1
%>
<a name="Awards"></a>
  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Awards</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "880">
<form action= 'MembersAwardsHandleForm.asp' method = "post">
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800" align = "center">
  <tr>
		<td class = "body" align = "center"><b>Year</b></td>
		<td class = "body" align = "center"><b>Show</b></td>
		<td class = "body" align = "center"><b>Class</b></td>
		<td class = "body" align = "center"><b>Placing</b></td>
		<td class = "body" align = "center"><b>Comments</b></td>
	</tr>
	<% 
    blankcount = 0
StopSub = False
rowcount = 1
While  rowcount < rs.recordcount + 1 and StopSub = false
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

if len(awardYear(rowcount)) < 1 and len(Showname(rowcount)) < 1 and len(Placing(rowcount)) < 1 and len(AClass(rowcount)) < 1 and len(Awardcomments(rowcount)) < 1 then
    blankcount = blankcount + 1
    if blankcount > 6 then
        StopSub  = True
    end if
end if
%>
<% If row = "even" Then
row = "odd"
Else
row = "even"
End if
If row = "even" Then %>
<tr bgcolor = "#e6e6e6">
<% Else %>
<tr>
<% End If %>
				<td  align = "center" valign = "top">
					<select size="1" name="AwardYear(<%=rowcount%>)">
					<option value="<%=Awardyear(rowcount)%>"><%=Awardyear(rowcount)%></option>
					<option value=""></option>
						<% currentyear = year(date) 
						For yearv= currentyear To 1983 step -1  %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>
     
					<input  type = "hidden" name="AwardsID(<%=rowcount%>)" value= "<%=AwardsID(rowcount)%>" >
				</td>
				<td  align = "center" valign = "top">
					<input name="Show(<%=rowcount%>)" value= "<%=Showname(rowcount)%>" size = "40">
				</td>
				<td  align = "center" valign = "top">
  <% if speciesID = 2 then %>
<select size="1" name="AClass(<%=rowcount%>)">
<option value="<%=AClass(rowcount)%>" selected><%=AClass(rowcount)%></option>
<option value="Halter">Halter</option>
<option value="Fleece">Fleece</option>
<option value="Composite">Composite</option>
<option value="Cottage">Cottage</option>
<option value="Spin-off">Spin-off</option>
<option value="Get of Sire">Get of Sire</option>
<option value="Produce of Dam">Produce of Dam</option>
<option  value=""></option>
</select>
<% else %>
<input type = "text" size="20" name="AClass(<%=rowcount%>)" value="<%=AClass(rowcount)%>">
<% end if %>	
				</td>
				<td  align = "center" valign = "top">
  <% if speciesID = 2 then %>
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
					<option  value="9th Place">9th Place</option>
					<option  value="10th Place">10th Place</option>
					<option  value="11th Place">11th Place</option>
					<option  value="12th Place">12th Place</option>
					<option value="Best Crimp">Best Crimp</option>
					<option value="Judges Choice">Judge's Choice</option>
					<option  value=""></option>
				</select>
<% else %>
<input type = "text" size="20" name="Placing(<%=rowcount%>)" value = "<%=Placing(rowcount)%>">
<% end if %>
				</td>
				<td  align = "center"><textarea name="Awardcomments(<%=rowcount%>)"  cols="20" rows="4"   class = "body"   ><%= Awardcomments(rowcount)%></textarea>
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
%>

</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800" align = "center">
<tr>
		<td class = "body2"  align = "right">
			<input type = "hidden" name="ID" value= "<%= ID%>" >
			<input type = "hidden" name="TotalCount" value= "<%= Recordcount%>" >
			
			<input type=submit value = "Submit Changes" size = "110" Class = "regsubmit2" >
		</td>
</tr>
</table></form>
</td>
</tr>
</table>