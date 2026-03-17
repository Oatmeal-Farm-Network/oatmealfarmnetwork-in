<% if Ancestor="0" then
Ancestor= ""
end if
if AncestorColor="0" then
AncestorColor= ""
end if
if AncestorARI="0" then
AncestorARI= ""
end if
if AncestorCLAA="0" then
AncestorCLAA= ""
end if
str1 = Ancestor
str2 = "'"
If InStr(str1,str2) > 0 Then
Ancestor= Replace(str1, "'", "''")
End If
str1 = Ancestor2
str2 = "'"
If InStr(str1,str2) > 0 Then
Ancestor2= Replace(str1, "'", "''")
End If
str1 = AncestorColor
str2 = "'"
If InStr(str1,str2) > 0 Then
Ancestor= Replace(str1, "'", "''")
End If
str1 = AncestorARI
str2 = "'"
If InStr(str1,str2) > 0 Then
Ancestor= Replace(str1, "'", "''")
End If
str1 = AncestorCLAA
str2 = "'"
If InStr(str1,str2) > 0 Then
Ancestor= Replace(str1, "'", "''")
End If %>