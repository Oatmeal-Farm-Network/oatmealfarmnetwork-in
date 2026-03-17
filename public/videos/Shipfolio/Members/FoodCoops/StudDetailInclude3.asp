

<table border = "0"  bordercolor = "#abacab" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" width = "<%=screenwidth-30 %>"   valign = "top">

<tr>
<td class = "body" align = "center" ><b>Name</b></td>
<td class = "body2" align = "center" width = "150"><b>Color</b></td>
<td class = "body2" align = "center" width = "150"><b>DOB</b></td>
<td class = "body2" align = "right" width = "150"><b>Stud Fee</b></td>
</tr>
<tr><td height = "1" bgcolor = "#abacab" colspan = "4"></td></tr>
<%
oldanimalid= "0"
	roworder = "nocolor"
While Not rs.eof 
counter = counter +1	
newanimalid= rs("id")		
if rs.recordcount > 1 then		
while oldanimalid = newanimalid and not rs.eof
  rs.movenext
  if not rs.eof then
  newanimalid= rs("ID")
  end if
wend
end if   

for x=1 to 1
DueDate	= ""
BredTo	= ""
ExternalStudID	= 0
ServiceSireID	= 0

if rs.eof then
	exit for
end if 
alpacaID = rs("id")
 'response.write( alpacaID)
StudFee = rs("StudFee")
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


Category = rs("Category")
%>
<tr ><td   class = "body">
  <a href = "Details.asp?ID=<%=alpacaID%>&DetailType=<%=DetailType%>&CurrentPeopleID=<%=CurrentpeopleID %>&screenwidth=<%=screenwidth %>" class = "body"><%=Trim(rs("FullName"))%></a>
</td>
<td valign = "top" class = "body2" align = "center">
<%
Color1 =rs("Color1")
Color2 = rs("Color2")
Color3 = rs("Color3")
Color4 = rs("Color4")
Color5 = rs("Color5")

if len(Color1) < 1 then
  Color1 = ""
end if
if len(Color2) < 1 then
  Color2 = ""
end if
if len(Color3) < 1 then
  Color3 = ""
end if
if len(Color4) < 1 then
  Color4 = ""
end if
if len(Color5) < 1 then
  Color5 = ""
end if														
%> 


<% If len(Color1) > 1 or len(Color2) > 1 or len(Color3) > 1 or len(Color4) > 1 or len(Color5) > 1 Then %>
		<% If len(Color1) > 1 Then %>
				<%=Color1%>
		<% end If %>
											
		<% If Len(Color2) > 1 Then %>
				/<%=Color2%>
		<% end If %>
												
		<% If Len(Color3) > 1 Then %>
				/<%=Color3%>
		<% end If %>

		<% If Len(Color4) > 1 Then %>
				/<%=Color4%>
		<% end If %>

		<% If Len(Color5) > 1 Then %>
				/<%=Color5 %>
		<% end If %>
<% end If %>
</td>
<td valign = "top" class = "body2" align = "center" >
<% 
DOBDay=rs("DOBDay")
if len(DOBDay)> 0 then
	DOBDay = cint(DOBDAY)
else
	DOBDay  = 0
end if
	DOBMonth=rs("DOBMonth")
if len(DOBMonth)> 0 then
	DOBMonth = cint(DOBMonth)
else
	DOBMonth  = 0
end if
										
DOBYear=rs("DOBYear") 
if len(DOBYear)> 0 then
	DOBYear = cint(DOBYear)
else
	DOBYear  = 0
end if
%>

<% if DOBDay> 0 or DOBMonth> 0 or DOBYear> 0 then %><% if DOBMonth > 0 then %><%=DOBMonth %>/<% end if  %><% if DOBDay > 0 then %><%=DOBDay %>/<% end if  %><% if DOBYear > 0 then %><%=DOBYear %><% end if  %><% end if %>
</td>
								
<td class = "body2" valign = "top" align = "right" >

								


<% if  len(StudFee) > 1 then%>
<b><%=(FormatCurrency(StudFee,0))%></b>
<% else %>
Call for Fee
<% end if  %>


	</td>
</tr>
<tr><td height = "1" bgcolor = "#abacab" colspan = "4"></td></tr>
<%   oldanimalid= rs("id")
rs.movenext
             next 
         Wend %>
         <td colspan = "4"></td>
	</table>
	<br /><br />