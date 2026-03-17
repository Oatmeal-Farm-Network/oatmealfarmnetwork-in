<!--#Include file="NewsHeader.asp"--> 

<% 
	  
CustID = session("CustID")


%>

<a name="Top"></a>



<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
	<tr>
		<td Class = "body">
			<H2>Add an News Article<br>
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
			 <form action= 'NewsAddHeader.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">
		<input name="NewsID"  size = "60" value = "<%=NewsID%>" type = "hidden">
		<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "780">
  		<tr>
			<td  align = "right"   class = "body">
						<b>Page Heading: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Heading"  size = "60" >
			</td>
	 </tr>
	 <tr>
			<td  align = "right"   class = "body">
						<b>Date: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="NewsDate"  size = "20" >
			</td>
	 </tr>
	 
	  <tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" ></form>
		</td>
		</tr>
		
	</table>

<br><br>

