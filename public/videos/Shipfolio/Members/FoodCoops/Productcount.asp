<%
str1 = ProdName
str2 = "'"
If InStr(str1,str2) > 0 Then
ProdName= Replace(str1,  str2, "")
End If  
'Query =  " UPDATE ProductStats Set Statdate = '2015-08-07 12:05:34' "
'Query =  Query & " where Statdate = '0000-00-00 00:00:00'" 
'conn.Execute(Query) 


Query =  "INSERT INTO ProductStats ( ProdID,  PeopleID, Productname, WebsiteID)" 
Query =  Query & " Values (" &  ProdID & ", " & CurrentPeopleID & ", '" & ProdName & "', 1 )"
conn.Execute(Query) 
conn.Close
Set conn = Nothing 
%>