

				<% if counter < 1 then%>
							<table valign = "top" border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 style="border-style: ridge; border-color: #941500 ; border-right-width: 3; border-left-width: 2; border-top-width: 2; border-bottom-width: 3" >
							<tr>
								<td>
						<%=click%>
								</td>
							</tr>
							</table>
						<% else %>
							<table border = "0"  valign = "top" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 style="border-style: ridge; border-color: #941500 ; border-right-width: 3; border-left-width: 2; border-top-width: 2; border-bottom-width: 3" >
							<tr>
								<td>
									<IMG alt="main image" border=0  name=but1 src="<%=buttonimages(1)%>" align = "center" width = "260">
								</td>
							</tr>
						</table>
						<% end if%>
		</td>
		<td valign = "top">
<%
	if not rsA.eof then
	rsA.movefirst
	counter = 0
	counttotal = rsA.recordcount
	
	While counter < counttotal
		%>

		<table border="0" cellspacing="0" align = "center" valign = "top" >
			<tr>
		<% for x= 1 to 1
		    
			 if counter = counttotal then
					exit for
             end if 
			counter = counter +1
			if rsA.recordcount > 1 then
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
			rsA.movenext
		end if
		
				next
		%>
			</tr>
			</table>
		<%
	wend
	end if
%>
