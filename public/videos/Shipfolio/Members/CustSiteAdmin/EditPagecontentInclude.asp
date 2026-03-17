<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "775">
	<tr>
		<td class = "body">
			<a name="Add"></a>
			<H1>Edit Information for <%=rs("animals.FullName")%> <img src = "images/line.jpg"> </H1>
			 
			
		</td>
	</tr>
</table>


 <table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "700">
	<tr>
		<td class = "body" width = "300" valign = "top">
			<h2>Edit your Information</h2>
				Scroll down to edit your information by topic or click on the links below to jump to the section that you need:<br>
						<ul>
							<li><a href = "#Pricing" class = "body">Pricing</a>
							<li><a href = "#BasicFacts" class = "body">Basic Facts</a>
							<li><a href = "#Awards" class = "body">Awards</a>
							<li><a href = "#Fiber" class = "body">Fiber</a>
							<li><a href = "#Ancestry" class = "body">Ancestry</a>
						</ul>
		</td><td width = "15"><img src = "images/px.gif" height="0" width = "0"></td>
		<td width = "1" bgcolor = "black"><img src = "images/px.gif" height="0" width = "0"></td>
		<td width = "15"><img src = "images/px.gif" height="0" width = "0"></td>
		<td class = "body"  valign = "top" width = "200">
			<h2>Photos</h2>
			<a href = "AdminPhotos.asp?ID=<%=ID%>" class = "body">Click here</a> to upload photos.</a>

		</td>
		<td width = "15"><img src = "images/px.gif" height="0" width = "0"></td>
		<td width = "1" bgcolor = "black"><img src = "images/px.gif" height="0" width = "0"></td>
		<td width = "15"><img src = "images/px.gif" height="0" width = "0"></td>
		<td class = "body"  valign = "top" width = "300">
			

			<%  


	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from Animals, SFCustomers  where animals.CustID = SFCustomers.CustID and animals.CustID = " & Session("custID") & " order by Fullname ;"
    'response.write(sql2)

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	If Not rs2.eof then
	


		'response.write("custBargainHunterStartservice=")
		'response.write(Year(custBargainHunterEndservice))
    If Len(custBargainHunterStartservice) > 1 And year(Now) < Year(custBargainHunterEndservice) Then
			ABHMember  = True
			'response.write(ABHMember )
		End If 



       If Len(custAlpacaChampStartService) > 1 And year(Now) < Year(custAlpacaChampEndservice) Then
			ACMember = True
			'response.write(ACMember)
		End If 

		  If Len(custASZStartService) > 1 And year(Now) < Year(custASZEndservice) Then
			ASZMember = True
			'response.write(ACMember)
		End If 
    End If 


	While Not rs2.eof  
		IDArray(acounter) = rs2("ID")
		alpacaName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))


		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>
		<form  action="editalpaca.asp" method = "post">
			<h2>Select Another Alpaca</h2>
			Select an animal below and push the edit button to update an animals information:<br>
			  
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your alpacas:
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
						 If Len(alpacaName(count)) > 2 then
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=alpacaName(count)%>
						</option>
					<% End If 
					count = count + 1
					  
					wend %>
					</select>
					<input type=submit value = "Edit" style="background-image: url('images/background.jpg'); border-width:1px" size = "210" class = "menu" >
				</td>
			  </tr>
		    </table>
	
		 


		  <h2>Add a New Alpaca</h2>
			<a href = "addanalpaca.asp" class = "body">Click here</a> to add a new alpaca listing.

 </form>
		</td>
	</tr>
</table>


	<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  height = "300" width = "775">
	<tr>
	    <td class = "body" valign = "top" align = "right" width = "775">
					<!--#Include virtual="/administration/adminGeneralStatsInclude.asp"--><br>
					<!--#Include virtual="/administration/AdminPricingInclude.asp"--><br>
						<% If category = "Dam" Or Category = "maiden" Then %>
							<!--#Include virtual="/administration/AdminFemaledataInclude.asp"--><br>
					  <% End If %>
			<!--#Include virtual="/administration/AdminDescriptionInclude.asp"--><br>

		</td>
	</tr>
	<tr>
		 <td class = "body" valign = "top" >
		 </td>
		</tr>
			<td colspan = "2">
			
				<!--#Include virtual="/administration/AdminAwardsInclude.asp"--> 
				<!--#Include virtual="/administration/adminFiberInclude.asp"--> 
				<!--#Include virtual="/administration/AdminAncestryInclude.asp"--> 
<br><br>

</TD>
</TR>
</TABLE>	

