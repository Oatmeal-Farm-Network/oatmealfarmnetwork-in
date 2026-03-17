<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="John Andresen">
    <meta name="generator" content="Global Grange inc.">
    <title>Global Grange Members Area</title>

<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
<% 
Sort=request.form("Sort") 
If Len(Sort) < 4 Then
	Sort = "Prodname"
End if


	PagegroupID=Request.Form("PagegroupID") 
	PageName=Request.Form("PageName") 
	LinkName=Request.Form("LinkName")
	Heading=Request.Form("PageHeading")
	PageType=Request.Form("PageType")
	ShowPage=Request.Form("ShowPage")
	response.Write("PageType=" & PageType )
	
	DirectoryName = PageName
	str1 = DirectoryName
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		DirectoryName= Replace(str1,  str2, "")
	End If  

    	str1 = DirectoryName
	str2 = """"
	If InStr(str1,str2) > 0 Then
		DirectoryName= Replace(str1,  str2, "")
	End If  

    response.write(" directory = " & DirectoryName)
	
		str1 = DirectoryName
	str2 = " "
	If InStr(str1,str2) > 0 Then
		DirectoryName= Replace(str1,  str2, "")
	End If  
	
	str1 = DirectoryName
	str2 = "<b>"
	If InStr(str1,str2) > 0 Then
		DirectoryName= Replace(str1,  str2, "")
	End If 
	
		str1 = DirectoryName
	str2 = "</b>"
	If InStr(str1,str2) > 0 Then
		DirectoryName= Replace(str1,  str2, "")
	End If 
	
		str1 = DirectoryName
	str2 = "<i>"
	If InStr(str1,str2) > 0 Then
		DirectoryName= Replace(str1,  str2, "")
	End If 
	
		str1 = DirectoryName
	str2 = "</i>"
	If InStr(str1,str2) > 0 Then
		DirectoryName= Replace(str1,  str2, "")
	End If 
	
		str1 = DirectoryName
	str2 = "<B>"
	If InStr(str1,str2) > 0 Then
		DirectoryName= Replace(str1,  str2, "")
	End If 
	
		str1 = DirectoryName
	str2 = "</B>"
	If InStr(str1,str2) > 0 Then
		DirectoryName= Replace(str1,  str2, "")
	End If 
	
		str1 = DirectoryName
	str2 = "<I>"
	If InStr(str1,str2) > 0 Then
		DirectoryName= Replace(str1,  str2, "")
	End If 
	
		str1 = DirectoryName
	str2 = "</I>"
	If InStr(str1,str2) > 0 Then
		DirectoryName= Replace(str1,  str2, "")
	End If 

	
	str1 = PageName
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		PageName= Replace(str1,  str2, "''")
	End If  

	str1 = LinkName
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		LinkName= Replace(str1,  str2, "''")
	End If  
	
	str1 = Heading
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "''")
	End If  
	
	
Proceed="True"
if len(PageName) < 1 then
  Message= Message & "<br>Please enter a page name."
  Proceed="False"
end if 


if len(LinkName) < 1 then
  Message=Message & "<br>Please enter a menu title."
  Proceed="False"
end if 

sql2 = "select * from Pagelayout where PageName = '" & PageName & "' and PeopleID = " & session("PeopleID") & " order by PageLayoutID Desc"	
	response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3  
	if not rs2.eof then
        Proceed = "False"
        Message=Message & "<br>A page with that name already exists. Please enter a new page name."
     end if
     
Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select * from Pagelayout "	
	response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3  
if Not rs2.eof then
    LinkOrder = rs2.recordcount - 1
end if
rs2.close

response.write("Proceed=" & Proceed & "<br>")	

if ShowPage = "True" then
	ShowPage = 1
else
	ShowPage = 0
end if

if Proceed="True" then

Query =  "INSERT INTO PageLayout (PeopleID, PageName, PageType, DirectoryName, "
if len(PageGroupID) >0 then
Query = Query & " PagegroupID, "
end if
Query = Query & " Linkname, LinkOrder, PageTitle, FileName,ShowPage,  PageAvailable)" 
	Query =  Query & " Values (" & session("PeopleID") & ", '" & PageName & "', "
	Query =  Query &  " '" & PageType & "' , " 
		   Query =  Query &  " '" & DirectoryName & "' , "
if len(PageGroupID) > 0 then 
	   Query =  Query &  " '" & PagegroupID & "' , " 
end if
    Query =  Query &  " '" & LinkName & "'," 
        Query =  Query &  " " & Linkorder & "," 
        Query =  Query &  " '" &  Heading & "'," 
    Query =  Query &  "'/" & DirectoryName & "/Default.asp' ," 
   Query =  Query &  " " & ShowPage & ", " 
      Query =  Query &  " 1 )" 
response.write("<br>" & Query & "<br>")
conn.execute(Query)
	

 Set rs2 = Server.CreateObject("ADODB.Recordset")

sql2 = "select * from Pagelayout where PageName = '" & PageName & "' and PeopleID = " & session("PeopleID") & " order by PageLayoutID Desc"	
	response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3  
if Not rs2.eof then
    PageLayoutID = rs2("PageLayoutID")
end if
rs2.close

Query =  "INSERT INTO PageSEO (PageName)" 
Query =  Query & " Values ('" &  DirectoryName & "' )" 

response.write(Query)	



 Query =  " UPDATE PageLayout Set Editlink = 'AdminPageData.asp?pagelayoutID=" & PageLayoutID & "' "
Query =  Query & " where PageLayoutID = " & PageLayoutID 

response.write(Query)	

 Set rs = Server.CreateObject("ADODB.Recordset")
BlockNum = 1
while BlockNum < 9 
Query =  "INSERT INTO PageLayout2 (PageLayoutID,   BlockNum )" 
Query =  Query & " Values ('" &  PageLayoutID & "' "
Query =  Query & " , " & BlockNum & " )" 
  	response.write(Query)	

Conn.Execute(Query) 
Set DataConnection = Nothing
BlockNum = BlockNum + 1
wend

sql2 = "select websitepath from Websites, People where People.WebsitesID = websites.WebsitesID and PeopleID = " & PeopleID
	response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3  
	if not rs2.eof then
        websitepath = rs2("websitepath")
     end if

'PhysicalPath = request.servervariables("APPL_PHYSICAL_PATH") 
'newdirectory = PhysicalPath &  DirectoryName & "\"


' Sample PageName variable

' Remove spaces and special characters
Dim regex
Set regex = New RegExp
regex.Pattern = "[^a-zA-Z0-9]+" ' Matches any character that is not a letter or digit
regex.Global = True ' Apply the replacement globally

' Replace spaces and special characters with an empty string
PageName = regex.Replace(PageName, "")



' Source file path
Dim sourceFilePath
sourceFilePath = "C:\inetpub\wwwroot\GlobalGrange\Company\1016\Default.asp"

' Destination directory path
Dim destinationDirectory
destinationDirectory = "C:\inetpub\wwwroot\LivestockOfAmerica\Company\" & Session("PeopleID") & "\"
response.Write("destinationDirectory=" & destinationDirectory )

' Destination file path
Dim destinationFilePath
destinationFilePath = destinationDirectory & "Default.asp"

	response.write("<br><br>destinationDirectory=" & destinationDirectory )
' Check if destination directory exists
Dim fso
Set fso = Server.CreateObject("Scripting.FileSystemObject")
If Not fso.FolderExists(destinationDirectory) Then
    ' Create destination directory
	 response.write("<br>Not Found")
    fso.CreateFolder(destinationDirectory)
else
   response.write("Found")
End If

' Copy the source file to the destination directory
fso.CopyFile sourceFilePath, destinationFilePath

' Clean up
'Set fso = Nothing





Response.redirect("AdminPageData.asp?PageLayoutID=" & PageLayoutID ) 
else
  
Response.redirect("AdminpageAdd.asp?Message=" & Message & "&PageName=" & PageName & "&LinkName=" & LinkName & "&PagegroupID=" & PagegroupID )
end if






%>

</Body>
</HTML>
