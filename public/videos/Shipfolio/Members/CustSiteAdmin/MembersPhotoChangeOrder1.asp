<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<% ' Clean directory NEA 4/2012 %>
<HTML>
<HEAD>

</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include virtual="/connloa.asp"--> 

<%Set rs = Server.CreateObject("ADODB.Recordset")
ID = request.form("ID")
oldSpot = request.form("CurrentPhoto")
Newspot = request.form("PhotoOrder")
'response.write("ID=" & ID )
response.write("oldSpot=" & oldSpot)
response.write("Newspot=" & Newspot)

dim photoarray(17)
dim PhotoCaptionArray(17)
			
sql = "select * from Photos where id = " & cint(ID)
response.write("sql=" & sql)
rs.Open sql, connLOA, 3, 3

If not rs.eof Then
	photoarray(1) = rs("Photo1")
	photoarray(2) = rs("Photo2")
	photoarray(3) = rs("Photo3")
	photoarray(4) = rs("Photo4")
	photoarray(5) = rs("Photo5")
	photoarray(6) = rs("Photo6")
	photoarray(7) = rs("Photo7")
	photoarray(8) = rs("Photo8")
    photoarray(9) = rs("Photo9")
    photoarray(10) = rs("Photo10")
    photoarray(11) = rs("Photo11")
    photoarray(12) = rs("Photo12")
    photoarray(13) = rs("Photo13")
    photoarray(14) = rs("Photo14")
    photoarray(15) = rs("Photo15")
    photoarray(16) = rs("Photo16")
	PhotoCaptionArray(1) = rs("PhotoCaption1")
	PhotoCaptionArray(2) = rs("PhotoCaption2")
	PhotoCaptionArray(3) = rs("PhotoCaption3")
	PhotoCaptionArray(4) = rs("PhotoCaption4")
	PhotoCaptionArray(5) = rs("PhotoCaption5")
	PhotoCaptionArray(6) = rs("PhotoCaption6")
	PhotoCaptionArray(7) = rs("PhotoCaption7")
	PhotoCaptionArray(8) = rs("PhotoCaption8")
    PhotoCaptionArray(9) = rs("PhotoCaption9")
    PhotoCaptionArray(10) = rs("PhotoCaption10")
    PhotoCaptionArray(11) = rs("PhotoCaption11")
    PhotoCaptionArray(12) = rs("PhotoCaption12")
    PhotoCaptionArray(13) = rs("PhotoCaption13")
    PhotoCaptionArray(14) = rs("PhotoCaption14")
    PhotoCaptionArray(15) = rs("PhotoCaption15")
    PhotoCaptionArray(16) = rs("PhotoCaption16")
end if
for x= 1 to 16
Dim str1
Dim str2
str1 = PhotoCaptionArray(x)
str2 = "'"
If InStr(str1,str2) > 0 Then
	 PhotoCaptionArray(x)= Replace(str1,  str2, "''")
End If  
next

for x= 1 to 16
str1 = photoarray(x)
str2 = "'"
If InStr(str1,str2) > 0 Then
	 photoarray(x)= Replace(str1,  str2, "''")
End If  
next



CurrentPhoto = photoarray(OldSpot)
CurrentPhotoCaption = PhotoCaptionArray(OldSpot)

If OldSpot < Newspot then
   currentspot = 0  
   
   while currentspot < 17 and currentspot < cint(OldSpot)
    currentspot = currentspot + 1
     wend

  currentspot = currentspot - 1

  while currentspot < 17 and cint(currentspot) < cint(NewSpot)
    currentspot = currentspot + 1
    if not cint(currentspot) = cint(Newspot) then

      photoarray(currentspot) = photoarray(currentspot + 1)
      PhotoCaptionArray(currentspot) = PhotocaptionArray(currentspot + 1)
    end if 
  wend
  photoarray(Newspot) = CurrentPhoto
  PhotoCaptionArray(Newspot) = CurrentPhotoCaption
