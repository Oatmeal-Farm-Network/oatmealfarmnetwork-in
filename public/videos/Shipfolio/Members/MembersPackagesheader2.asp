
<div class="container"> 
<b class="rtop"> 
  <b class="rs1"></b> <b class="rs2"></b> 
</b>

<table border = "0" width = "754" height = "25" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 background = "images/YourPackgesandlotsHeader.jpg" valign = "top" align = "center">

<% If Garagesale = True Then %>
	<tr>
		<td height = "77" >&nbsp;</td></tr>
	<tr>
		<td Class = "body"   >
			&nbsp;<b>Maintain Your Packages & Lots:</b><br>
			<a href = "PackagesHome.asp" class = "body">Packages/Lots List</a>|
			<a href = "PackagesAdd.asp" class = "body">Create a Package</a>|
			<a href = "EditPackage1.asp" class = "body">Edit Packages/Lots</a>|
			<a href = "PackagesDelete.asp" class = "body">Delete Packages / Reset Lots</a>|
			<a href = "EditPackageLayout.asp" class = "body">Package Ad Layouts</a><br>
			<br>
		</td>
	</tr>

<% Else %>
	<tr>
		<td height = "77" colspan = "5">&nbsp;</td></tr>
	<tr>
		<td Class = "body"   width = "185">
			&nbsp;<b>Maintain Your Packages:</b>
		</td>
		<td Class = "body"  align = "center" width = "120">
			<a href = "PackagesHome.asp" class = "body">Packages List</a>|
		</td>
		<td Class = "body"  align = "center" width = "125">
			<a href = "PackagesAdd.asp" class = "body">Create a Package</a>|
		</td>
		<td Class = "body"  align = "center" width = "110">
			<a href = "EditPackage1.asp" class = "body">Edit Packages</a>|
		</td>
		
		<td Class = "body"  align = "center" width = "124">
			<a href = "PackagesDelete.asp" class = "body">Delete Packages</a>|
		</td>
		<td Class = "body"  align = "center" width = "90">&nbsp;
			<a href = "EditPackageLayout.asp" class = "body">Ad Layout</a>&nbsp;
		</td>
	</tr>

<% End If %>


</table>
<b class="rbottom"> 
   <b class="rs2"></b> <b class="rs1"></b> 
</b> 
</div>