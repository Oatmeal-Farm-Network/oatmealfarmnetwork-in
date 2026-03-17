<%
Query =  "INSERT INTO Stats ( AnimalID,  Statdate)" 
Query =  Query + " Values ('" &  ID & "'," 
Query =  Query + " '" &  FormatDateTime(Now , 2)  & "')"
'response.write(Query)
Conn.Execute(Query) 
Conn.Close
Set Conn = Nothing 
%>