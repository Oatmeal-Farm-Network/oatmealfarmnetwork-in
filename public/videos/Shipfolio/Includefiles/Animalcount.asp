<%
'response.write("name=" & Name)
str1 = Name
str2 = "'"
If InStr(str1,str2) > 0 Then
Name= Replace(str1,  str2, "")
End If  
'response.write("name=" & Name)
'Query =  " UPDATE AnimalStats Set Statdate = '2015-08-07 12:05:34' "
'Query =  Query & " where Statdate = '0000-00-00 00:00:00'" 
'conn.Execute(Query) 

Query =  "INSERT INTO AnimalStats ( AnimalID,  PeopleID, AnimalName, WebsiteID)" 
Query =  Query & " Values (" &  ID & ", " & CurrentPeopleID & ", '" & Name & "', 1 )"
'response.write(Query)
conn.Execute(Query) 

%>

