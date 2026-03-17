<%
Class clsUpload
    Private m_arr_fields
    Private m_arr_files

    Private Sub Class_Initialize()
        Dim lng_len, bin_data, str_data, arr_data, str_bound
        Dim i, str_name, str_filename, str_content_type
        Dim lng_pos_start, lng_pos_end, bin_file_data, lng_crlf_pos

        ReDim m_arr_fields(0)
        ReDim m_arr_files(0)

        lng_len = Request.TotalBytes
        If lng_len = 0 Then Exit Sub

        bin_data = Request.BinaryRead(lng_len)
        str_data = BinToText(bin_data)
        
        ' --- CORRECTED SECTION ---
        ' Find the position of the first carriage return/line feed
        lng_crlf_pos = InStr(str_data, vbCrLf)

        ' If no line break is found, the data is invalid, so we exit.
        If lng_crlf_pos = 0 Then Exit Sub

        ' Now it's safe to call the Left function
        str_bound = Left(str_data, lng_crlf_pos - 1)
        ' --- END OF CORRECTION ---

        If Len(str_bound) = 0 Then Exit Sub

        arr_data = Split(str_data, str_bound)

        For i = 1 To UBound(arr_data) - 1
            lng_pos_start = InStr(arr_data(i), "Content-Disposition: form-data; ")
            
            If lng_pos_start > 0 Then
                lng_pos_start = lng_pos_start + 32
                lng_pos_end = InStr(lng_pos_start, arr_data(i), """")

                If lng_pos_end > 0 Then
                    str_name = Mid(arr_data(i), lng_pos_start, lng_pos_end - lng_pos_start)
                    lng_pos_start = InStr(arr_data(i), "filename=""")

                    If lng_pos_start > 0 Then
                        ' This is a FILE
                        lng_pos_start = lng_pos_start + 10
                        lng_pos_end = InStr(lng_pos_start, arr_data(i), """")
                        str_filename = Mid(arr_data(i), lng_pos_start, lng_pos_end - lng_pos_start)

                        If str_filename <> "" Then
                            ReDim Preserve m_arr_files(UBound(m_arr_files) + 1)
                            Set m_arr_files(UBound(m_arr_files)) = New clsUploadFile

                            m_arr_files(UBound(m_arr_files)).Name = str_name
                            m_arr_files(UBound(m_arr_files)).FileName = str_filename

                            lng_pos_start = InStr(arr_data(i), "Content-Type: ")
                            If lng_pos_start > 0 Then
                                lng_pos_start = lng_pos_start + 14
                                lng_pos_end = InStr(lng_pos_start, arr_data(i), vbCrLf)
                                str_content_type = Mid(arr_data(i), lng_pos_start, lng_pos_end - lng_pos_start)
                                m_arr_files(UBound(m_arr_files)).ContentType = str_content_type
                            End If

                            lng_pos_start = InStr(1, arr_data(i), vbCrLf & vbCrLf) + 4
                            lng_pos_end = Len(arr_data(i)) - 2
                            bin_file_data = MidB(bin_data, InStrB(1, bin_data, TextToBin(arr_data(i))) + lng_pos_start - 1, (InStrB(1, bin_data, TextToBin(arr_data(i))) + lng_pos_end) - (InStrB(1, bin_data, TextToBin(arr_data(i))) + lng_pos_start - 1))
                            m_arr_files(UBound(m_arr_files)).FileData = bin_file_data
                        End If
                    Else
                        ' This is a regular FORM FIELD
                        ReDim Preserve m_arr_fields(UBound(m_arr_fields) + 1)
                        Set m_arr_fields(UBound(m_arr_fields)) = New clsUploadField

                        m_arr_fields(UBound(m_arr_fields)).Name = str_name
                        lng_pos_start = InStr(1, arr_data(i), vbCrLf & vbCrLf) + 4
                        m_arr_fields(UBound(m_arr_fields)).Value = Mid(arr_data(i), lng_pos_start, Len(arr_data(i)) - lng_pos_start - 2)
                    End If
                End If
            End If
        Next
    End Sub

    Public Property Get Fields()
        Set Fields = New clsUploadFields
        Fields.Init m_arr_fields
    End Property

    Public Property Get Files()
        Set Files = New clsUploadFiles
        Files.Init m_arr_files
    End Property

    Private Function BinToText(bin)
        Dim oStream
        Set oStream = Server.CreateObject("ADODB.Stream")
        oStream.Type = 1
        oStream.Open
        oStream.Write bin
        oStream.Position = 0
        oStream.Type = 2
        oStream.Charset = "iso-8859-1"
        BinToText = oStream.ReadText
        oStream.Close
        Set oStream = Nothing
    End Function

    Private Function TextToBin(str)
        Dim oStream
        Set oStream = Server.CreateObject("ADODB.Stream")
        oStream.Type = 2
        oStream.Charset = "iso-8859-1"
        oStream.Open
        oStream.WriteText str
        oStream.Position = 0
        oStream.Type = 1
        TextToBin = oStream.Read
        oStream.Close
        Set oStream = Nothing
    End Function
End Class

Class clsUploadFields
    Private m_arr
    Public Sub Init(arr)
        m_arr = arr
    End Sub
    Public Function Item(var_item)
        Dim i, l_item
        l_item = LCase(CStr(var_item))
        For i = 1 To UBound(m_arr)
            If LCase(m_arr(i).Name) = l_item Then
                Set Item = m_arr(i)
                Exit Function
            End If
        Next
    End Function
    Public Default Function Count()
        Count = UBound(m_arr)
    End Function
End Class

Class clsUploadField
    Public Name
    Public Value
End Class

Class clsUploadFiles
    Private m_arr
    Public Sub Init(arr)
        m_arr = arr
    End Sub
    Public Function Item(var_item)
        Dim i, l_item
        l_item = LCase(CStr(var_item))
        For i = 1 To UBound(m_arr)
            If LCase(m_arr(i).Name) = l_item Then
                Set Item = m_arr(i)
                Exit Function
            End If
        Next
    End Function
    Public Default Function Count()
        Count = UBound(m_arr)
    End Function
End Class

Class clsUploadFile
    Public Name
    Public FileName
    Public ContentType
    Public FileData
End Class
%>