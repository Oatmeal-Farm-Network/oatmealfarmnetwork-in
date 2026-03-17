<%
Set rsb = Server.CreateObject("ADODB.Recordset")
oldanimalid = 0
While Not rs.eof 

	counter = counter +1	%>          
<%
   for x=1 To 1 %>
<% if rs.eof then
		exit for
       end if 
alpacaID = rs("ID")
skip = False
if alpacaID = oldanimalid then skip = True
oldanimalid = alpacaID

if skip = False then
breedlookupID = rs("BreedID")
 alpacasPrice= rs("Price")
Sold 	= rs("Sold")
SalePending 	= rs("SalePending")
photoID = "nophoto"
If Len(rs("Photo1")) < 2 And Len(rs("Photo2"))< 2  And Len(rs("Photo3")) < 2  And Len(rs("Photo4")) < 2  And Len(rs("Photo5")) < 2 And Len(rs("Photo6")) < 2  And Len(rs("Photo7")) < 2  And Len(rs("Photo8")) < 2 then 
	photoId = "http://www.LivestockOfAmerica.com/Uploads/NotAvailable.jpg"
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
str1 = lcase(photoId)
str2 = "uploads"
str3 = "http://"
If  InStr(str1,str2) > 0 and Not(InStr(str1,str3) > 0) Then
photoId = "http://www.livestockofamerica.com/" & photoId
End If 
end if


End If 
	
FullPrice =  rs("price")
If Len(rs("StartingPrice")) > 3 Then
	Startingprice =  rs("StartingPrice")
else
	Startingprice =  FullPrice
End If


Discount = (rs("Discount"))
If discount > 1 Then
DiscountPrice = cLng(FullPrice) - cLng(fullprice)*(cLng(discount)/100)
Else
	DiscountPrice = FullPrice
End if
 If not Sold = True Then 
%> 
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left"><a href = "Details.asp?ID=<%=alpacaID%>" class = "heading2"><b><%=Trim(rs("FullName"))%></b></a></div></H1>
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
<td align = "center" class = "body" width = "130">
		<img src = "images/px.gif" width = "130" height= "10"><br><a href = "Details.asp?ID=<%=alpacaID%>" ><img src = "<%= PhotoID %>" width="110" border = "0"></a>
</td>
<td class = "body" colspan = "3" valign = "top" width = "330">
	<table border = "0"  width = "330" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
 
<% If Len(rs("price")) > 2 Then %>
	<% If Sold = True Or SalePending = True Then 
		If Sold = True Then %>
		<tr><td class = "body" valign = "top" colspan = "2">
			<br><h2><font color = "red" size = "5"><b>SOLD</b></font></h2>
		</td></tr>
		<% End if %>
		<%  If SalePending= True And Sold = False Then %>
			<tr><td class = "body" valign = "top" colspan = "2">
				<br><font color = "red" size = "6">Sale<br><br>Pending</font>
			</td ></tr>
		<% End if %>
<% End if %>

<% If Len(discount) > 1 Then %>
<tr><td class = "body2" valign = "top" align = "right">
	Full Price:
</td>
<td class = "body" align = "left">
	<b><%=formatcurrency(Fullprice,0)%></b><br>
</td></tr>
<tr><td class = "body2" valign = "top" align = "right">
	Discount:<br>
</td>
<td class = "body" align = "left">
	<font color ="red"><%=Discount%>%</font>
</td></tr>
<tr><td class = "body2" valign = "top" align = "right">
	Discount Price: 
</td>
<td class = "body" align = "left">
	<font color ="red"><%=formatcurrency(DiscountPrice, 0)%></font><br>
</td></tr>
<% else %>
<tr><td class = "body2" valign = "top" align = "right">
	Price:
</td>
<td class = "body" align = "left">
	<b><%=formatcurrency(Fullprice,0)%></b><br>
</td></tr>
<%End If %>

<% If Len(ARI) > 1 Then %>
 	<tr><td class = "body2" >ARI#:</td>
	<td class = "body" align = "left"><%=ARI%></td></tr>
<% End If %>
<tr><td class = "body2" valign = "top" width = "100" align = "right">
Species:&nbsp;<br />
Breed:&nbsp;</br>
Category:&nbsp;<br>
DOB:&nbsp;<br>
Color(s):&nbsp; 
<td class = "body" align = "left" valign = "top">
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
<% End If %>
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
<% end if
end if

rs.movenext
      next 
     Wend %>