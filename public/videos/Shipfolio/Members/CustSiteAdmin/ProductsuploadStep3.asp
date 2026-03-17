<%@ Language=VBScript %>

<% 


Response.Expires = -1
Server.ScriptTimeout = 600
%>
 <!-- #include file="GlobalVariables.asp" -->
<!--#Include file="freeaspupload.asp" -->
 <!-- #include file="Dimensions.asp" -->
<%

' ****************************************************
' Change the value of the variable below to the pathname
' of a directory with write permissions, for example "C:\Inetpub\wwwroot"
  Dim uploadsDirVar
    uploadsDirVar = uploadPath & "\\Products\\"

' ****************************************************



function TestEnvironment()
    Dim fso, fileName, testFile, streamTest
    TestEnvironment = ""
    Set fso = Server.CreateObject("Scripting.FileSystemObject")
    if not fso.FolderExists(uploadsDirVar) then
        TestEnvironment = "<B>Folder " & uploadsDirVar & " does not exist.</B><br>The value of your uploadsDirVar is incorrect. Open uploadTester.asp in an editor and change the value of uploadsDirVar to the pathname of a directory with write permissions."
        exit function
    end if
    fileName = uploadsDirVar & "\test.txt"
    on error resume next
    Set testFile = fso.CreateTextFile(fileName, true)
    If Err.Number<>0 then
        TestEnvironment = "<B>Folder " & uploadsDirVar & " does not have write permissions.</B><br>The value of your uploadsDirVar is incorrect. Open uploadTester.asp in an editor and change the value of uploadsDirVar to the pathname of a directory with write permissions."
        exit function
    end if
    Err.Clear
    testFile.Close
    fso.DeleteFile(fileName)
    If Err.Number<>0 then
        TestEnvironment = "<B>Folder " & uploadsDirVar & " does not have delete permissions</B>, although it does have write permissions.<br>Change the permissions for IUSR_<I>computername</I> on this folder."
        exit function
    end if
    Err.Clear
    Set streamTest = Server.CreateObject("ADODB.Stream")
    If Err.Number<>0 then
        TestEnvironment = "<B>The ADODB object <I>Stream</I> is not available in your server.</B><br>Check the Requirements page for information about upgrading your ADODB libraries."
        exit function
    end if
    Set streamTest = Nothing
end function

function SaveFiles
'response.write("SaveFiles")
	
	
	Dim Upload, fileName, fileSize, ks, i, fileKey

    Set Upload = New FreeASPUpload
    Upload.Save(uploadsDirVar)

	' If something fails inside the script, but the exception is handled
	If Err.Number<>0 then Exit function

    SaveFiles = ""
    ks = Upload.UploadedFiles.keys
    if (UBound(ks) <> -1) then
        'SaveFiles = "<B>Files uploaded:</B> "
        for each fileKey in Upload.UploadedFiles.keys
            SaveFiles = Upload.UploadedFiles(fileKey).FileName 
 
		'SaveFiles = SaveFiles & Upload.UploadedFiles(fileKey).FileName & " (" & Upload.UploadedFiles(fileKey).Length & "B) "
		
        next
    else
        SaveFiles = "The file name specified in the upload form does not correspond to a valid file in the system."
    end if
	
end function
%>

<HTML>
<HEAD>
<title>Photo Upload</title>
       <link rel="stylesheet" type="text/css" href="/Administration/style.css">

</HEAD>

<BODY>
<% Showsearch = True %>

<!--#Include file="Header.asp"--> 



<%

'if Request.ServerVariables("REQUEST_METHOD") <> "POST" then
 '   diagnostics = TestEnvironment()
  '  if diagnostics<>"" then
   '     response.write "<div style=""margin-left:20; margin-top:30; margin-right:30; margin-bottom:30;"">"
    '    response.write diagnostics
     '   response.write "<p>After you correct this problem, reload the page."
      '  response.write "</div>"
    'else
     '   response.write "<div style=""margin-left:150"">"
      '  OutputForm()
       ' response.write "</div>"
    'end if
'else
 
  ProdID = Session("ProdID")
' If Len(ProdID) < 4 then
'ProdID=request.form("ProdID") 
'End If
'response.write("ProdID=")
'response.write(ProdID)

	Filename = SaveFiles()
    

    str1 = Filename
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		Filename= Replace(str1,  str2, "''")
	End If  


	Query =  " UPDATE sfProducts Set prodImageSmallPath = '" &  Filename & "' ," 
		Query =  Query + " prodImageLargePath = '" &  Filename & "' " 
	Query =  Query + " where ProdID = '" & ProdID & "';" 

'response.write(Query)
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

DataConnection.Execute(Query) 
 

%>
<table border = "0" width = "625"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
					<tr>
							<td colspan = "2" ><h1>Upload Photos </h1></td>
					</tr>
					<tr>
						<td colspan = "2"   height = "2"  background = "images/Underline.jpg"><img src = "images/px.gif". height = "2"></td>
					</tr>
				<tr>
						<td colspan = "2"   height = "5"  class = "body"></td>
					</tr>
				</table>
				<h2><b>Your Photo Has Been Uploaded:</b><img src = "/uploads/Products/<%=Filename%>" width = "100"></h2>
<br>

<div align = "left">
	<blockquote><h2>Where To Go Next:</h2>
			<table>
			<tr>
				<td class = "body" align = "leftr" width = "600">
					<ul>
					 <li><a href = "ProductsUploadPhotos.asp" class = "body">
					Upload Another Photo</a><br>
				
					<li><a href = "EditAd.asp" class = "body">
					Edit one of your Listings.</a><br> 
				
					<li><a href = "Default.asp" class = "body">
					Go to the admin home page.</a>
					</ul>
				</td>
			</tr>
		</table>
		
		
	</blockquote>
   </div>
 <!-- #include file="Footer.asp" -->


</BODY>
</HTML>
