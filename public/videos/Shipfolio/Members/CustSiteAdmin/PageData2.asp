<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Website Administration</title>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
<!--#Include file="AdminGlobalVariables.asp"-->
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
    <% 
   Current2="Design"
   Current3="About Us" %> 
<% 
Header = Request.Querystring("Header")
PageName=Request.Querystring("PageName" ) 
Filename = "PageData2.asp?PageName=" & PageName & "&Header=" & Header


If Len(PageName) = 0 then
	PageName=Request.Form("PageName" ) 
End If
session("PageName") = PageName

PeopleID = session("PeopleID")

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


sql = "select PageLayoutID from RanchpageLayout where PeopleID = " & PeopleID 
'response.write("sql=" & sql)
		
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  
if not rs.eof then
    PageLayoutID = rs("PageLayoutID")
end if
rs.close


sql = "select * from RanchpageLayout2 where  PageLayoutID = " &  PageLayoutID 
'response.write("sql=" & sql)
		
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  
if  rs.eof then
CurrentBlockNum = 0
 while CurrentBlockNum < 9
    CurrentBlockNum = CurrentBlockNum + 1
 Query =  "INSERT INTO RanchpageLayout2 ( BlockNum, PeopleID, PageLayoutID)" 
		Query =  Query & " Values (" &  CurrentBlockNum & "," 
		Query =  Query & " " &  PeopleID & "," 
		Query =  Query & " " &  PageLayoutID & ")"
		
    Conn.Execute(Query) 
wend
end if
rs.close


sql = "select RanchpageLayout.PageName, RanchpageLayout2.* from RanchpageLayout, RanchpageLayout2 where RanchpageLayout.PageLayoutID  = RanchpageLayout2.PageLayoutID  and RanchpageLayout.PageName = '" & Pagename & "' and RanchpageLayout.PeopleID = " & PeopleID & " order by BlockNum"
'response.write("sql=" & sql)
		
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  
while not rs.eof



PageLayoutID = rs("PageLayoutID")
	BlockNum = rs("BlockNum")
	

	
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
	'response.write("PageTextArray(BlockNum)=" & PageTextArray(BlockNum) )
	
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
Query =  "INSERT INTO RanchpageLayout2 ( BlockNum, PageLayoutID)" 
		Query =  Query & " Values (" &  LastBlockNum & "," 
		Query =  Query & " " &  PageLayoutID & ")"
		


Conn.Execute(Query) 


'response.redirect("PageData2.asp?PageName=" & PageName )


end if 


  %>
<!--#Include file="adminHeader.asp"-->
<a name="Top"></a>
 <br>
<!--#Include file="AdminPagesTabsInclude.asp"-->
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width="<%=screenwidth -30%>"><tr><td class = "roundedtopandbottom" align = "left">
<H1><div align = "left"><%= Pagename %></div></H1>
<div align = "left" class= "body">Below are multiple Text Blocks that you can use to enter text, photo, and forms. </div>
<table border = "0" width = "<%=screenwidth - 30 %>">
<tr>
<td align = "center" valign = "top">
<!--#Include file="PagedataeditInclude.asp"--> 
</td>
</tr>
</table>
<br>
<div align = "center"><a href = "#Top" class ="body">Click here to go to the top of the page.</a></div>
</td>
</tr>
</table>
<br><br>
<!-- #include virtual="/Footer.asp" -->
 </Body>
</HTML>
