
<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" width = "<%=screenwidth - 40 %>">
<%
imagerows = 4
if screenwidth < 900 then
imagerows = 3
end if

if screenwidth < 800 then
imagerows = 2
end if

if screenwidth < 640 then
imagerows = 1
end if

oldanimalid= "0"
imagecount = 0
While Not rs.eof 
counter = counter +1	          
newanimalid= rs("ID")		
while oldanimalid = newanimalid and not rs.eof
    if not rs.eof then
    rs.movenext
   end if
    if not rs.eof then
  newanimalid= rs("ID")
  end if
wend
    
for x=1 to 1

 if rs.eof then
	exit for
end if 
AnimalID = rs("ID")

 StudFee= rs("StudFee")

 photoID = "nophoto"

       
if Len(rs("Photo1")) > 1 then
photoID = rs("Photo1")
Else
photoID = "/uploads/ImageNotAvailable.jpg"
end if
str1 = lcase(photoId)
str2 = "uploads"
str3 = "http://"
If Not(InStr(str1,str3) > 0) Then
photoId = "http://www.LivestockOfAmerica.com" & photoId
End If  

imagecount = imagecount + 1

if imagecount = 1 then	
	%> 
	<tr>
<% end if %>
<td valign = "top">			
<% Category = rs("Category")%>
<table border = "0"   leftmargin="5" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" width = "200" valign = "top">
<tr>
	<td  valign = "middle" class = "body"  align = "center" width = "200" height = "160" > 
   <a href = "Details.asp?ID=<%=AnimalID%>&DetailType=<%=DetailType%>&CurrentPeopleID=<%=CurrentpeopleID %>&screenwidth=<%=screenwidth %>" class = "Image"><img src = "<%= PhotoID %>" height="150" border = "1" bordercolor="black" class = "Image" style="border:1px solid black;" /></a>
 </td></tr>
 <tr><td align = "center" class = "body">
    <a href = "Details.asp?ID=<%=AnimalID%>&DetailType=<%=DetailType%>&CurrentPeopleID=<%=CurrentpeopleID %>&screenwidth=<%=screenwidth %>" class = "body"><b><%=Trim(rs("FullName"))%></b></a><br>

<% If Len(StudFee) > 1 Then %>
	<b><%=(FormatCurrency(StudFee,0))%> Stud Fee</b><br />
<% else %>
<b>Call for Fee</b><br />
<% End If %>

<div align = "right"><a href = "Details.asp?ID=<%=AnimalID%>&CurrentPeopleID=<%=CurrentpeopleID %>&screenwidth=<%=screenwidth %>" class = "body">Learn More...</a></div><br />
	</td>
	</tr>
	</table>	
	</td>
<% 
 if imagecount = imagerows then 
   imagecount = 0 
%>
</tr>
<% end if %>	
<% oldanimalid= rs("ID")
rs.movenext
 next 
Wend
         
if imagecount = 1 or imagecount = 2  then %>
      </tr>
<% end if %>
    </table>    
  <br /><br>   
