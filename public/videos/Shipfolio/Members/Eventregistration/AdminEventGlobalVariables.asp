<% 'Global Variables
Dim IDArray(999999)
Dim alpacaName(999999)
%>
<!--#Include virtual="/members/Conn.asp"-->
<%
PeopleID = session("PeopleID")
if Len(Session("PeopleID")) < 1 then
Session("PeopleID") = Request.Cookies("PeopleID")
PeopleID = session("PeopleID")
end if  %>
<%
PeopleID = session("PeopleID")
if Len(Session("PeopleID")) < 1 then
Session("PeopleID") = Request.Cookies("PeopleID")
PeopleID = session("PeopleID")
end if  

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
Query =  Query &  " 1 ,"
Query =  Query &  " 0 )"
Conn.Execute(Query) 
 %>

<%sql = "select PageLayoutID from RanchPageLayout where PeopleID = " & PeopleID & " and LinkName='About Us'"
rs.Open sql, conn, 3, 3
PageLayoutID = rs("PageLayoutID")
rs.close
X = 0
while X < 9
X = X + 1 
Query =  "INSERT INTO RanchPageLayout2 (PeopleID, BlockNum, PageLayoutID )" 
Query =  Query & " Values (" & PeopleID & ", " 
Query =  Query &  " " &  X & ", " 
Query =  Query &  " " & PageLayoutID & " )" 
Conn.Execute(Query) 
wend
else
end if 
If not rs.State = adStateClosed Then
rs.close
End If  
%>


<title><%=Sitenamelong %> Administration</title>
<meta name="Title" content="<%=Sitenamelong %> Administration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="stylesheet" type="text/css" href="/administration/adminstyle.css" />