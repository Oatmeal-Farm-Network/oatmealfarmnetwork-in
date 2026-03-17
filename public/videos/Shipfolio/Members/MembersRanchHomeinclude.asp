<% 
	  
PeopleID = session("PeopleID")

  sql = "select * from People where PeopleID = " & session("PeopleID")
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

	
	  PageTitle = rs("RanchHomeHeading")

	PageText1 = rs("RanchHomeText")
	 PageText2 = rs("RanchHomeText2")
	 PageText3 = rs("RanchHomeText3")
	 PageText4 = rs("RanchHomeText4")
	 Image1= rs("RanchHomeImage1")
str1 = lcase(Image1) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Image1=  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
	Image2= rs("RanchHomeImage2")
    str1 = lcase(Image2) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Image2=  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
	 Image3= rs("RanchHomeImage3")
     str1 = lcase(Image3) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Image3=  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
	 Image4= rs("RanchHomeImage4")
     str1 = lcase(Image4) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Image4=  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
	 ImageOrientation1= rs("RanchHomeImageOrientation1")
	ImageOrientation2= rs("RanchHomeImageOrientation2")
	 ImageOrientation3= rs("RanchHomeImageOrientation3")
		ImageOrientation4= rs("RanchHomeImageOrientation4")


str1 = PageTitle
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, " ")
End If 

str1 = PageTitle
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "'")
End If 

str1 = PageText1
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText1= Replace(str1,  str2, " ")
End If 

str1 = PageText1
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText1= Replace(str1,  str2, "'")
End If 

str1 = PageText2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText2= Replace(str1,  str2, " ")
End If 

str1 = PageText2
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText2= Replace(str1,  str2, "'")
End If 


str1 = PageText3
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText3= Replace(str1,  str2, " ")
End If 

str1 = PageText3
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText3= Replace(str1,  str2, "'")
End If 

str1 =  PageText4
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 PageText4= Replace(str1,  str2, " ")
End If 

str1 =  PageText4
str2 = "''"
If InStr(str1,str2) > 0 Then
	 PageText4= Replace(str1,  str2, "'")
End If 

str1 =  ImageCaption2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption2= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption2
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption2= Replace(str1,  str2, "'")
End If 

str1 =  ImageCaption3
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption3= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption3
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption3= Replace(str1,  str2, "'")
End If 


str1 =  ImageCaption4
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption4= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption4
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption4= Replace(str1,  str2, "'")
End If 


str1 = PageTitle
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, " ")
End If 

str1 = PageTitle
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "'")
End If 


str1 = PageText
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1, str2 , vbCr)
End If  

str1 =PageText
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, " ")
End If 

str1 = PageText
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "'")
End If 

str1 = PageText1
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText1= Replace(str1, str2 , vbCr)
End If  

str1 =PageText1
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText1= Replace(str1,  str2, " ")
End If 

str1 = PageText1
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText1= Replace(str1,  str2, "'")
End If 

str1 = PageText2
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText2= Replace(str1, str2 , vbCr)
End If  

str1 =PageText2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText2= Replace(str1,  str2, " ")
End If 

str1 = PageText2
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText2= Replace(str1,  str2, "'")
End If 

str1 = PageText3
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText3= Replace(str1, str2 , vbCr)
End If  

str1 =PageText3
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText3= Replace(str1,  str2, " ")
End If 

str1 = PageText3
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText3= Replace(str1,  str2, "'")
End If 

str1 = PageText4
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText4= Replace(str1, str2 , vbCr)
End If  

str1 =PageText4
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText4= Replace(str1,  str2, " ")
End If 

str1 = PageText4
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText4= Replace(str1,  str2, "'")
End If 
%>
<a name="Top"></a>



    <div class="container-fluid justify-content-center">
        <div class="row justify-content-center">
             <div class="col-sm-2">
                <h3>Page Heading</h3>
            </div>
             <div class="col-sm-10">
              <form action= 'MembersRanchHomePageHandleForm.asp' method = "post">
			    <input name="TextBlock"  size = "60" value = "Heading" type = "hidden">
                <input name="Text"  size = "60" value = '<%=PageTitle%>'>
                <input type=submit value = "Submit" class = "regsubmit2" size = "110" >
              </form>
            </div>
        </div>
    </div>
    <a name="TextBlock1"></a>
    <div class="container-fluid justify-content-center">
        <div class="row justify-content-center">
             <div class="col-sm-12">
               <H2>Welcome Text & Image</H2>
            </div>
        </div>
        <div class="row justify-content-center">
             <div class="col-sm-8">
                    Note: If no text is entered below then some of your about us text will automatically appear on your home page.
				    <form action= 'membersRanchHomePageHandleForm.asp' method = "post">
					<input name="TextBlock"  size = "60" value = "TB1" type = "hidden">

					<TEXTAREA NAME="Text" ID="Text" cols="78" rows="10" wrap="file"><%=PageText1%></textarea>
					<center><input type=submit value = "Submit"   class = "regsubmit2" ></center>
			</form>
            </div>
             <div class="col-sm-4">
           	        <% If Len(trim(Image1)) > 2 Then %>
							<img src = "<%=Image1%>" height = "100">
					<% Else %>
							<h2>No Image</h2>
					<% End If %>
                    <form name="frmSend" method="POST" enctype="multipart/form-data" action="membersRanchHomeuploadPageImage.asp"  >
								Upload Photo: <br>
								<input name="attach1" type="file" size=35 >
								<center><input  type=submit value="Upload"  class = "regsubmit2"></center>
							</form>
                        <% If Len(trim(Image1)) > 2 Then %>
                        <br />
						<form action= 'membersRemoveRanchHomeImage.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "1" >
								<center><input type=submit value="Remove" class = "regsubmit2"></center>
							</form>
				        <% end if %>
            </div>
        </div>
    </div>


