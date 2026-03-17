<!--#Include file="BlogHeader.asp"--> 

<% 
	  
CustID = session("CustID")


%>

<a name="Top"></a>



<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
	<tr>
		<td Class = "body">
			<H2>Add a Blog Entry<br>
			<img src = "images/underline.jpg" width = "600"></H2>
			<br><br>
		</td>
	</tr>
</table>

<table border= "0">
<tr>
			<td  align = "center" class = "body" colspan= "2"  height = "24" width = "800">
					<big><b>Step 1: Enter Basic Information</b></big> </b>
			</td>
		</tr>
   <tr>
</table>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
	<tr>
		<td valign = "top">
			 <form action= 'BlogAddHeader.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">
		<input name="BlogID"  size = "60" value = "<%=BlogID%>" type = "hidden">
		<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "780">
  		<tr>
			<td  align = "right"   class = "body">
						<b>Page Heading: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Heading"  size = "60" value = "<%=PageTitle%>">
			</td>
	 </tr>
	
	  <tr>
     


					
  <tr>
		<td class = "body" align = "right">
			<b>Entry Date: </b></td>
		<td>
		<% BlogMonth = Month(now) 
		BlogDay  = day(now)
		BlogYear  =  Year(now)%>
				<select size="1" name="BlogMonth">
				<% if len(BlogMonth) > 0 then %>
					<option value="<%=BlogMonth%>" selected><%=BlogMonth%></option>
				<% else %>
					<option value="" selected>------</option>
				<% end if %>
					<option value="1">Jan.(1)</option>
					<option  value="2">Feb.(2)</option>
					<option  value="3">March (3)</option>
					<option  value="4">April (4)</option>
					<option  value="5">May (5)</option>
					<option  value="6">June (6)</option>
					<option  value="7">July (7)</option>
					<option  value="8">Aug. (8)</option>
					<option  value="9">Sept. (9)</option>
					<option  value="10">Oct. (10)</option>
					<option  value="11">Nov. (11)</option>
					<option  value="12">Dec. (12)</option>
				</select>
				/ <select size="1" name="BlogDay">
				<% if len(BlogDay) > 0 then %>
					<option value="<%=BlogDay%>" selected><%=BlogDay%></option>
				<% else %>
					<option value="" selected>------</option>
				<% end if %>
					<option value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
					<option  value="9">9</option>
					<option  value="10">10</option>
					<option  value="11">11</option>
					<option  value="12">12</option>
					<option  value="13">13</option>
					<option  value="14">14</option>
					<option  value="15">15</option>
					<option  value="16">16</option>
					<option  value="17">17</option>
					<option  value="18">18</option>
					<option  value="19">19</option>
					<option  value="20">20</option>
					<option  value="21">21</option>
					<option  value="22">22</option>
					<option  value="23">23</option>
					<option  value="24">24</option>
					<option  value="25">25</option>
					<option  value="26">26</option>
					<option  value="27">27</option>
					<option  value="28">28</option>
					<option  value="29">29</option>
					<option  value="30">30</option>
					<option  value="31">31</option>
				</select>
		<select size="1" name="BlogYear">
					<% if len(BlogMonth) > 0 then %>
					<option value="<%=BlogYear%>" selected><%=BlogYear%></option>
				<% else %>
					<option value="<%=year(now)%>" selected><%=year(now)%></option>
				<% end if %>

					
					
				
			<% currentyear = year(date)  - 3
						'response.write(currentyear)
					For yearv=currentyear+1 To currentyear + 5%>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>
		</td>
	   </tr>
	  <tr>
		<td  valign = "middle" colspan = "2" align = "center">
		<input type = "hidden" name="BlogCatID" value = "6">
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" ></form>
		</td>
		</tr>
		
	</table>

<br><br>

