<!--#Include virtual="/ConnLOA.asp"--> 
<%
str1 = SourceFullName
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceFullName= Replace(str1, "'", "''")
End If
Found = False
if len(SourceLOAID) > 0 then
sql = "select * from Animals where  PeopleID= " &  session("AIID") & " and (ID = " &   SourceLOAID  & " ) ;"
'ReSPONSE.WRITE("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, ConnLOA, 3, 3   
If (Not rs.eof) and len(trim(SourceLOAID)) > 0 Then
'Response.write("SourceLOAID=!" & len(SourceLOAID) & "!")
AnimalID = rs("ID")
Found = True
End if		 
rs.close
 
else
SourceLOAID = ""
end if

if rs.state> 0 then
rs.close
end if

'ReSPONSE.WRITE("Found=" & Found)
If Found = True and len(trim(SourceLOAID)) > 0 Then %>
<!--#Include virtual="/Administration/Transfers/TransferFoundAnimal.asp"--> 
<% Else %>
<!--#Include virtual="/Administration/Transfers/TransferNewAnimal.asp"--> 
<% End if
if not isObject(ConnLOA)  = True then
ConnLOA.close
Set ConnLOA = nothing
end if %>