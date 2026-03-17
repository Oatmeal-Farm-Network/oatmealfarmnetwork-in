<%
Dim IDArray(999999)
Dim alpacaName(999999)

%>
<!--#Include virtual="/Conn.asp"-->
<%
Set rsb = Server.CreateObject("ADODB.Recordset")
PeopleID = session("PeopleID")
'**************************************************************
' Check if the About Us Page is listed in RanchPageLayout
'**************************************************************
sql = "select * from RanchPageLayout where PageName = 'About Us' and PeopleID = " & PeopleID
rs.Open sql, conn, 3, 3
If  rs.eof then
rs.close
Query =  "INSERT INTO RanchPageLayout (PeopleID, LinkOrder, Linkname, Editlink, FileName, PageName, PageAvailable, ShowPage )" 
Query =  Query & " Values (" &  PeopleID  & ", "
Query =  Query &  " 4," 
Query =  Query &  " 'About Us'," 
Query =  Query &  " 'PageData2.asp?pagename=About Us&PeopleID=" & PeopleID & "'," 
Query =  Query &  " 'RanchAboutUs.asp?PeopleID=" & PeopleID & "'," 
Query =  Query &  " 'About Us' ," 
Query =  Query &  " Yes ,"
Query =  Query &  " Yes )"
Conn.Execute(Query) 
Conn.Close
Set Conn = Server.CreateObject("ADODB.Connection") 
Conn.Open "DSN=" & DSN_Name & ";UID=Test;PWD=Test"
sql = "select PageLayoutID from RanchPageLayout where PeopleID = " & PeopleID & " and LinkName='About Us'"
rs.Open sql, conn, 3, 3
PageLayoutID = rs("PageLayoutID")
X = 0
while X < 9
X = X + 1 
	Query =  "INSERT INTO RanchPageLayout2 (PeopleID, BlockNum, PageLayoutID )" 
	Query =  Query & " Values (" & PeopleID & ", " 
	Query =  Query &  " " &  X & ", " 
  	Query =  Query &  " " & PageLayoutID & " )" 
 
Conn.Execute(Query) 
       Conn.Close
	Set Conn = Server.CreateObject("ADODB.Connection") 
Conn.Open "DSN=" & DSN_Name & ";UID=Test;PWD=Test"
	wend
	else
end if 

 If not rs.State = adStateClosed Then
  rs.close
End If   
 Set rsa = Server.CreateObject("ADODB.Recordset")
sqla = "select * from animals, Pricing where animals.id = Pricing.id and PublishForSale = True and PeopleID = " & PeopleID & " Order by Price desc"
rsa.Open sqla, conn, 3, 3
If not rsa.eof then
numPublishedAnimals = rsa.recordcount    
end if
rsa.close


sqla = "select * from animals, Pricing where animals.id = Pricing.id and PublishStud = True and PeopleID = " & PeopleID & " Order by Price desc"
rsa.Open sqla, conn, 3, 3
If not rsa.eof then
numPublishedStuds = rsa.recordcount    
end if
rsa.close

sqlb = "select SubscriptionLevel from People where PeopleID = " & PeopleID
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then
SubscriptionLevel = rsb("SubscriptionLevel")
end if
rsb.close

%>