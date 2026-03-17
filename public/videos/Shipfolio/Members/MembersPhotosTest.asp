<%@ Language=VBScript %>
<%
' Define the maximum dimensions for the resized image
Const MAX_WIDTH = 800
Const MAX_HEIGHT = 600

' Function to resize the image
Function ResizeImage(originalImage, maxWidth, maxHeight)
    ' Create a new image object
    Set objImage = Server.CreateObject("Persits.Jpeg")
    
    ' Load the original image
    objImage.OpenBinary originalImage
    
    ' Get the original dimensions
    originalWidth = objImage.Width
    originalHeight = objImage.Height
    
    ' Calculate the new dimensions while maintaining the aspect ratio
    ratioX = maxWidth / originalWidth
    ratioY = maxHeight / originalHeight
    If ratioX < ratioY Then
        newWidth = maxWidth
        newHeight = originalHeight * ratioX
    Else
        newWidth = originalWidth * ratioY
        newHeight = maxHeight
    End If
    
    ' Resize the image
    objImage.Width = newWidth
    objImage.Height = newHeight
    
    ' Generate a new filename based on the original image's name
    resizedFileName = Replace(Replace(Replace(originalImage.Name, "\", "_"), "/", "_"), " ", "_")
    resizedImage = Server.MapPath("uploads/") & resizedFileName ' Change the folder path as needed
    
    ' Save the resized image
    objImage.Save resizedImage
    
    ' Clean up the image object
    objImage.Close
    Set objImage = Nothing
    
    ' Return the path to the resized image
    ResizeImage = "https://www.Livestockoftheworld.com/uploads/" & resizedFileName ' Return the full URL of the resized image
End Function

' Handle the file upload
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
    ' Check if a file was uploaded
    If Request.TotalBytes > 0 Then
        ' Get the uploaded file data as binary
        uploadedData = Request.BinaryRead(Request.TotalBytes)
        
        ' Create a new temporary file to save the uploaded data
        Set fso = CreateObject("Scripting.FileSystemObject")
        tempFilePath = Server.MapPath("../../Livestockoftheworld.com/uploads/temp.jpg") ' Change the filename and extension as needed
        Set tempFile = fso.CreateTextFile(tempFilePath, True)
        tempFile.BinaryWrite uploadedData
        tempFile.Close
        
        ' Resize the image
        resizedImagePath = ResizeImage(tempFilePath, MAX_WIDTH, MAX_HEIGHT)
        
        ' Display the resized image
        Response.Write "<h2>Resized Image:</h2>"
        Response.Write "<img src='" & resizedImagePath & "' alt='Resized Image'>"
        
        ' Delete the temporary uploaded file
        fso.DeleteFile tempFilePath
        Set fso = Nothing
    Else
        Response.Write "No file was uploaded."
    End If
End If
%>
<!DOCTYPE html>
<html>
<head>
    <title>Image Upload and Resize</title>
</head>
<body>
    <h2>Upload and Resize Image</h2>
    <form method="POST" enctype="multipart/form-data">
        <input type="hidden" name="MAX_FILE_SIZE" value="1048576"> <!-- Set the maximum file size limit in bytes -->
        <input type="file" name="image" accept="image/jpeg, image/png">
        <br>
        <input type="submit" value="Upload and Resize">
    </form>
</body>
</html>

