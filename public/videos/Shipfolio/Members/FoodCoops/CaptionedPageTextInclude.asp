<br />
<%
if len(TempImageLink) > 3 then
	   target=self
	else
		TempImageLink = TempImage
		target = "target=blank"
	end if 
	If Len(TempImageCaption) < 2 Then
	TempImageCaption = " "
	End if

str1 = TempImageCaption	
	str2 = "&nbsp;"
	If InStr(str1,str2) > 0 Then
		TempImageCaption= Replace(str1,  str2, " ")
	End If 

	str1 = TempImageCaption	
	str2 = "''"
	If InStr(str1,str2) > 0 Then
		TempImageCaption = replace(str1,  str2, "'")
	End If 

str1 = TempHeading	
	str2 = "&nbsp;"
	If InStr(str1,str2) > 0 Then
		TempHeading= Replace(str1,  str2, " ")
	End If 

	str1 = TempHeading	
	str2 = "''"
	If InStr(str1,str2) > 0 Then
		TempHeading = replace(str1,  str2, "'")
	End If 
str1 = TempHeading
str2 = "''"
If InStr(str1,str2) > 0 Then
	TempHeading= Replace(str1, str2 , "'")
End If 
str1 = TempPageText	
	str2 = "&nbsp;"
	If InStr(str1,str2) > 0 Then
		TempPageText= Replace(str1,  str2, " ")
	End If 

	str1 = TempPageText	
	str2 = "''"
	If InStr(str1,str2) > 0 Then
		TempPageText = replace(str1,  str2, "'")
	End If 

str1 = TempPageText
str2 = "''"
If InStr(str1,str2) > 0 Then
	TempPageText= Replace(str1, str2 , "'")
End If 


if len(TempPageText) > 1 then
For y = 1 to Len( TempPageText )
    spec = Mid(TempPageText, y, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
	TempPageText= Replace(TempPageText,  spec, " ")
   end if
 Next
end if

if len(TempHeading) > 1 then
For y =1 to Len( TempHeading )
    spec = Mid(TempHeading, y, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
	TempHeading= Replace(TempPageText,  spec, " ")
   end if
 Next
end if

found = false



  'if (CheckLink(TempImage)) = "Link is broken" then
   '     TempImage = ""
' end if


            str1 = lcase(TempImage)
            str2 = "livestockofamerica.com"
            If InStr(str1,str2) > 0 Then
	           TempImage= Replace(str1, str2 , "livestockoftheworld.com")
            End If 

            str1 = lcase(TempImage)
            str2 = "http:"
            If InStr(str1,str2) > 0 Then
	            TempImage= Replace(str1, str2 , "https:")
            End If 



            if trim(lcase(TempImage))= "https://www.livestockofamerica.com/uploads/"  then
	            TempImage = "https://www.livestockoftheworld.com/uploads/ImageNotAvailable.jpg"
            end if

            if Len(TempImage) > 1 then
            Else
	            TempImage = "https://www.livestockoftheworld.com/uploads/ImageNotAvailable.jpg"
            end if

            if len(TempImage) = 135 then
                TempImage = "https://www.livestockoftheworld.com/images/ImageNotAvailable.jpg"
            end if 

            if len(TempImage) < 50 then
                TempImage = "https://www.livestockoftheworld.com/" & TempImage
            end if 




If Len(TempImage) > 2 And TempOrientation = "Right" Then 
found = True %> 		
		<div class="container">
		  <div class="row">
			  <div class="col-md-8 order-md-1 order-2">
				<h3><%=TempHeading%></h3>
				<%=TempPageText %>
				<%  if len(TempUpload) > 2 then %>
					<br><a href = "<%=TempUpload%>" class = "overview">DOWNLOAD NOW</a>
   				<% end if %>
			</div>
			 <div class="col-md-3 order-md-2 order-1">
					<a href = "<%=TempImageLink%>" <%=target %>><img src = "<%=TempImage%>"  width = "280" border = "0" align = "center"></a><br />
					<%=TempImageCaption%>
			</div>
		  </div>
		</div>
<% End If  %>

<% If Len(TempImage) > 2 And not TempOrientation = "Right" Then 
found = True %> 		
		<div class="container">

		<div class="col-md-3 order-md-2 order-1">
					<a href = "<%=TempImageLink%>" <%=target %>><img src = "<%=TempImage%>"  width = "280" border = "0" align = "center"></a><br />
					<%=TempImageCaption%>
			</div>

		  <div class="row">
			  <div class="col-md-8 order-md-1 order-2">
				<h3><%=TempHeading%></h3>
				<%=TempPageText %>
				<%  if len(TempUpload) > 2 then %>
					<br><a href = "<%=TempUpload%>" class = "overview">DOWNLOAD NOW</a>
   				<% end if %>
			</div>
			
		  </div>
		</div>
<% End If  %>

<% If Len(TempImage) < 2  Then 
found = True %> 		
		<div class="container">
		  <div class="row">
			  <div class="col">
				<h3><%=TempHeading%></h3>
				<%=TempPageText %>
				<%  if len(TempUpload) > 2 then %>
					<br><a href = "<%=TempUpload%>" class = "overview">DOWNLOAD NOW</a>
   				<% end if %>
			</div>
			
		  </div>
		</div>
<% End If  %>

