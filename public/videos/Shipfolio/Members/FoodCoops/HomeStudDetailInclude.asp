<%
oldanimalid= "0"
	roworder = "nocolor"
While Not rs.eof 
			counter = counter +1	
			
			newanimalid= rs("id")		
'if rs.recordcount > 1 then		
'while oldanimalid = newanimalid and not rs.eof
 ' rs.movenext
 ' if not rs.eof then
 ' newanimalid= rs("ID")
 ' end if
'wend
' end if   

             for x=1 to 1
			 	DueDate	= ""
				BRedTo	= ""
				ExternalStudID	= 0
				ServiceSireID	= 0

				  if rs.eof then
					exit for
                 end if 
                alpacaID = rs("id")
               'response.write( alpacaID)
               	alpacasPrice= rs("Price")
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
photoId = "http://www.AlpacaInfinity.com" & photoId
End If 
End If 

If Len(PhotoID) < 4 then 
click =  " <form action=""studDetails.asp"" method=""get"">" &_
"<input name=ID type=hidden value=" &  alpacaID & ">" & hiddenInput &_
"<input name=DetailType type=hidden value=" & DetailType & ">" &_
"<input name=Detail type=image src=""/uploads/ImageNotAvailable.jpg""  border=0  width=""150"" ></form>"
Else
click =  " <form action=""StudDetails.asp"" method=""get"">" &_
"<input name=ID type=hidden value=" &  alpacaID & ">" & hiddenInput &_
"<input name=DetailType type=hidden value=" & DetailType & ">" &_
"<input name=Detail type=image src=""" & PhotoID &"""  border=0  width=""150"" ></form>"     
End If
Category = rs("Category")
%>

<a href = "details.asp?ID=<%=rs("ID") %>&CurrentPeopleID=<%=CurrentpeopleID %>" class = "body"><%=rs("FullName") %></a> <%=rs("Color1") %>&nbsp;  Stud Fee:
<% if len(rs("StudFee")) > 2 then%>
	       <%=formatcurrency(rs("StudFee"),2) %>
<% else %>
Call for Price
	   <% end if %>
	    <% if rs("OBO") = True then %>
	    <a class="tooltip" href="#"><b>OBO</b><span class="custom info"><img src="/images/logoTip.png" alt="About OBO" height="48" width="48" /><em>About OBO</em>By offering OBO the seller is willing to consider any offers that are made; however, that does not mean that they have to accept an offer.</span></a>
 <% end if %>
 <br />
<%   oldanimalid= rs("id")
rs.movenext
next 
Wend %>