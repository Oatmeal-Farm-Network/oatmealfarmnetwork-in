<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>The Andresen Group Content Management System</title>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/alpacachamps/infinityknot.ico" /> 
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include File="AdminGlobalVariables.asp"--> 
<!--#Include File="AdminSecurityInclude.asp"--> 

</HEAD>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">


<!--#Include File="AdminHeader.asp"--> 


<% 
PageName=Request.Querystring("PageName" ) 
Filename = "AdminPageData2.asp?PageName=" & PageName

If Len(PageName) = 0 then
	PageName=Request.Form("PageName" ) 
End If
session("PageName") = PageName
%>

<% if pagename="Blog" Then %>
<!--#Include File="AdminArticleHeader.asp"--> 
<% end if %>


<%
CustID = session("CustID")

Dim PageLayout2IDArray(1000)
Dim BlockNum
Dim PageHeadingArray(1000)
Dim EditImageArray(1000)
Dim PageTextArray(1000)
Dim ImageArray(1000)
Dim ImageCaptionArray(1000)
Dim ImageOrientationArray(1000)
Dim ImageLinkArray(1000)
Dim UploadTextArray(1000)
Dim UploadArray(10000)



sql = "select PageLayout.PageName, PageLayout2.* from PageLayout, PageLayout2 where Pagelayout.PageLayoutID  = PageLayout2.PageLayoutID  and PageLayout.PageName = '" & Pagename & "' order by BlockNum"

		
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  
while not rs.eof



PageLayoutID = rs("PageLayoutID")
	BlockNum = rs("BlockNum")
	

	'response.write("BlockNum = " & BlockNum)
	PageLayout2IDArray(BlockNum) = rs("PageLayout2ID")
	PageHeadingArray(BlockNum) = rs("PageHeading")
	
	str1 = PageHeadingArray(BlockNum)
	str2 = "&nbsp;"
	If InStr(str1,str2) > 0 Then
		PageHeadingArray(BlockNum)= Replace(str1,  str2, " ")
	End If 

	str1 = PageHeadingArray(BlockNum)
	str2 = "''"
	If InStr(str1,str2) > 0 Then
		PageHeadingArray(BlockNum) = replace(str1,  str2, "'")
	End If 





	EditImageArray(BlockNum) = rs("EditImage")
	PageHeadingArray(BlockNum) = rs("PageHeading")
	PageTextArray(BlockNum) = rs("PageText")
	
	
	str1 = PageTextArray(BlockNum)
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageTextArray(BlockNum)= Replace(str1,  str2, " ")
End If 

str1 = PageTextArray(BlockNum)
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageTextArray(BlockNum)= Replace(str1,  str2, "'")
End If 


str1 = PageTextArray(BlockNum)
str2 = "<br>"
If InStr(str1,str2) > 0 Then
	PageTextArray(BlockNum)= Replace(str1, str2 , vbCrLf)
End If  

	
	
	ImageArray(BlockNum) = rs("Image")
	ImageCaptionArray(BlockNum) = rs("ImageCaption")
	
	if ImageCaptionArray(BlockNum) = "0" then
   		ImageCaptionArray(BlockNum)= ""
	end if

	str1 =  ImageCaptionArray(BlockNum)
	str2 = "&nbsp;"
	If InStr(str1,str2) > 0 Then
		 ImageCaptionArray(BlockNum)= Replace(str1,  str2, " ")
	End If 

	str1 = ImageCaptionArray(BlockNum)
	str2 = "''"
	If InStr(str1,str2) > 0 Then
		ImageCaptionArray(BlockNum)= Replace(str1,  str2, "'")
	End If
	
str1 =  Trim(ImageCaptionArray(BlockNum))
	str2 = "0"
	If InStr(str1,str2) > 0 Then
		 ImageCaptionArray(BlockNum)= Replace(str1,  str2, "")
	End If 
 

	ImageOrientationArray(BlockNum) = rs("ImageOrientation")
	ImageLinkArray(BlockNum) = rs("ImageLink")
	
	str1 =  Trim(ImageLinkArray(BlockNum))
	str2 = "0"
	If InStr(str1,str2) > 0 Then
		 ImageLinkArray(BlockNum)= Replace(str1,  str2, "")
	End If 



	UploadTextArray(BlockNum) = rs("UploadText")
	UploadArray(BlockNum) = rs("Upload")




rs.movenext
wend

LastBlockNum = BlockNum


