<%
'response.write("name=" & Name)
str1 = Name
str2 = "'"
If InStr(str1,str2) > 0 Then
Name= Replace(str1,  str2, "")
End If  

str1 = packageName
str2 = "'"
If InStr(str1,str2) > 0 Then
PackageName= Replace(str1,  str2, "")
End If  

'response.write("name=" & Name)
'Query =  " UPDATE PackageStats Set Statdate = '2015-08-07 12:05:34' "
'Query =  Query & " where Statdate = '0000-00-00 00:00:00'" 
'conn.Execute(Query)  

Query =  "INSERT INTO PackageStats ( PackageID,  PeopleID, PackageName, WebsiteID)" 
Query =  Query & " Values (" &  packageID & ", " & CurrentPeopleID & ", '" & PackageName & "', 1 )"
'response.write(Query)
conn.Execute(Query) 
conn.Close
Set conn = Nothing 
%>