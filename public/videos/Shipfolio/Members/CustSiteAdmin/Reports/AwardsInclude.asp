<%
		 sql3= "select * from Awards where Awards.ID = " & ID & " order by Awards.Placing desc"
				Set rs3 = Server.CreateObject("ADODB.Recordset")
				'response.write(sql3)
				rs3.Open sql3, conn, 3, 3 
				if Not rs3.eof  then
					if len(rs3("Show")) > 1  or len(rs3("Placing")) > 1   or len(rs3("Class")) > 1 then 
				%>

<table border="0" cellspacing="2"  width = "<%=TextWidth%>"  align = "center" >
		<tr>
			<td colspan = "5" align = "center" class = "body" > 
					<br><h2>Awards<br></h2>
			</td>
		</tr>
		<tr>
				<td class = "body" align ="left" bgcolor = "#670000" height = "1" colspan = "53"><img src = "images/px.gif" height = "1"></td>
			</tr>
		<tr  bgcolor = "antiquewhite">
				<td width = "9"    valign = "top" align = "center" class = "body" ><b>Year</b></td>
				<td    valign = "top" align = "center" class = "body"><b>Show</b></td>
				<td   valign = "top" align = "center" class = "body" ><b>Placing</b></td>
				<td    valign = "top" align = "center" class = "body" ><b>Class</b></td>
				<td   valign = "top" align = "center" class = "body"><b>Comments</b></td>

		</tr>  

	<%
		While Not rs3.eof  
		   If Len(rs3("AwardYear")) > 2 then
			AwardYear	= rs3("AwardYear") 
			aShow	= rs3("Show") 
			aPlacing	= rs3("Placing") 
				aClass	= rs3("Type") 
			Awardcomments		= rs3("Awardcomments") 
	%>
			<tr bgcolor = "linen">
				<td   class = "body" ><%=AwardYear%> </td>	
					<td   class = "body" ><%=aShow%> </td>	
					<td align = "center" class = "body"  valign = "top"><%=aPlacing%> </td>
					<td align = "center" class = "body"  valign = "top"><%=AClass%> </td>
					<td class = "body"  valign = "top"><% If Len(awardcomments) > 2 Then %>
																			<%=Awardcomments%> 
																			<% End If %></td>

		   		</tr>     
         <%
		 End if
		rs3.movenext
		Wend 
	%>
</table>

<%End if%>
<%End if%>	