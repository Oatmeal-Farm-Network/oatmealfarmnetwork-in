<!--#Include file="AdminGalleryHeader.asp"-->

<% GalleryID= Request.Form("GalleryID")
if len(GalleryID) > 0 then
else
	GalleryID= Request.querystring("GalleryID")
End If
if len(GalleryCatID) > 0 then
else
	GalleryCatID= Request.querystring("GalleryCatID")
End If

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
"User Id=;Password=;" 
Set rsh = Server.CreateObject("ADODB.Recordset")
Set rs = Server.CreateObject("ADODB.Recordset")	
Set rs3 = Server.CreateObject("ADODB.Recordset")	

if len(GalleryID) > 0 then
sql =  "select gallerycategoryname, GalleryCatID from GalleryCategories where GalleryCatID = " & GalleryID
'response.write("sql=" & sql)

rsh.Open sql, conn, 3, 3 
if Not rsh.eof then
   gallerycategoryname = rsh("gallerycategoryname")
   GalleryCatID = rsh("GalleryCatID")
end if	
rsh.close
end if

'response.write("GalleryCatID=" & GalleryCatID)

%>
  <table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
		<tr>
			<td class = "body">
				<H1>Edit <%= gallerycategoryname%> Gallery Images</H1>			
			</td>
		</tr>
	</table>


<form  action="AdminGalleryEditImages.asp" method = "post">
	<input  type="hidden" name = "GalleryCatID" value="<%=GalleryCatID%>">

			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
				 <br>Select one of your Photo Galleries:
				 <% sql =  "select * from GalleryCategories order by gallerycategoryname "
						'response.write("sql=" & sql)
				%>
					<select size="1" name="GalleryID">
					<option name = "AID0" value= "" selected></option>
					
					<% 
						
						rs.Open sql, conn, 3, 3 
						While Not rs.eof 					%>
						<option name = "AID1" value="<%=rs("GalleryCatID")%>">
							<%=rs("GalleryCategoryName")%></option>
					<% 	rs.movenext
Wend 
 %>
					</select>
					
					<input type=submit value = "Edit" style="background-image: url('images/background.jpg'); border-width:1px" size = "210" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
<% 
rs.close %>



<%	if len(GalleryCatID) > 0 then 

sql3 =  "select * from Gallery Where GalleryCatID = " & GalleryCatID
 	rs3.Open sql3, conn, 3, 3 
 	if not rs3.eof then
 	totalcount = rs3.recordcount
 	end if

%>
<table Border = "1" Bgcolor = "#dddddd" width = "748" align = "center">		
<%	sql = "select * from Gallery where len(GalleryImage) > 1 and GalleryCatID = " & GalleryCatID & " order by ImageOrder"
	'response.write(sql)
	rs.Open sql, conn, 3, 3
	
imagecount = 0	
While Not rs.eof
	GalleryImage= rs("GalleryImage")
	ImageOrder= rs("ImageOrder")
	GalleryCaption = rs("GalleryCaption")
	GalleryID = rs("GalleryID")
	
if imagecount = 0 then
%>
<tr>
<% end if %>
<td width = "187" align = "center" class = "body">
	 <!-- #include file="AdminGalleryImageUpdateInclude.asp" -->
	
</td>

<% rs.movenext
imagecount = imagecount + 1	
if imagecount = 4 or rs.eof then 
	imagecount = 0%>
<tr>
<% end if 
Wend
rs.close %>
</table>		
<% end if %>
    <br> 