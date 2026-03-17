<table align = "right" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
	<tr>
	<td colspan = "3">
    	<% if counter < 1 then%>
			<%=click%>
		<% else %>
			<IMG alt="main image" border=0  name=but1 src="<%=buttonimages(1)%>" align = "center" width = "285">
		<% end if%>
	</td>
	</tr>
<%
	if not rs.eof then
	rs.movefirst
	counter = 0
	counttotal = rs.recordcount %>
	<tr>
	<% While counter < counttotal
		%>
		
		<% for x= 1 to 3
		    
			 if counter = counttotal then
					exit for
             end if 
			counter = counter +1
			if rs.recordcount > 1 then
			%>
			<td valign = "top" align = "center">
			<font 
			onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
			onMouseOut="img<%=counter%>('but1')"  class = "menu">
			<img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0"></font>
			</td>

		<%
			end if
		if counter< counttotal then
			rs.movenext
		end if
		
				next
		%>
			</tr>
			
		<%
	wend
	end if
%>
</table>