
<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" width = "<%=screenwidth -30 %>">

<%
oldanimalid= "0"
imagecount = 0
While Not rs.eof 
CurrentpeopleID = rs("PeopleID")

counter = counter +1	          
     newanimalid= rs("AnimalID")
StartingPrice = rs("StartingPrice") 
CurrentPrice = StartingPrice- (StartingPrice * (FFAADiscount / 100))


Price= rs("Price")


 if not rs.eof then		
while oldanimalid = newanimalid and not rs.eof
  rs.movenext
  if not rs.eof then
  newanimalid= rs("animalID")
  end if
wend
 end if   
          
for x=1 to 1
DueDate	= ""
BRedTo	= ""
ExternalStudID	= 0
ServiceSireID	= 0
if rs.eof then
exit for
end if 
alpacaID = rs("animalID")

photoId =""
If Len(trim(rs("Photo1"))) < 4 And Len(trim(rs("Photo2")))< 4  And Len(trim(rs("Photo3"))) < 4  And Len(trim(rs("Photo4"))) < 4   then 
photoId = "/Uploads/ImageNotAvailable.jpg"
noimage = true
Else 
noimage = false
End If
ImageFound = false
If noimage = False Then
If Len(rs("Photo1")) > 2 Then
photoId = rs("Photo1")
ImageFound = true
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

if len(PhotoID) < 8 then
photoId = "/Uploads/ImageNotAvailable.jpg"
end if

str1 = lcase(photoId)
str2 = "uploads"
str3 = "http://"
If Not(InStr(str1,str3) > 0) Then
photoId = "http://www.LivestockOfAmerica.com" & photoId
End If 
End If 


If Len(PhotoID) < 4 then 
click =  " <form action=""Details.asp"" method=""get"">" &_
"<input name=ID type=hidden value=" &  alpacaID & ">" & hiddenInput &_
"<input name=DetailType type=hidden value=" & DetailType & ">" &_
"<input name=Detail type=image src=""/uploads/ImageNotAvailable.jpg""  border=0  width=""150"" ></form>"
Else
click =  " <form action=""Details.asp"" method=""get"">" &_
"<input name=ID type=hidden value=" &  alpacaID & ">" & hiddenInput &_
"<input name=DetailType type=hidden value=" & DetailType & ">" &_
"<input name=Detail type=image src=""" & PhotoID &"""  border=0  width=""150"" ></form>"     
End If
imagecount = imagecount + 1
if imagecount = 1 then	
%> 
<tr>
<% end if %>
<td valign = "top"><% Category = rs("Category")%>
<table border = "0"   leftmargin="5" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" width = "<%=(screenwidth /3) - 20%>" valign = "top" class = "roundedtopandbottom">
<tr><td   valign = "middle" class = "body2"  align = "center" width = "200" height = "160" > 
                            
<a href = "Details.asp?ID=<%=alpacaID%>&DetailType=<%=DetailType%>&CurrentPeopleID=<%=CurrentpeopleID %>" class = "Image"><img src = "<%= PhotoID %>" height="150" border = "1" bordercolor="black" class = "Image" style="border:1px solid black;" /></a>
 </td></tr>
<tr><td align = "center" class = "body">
<a href = "Details.asp?ID=<%=alpacaID%>&DetailType=<%=DetailType%>&CurrentPeopleID=<%=CurrentpeopleID %>" class = "body"><b><%=Trim(rs("FullName"))%></b></a><br>
 <% If rs("Sold") = true Then %>
<b><font color ="#155289" size = "3">Sold!</font></b><br>
<%End If %>
<% If rs("SalePending")  = true Then %>
<b><font color ="#155289" size = "3">Sale Pending</font></b><br>
<%End If %>
<% 
price = cLng(rs("price"))

If Len(rs("price")) > 2 and Len(Discount) < 2 Then %>
	Full Price:	<b><%=(FormatCurrency(price,0))%></b>
<% End If %>

<br />Current Price: <b><%=formatcurrency(Currentprice,0) %></b>

<% If Len(color1) > 1 Then %>
<%=Color1%><% end if %>
<% If Len(color2) > 1 Then %>/<%=Color2%>
<% end if %>
<% If Len(color3) > 1 Then %>
<br>/<%=Color3%>
<% end if %>
<% If Len(color4) > 1 Then %>
<br>/<%=Color4%>
<% end if %>
<% If Len(color5) > 1 Then %>
<br>/<%=Color5%>
<% end if %><br />
<%=category %><br />

<% If Len(Discount) > 1 Then %>
Discount Price:<b><font color ="#990000"><%=formatcurrency(Price * ((100-Discount)/100), 0)%></font></b><br>
<%End If %>	

<a href = "Details.asp?ID=<%=alpacaID%>&DetailType=<%=DetailType%>&CurrentPeopleID=<%=CurrentpeopleID %>" class = "body">Learn More...</a><br />
	</td>
	</tr>
	</table>	
	</td>
    <td width = 10></td>
<% 
 if imagecount = 3 then 
   imagecount = 0 
%>
</tr>
<tr><td colspan = 6 height = 6></td></tr>
<% end if %>	
<% oldanimalid= rs("animalID")
rs.movenext
next 
Wend%>
</table>