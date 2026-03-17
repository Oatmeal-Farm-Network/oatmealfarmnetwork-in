<% 
	  
If Len(PageName) = 0 then
	PageName=Request.Form("PageName" ) 
End if

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			  sql = "select * from PageSEO where PageName='" & PageName & "';"

		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   




	
Title = rs("Title")
Description = rs("Description")
Keyword1 = rs("Keyword1")
Keyword2 = rs("Keyword2")
Keyword3 = rs("Keyword3")
Keyword4 = rs("Keyword4")
Keyword5 = rs("Keyword5")
Keyword6 = rs("Keyword6")
Keyword7 = rs("Keyword7")
Keyword8 = rs("Keyword8")
Keyword9 = rs("Keyword9")
Keyword10 = rs("Keyword10")
Keyword11 = rs("Keyword11")
Keyword12 = rs("Keyword12")
Keyword13 = rs("Keyword13")
Keyword14 = rs("Keyword14")
Keyword15 = rs("Keyword15")
Keyword16 = rs("Keyword16")
Keyword17 = rs("Keyword17")
Keyword18 = rs("Keyword18")
Keyword19 = rs("Keyword19")
Keyword20 = rs("Keyword20")



str1 = Description
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	Description= Replace(str1, str2 , vbCrLf)
End If  


str1 = Description
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	Description= Replace(str1,  str2, " ")
End If 

str1 = Description
str2 = "''"
If InStr(str1,str2) > 0 Then
	Description= Replace(str1,  str2, "'")
End If 


rs.close

Dim PageNameList(40000)	
	sql2 = "select PageSEO.* from Pagelayout, PageSEO where Pagelayout.PageLayoutId = PageSEO.PageLayoutId and  PageAvailable = True"	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
	
		PageNameList(acounter) = rs2("PageName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
	<tr>
		<td Class = "body">
			<h2>Select a Different Page</h2>
			<img src = "images/underline.jpg" width = "600"></H2>
		</td>
	</tr>
</table>
<form  action="PageSEOMantainance.asp" method = "post">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your pages:
					<select size="1" name="PageName">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=PageNameList(count)%>">
							<%=PageNameList(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Edit" style="background-image: url('images/background.jpg'); border-width:1px" size = "210" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>



<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
	<tr>
		<td Class = "body">
			<H2><% = PageName%> Content<br>
			<img src = "images/underline.jpg" width = "600"></H2>
		</td>
	</tr>
</table>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
	<tr>
		<td valign = "top">
			 <form action= 'PageSEOHandleForm.asp' method = "post">
			<input name="PageName"  size = "60" value = "<%=PageName%>" type = "hidden">
			<input name="ID"  size = "60" value = "<%=ID%>" type = "hidden">

<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
  	<tr>
			<td  align = "right"   class = "body">
					<b>Title</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Title"  size = "60" value = "<%=Title%>">
			</td>
		</tr>
		<tr>
			<td  align = "right"   class = "body" valign = "top" >
					<b>Description</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<TEXTAREA NAME="Description" cols="55" rows="10" wrap="file"><%=Description%></textarea>
			</td>
		</tr>
		<tr>
			<td  align = "right"   class = "body">
					<b>Keyword1</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Keyword1"  size = "60" value = "<%=Keyword1%>">
			</td>
		</tr>
		<tr>
			<td  align = "right"   class = "body">
					<b>Keyword2</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Keyword2"  size = "60" value = "<%=Keyword2%>">
			</td>
		</tr>
		<tr>
			<td  align = "right"   class = "body">
					<b>Keyword3</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Keyword3"  size = "60" value = "<%=Keyword3%>">
			</td>
		</tr>
				<tr>
			<td  align = "right"   class = "body">
					<b>Keyword4</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Keyword4"  size = "60" value = "<%=Keyword4%>">
			</td>
		</tr>
				<tr>
			<td  align = "right"   class = "body">
					<b>Keyword5</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Keyword5"  size = "60" value = "<%=Keyword5%>">
			</td>
		</tr>
				<tr>
			<td  align = "right"   class = "body">
					<b>Keyword6</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Keyword6"  size = "60" value = "<%=Keyword6%>">
			</td>
		</tr>
				<tr>
			<td  align = "right"   class = "body">
					<b>Keyword7</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Keyword7"  size = "60" value = "<%=Keyword7%>">
			</td>
		</tr>
				<tr>
			<td  align = "right"   class = "body">
					<b>Keyword8</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Keyword8"  size = "60" value = "<%=Keyword8%>">
			</td>
		</tr>
				<tr>
			<td  align = "right"   class = "body">
					<b>Keyword9</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Keyword9"  size = "60" value = "<%=Keyword9%>">
			</td>
		</tr>
				<tr>
			<td  align = "right"   class = "body">
					<b>Keyword10</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Keyword10"  size = "60" value = "<%=Keyword10%>">
			</td>
		</tr>
				<tr>
			<td  align = "right"   class = "body">
					<b>Keyword11</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Keyword11"  size = "60" value = "<%=Keyword11%>">
			</td>
		</tr>
				<tr>
			<td  align = "right"   class = "body">
					<b>Keyword12</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Keyword12"  size = "60" value = "<%=Keyword12%>">
			</td>
		</tr>
				<tr>
			<td  align = "right"   class = "body">
					<b>Keyword13</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Keyword13"  size = "60" value = "<%=Keyword13%>">
			</td>
		</tr>
				<tr>
			<td  align = "right"   class = "body">
					<b>Keyword14</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Keyword14"  size = "60" value = "<%=Keyword14%>">
			</td>
		</tr>
				<tr>
			<td  align = "right"   class = "body">
					<b>Keyword15</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Keyword15"  size = "60" value = "<%=Keyword15%>">
			</td>
		</tr>
				<tr>
			<td  align = "right"   class = "body">
					<b>Keyword16</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Keyword16"  size = "60" value = "<%=Keyword16%>">
			</td>
		</tr>
				<tr>
			<td  align = "right"   class = "body">
					<b>Keyword17</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Keyword17"  size = "60" value = "<%=Keyword17%>">
			</td>
		</tr>
				<tr>
			<td  align = "right"   class = "body">
					<b>Keyword18</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Keyword18"  size = "60" value = "<%=Keyword18%>">
			</td>
		</tr>
				<tr>
			<td  align = "right"   class = "body">
					<b>Keyword19</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Keyword19"  size = "60" value = "<%=Keyword19%>">
			</td>
		</tr>
				<tr>
			<td  align = "right"   class = "body">
					<b>Keyword20</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Keyword20"  size = "60" value = "<%=Keyword20%>">
			</td>
		</tr>

		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" >
		</td>
		</tr>
		</table></form>
