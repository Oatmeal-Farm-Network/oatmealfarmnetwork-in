<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>Home Infatuation - welcome to outdoor living</TITLE>
<META NAME="Generator" CONTENT="Webartists.biz">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<link rel="stylesheet" href="test2/style-summer.css" type="text/css">




<style type="text/css">
.hiddenPic {display:none;}
</style>

</HEAD>

<body border="0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0>

<IMG alt="main image" border=0 width="0" height="0" name=but1 src="Images/px.gif" align = "center"><IMG alt="main image" border=0 width="0" height="0" name=but2 src="Images/px.gif" align = "center"><table border="0" width="730" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0>
		<tr>
			<td width = "365" height = "253" bgcolor = "#aab294" align = "center"><img ID="td1" height = "253" src ="http://www.homeinfatuation.com/Uploads/Details/<%= 	rs("prodImageLargePath")%>"></td>
	

<%
		if  len(rs("text")) < 5 then
		%>		
			<td width = "365" height = "253" background= "../Uploads/Bios/<%=rs("prodImageSmallPath")%>" valign = "bottom">
				<img ID="td2"  src= "images/px.gif">
			</td>
		<% else%>
				<td width = "365" height = "253"   bgcolor = "white" align = "left" >
					<table width = "362" background= "../Uploads/Bios/<%=rs("prodImageSmallPath")%>">
						<tr>
							<td width = "160" valign = "bottom">
									<img ID="td2"  src= "images/px.gif">
							</td>
							<td>
							<%=rs("text")%>
							</td>
						</tr>
					</table>
			</td>
		<% end if	
	else %>
			<td width = "365" height = "253" background= "images/Tilebackground.jpg" valign = "bottom">
				<img ID="td2"  src= "images/px.gif">
			</td>
		<% end if	%>		
		</tr>
</table>

<table border="0" width="730" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 bgcolor = "white">
	<tr>
			<td colspan = "5" height = "2" bgcolor = "#eceaee"><img src = "images/px.gif" height = "2" width = "1"></td>
		</tr>
		<tr>
		<td width = "2" bgcolor = "#eceaee"><img src = "images/px.gif" height = "1" width = "1"></td>
		<td width = "365" class = "body" align = "center">
			<% recordcount = rs.recordcount
				counter = 0
				
				If recordcount > 1 then%>
					Images:
				<%
					while not rs.eof 
						counter = counter +1%>
						<font color = "green" onmouseover="img1('but1'), document.all.td1.src = '../Uploads/Details/<%=rs("prodImageLargePath")%>';this.style.color = 'black' ; this.style.cursor = 'hand' "
						onmouseout="this.style.color = 'green'  "
							class = "homelinks" >
							<%=counter%></font>
			<% rs.movenext
				 wend 
				 end if
				
				 sql = "SELECT  * FROM sfSwatches WHERE prodId=" & ID & " ;"
						Set rs = Server.CreateObject("ADODB.Recordset")
						'response.write(sql)
						rs.Open sql, cnn, 3, 3   
				 %>
		</td>
		<td width = "2" bgcolor = "#eceaee"><img src = "images/px.gif" height = "1" width = "1"></td>
		<td width = "365"class = "body">
			<% if not rs.eof then%>
				Swatches:
				<%while not rs.eof %>
					<font color = "green" onmouseover="img2('but2'), document.all.td2.src = '../Uploads/Swatches/<%=rs("SwatchName")%>';this.style.color = 'black' ; this.style.cursor = 'hand' "
						onmouseout="this.style.color = 'green' " class = "homelinks" >
							<img src= "../Uploads/Swatches/<%=rs("SwatchName")%>" alt = "<%=rs("SwatchImage")%>" height = "14"></font>

			<% rs.movenext 
				wend
				end if%>
		</td>
		<td width = "2" bgcolor = "#eceaee"><img src = "images/px.gif" height = "1" width = "1"></td>
	</tr>
	<tr>
			<td colspan = "5" height = "2" bgcolor = "#eceaee"><img src = "images/px.gif" height = "2" width = "1"></td>
		</tr>
</table>




</body>
</html>



