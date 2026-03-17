<% sql2 = "select distinct * from Fiber where Fiber.ID = " & ID & " order by SampleDate DESC, Average DESC,  StandardDev DESC ,  COV DESC, GreaterThan30 DESC , Blanketweight DESC, Shearweight DESC"

				Set rs2 = Server.CreateObject("ADODB.Recordset")
				rs2.Open sql2, conn, 3, 3 
	if not rs2.eof  then
		if (len(rs2("SampleDate")) >1 or len(rs2("Average")) >1 or len(rs2("StandardDev")) >1 or len(rs2("COV")) >1 or len(rs2("GreaterThan30")) >1 	or len(rs2("Blanketweight")) >1 or len(rs2("Shearweight")) >1	) then %>
<table border="0" cellspacing="2"  width = "<%=TextWidth%>"  align = "center" >
	<tr>
		<td valign = "top" align = "center" class = "body"> 
			<br><h2>Fiber Facts</h2>
			</td>
				</tr>
			<tr>
				<td class = "body" align ="left" bgcolor = "#670000" height = "1" colspan = "3"><img src = "images/px.gif" height = "1"></td>
			</tr>
				<%

				While Not rs2.eof  
				
					if (len(rs2("SampleDate")) >1 or len(rs2("Average")) >1 or len(rs2("StandardDev")) >1 or len(rs2("COV")) >1 or len(rs2("GreaterThan30")) >1 	or len(rs2("Blanketweight")) >1 or len(rs2("Shearweight")) >1	) then 

				 SampleDate	= rs2("SampleDate") 
				Average	= rs2("Average") 
				 StandardDev	= rs2("StandardDev") 
				 COV	= rs2("COV")
				GreaterThan30	= rs2("GreaterThan30")
				 Blanketweight	= rs2("Blanketweight")
				 Shearweight	= rs2("Shearweight")
				  CF	= rs2("CF")
				 Length	= rs2("Length")
				 Curve= rs2("Curve")
				 CrimpPerInch= rs2("CrimpPerInch")
				 %>
				<% If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
		 If row = "even" Then %>
	<table border = "0" width = "<%=TextWidth%>"  align = "center" bgcolor = "linen">
<% Else %>
	<table border = "0" width = "<%=TextWidth%>"  align = "center" bgcolor = "antiquewhite">
<% End If %>
				<tr>	
		<td class = "body" width = "120" valign= "top">
		Sample Date:<br>
			AFD:<br>
		    SD:<br>
			COV: <br>
			%>30µ:
		</td>
		<td class = "body" width = "90" valign= "top">
		<%=SampleDate%><br>
			<%=Average%><br>
		   <%=StandardDev%><br>
			<%= COV%><br>
			<%=GreaterThan30%>
		</td>
		<td class = "body" width = "120" valign= "top">
			
			CF:<br>
			Curve:<br>
			Crimps / Inch:<br>
			Staple Length:
		</td>
		<td class = "body" width = "90" valign= "top">
			
			<%= CF%><br>
			<%= Curve%><br>
			<%= CrimpPerInch%><br>
			<%= Length%>
		</td>
		<td class = "body" valign = "top" width = "70">
			Weight<br>
			&nbsp;Blanket:<br>
			&nbsp;Shear:<br>
		</td>
		<td class = "body" valign = "top" >
		<br>
			<%= BlanketWeight%><br>
			<%= ShearWeight%>
		</td>
	</tr>
</table>
             <% End if
					rs2.movenext
				Wend 
			%>
		  
	
<%End if%>
<%End if%>
<br>

