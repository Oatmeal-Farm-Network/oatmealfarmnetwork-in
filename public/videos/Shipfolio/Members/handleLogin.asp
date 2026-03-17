<%@LANGUAGE="VBSCRIPT" %>
<% Response.Buffer = True %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>Login Authentication</title>
<meta name="author" content="The Andresen Group">
<link rel="stylesheet" type="text/css" href="/Style.css">
<!--#Include virtual="/Conn.asp"-->
 <%
Refferal = request.querystring("Refferal")
PeopleID = Request.querystring("PeopleID")

sDate = Now()
sNewDate = DateAdd("yyyy", 2, sDate)

if len(PeopleID)> 0 then

else
    PeopleID = session("PeopleID")
 Response.Cookies("PeopleID")= PeopleID
 Response.Cookies("PeopleID").Expires=now() + 365
end if

UID=Trim(Request.Form("UID")) 
Email=Trim(Request.Form("Email")) 
password=Trim(Request.Form("password")) 

Action = Request.querystring("Action") 
ReturnfileName = Request.querystring("ReturnFileName") 
ReturnEventID = Request.querystring("ReturnEventID") 

if len(Email) > 1 then

else
Email = UID
end if

Email = lcase(trim(Email))
password = trim(password)

if len(Action) < 1 then
  Session("Action") = Action
end if 

	redirect = False


	sql2 = "select * from People where lcase(Peopleemail) = '" & Email & "' and (PeoplePassword = '" & password & "' or PeoplePassword2 = '" & password & "'  )   order by PeopleID Asc"
response.Write("sql2=" & sql2 )
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if Not rs2.eof Then
	PeopleID = rs2("PeopleID")
    session("accesslevel") = rs2("accesslevel")
	Session("PeopleID")= PeopleID
   AISubscription = rs2("AISubscription")
	Response.Cookies("PeopleID")= PeopleID
	Response.Cookies("PeopleID").Expires=now() + 365
	Response.write("cookie PeopleID=" & request.Cookies("PeopleID"))
	custAIEndService = rs2("custAIEndService")
	if len(custAIEndService) < 3 then
	   custAIEndService = FormatDateTime(now,2)
	end if
	
	Session("LoggedIn") = True
    Response.Cookies("LoggedIn")= True
    Response.Cookies("LoggedIn").Expires=now() + 365
	redirect = true

    end if 
rs2.close
'response.Write("redirect=" & redirect)




if len(ReturnFileName) < 5 then
ReturnFileName = "Default.asp"
end if 
'redirect = False

'if DateDiff("d",Now, custAIEndService) > 0 and redirect = True then
'else
'response.Redirect("renewAccount.asp?PeopleID=" & PeopleID )

'end if
	If redirect = "True" then
			
Query =  "UPDATE People Set custlastAccess = " & FormatDateTime(Now(),2) & " " 
Query =  Query & " where PeopleID = " & PeopleID & ";" 
response.Write("Query=" & Query)
		
Conn.Execute(Query)
		  Set conn = Nothing
		  response.Write("Refferal=" & Refferal)
          if Refferal = "True" then
          	Response.Redirect("/administration/ReferaFriend.asp" )
          else
Response.Redirect("/administration/Default.asp" )
              end if
      else
      Set conn = Nothing
    Response.Redirect("/Login.asp?Fail=True" )
     end if  
%>

</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
</BODY>
</HTML>