<br />
<a name="TextBlock2"></a>
    <div class="container-fluid justify-content-center">
        <div class="row justify-content-center">
             <div class="col-sm-12">
               	<H2>News</H2>
            </div>
        </div>
        <div class="row justify-content-center">
             <div class="col-sm-8">
                    Note: If no text is entered below then some of your about us text will automatically appear on your home page.
				    <form action= 'membersRanchHomePageHandleForm.asp' method = "post">
					<input name="TextBlock"  size = "60" value = "TB2" type = "hidden">

                    <TEXTAREA NAME="NewsText" ID="NewsText" cols="78" rows="10" wrap="file"><%=PageText2%></textarea>
					<center><input type=submit value = "Submit Changes" class = "regsubmit2" ></center>
                    </script> 
                    </form>
			</form>
            </div>
             <div class="col-sm-4">
           	       	<% If Len(Image2) > 2 Then %>
							<img src = "<%=Image2%>" height = "100">
					<% Else %>
							<h2>No Image</h2>
					<% End If %>

                    <form name="frmSend" method="POST" enctype="multipart/form-data" action="MembersRanchHomeuploadPageImage2.asp" >
								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<input  type=submit value="Upload" class = "regsubmit2">
							</form>
                    <% If Len(Image2) > 2 Then %>
							<form action= 'membersRemoveRanchHomeImage.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "2" >
								<center><input type=submit value="Remove This Image" class = "regsubmit2"></center>
							</form>
                 <% end if %>

            </div>
        </div>
    </div>

<% featuredanimal = false
if featuredanimal = true then
 sql2 = "select Animals.ID, Animals.FullName, People.FeaturedAlpaca1 from Animals, People where animals.ID = FeaturedAlpaca1 and Animals.PeopleID = " & session("PeopleID")
	
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	if Not rs2.eof  then
		FeaturedAlpaca1 = rs2("FeaturedAlpaca1")
		FeaturedAlpacaName = rs2("FullName")


		End if
	
		rs2.close

		sql2 = "select Animals.ID, Animals.FullName, People.FeaturedAlpaca2 from Animals, People where animals.ID = FeaturedAlpaca2 and Animals.PeopleID = " & session("PeopleID")
	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	if Not rs2.eof  then
		FeaturedAlpaca2 = rs2("FeaturedAlpaca2")
		FeaturedAlpacaName2 = rs2("FullName")


		End if
	
		rs2.close

		sql2 = "select Animals.ID, Animals.FullName, People.FeaturedHerdsire from Animals, People where animals.ID = FeaturedHerdsire and Animals.PeopleID = " & session("PeopleID")
	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	if Not rs2.eof  then
		FeaturedHerdsire = rs2("FeaturedHerdsire")
		FeaturedHerdsireName = rs2("FullName")


		End if
	
		rs2.close
		set rs2=nothing
Dim	IDArrayz(10000) 
Dim	alpacaNamez(100000) 


	sql2 = "select Animals.ID, Animals.FullName from Animals where PeopleID = " & session("PeopleID") & " order by Fullname"
	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArrayz(acounter) = rs2("ID")
		alpacaNamez(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
rs2.close
set rs2=nothing
 %>
 <a name="TextBlock3"></a><br />
 <table width ="<%=screenwidth - 32 %>" cellpadding = "0" cellspacing = "0">
 <tr>
 <td width = "448">
 
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width=<%=screenwidth - 32 %> ><tr><td align = "left">
		<H2>Featured Animal</H2>

<br />	

<div align = "left">
Note: If you do not have featured alpacas selected, animals will be randomly selected each time a user comes to your home page.<br></div>
<table border = "0" leftmargin="5" topmargin="5" marginwidth="5" marginheight="5"  cellpadding=5 cellspacing=5  width = "420">
	<tr>
		<td class = "body" >
			<form  action="membersRanchHPAddFeaturedAlpaca1.asp" method = "post" name = "edit1">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select a New Featured Animal 1:
					<select size="1" name="ID">
					<% If Len(FeaturedAlpaca1) > 0 Then %>
						<option name = "AID0" value= "<%=FeaturedAlpaca1%>" selected><%=FeaturedAlpacaName%></option>
					<% End If %>
					<option name = "AID0" value= "0" >Random</option>
					
					<% count = 2
						while count < acounter 
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=alpacaName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
			<center><input type=submit value="Select" class = "regsubmit2"></center>
				</td>
			  </tr>
		    </table>
		  </form>


		  	</td>
	
			  </tr>
		    </table>
		  </form>
		</tr>
   <tr>
</table>
<% end if %>

 </td>

</table>

<br><br>
<div align = "center"><a href = "#Top" class ="body">TOP</a></center>
	  	</td>
			  </tr>
		    </table>
<br><br>