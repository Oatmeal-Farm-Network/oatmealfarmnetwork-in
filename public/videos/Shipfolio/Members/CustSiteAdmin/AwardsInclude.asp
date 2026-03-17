<%
		 sql3= "select * from Awards where Awards.ID = " & ID & " order by Awards.show, Awards.placing"
				Set rs3 = Server.CreateObject("ADODB.Recordset")
				rs3.Open sql3, conn, 3, 3 
				if Not rs3.eof  then
					if len(rs3("Show")) > 0  or len(rs3("Placing")) > 0   or len(rs3("Class")) > 0 then 
				%>

<table border="0" cellspacing="0"  align = "center" width = "320">
		<tr>
		<td colspan = "3" class = "Details"><br><big><b>Awards</b></big><br><img src = "images/Line.jpg" alt="Alpacas at Lone Ranch Line" width = "330" height = "2">	</td>

		</tr>
		<tr >
				<td width = "160"    valign = "top" align = "center" class = "details" ><b>Show</b></td>
				<td   width = "70"   valign = "top" align = "center" class = "details" ><b>Placing</b></td>
				<td   width = "100"   valign = "top" align = "center" class = "details" ><b>Class</b></td>

		</tr>  
		<tr>
	<td colspan = "2"  valign = "top" height = "2" valign = "bottom" background = "images/Underline.jpg"><img src = "images/px.gif" height = "2" border = "0"></td>
		</tr>
	<%
		While Not rs3.eof     
			aShow	= rs3("Show") 
			aPlacing	= rs3("Placing") 
			aClass		= rs3("Class") 
	%>
			<tr>
					<td align = "left" class = "details" ><%=aShow%> </td>	
					<td align = "center" align = "center" class = "details"  ><%=aPlacing%> </td>
					<td align = "center" align = "center" class = "details"  ><%=aClass%> </td>

		   		</tr>     
         <% 
		rs3.movenext
		Wend 
	%>
</table>

<%End if%>
<%End if%>	