<html>

<head>
<!--#Include virtual="/GlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title><%= WebSiteName %> </title>
<META name="description" content="<%= WebSiteName %>">
<META name="keywords" content="<%=State%> Alpaca Ranch, <%= WebSiteName %>, <%= Slogan %>, Alpaca web development, alpacas, alpaca">
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="style.css">

</head>

<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<!--#Include virtual="/Header.asp"-->
<table border="0" cellpadding="5" cellspacing="0" width="800"   height = "350" background = "images/PageBackground.jpg" align = "center" valign = "top">
   <tr>
      <td class = "body" colspan = "3" valign = "top" >
       <br><h1 ><i>&nbsp;Your Bid is Confirmed</i><img src = "images/Line.jpg" width = "500" height = "2"></h1>

<%

	dim ID
	dim Newbid
	dim Fullname


	ID=Request.Form("ID") 
	Newbid=Request.Form("Newbid") 
	Fullname=Request.Form("Fullname") 
	Owner=Request.Form("Owner") 
%>
	
<%
Dim strFName
Dim strLName
Dim strMName
Dim strBizName
Dim strAddress1
Dim strCity
Dim strState
Dim strZipcode
Dim strCountry
Dim strEmail
Dim strPhone
Dim strCommentText

strFName=Request.Form("FName")
strLName=Request.Form("LName")
strMName=Request.Form("MName")
strBizName=Request.Form("BizName")
strAddress1=Request.Form("Address1")
strCity=Request.Form("City")
strState=Request.Form("State")
strZipcode=Request.Form("Zipcode")
strCountry=Request.Form("Country")
strEmail=Request.Form("Email")
strPhone=Request.Form("Phone")
strCommentText=Request.Form("CommentText")
%>



<%
Response.Flush

'Email Contact Information to WebArtists.biz
Dim strTo, strSubject, strBody
Dim objCDONTSmail
Dim smtpServer

If Owner = "Alpacas At Lone Ranch" Then
	'response.write("Alpacas at Lone Ranch")
	smtpServer = "mail.AlpacasAtLoneRanch.com"
	strFrom = "Richard@AlpacasOnTheWeb.com"
	strTo = "renate@hughes.net, johna@WebArtists.biz"
Else
	'response.write("From The Heart Ranch")
	smtpServer = "mail.AlpacasAtLoneRanch.com"
		strFrom = "Richard@AlpacasOnTheWeb.com"
	strTo = "renate@hughes.net, alpaca@fromtheheartranch.com,  johna@WebArtists.biz"

End If 

	strSubject = "You received an auction bid"

strBody = "You received an auction bid"

' Body Data
strBody = strBody & "<br>Alpaca's Name: "
strBody = strBody & Fullname
strBody = strBody & "<br>Owner: "
strBody = strBody & Owner
strBody = strBody & "<br>Bid: "
strBody = strBody & FormatCurrency(Newbid,0)

strBody = strBody & "<br>The bid came from: "
strBody = strBody & strFName
strBody = strBody & "&nbsp;"
strBody = strBody & strMName
strBody = strBody & "&nbsp;"
strBody = strBody & strLName
strBody = strBody & "<br> Business Name: "
strBody = strBody & strBizName
strBody = strBody & "<br>Address:        "
strBody = strBody & strAddress1
strBody = strBody & "<br>                 "
strBody = strBody & strCity
strBody = strBody & ", "
strBody = strBody & strState
strBody = strBody & " "
strBody = strBody & strZipcode
strBody = strBody & " "
strBody = strBody & strCountry
strBody = strBody & "<br>Email Address: "
strBody = strBody & strEmail
strBody = strBody & "<br>Phone: "
strBody = strBody & strPhone
strBody = strBody & "<br><br> Message: "
strBody = strBody & strCommentText
strBody = strBody & "<br>"

'CDONTS EMail
set objCDONTSmail = Server.CreateObject("CDONTS.NewMail")
objCDONTSmail.BodyFormat = 0
objCDONTSmail.MailFormat = 0
objCDONTSmail.From = strFrom
objCDONTSmail.To = strTo
objCDONTSmail.Subject = strSubject
objCDONTSmail.Body = strBody
objCDONTSmail.Send

set objCDONTSmail = Nothing

bidtime = FormatDateTime(now,0)
'response.write(bidtime)

		Query =  "INSERT INTO SFCustomers ( custFirstName,  custMiddleInitial,  custLastName, custCompany, custAddr1, custCity, custState, custZip, custCountry, custLastAccess, custEmail)" 
		Query =  Query & " Values ('" &  strFName & "'," 
		Query =  Query & " '" &  strMName & "'," 
		Query =  Query & " '" &  strLName & "'," 
		Query =  Query & " '"  & strBizName & "'," 
		Query = Query & " '"  &  strAddress1 & "'," 
		Query = Query & " '"  &  strCity & "'," 
		Query = Query & " '"  &  strState & "'," 
		Query =  Query & " '" &  strZipcode & "'," 
		Query =  Query & " '" &  strCountry & "'," 
			Query =  Query & " '" &  bidtime & "'," 
		Query =  Query & " '" &  strEmail & "')"
		'response.write(Query)

		Set DataConnection = Server.CreateObject("ADODB.Connection")

		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(databasepath) 	& ";" 

		DataConnection.Execute(Query) 

		DataConnection.Close
		Set DataConnection = Nothing 

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select custID from SFCustomers where custLastAccess = '" & bidtime & "'"
  Set rs = Server.CreateObject("ADODB.Recordset")
  'response.write(sql)
	
	rs.Open sql, conn, 3, 3 

custID = rs("custID")

    rs.close
	Set Conn = Nothing 


Query =  "INSERT INTO AuctionBids ( custID,  animalID,  Bid, BidDateTime, Comments )" 
		Query =  Query & " Values ('" &  custID & "'," 
		Query =  Query & " '" &  ID & "'," 
		Query =  Query & " '" &  Newbid & "'," 
		Query =  Query & " '"  & bidtime & "'," 
		Query =  Query & " '" &  strCommentText & "')"
		'response.write(Query)

		Set DataConnection = Server.CreateObject("ADODB.Connection")

		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(databasepath) 	& ";" 

		DataConnection.Execute(Query) 

		DataConnection.Close
		Set DataConnection = Nothing 

%>

	<blockquote>	
		Thank you for your bid of <%=FormatCurrency(Newbid,0)%> on <%=Fullname%>. Your bid has been confirmed. Please check back to see how the bidding proceeds.<br><br>
		<A href= "auction.asp" class = "body"> Please click here to view our list of animals in the current auction.</a>	</blockquote>	
</td>
</tr>
</table>
<!--#Include virtual="/Footer.asp"-->
</body>
</html>