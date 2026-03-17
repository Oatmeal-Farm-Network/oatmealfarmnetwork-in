

<%
Dim content, contentType, contentDisposition, boundary

' Read the request content
content = Request.BinaryRead(Request.TotalBytes)

' Get the content-type header
contentType = Request.ServerVariables("HTTP_CONTENT_TYPE")

' Get the content-disposition header
contentDisposition = Request.ServerVariables("HTTP_CONTENT_DISPOSITION")

' Get the boundary string from the content-type header
boundary = GetBoundary(contentType)

' Split the content into parts based on the boundary
Dim parts
parts = Split(content, "--" & boundary)

' Process each part
Dim i, formData, fileName, fieldName, fieldValue, contentTypePart
For i = 1 To UBound(parts) - 1
    ' Get the current part
    Dim part
    part = parts(i)
    
    ' Find the position of the first occurrence of vbCrLf
    Dim pos
    pos = InStr(part, vbCrLf & vbCrLf)
    
    ' Extract the headers and content of the part
    Dim headers, partContent
    headers = Trim(Left(part, pos))
    partContent = Mid(part, pos + 4)
    
    ' Find the position of the first occurrence of vbCrLf in the headers
    Dim headersPos
    headersPos = InStr(headers, vbCrLf)
    
    ' Extract the content-disposition header
    Dim partDisposition
    partDisposition = Trim(Left(headers, headersPos))
    
    ' Extract the content-type header
    contentTypePart = GetContentType(partDisposition)
    
    ' Extract the fieldname from the content-disposition header
    fieldName = GetFieldName(partDisposition)
    
    ' Extract the filename from the content-disposition header
    fileName = GetFileName(partDisposition)
    
    ' Extract the field value from the form data
    fieldValue = GetFieldValue(partContent)
    
    ' Process the form data based on the field type
    If fieldName <> "" Then
        If fileName <> "" Then
            ' File field
            ' Do something with the uploaded file
            ' Save it, move it, or process it as needed
        Else
            ' Text field
            ' Do something with the field value
        End If
    End If
    
    ' Call the ProcessFormData function passing the field name, field value, and content type
    ProcessFormData fieldName, fieldValue, contentTypePart
Next

' Extracts the boundary string from the content-type header
Private Function GetBoundary(contentType)
    Dim arrParams, i

    arrParams = Split(contentType, ";")

    For i = 0 To UBound(arrParams)
        If InStr(arrParams(i), "boundary") > 0 Then
            GetBoundary = Trim(Replace(arrParams(i), "boundary=", ""))
            Exit Function
        End If
    Next
End Function

' Extracts the filename from the content-disposition header
Private Function GetFileName(contentDisposition)
    Dim arrParams, i

    arrParams = Split(contentDisposition, ";")

    For i = 0 To UBound(arrParams)
        If InStr(arrParams(i), "filename") > 0 Then
            GetFileName = Trim(Replace(arrParams(i), "filename=", ""))
            Exit Function
        End If
    Next
End Function

' Extracts the fieldname from the content-disposition header
Private Function GetFieldName(contentDisposition)
    Dim arrParams, i

    arrParams = Split(contentDisposition, ";")

    For i = 0 To UBound(arrParams)
        If InStr(arrParams(i), "name") > 0 Then
            GetFieldName = Trim(Replace(arrParams(i), "name=", ""))
            Exit Function
        End If
    Next
End Function

' Extracts the content-type from the content-disposition header
Private Function GetContentType(contentDisposition)
    Dim arrParams, i

    arrParams = Split(contentDisposition, ";")

    For i = 0 To UBound(arrParams)
        If InStr(arrParams(i), "Content-Type") > 0 Then
            GetContentType = Trim(Replace(arrParams(i), "Content-Type=", ""))
            Exit Function
        End If
    Next
End Function

' Extracts the field value from the form data
Private Function GetFieldValue(formData)
    GetFieldValue = Trim(formData)
End Function

' Process the form data
Private Sub ProcessFormData(fieldName, fieldValue, contentType)
    ' Add your custom code here to process the form data
    ' You can access the field name, field value, and content type
    
    ' Example: Print the field name and field value
    Response.Write("Field Name: " & fieldName & "<br>")
    Response.Write("Field Value: " & fieldValue & "<br>")
    Response.Write("<br>")

'ID=request.querystring("ID")
'photonum=request.querystring("photonum")

'	Query =  " UPDATE Photos Set Photo" & photonum & " = '" &  fileName & "' " 
'	Query =  Query & " where ID = " & ID & ";" 
'response.write("Query=" & Query )
'Conn.Execute(Query) 
'Conn.Close
'Set Conn = Nothing 

End Sub






%>