end if 

If OldSpot > Newspot then
   currentspot = 0  
 
For currentspot =  cint(Oldspot -1) to cint(Newspot) step -1
	 photoarray(currentspot + 1) = photoarray(currentspot)
	 PhotoCaptionArray(currentspot + 1) = PhotocaptionArray(currentspot)
next
  
  photoarray(Newspot) = CurrentPhoto
   PhotoCaptionArray(Newspot) = CurrentPhotoCaption
end if 

If OldSpot = Newspot then
  DoNothing = true
else
	Query =  " UPDATE Photos Set Photo1 = '" &  photoarray(1) & "', " 
	Query =  Query & " PhotoCaption1 = '"  & PhotoCaptionArray(1) & "'," 
	Query =  Query & " Photo2 = '"  & photoarray(2) & "'," 
	Query =  Query & " PhotoCaption2 = '"  & PhotoCaptionArray(2) & "'," 
	Query =  Query & " Photo3 = '"  & photoarray(3) & "',"
	Query =  Query & " PhotoCaption3 = '"  & PhotoCaptionArray(3) & "'," 
	Query =  Query & " Photo4 = '"  & photoarray(4) & "',"
	Query =  Query & " PhotoCaption4 = '"  & PhotoCaptionArray(4) & "'," 
	Query =  Query & " Photo5 = '"  & photoarray(5) & "',"
	Query =  Query & " PhotoCaption5 = '"  & PhotoCaptionArray(5) & "'," 
	Query =  Query & " Photo6 = '"  & photoarray(6) & "',"
	Query =  Query & " PhotoCaption6 = '"  & PhotoCaptionArray(6) & "'," 
	Query =  Query & " Photo7 = '"  & photoarray(7) & "',"
	Query =  Query & " PhotoCaption7 = '"  & PhotoCaptionArray(7) & "'," 
	Query =  Query & " Photo8 = '"  & photoarray(8) & "',"
	Query =  Query & " PhotoCaption8 = '"  & PhotoCaptionArray(8) & "'," 
    	Query =  Query & " Photo9 = '"  & photoarray(9) & "',"
	Query =  Query & " PhotoCaption9 = '"  & PhotoCaptionArray(9) & "'," 
    	Query =  Query & " Photo10 = '"  & photoarray(10) & "',"
	Query =  Query & " PhotoCaption10 = '"  & PhotoCaptionArray(10) & "'," 
    	Query =  Query & " Photo11 = '"  & photoarray(11) & "',"
	Query =  Query & " PhotoCaption11 = '"  & PhotoCaptionArray(11) & "'," 
    	Query =  Query & " Photo12 = '"  & photoarray(12) & "',"
	Query =  Query & " PhotoCaption12 = '"  & PhotoCaptionArray(12) & "'," 
    	Query =  Query & " Photo13 = '"  & photoarray(13) & "',"
	Query =  Query & " PhotoCaption13 = '"  & PhotoCaptionArray(13) & "'," 
    	Query =  Query & " Photo14 = '"  & photoarray(14) & "',"
	Query =  Query & " PhotoCaption14 = '"  & PhotoCaptionArray(14) & "'," 
    	Query =  Query & " Photo15 = '"  & photoarray(15) & "',"
	Query =  Query & " PhotoCaption15 = '"  & PhotoCaptionArray(15) & "'," 
    	Query =  Query & " Photo16 = '"  & photoarray(16) & "',"
	Query =  Query & " PhotoCaption16 = '"  & PhotoCaptionArray(16) & "'" 

	Query =  Query & " where ID = " & ID & ";" 
connLOA.Execute(Query) 
end if 

rowcount= rowcount +1
connLOA.Close
Set connLOA = Nothing

response.redirect("MembersPhotos.asp?ID=" & ID & "#" & Newspot)
%>

</Body>
</HTML>
