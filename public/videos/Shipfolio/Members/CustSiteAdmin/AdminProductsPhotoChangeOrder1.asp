<!DOCTYPE html>

<HTML>
<HEAD>
  <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
</head>
<body >
  

<%
ID = request.form("ID")
oldSpot = request.form("CurrentPhoto")
Newspot = request.form("PhotoOrder")
response.write("ID=" & ID )
response.write("oldSpot=" & oldSpot)
response.write("Newspot=" & Newspot)

dim photoarray(12)
dim PhotoCaptionArray(12)

Set rs = Server.CreateObject("ADODB.Recordset")
			
sql = "select * from ProductsPhotos where id = " & ID
response.write("sql = " & sql & "<br>")
rs.Open sql, conn, 3, 3

If not rs.eof Then
	photoarray(1) = rs("ProductImage1")
	photoarray(2) = rs("ProductImage2")
	photoarray(3) = rs("ProductImage3")
	photoarray(4) = rs("ProductImage4")
	photoarray(5) = rs("ProductImage5")
	photoarray(6) = rs("ProductImage6")
	photoarray(7) = rs("ProductImage7")
	photoarray(8) = rs("ProductImage8")

end if
'response.Write("PhotoArray(1) = " & PhotoArray(1) & "PhotoCaptionArray(1)= " & "<br>")
for x= 1 to 8
Dim str1
Dim str2
str1 = PhotoCaptionArray(x)
str2 = "'"
If InStr(str1,str2) > 0 Then
	 PhotoCaptionArray(x)= Replace(str1,  str2, "''")
End If  
next


for x= 1 to 8
str1 = photoarray(x)
str2 = "'"
If InStr(str1,str2) > 0 Then
	 photoarray(x)= Replace(str1,  str2, "''")
End If  
next




CurrentPhoto = photoarray(OldSpot)
CurrentPhotoCaption = PhotoCaptionArray(OldSpot)
'/Lower Image
If OldSpot < Newspot then
   currentspot = 0  
   
   while currentspot < 11 and currentspot < cint(OldSpot)
    currentspot = currentspot + 1
		response.write("currentspot = " & currentspot & "<br>")
     wend

  currentspot = currentspot - 1

  while currentspot < 11 and cint(currentspot) < cint(NewSpot)
    currentspot = currentspot + 1
    if not cint(currentspot) = cint(Newspot) then

      photoarray(currentspot) = photoarray(currentspot + 1)
      PhotoCaptionArray(currentspot) = PhotocaptionArray(currentspot + 1)
    end if 
  wend
  photoarray(Newspot) = CurrentPhoto
  PhotoCaptionArray(Newspot) = CurrentPhotoCaption
end if 

'response.write("Oldspot=" & Oldspot & " <br>")
'response.write("Newspot=" & Newspot & " <br>")

'/Raise Up Image
If OldSpot > Newspot then
   currentspot = 0  
 
For currentspot =  cint(Oldspot -1) to cint(Newspot) step -1
    response.write("currentspotx=" & currentspot & " <br>")
	 photoarray(currentspot + 1) = photoarray(currentspot)
	 PhotoCaptionArray(currentspot + 1) = PhotocaptionArray(currentspot)
next
  
  photoarray(Newspot) = CurrentPhoto
   PhotoCaptionArray(Newspot) = CurrentPhotoCaption
end if 

If OldSpot = Newspot then
  DoNothing = true
else
	Query =  " UPDATE ProductsPhotos Set ProductImage1 = '" &  photoarray(1) & "', " 
	Query =  Query & " ProductImage2 = '"  & photoarray(2) & "'," 
	Query =  Query & " ProductImage3 = '"  & photoarray(3) & "',"
	Query =  Query & " ProductImage4 = '"  & photoarray(4) & "',"
	Query =  Query & " ProductImage5 = '"  & photoarray(5) & "',"
	Query =  Query & " ProductImage6 = '"  & photoarray(6) & "',"
	Query =  Query & " ProductImage7 = '"  & photoarray(7) & "',"
	Query =  Query & " ProductImage8 = '"  & photoarray(8) & "' "
	Query =  Query & " where ID = " & ID & ";" 
response.write("Query =" & Query & "<br>")	
Conn.Execute(Query) 
end if 




rowcount= rowcount +1

response.redirect("AdminProductPhotos.asp?ID=" & ID)
%>

</Body>
</HTML>
