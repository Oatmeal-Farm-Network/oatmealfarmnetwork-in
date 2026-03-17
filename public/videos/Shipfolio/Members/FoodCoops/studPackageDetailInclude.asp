<%While Not rs.eof 
counter = counter +1	%>          
<%
for x=1 To 1 %>
<% if rs.eof then
exit for
end if 
alpacaID = rs("ID")
QTYBreeedings = rs("QTYBreedings")
 'response.write( alpacaID)
 alpacasPrice= rs("Price")
Sold 	= rs("Sold")
SalePending 	= rs("SalePending")
photoID = "nophoto"
If Len(rs("Photo1")) < 2 And Len(rs("Photo2"))< 2  And Len(rs("Photo3")) < 2  And Len(rs("Photo4")) < 2  And Len(rs("Photo5")) < 2 And Len(rs("Photo6")) < 2  And Len(rs("Photo7")) < 2  And Len(rs("Photo8")) < 2 then 
	photoId = "http://www.AlpacaInfinity.com/Uploads/NotAvailable.jpg"
	noimage = true
Else 
	noimage = false
End If
	ImageFound = false
If noimage = False Then
			 
If Len(rs("Photo1")) > 2 Then
	photoId = rs("Photo1")
	ImageFound = True
End if

If Len(rs("Photo2")) > 2  And ImageFound = false Then
	photoId = rs("Photo2")
	ImageFound = true
End if
				
If Len(rs("Photo3")) > 2  And ImageFound = false Then
	photoId = rs("Photo3")
	ImageFound = true
End If
				
If Len(rs("Photo4")) > 2  And ImageFound = false Then
	photoId = rs("Photo4")
	ImageFound = true
End If
				
If Len(rs("Photo5")) > 2  And ImageFound = false Then
	photoId = rs("Photo5")
	ImageFound = true
End If
				
If Len(rs("Photo6")) > 2  And ImageFound = false Then
	photoId = rs("Photo6")
	ImageFound = true
End If
				
If Len(rs("Photo7")) > 2  And ImageFound = false Then
	photoId = rs("Photo7")
	ImageFound = true
End If
				
If Len(rs("Photo8")) > 2  And ImageFound = false Then
	photoId = rs("Photo8")
	ImageFound = true
End If
				

if len(photoId) > 4 then
str1 = lcase(photoId)
str2 = "uploads"
str3 = "http://"
If Not(InStr(str1,str2) > 0) and Not(InStr(str1,str3) > 0) Then
photoId= "http://www.livestockofamerica.com/Uploads/" & photoId
End If 
str1 = lcase(ARIPhoto)
str2 = "uploads"
str3 = "http://"
If  InStr(str1,str2) > 0 and Not(InStr(str1,str3) > 0) Then
photoId = "http://www.livestockofamerica.com/" & photoId
End If 
end if


End If 
	
StudFee =  rs("StudFee")

%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<div align = "left" class = "body"><a href = "Details.asp?ID=<%=alpacaID%>" class = "heading2"><%=Trim(rs("FullName"))%>  - Stud Breeding</a></div>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center"> 
<table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" bgcolor = "antiquewhite"  width = "400" >
<% Category = "Other" %>
<% if len(BreedLookupID)> 0 then 
sqlb = "select * from SpeciesBreedLookupTable where BreedLookupID=" & BreedLookUpID 
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed = trim(rsb("Breed"))
CurrentSpeciesID = trim(rsb("SpeciesID"))
end if
rsb.close

 if len(CurrentSpeciesID )> 0 then 
sqlb = "select * from SpeciesAvailable where SpeciesID=" & CurrentSpeciesID 
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
CurrentSpecies = trim(rsb("Species"))
end if
rsb.close
end if

end if%>
<tr>
<td align = "center" class = "body" width = "110" height = "21">
		<img src = "images/px.gif" width = "110" height= "18"><br><a href = "Details.asp?ID=<%=alpacaID%>" ><img src = "<%= PhotoID %>" width="100" border = "0"></a>
</td>
<td class = "body" colspan = "3" valign = "top" width = "250"> 
	<table border = "0"  width = "250" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<tr><td width = "4">&nbsp;</td></tr>
<tr><td class = "body2" valign = "top" align = "right" width = "102" >
	# Breedings:&nbsp;
</td>
<td class = "body">
<%=QTYBreeedings%>
</td></tr>
 <% If Len(StudFee) > 2 Then %>
<tr><td class = "body2" valign = "top" align = "right" >
Stud Fee:&nbsp;
</td>
<td class = "body">
<b><%=formatcurrency(StudFee,0)%></b>
</td></tr>
<% End If %>
<tr><td class = "body2" valign = "top" align = "right">
Species:&nbsp;<br />
Breed:&nbsp;</br>
Category:&nbsp;<br>
DOB:&nbsp;<br>
Color(s):&nbsp;
<td class = "body" valign = "top">
<%=CurrentSpecies%><br>
<%=CurrentBreed%><br>		
<%=rs("category")%><br>
<%=rs("DOBMonth")%>/<%=rs("DOBDay")%>/<%=rs("DOBYear")%><br>
<% If Len(rs("color1")) > 1 Then %>
<%=rs("Color1")%>
<% end if %>
<% If Len(rs("color2")) > 1 Then %><br>/<%=rs("Color2")%><% end if %>
<% If Len(rs("color3")) > 1 Then %><br>/<%=rs("Color3")%><% end if %>
<% If Len(rs("color4")) > 1 Then %><br>/<%=rs("Color4")%><% end if %>
<% If Len(rs("color5")) > 1 Then %><br>/<%=rs("Color5")%><% end if %>	
</td>
</tr>
</tr>
<td colspan ="2">
<center>	<form name="input" action="Details.asp" method="put" >
<table align = "center" border = "0">
	<tr> 
		<td class = "body" align = "center" valign = "top">
			<form name="input" action="Details.asp" method="put" >
			<table align = "center" border = "0">
				<tr>
					<td>
						<input type="Hidden" name="ID" value = "<%=alpacaID%>">
						<input type="submit" value="View Details" value="Submit" class = "regsubmit2">
						&nbsp;
					</td>
				</tr>
			</table>
			</form>
		</td>
		<td class = "body" align ="left"  valign = "top">
			
		</td>
	</tr>
</table>
</form></center>
</td>
</tr>
</table>
</td>
</tr>	
</table>
</td>
</tr>	
</table>
<% rs.movenext
      next 
     Wend %>