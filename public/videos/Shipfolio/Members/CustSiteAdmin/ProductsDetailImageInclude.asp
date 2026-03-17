
<%

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
	
	Set rsA = Server.CreateObject("ADODB.Recordset")
	sql = "select * from ProductsAdditionalPhotos where ID=" & ProductID & " Order by PhotoOrder"
	'response.write(sql)
	counter = 0

	rsA.Open sql, conn, 3, 3 
	if not rsA.eof then 

    'response.write(" Image=")
  'response.write( rsA("Image"))


	imageone = "/Uploads/Products/" + rsA("Image")
	'response.write(imageone)
	ButtoncounterStart  = Buttoncounter
	counttotal = rsA.recordcount
	While counter < counttotal
		Buttoncounter = Buttoncounter + 1
		counter = counter +1
		buttonimages(counter) = "/Uploads/Products/" & rsA("Image") 
		buttontitle(counter) = rsA("ImageTitle")
		'response.write(rsA("Image"))
%>
<script language="JavaScript">
               if (document.images) version = "n3";
               else version = "n2";
               if (version == "n3") {
				but<%=Buttoncounter%>on = new Image(85, 115);
				but<%=Buttoncounter%>on.src = "/Uploads/Products/<%=rsA("Image")%>";
			   }
	

       function img<%=Buttoncounter%>(imgName) {
               if (version == "n3") {
               imgOn = eval("but<%=Buttoncounter%>on.src");
               document [imgName].src = imgOn;               }       }
      
      
</script>

<% 
		if counter< counttotal then
			rsA.movenext
		end if
	Wend
 Buttoncounter = ButtoncounterStart 
%>

<% end if %>



					<% if counter < 1 Then
					     %>
							<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 style="border-style: ridge; border-color: #6a7d67 ; border-right-width: 3; border-left-width: 2; border-top-width: 2; border-bottom-width: 3" >
							<tr>
								<td>
								     <img src = "/uploads/Products/NotAvailable.jpg" width = "200">
								</td>
							</tr>
						</table>
						<% else  %>
							<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 style="border-style: ridge; border-color: #6a7d67 ; border-right-width: 3; border-left-width: 2; border-top-width: 2; border-bottom-width: 3" >
							<tr>
								<td>
									<IMG alt="main image" border=0  name="but<%=ID%>" src="<%=buttonimages(1)%>" align = "center" height = "200">
								</td>
						</tr>
			</table>
						<% end if%>

<%

	if not rsA.eof then
	rsA.movefirst
	counter = 0
	counttotal = rsA.recordcount
	
	While counter < counttotal
	
		%>

		<table border="0" cellspacing="0" align = "center" valign = "top" >
			<tr>
		<% for x= 1 to 3
		   	Buttoncounter= Buttoncounter +1
			 if counter = counttotal then
					exit for
             end if 
			bcounter =bcounter +1
			counter = counter +1
			if rsA.recordcount > 1 then
			%>
			<td valign = "top" align = "center">
			<font 
			onMouseOver="img<%=Buttoncounter%>('but<%=ID%>'), this.style.cursor = 'hand'" 
			onMouseOut="img<%=Buttoncounter%>('but<%=ID%>')"  class = "menu">
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
