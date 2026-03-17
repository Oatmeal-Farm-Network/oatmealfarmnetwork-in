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

Query =  "INSERT INTO AnimalStats ( AnimalID,  PeopleID, AnimalName, Websitename)" 
Query =  Query & " Values (" &  ID & ", " & CurrentPeopleID & ", '" & sitename & "', 1 )"
'response.write(Query)
conn.Execute(Query) 

sql = "select FullName, ID, peopleid from Animals where publishforsale = 1 order by rand() limit 1"
rs.Open sql, conn, 3, 3 
if not rs.eof then
StatAnimalname = rs("FullName")
str1 = StatAnimalname
str2 = "'"
If InStr(str1,str2) > 0 Then
StatAnimalname= Replace(str1,  str2, "")
End If  
StatID = rs("ID")
StatPeopleId = rs("PeopleId")
'response.write("animalname=" & animalname )

Query =  "INSERT INTO AnimalStats ( AnimalID,  PeopleID, AnimalName, Websitename)" 
Query =  Query & " Values (" &  StatID & ", " & StatPeopleId & ", '" & StatAnimalname & "', '" & WebSiteName & "' )"
'response.write(Query)
conn.Execute(Query) 
end if




conn.Close
Set conn = Nothing 
%>

