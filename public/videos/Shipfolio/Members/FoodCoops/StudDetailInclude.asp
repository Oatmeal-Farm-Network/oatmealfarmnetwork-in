
<table border = "0" width = "<%=screenwidth -30%>" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">

<%
oldanimalid= "0"
While Not rs.eof 
counter = counter +1	
			
newanimalid= rs("id")		
if not rs.eof then	
'response.write("oldanimalid=" & oldanimalid )
'response.write("Newanimalid=" & Newanimalid )
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
if DetailType = "Dam" then
	sqld = "SELECT * FROM Femaledata WHERE ID = " & newanimalid 
    Set rsd = Server.CreateObject("ADODB.Recordset")
    rsd.Open sqld, conn, 3, 3   
    if not rsd.eof then
		ExternalStudID	= rsd("ExternalStudID")
		ServiceSireID	= rsd("ServiceSireID")
		DueDate = rsd("DueDate")
		Bred = rsd("Bred")
	end if
end if
 if rs.eof then
	exit for
 end if 
 

AnimalID = rs("id")
StudFee= rs("StudFee")

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


Category = rs("Category")%>

<tr><td colspan = 2 height = 1 bgcolor = "#abacab"></td></tr>
<tr><td colspan = 2 height = 40 bgcolor = "<%=menuBackgroundColor%>">
<b>
<a href = "Details.asp?ID=<%=AnimalID%>&DetailType=<%=DetailType%>&CurrentPeopleID=<%=CurrentpeopleID %>&screenwidth=<%=screenwidth %>" class = "body">
<font size = "3" color = white><b><%=Trim(rs("FullName"))%></font>
</b></a></td></tr>
<tr><td colspan = 2 height = 1 bgcolor = "#abacab"></td></tr>

<tr><td valign = "top"  class = "body" rowspan = "2" align = "center" width = "180" >

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 align = "center" width= "100%"><tr><td><a href = "Details.asp?ID=<%=AnimalID%>&DetailType=<%=DetailType%>&CurrentPeopleID=<%=CurrentpeopleID %>&screenwidth=<%=screenwidth %>" ><img src = "<%= PhotoID %>" width="150"  border = "1" bordercolor="black" class = "Image" style="border:1px solid black;" ></a><br><br></td></tr></table>
</td>
<td class= "body"   valign = "top">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=3 cellspacing=0 width = "<%=screenwidth -180 %>" align = "center">
<tr>
<td class = body2 align = "right" width = 100>Stud Fee</td>
<td class = "body" colspan = "3">									
<% if len(StudFee) > 1 then %>
<b><%=(FormatCurrency(StudFee,0))%></b>
<% else %>
<b>Call For Fee</b>
<% end if %>
</td><tr>
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

If len(Color1) > 1 or len(Color2) > 1 or len(Color3) > 1 or len(Color4) > 1 or len(Color5) > 1 Then %>
<tr>
</tr><td class = "body2"  align = "right" >
	Color
</td>
<td class = "body"  align = "right" colspan = 3>
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
</tr>
<% end if %>
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

if DOBDay > 0 or DOBMonth > 0 or DOBYear > 0 then %>
<tr>
<td class = "body2"  align = "right" >
   DOB
</td>
<td class = "body"  >
<% if DOBDay> 0 or DOBMonth> 0 or DOBYear> 0 then %><% if DOBMonth > 0 then %><%=DOBMonth %>/<% end if  %><% if DOBDay > 0 then %><%=DOBDay %>/<% end if  %><% if DOBYear > 0 then %><%=DOBYear %><% end if  %><% end if %>
</td>
</tr>
<% end if %>
<% Sire = rs("Sire")
			DBSire = Sire
		str1 = DBSire
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		DBSire= Replace(str1, "'", "''")
	End If

			Set rsSire = Server.CreateObject("ADODB.Recordset")
			sqlSire = "select ID, FullName from Animals where trim(FullName) = '"  & DBSire & "'"
			rsSire.Open sqlSire, conn, 3, 3 

			if not rsSire.eof then 
				SireChoice = 1 %>
				<%counter = counter +1
				Sire 	= trim(rsSire("FullName"))
				SireID 	= rsSire("ID")%>
					
		<%
			else if len(SireLink) > 1 then 
				SireChoice = 2
			else SireChoice = 3 
		   end if
		end if
		
			str1 = Sire
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				Sire= Replace(str1, "''", "'")
				Sire = trim(Sire)
			End If
			
			
		
		rsSire.close
		set rsSire=nothing
		if SireChoice = 1 then %>	

		<% end if %>
<%
	Dam = rs("Dam")
			'response.write(Sire)
			DBDam = Dam
				str1 = Dam
			str2 = "'"
			If InStr(str1,str2) > 0 Then
				DBDam= Replace(str1, "'", "''")
				DBDam = trim(DBDam)
			End If

			Set rsDam = Server.CreateObject("ADODB.Recordset")
			sqlDam = "select ID, FullName from Animals where trim(FullName) = '"  & DBDam & "'"
			rsDam.Open sqlDam, conn, 3, 3 

			if not rsDam.eof then 
				DamChoice = 1 
				 Dcounter = Dcounter +1
				Dam = trim(rsDam("FullName"))
				DamID 	= rsDam("ID")
			else if len(DamLink) > 1 then
				DamChoice = 2
			else DamChoice = 3
		   end if
		end if
		
				str1 = Dam
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				DBDam= Replace(str1, "''", "'")
				DBDam = trim(DBDam)
			End If
			
		rsDam.close
		set rsDam=nothing
		%>
<% if len(sire) > 1 then %>
<tr><td class = "body2" align = "right" >Sire</td>
<% if SireChoice = 1 then  %>
<td  class = "body" ><a href = "Details.asp?ID=<%=SireID%>&DetailType=Sire&screenwidth=<%=screenwidth %>" class = "body"><%=Sire%></a></td>
<% else if  SireChoice = 2 then%>
<td class = "body" ><a class = "body" target = "_blank" href ="http://<%=SireLink%>"> <%=Sire%></a></td>
<%else %>
<td  class = "body" ><%=Sire%></td>
<% end if
end if
%>
</tr>
<% end if %>

<% if len(dam) > 1 then %>
<tr>
<td  class = "body2" align = "right">Dam</td>
<%if DamChoice = 1 then %>
<td  class = "body" ><a href = "Details.asp?ID=<%=DamID%>&DetailType=Dam&screenwidth=<%=screenwidth %>" class = "body"><%=Dam%></a></td>
<% else if DamChoice = 2 then%>
<td class = "body" ><a class = "slink" target = "_blank" href =<%=DamLink%>> <%=Dam%></a></td>
<%else %>
<td  class = "body" ><%=Dam%></td>
<% end if
end if %>
</tr>
<% end if %>

<tr><td></td>
<td class = "body"  >
	&nbsp;&nbsp;&nbsp;<a href = "Details.asp?ID=<%=AnimalID%>&DetailType=<%=DetailType%>&CurrentPeopleID=<%=CurrentpeopleID %>&screenwidth=<%=screenwidth %>" class = "regsubmit2">LEARN MORE</a><br><br><br>
</td>
</tr>
</table>
</td>
</tr>
<% oldanimalid= rs("ID")
rs.movenext
 next %>
 <%     
  Wend %>
</table>