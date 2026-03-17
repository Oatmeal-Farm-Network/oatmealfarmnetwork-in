<!-- #include file="conn.asp" -->
<%
Response.ContentType = "application/json"

Dim upload, file, newFileName, savedPath, fileExt
Dim animalId, photoNum, peopleId, updateSQL, cmd
Dim success, message, filePath

' --- CONFIGURATION ---
Dim uploadPath
uploadPath = "/uploads/animals/" ' IMPORTANT: Must be a physical path on your server.
' Example: uploadPath = Server.MapPath("/uploads/animals/")

' Initialize response object
success = false
message = "An unknown error occurred."
filePath = ""

' Create the upload object
Set upload = Server.CreateObject("Persits.Upload")

' Process the uploaded file
upload.SaveVirtual(uploadPath)

' Get the file object
Set file = upload.Files(1)

If Not file Is Nothing Then
    ' --- Get Form Data ---
    animalId = CLng(upload.Form("animalId"))
    photoNum = CInt(upload.Form("photoNum"))
    ' You must add session validation here to ensure the user is logged in
    ' and has permission to edit this animal.
    ' peopleId = Session("PeopleID")
    
    ' --- File Validation ---
    fileExt = LCase(file.Ext)
    If file.ImageWidth = 0 Or file.ImageHeight = 0 Then
        message = "Error: Uploaded file is not a valid image."
    ElseIf file.Size > 1024 * 1024 Then ' 1MB size limit
        message = "Error: File size cannot exceed 1MB."
    ElseIf Instr(".jpg.jpeg.png.webp", fileExt) = 0 Then
        message = "Error: Invalid file type. Only JPG, PNG, and WEBP are allowed."
    Else
        ' --- File is valid, proceed with database update ---
        newFileName = animalId & "_" & photoNum & "_" & Year(Now) & Month(Now) & Day(Now) & "." & fileExt
        file.SaveAs uploadPath & newFileName
        savedPath = "/uploads/animals/" & newFileName

        updateSQL = "UPDATE Photos SET Photo" & photoNum & " = ? WHERE ID = ?"
        
        Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = conn ' Assumes 'conn' is from an include file
        cmd.CommandText = updateSQL
        cmd.Parameters.Append cmd.CreateParameter("@PhotoPath", 200, 1, 255, savedPath) ' adVarChar
        cmd.Parameters.Append cmd.CreateParameter("@ID", 3, 1, , animalId) ' adInteger
        cmd.Execute

        If Err.Number = 0 Then
            success = true
            message = "Upload successful!"
            filePath = savedPath
        Else
            message = "Database error: " & Err.Description
        End If
        
        Set cmd = Nothing
    End If
Else
    message = "No file was uploaded."
End If

' --- Create and send JSON response ---
Response.Write "{""success"": " & LCase(CStr(success)) & ", ""message"": """ & message & """, ""filePath"": """ & filePath & """}"

%>