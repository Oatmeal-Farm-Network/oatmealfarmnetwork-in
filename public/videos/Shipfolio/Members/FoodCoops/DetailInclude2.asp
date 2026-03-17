
<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" width = "<%=screenwidth -40 %>">

<%
oldanimalid= "0"
imagecount = 0
While Not rs.eof 
			counter = counter +1	          
     newanimalid= rs("ID")
 if not rs.eof then		
while oldanimalid = newanimalid and not rs.eof
  rs.movenext
  if not rs.eof then
  newanimalid= rs("ID")
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
alpacaID = rs("ID")
ShowPrices= rs("ShowPrices")

alpacasPrice= rs("Price")
Free= rs("Free")
Discount= rs("Discount")
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


str1 = lcase(photoId)
str2 = "uploads"
str3 = "http://"
If Not(InStr(str1,str3) > 0) Then
photoId = "http://www.Livestockofamerica.com" & photoId
End If 
End If 


If trim(lcase(photoId)) = "http://www.livestockofamerica.com" Then
photoId = "/Uploads/ImageNotAvailable.jpg"
End If 

If trim(photoId) = "http://www.livestockoftheworld.com" Then
photoId = "/Uploads/ImageNotAvailable.jpg"
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
<table border = "0"   leftmargin="5" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" width = "200" valign = "top">
<tr>
		<td   valign = "middle" class = "body"  align = "center" width = "200" height = "160" >                    
           <a href = "Details.asp?ID=<%=alpacaID%>&DetailType=<%=DetailType%>&CurrentPeopleID=<%=CurrentpeopleID %>&screenwidth=<%=screenwidth %>" class = "Image"><img src = "<%= PhotoID %>" height="150" border = "1" bordercolor="black" class = "Image" style="border:1px solid black;" /></a>
           </td></tr>
           <tr><td align = "center" class = "body">
            <a href = "Details.asp?ID=<%=alpacaID%>&DetailType=<%=DetailType%>&CurrentPeopleID=<%=CurrentpeopleID %>&screenwidth=<%=screenwidth %>" class = "body"><b><%=Trim(rs("FullName"))%></b></a><br>
 <% If rs("Sold") = true Then %>
<b><font color ="#155289" size = "3">Sold!</font></b><br>
<%End If %>
<% If rs("SalePending")  = true Then %>
<b><font color ="#155289" size = "3">Sale Pending</font></b><br>
<%End If %>

<% If ShowPrices = 1 then%>

<% price = cLng(rs("price"))

If Len(rs("price")) > 2 and Len(Discount) < 2 Then %>
	Price:	<b><%=(FormatCurrency(price,0))%></b>
<% End If %>
<% If Free = "True" Then %>
		<b>Free</b><br />
<% End If %>
<% If Len(rs("price")) > 1 or Len(Discount) >1  then
else
if not Free = "True" Then %>
Call for Price
<% end if %>
<% end if %>
<% end if %>


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

<div align = "right"><a href = "Details.asp?ID=<%=alpacaID%>&DetailType=<%=DetailType%>&CurrentPeopleID=<%=CurrentpeopleID %>&screenwidth=<%=screenwidth %>" class = "body">Learn More...</a></div><br />
	</td>
	</tr>
	</table>	
	</td>
<% 
 if imagecount = 3 then 
   imagecount = 0 
%>
</tr>
<% end if %>	
             <%   oldanimalid= rs("ID")

rs.movenext
             next 
         Wend
         
if imagecount = 1 or imagecount = 2  then %>
      </tr>
<% end if %>
    </table>    
  <br /><br>   
