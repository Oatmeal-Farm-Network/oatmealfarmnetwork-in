<SCRIPT LANGUAGE="JavaScript">
function verify() {
var themessage = "Please fill out the following fields: \r";
if (document.form.Weeks.value=="") {
themessage = themessage + " -Weeks \r";
}
if (document.form.Month.value=="") {
themessage = themessage + " -Month \r";
}
if (document.form.Day.value=="") {
themessage = themessage + " -Day \r";
}
if (document.form.Year.value=="") {
themessage = themessage + " -Year \r";
}
//alert if fields are empty and cancel form submit
if (themessage == "Please fill out the following fields: \r") {
document.form.submit();
}
else {
alert(themessage);
return false;
   }
}
//  End -->
</script>

<%  Session("Step4Count") = 0%>
<% AdType=Request.Form( "AdType" ) %>

<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"    width = "630">
	<tr>
		<td class = "body" valign = "top"  ><h1>Create an Ad - Step 4: Ad Duration<a name="Add"></a>
			<img src = "images/underline.jpg" width = "600"></h1>
			<blockquote>Please select the number of weeks you wish your ad to run and the day you wish it to start:</blockquote>
		</td>
	</tr>
</table>



<table  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "left"  border = "0">
	<tr>
		<td class = "body"  width = "80">&nbsp;
		</td>
		<td class = "body">
		<form  name="form" method="post" action="PlaceClassifiedAdStep4.asp"><i>* indicates required fields.</i>
<table  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "left"  bgcolor = "#edf2e4" border = "1" bordercolor = "#628038">
	<tr>
		<td class = "body"  width = "300">&nbsp
		

<table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "left"  >
	<tr>
		<td class = "body"  >Rate:</td>
		<td class = "body" >$5.00 per Week</td>
	</tr>
	<tr>
		<td class = "body" >Number of Weeks:</td>
		<td class = "body" ><input name="Weeks" size = "5">*
		</td>
	</tr>
	<tr>
		<td class = "body" >Start Date:<td>
		<td class = "body" ><td>
	</tr>
	<tr>
		<td class = "body" align = "right">Month:</td>
		<td class = "body" ><select size="1" name="Month">
					<option value="" selected></option>
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
				</select>*
		</td>
	</tr>
	<tr>
		<td class = "body" align = "right">Day:</td>
		<td class = "body" >
				<select size="1" name="Day">
					<option value="" selected></option>
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
				</select>*
			</td>
		</tr>
		<tr>
			<td class = "body" align = "right">Year:</td>
			<td class = "body" >
				<select  name="Year">
					<option value="<%= year(date) %>" selected><%= year(date) %></option>
					<option value="<%= year(date) + 1%>" ><%= year(date) + 1%></option>
				
			</select>*
		</td>
	</tr>
	
	<tr>
			<td class = "body" align = "right"><br>Coupon Code:</td>
			<td class = "body" ><br><input name="Code" size = "15">
				
		</td>
	</tr>
</table>
</td>
	</tr>
	<tr>
		<td colspan = "2" align = "center">
		
		<input name="AdType" value = "<%=AdType%>" type = "hidden">
		<input type="button" value="Next ->" onclick="verify();" style="background-image: url('images/background.jpg'); border-width:1px" class = "menu">

	</td>
	</tr>
	</table></form>
		</td>
	</tr>
	</table>