if len(PageTextArray(LastBlockNum)) > 2 or len(PageHeadingArray(LastBlockNum)) > 2 or  len(UploadTextArray(LastBlockNum)) > 2 or  len(UploadArray(LastBlockNum)) > 2 or len(ImageArray(LastBlockNum)) > 2 or len(ImageCaptionArray(LastBlockNum)) > 2 then
LastBlockNum = LastBlockNum + 1
Query =  "INSERT INTO PageLayout2 ( BlockNum, PageLayoutID)" 
		Query =  Query & " Values (" &  LastBlockNum & "," 
		Query =  Query & " " &  PageLayoutID & ")"
		


Conn.Execute(Query) 


'response.redirect("AdminPageData2.asp?PageName=" & PageName )


end if 




sql = "select * from Pagelayout where PageName = '" & Pagename & "'"
'response.write(sql)
		
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
PageTitle = rs("PageTitle")
PageHeading5= rs("PageHeading5")
PageHeading6= rs("PageHeading6")
PageHeading7= rs("PageHeading7")

PageText5 = rs("PageText5")
PageText6 = rs("PageText6")
PageText7 = rs("PageText7")



if len(PageText5) > 1 then
For loopi=1 to Len( PageText5 )
    spec = Mid(PageText5, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
	PageText5= Replace(PageText5,  spec, " ")

   end if
  
 Next
end if



if len(PageText6) > 1 then
For loopi=1 to Len( PageText6 )
    spec = Mid(PageText6, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
	PageText6= Replace(PageText6,  spec, " ")

   end if
  
 Next
end if


if len(PageText7) > 1 then
For loopi=1 to Len( PageText7 )
    spec = Mid(PageText7, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
	PageText7= Replace(PageText7,  spec, " ")

   end if
  
 Next
end if


if len(PageText8) > 1 then
For loopi=1 to Len( PageText8 )
    spec = Mid(PageText8, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
	PageText8= Replace(PageText8,  spec, " ")

   end if
  
 Next
end if



if len(PageText9) > 1 then
For loopi=1 to Len( PageText9 )
    spec = Mid(PageText9, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
	PageText9= Replace(PageText9,  spec, " ")

   end if
  
 Next
end if



if len(PageText10) > 1 then
For loopi=1 to Len( PageText10 )
    spec = Mid(PageText10, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
	PageText10= Replace(PageText10,  spec, " ")

   end if
  
 Next
end if


if len(PageText11) > 1 then
For loopi=1 to Len( PageText11 )
    spec = Mid(PageText11, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
	PageText11= Replace(PageText11,  spec, " ")

   end if
  
 Next
end if




if len(PageText12) > 1 then
For loopi=1 to Len( PageText12 )
    spec = Mid(PageText12, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
	PageText12= Replace(PageText12,  spec, " ")

   end if
  
 Next
end if




if len(PageText13) > 1 then
For loopi=1 to Len( PageText13 )
    spec = Mid(PageText13, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
	PageText13= Replace(PageText13,  spec, " ")

   end if
  
 Next
end if



if len(PageText14) > 1 then
For loopi=1 to Len( PageText14 )
    spec = Mid(PageText14, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
	PageText14= Replace(PageText14,  spec, " ")

   end if
  
 Next
end if




if len(PageText15) > 1 then
For loopi=1 to Len( PageText15 )
    spec = Mid(PageText15, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
	PageText15= Replace(PageText15,  spec, " ")

   end if
  
 Next
end if




if len(PageText16) > 1 then
For loopi=1 to Len( PageText16 )
    spec = Mid(PageText16, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
	PageText16= Replace(PageText16,  spec, " ")

   end if
  
 Next
end if


HeaderImage = rs("HeaderImage")
Image5= rs("Image5")
Image6= rs("Image6")
Image7= rs("Image7")

if ImageCaption5 = "0" then
   ImageCaption5 = ""
end if

if ImageCaption6 = "0" then
   ImageCaption6 = ""
end if

if ImageCaption7 = "0" then
   ImageCaption7 = ""
end if

if ImageCaption8 = "0" then
   ImageCaption8 = ""
end if

if ImageCaption9 = "0" then
   ImageCaption9 = ""
end if

if ImageCaption10 = "0" then
   ImageCaption10 = ""
end if

if ImageCaption11 = "0" then
   ImageCaption11 = ""
end if

if ImageCaption12 = "0" then
   ImageCaption12 = ""
end if

if ImageCaption13 = "0" then
   ImageCaption13 = ""
end if

if ImageCaption14 = "0" then
   ImageCaption14 = ""
end if

if ImageCaption15 = "0" then
   ImageCaption15 = ""
end if

if ImageCaption16 = "0" then
   ImageCaption16 = ""
end if


str1 = PageHeading5
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading5= Replace(str1,  str2, " ")
End If 

str1 = PageHeading5
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading5= Replace(str1,  str2, "'")
End If

str1 = PageHeading6
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading6= Replace(str1,  str2, " ")
End If 

str1 = PageHeading6
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading6= Replace(str1,  str2, "'")
End If


str1 = PageHeading7
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading7= Replace(str1,  str2, " ")
End If 

str1 = PageHeading7
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading7= Replace(str1,  str2, "'")
End If


str1 = PageHeading8
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading8= Replace(str1,  str2, " ")
End If 

str1 = PageHeading8
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading8= Replace(str1,  str2, "'")
End If


str1 = PageHeading9
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading9= Replace(str1,  str2, " ")
End If 

str1 = PageHeading9
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading9= Replace(str1,  str2, "'")
End If


str1 = PageHeading10
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading10= Replace(str1,  str2, " ")
End If 

str1 = PageHeading10
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading10= Replace(str1,  str2, "'")
End If


str1 = PageHeading11
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading11= Replace(str1,  str2, " ")
End If 

str1 = PageHeading11
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading11= Replace(str1,  str2, "'")
End If


str1 = PageHeading12
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading12= Replace(str1,  str2, " ")
End If 

str1 = PageHeading12
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading12= Replace(str1,  str2, "'")
End If

str1 = PageHeading13
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading13= Replace(str1,  str2, " ")
End If 

str1 = PageHeading13
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading13= Replace(str1,  str2, "'")
End If

str1 = PageHeading14
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading14= Replace(str1,  str2, " ")
End If 

str1 = PageHeading14
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading14= Replace(str1,  str2, "'")
End If

str1 = PageHeading15
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading15= Replace(str1,  str2, " ")
End If 

str1 = PageHeading15
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading15= Replace(str1,  str2, "'")
End If

str1 = PageHeading116
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading16= Replace(str1,  str2, " ")
End If 

str1 = PageHeading16
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading16= Replace(str1,  str2, "'")
End If


str1 =  ImageCaption5
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption5= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption5
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption5= Replace(str1,  str2, "'")
End If 

str1 =  ImageCaption6
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption6= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption6
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption6= Replace(str1,  str2, "'")
End If 

str1 =  ImageCaption7
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption7= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption7
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption7= Replace(str1,  str2, "'")
End If 

str1 =  ImageCaption8
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption8= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption8
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption8= Replace(str1,  str2, "'")
End If 

str1 =  ImageCaption9
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption9= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption9
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption9= Replace(str1,  str2, "'")
End If 


str1 =  ImageCaption10
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption10= Replace(str1,  str2, "'")
End If 


str1 =  ImageCaption10
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption10= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption11
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption11= Replace(str1,  str2, "'")
End If 

str1 =  ImageCaption11
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption11= Replace(str1,  str2, " ")
End If 


str1 =  ImageCaption12
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption12= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption12
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption12= Replace(str1,  str2, "'")
End If 


str1 =  ImageCaption13
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption13= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption13
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption13= Replace(str1,  str2, "'")
End If 


str1 =  ImageCaption14
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption14= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption14
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption14= Replace(str1,  str2, "'")
End If 


str1 =  ImageCaption15
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption15= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption15
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption15= Replace(str1,  str2, "'")
End If 


str1 =  ImageCaption16
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption16= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption16
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption16= Replace(str1,  str2, "'")
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
str2 = "<br>"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1, str2 , vbCrLf)
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

str1 = PageText
str2 = "<br>"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1, str2 , vbCrLf)
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

str1 = PageText2
str2 = "<br>"
If InStr(str1,str2) > 0 Then
	PageText2= Replace(str1, str2 , vbCrLf)
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
str2 = "<br>"
If InStr(str1,str2) > 0 Then
	PageText3= Replace(str1, str2 , vbCrLf)
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
str2 = "<br>"
If InStr(str1,str2) > 0 Then
	PageText4= Replace(str1, str2 , vbCrLf)
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

str1 = PageText5
str2 = "<br>"
If InStr(str1,str2) > 0 Then
	PageText5= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText5
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText5= Replace(str1,  str2, " ")
End If 

str1 = PageText5
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText5= Replace(str1,  str2, "'")
End If 

str1 = PageText6
str2 = "<br>"
If InStr(str1,str2) > 0 Then
	PageText6= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText6
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText6= Replace(str1,  str2, " ")
End If 

str1 = PageText6
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText6= Replace(str1,  str2, "'")
End If 

str1 = PageText7
str2 = "<br>"
If InStr(str1,str2) > 0 Then
	PageText7= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText7
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText7= Replace(str1,  str2, " ")
End If 

str1 = PageText7
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText7= Replace(str1,  str2, "'")
End If 

str1 = PageText8
str2 = "<br>"
If InStr(str1,str2) > 0 Then
	PageText8= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText8
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText8= Replace(str1,  str2, " ")
End If 

str1 = PageText8
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText8= Replace(str1,  str2, "'")
End If 



str1 = PageText9
str2 = "<br>"
If InStr(str1,str2) > 0 Then
	PageText9= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText9
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText9= Replace(str1,  str2, " ")
End If 

str1 = PageText9
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText9= Replace(str1,  str2, "'")
End If 


str1 = PageText10
str2 = "<br>"
If InStr(str1,str2) > 0 Then
	PageText10= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText10
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText10= Replace(str1,  str2, " ")
End If 

str1 = PageText10
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText10= Replace(str1,  str2, "'")
End If 



str1 = PageText11
str2 = "<br>"
If InStr(str1,str2) > 0 Then
	PageText11= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText11
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText11= Replace(str1,  str2, " ")
End If 

str1 = PageText11
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText11= Replace(str1,  str2, "'")
End If 



str1 = PageText12
str2 = "<br>"
If InStr(str1,str2) > 0 Then
	PageText12= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText12
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText12= Replace(str1,  str2, " ")
End If 

str1 = PageText12
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText12= Replace(str1,  str2, "'")
End If 



str1 = PageText13
str2 = "<br>"
If InStr(str1,str2) > 0 Then
	PageText13= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText13
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText13= Replace(str1,  str2, " ")
End If 

str1 = PageText13
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText13= Replace(str1,  str2, "'")
End If 



str1 = PageText14
str2 = "<br>"
If InStr(str1,str2) > 0 Then
	PageText14= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText14
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText14= Replace(str1,  str2, " ")
End If 

str1 = PageText14
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText14= Replace(str1,  str2, "'")
End If 



str1 = PageText15
str2 = "<br>"
If InStr(str1,str2) > 0 Then
	PageText15= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText15
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText15= Replace(str1,  str2, " ")
End If 

str1 = PageText15
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText15= Replace(str1,  str2, "'")
End If 



str1 = PageText16
str2 = "<br>"
If InStr(str1,str2) > 0 Then
	PageText16= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText16
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText16= Replace(str1,  str2, " ")
End If 

str1 = PageText16
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText16= Replace(str1,  str2, "'")
End If 



%>
<a name="Top"></a>

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "980" >
	<tr>
		<td Class = "body"><H2><center><%=Pagename %> Page Content</center></h2></td>
	</tr>
</table>

<table border = "0" width = "980">
<tr>
<td align = "center" valign = "top" width = "500">
    <table>
	  <tr><td bgcolor = "abacab" colspan = "2" ><h2>Page Heading</h2></td></tr>
	  <tr><td class = "body" colspan = "2" >
		<form action= 'AdminPageDataPageHandleForm.asp' method = "post">
		<input name="TextBlock"  size = "40" value = "Heading" type = "hidden">
		<input name="Text"  size = "60" value = "<%=PageTitle%>"><br>
		<input type=submit value = "Submit Changes" size = "110" Class = "body" >
		</form>
	</td></tr>	
	<tr><td bgcolor = "abacab" colspan = "2" ><h2>Page Top Image</h2></td></tr>
	<tr><td class = "body" colspan = "2">

					<% If Len(HeaderImage) > 2 Then %>
							<img src = "<%=HeaderImage%>" height = "100">
					<% Else %>
							<h2>No Image</h2>
					<% End If %>
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminPageDataUploadPageImage.asp" >
								Upload Photo: <br>
								<input name="attach1" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
							<form action= 'AdminPageDataRemoveImage.asp?filename=<%=filename%>' method = "post">
								<input type = "hidden" name="ImageID" value= "0" >
								<input type=submit value="Remove Image">
							</form>
	  </td>
	 </tr>
	 </table>
</td>
<td>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "480">
	<tr>
	    <td class = "body" valign = "top">
             Your page is built from multiple "Text Blocks". Each Text Block is comprised of:
				<ul>
					<li>A Heading</li>
					<li>Text
					<li>An Image with a caption
				</ul>
        
				<br>
		</td>
		<td Class = "body">
			
			<img src = "images/TextBlocks.jpg" height = "250">
		</td>
	</tr>
</table>


</td>
</tr>
</table>

<table border = "0" width = "980">
<tr>
<td align = "center" valign = "top">
	<script language="JavaScript" type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script> 

<script language="JavaScript" type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>

	
	    <!--#Include File="AdminPageDataEditInclude.asp"--> 
</td>
</table>


<br><br><br>
<div align = "center"><a href = "#Top" class ="body">Click here to go to the top of the page.</a></div>
<!-- #include File="AdminFooter.asp" -->
 </Body>
</HTML>
