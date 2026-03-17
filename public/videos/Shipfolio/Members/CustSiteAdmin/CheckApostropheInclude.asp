<%
str1 = TempVar
str2 = "'"
If InStr(str1,str2) > 0 Then
	TempVar= Replace(str1, "'", "''")
End If
%>

