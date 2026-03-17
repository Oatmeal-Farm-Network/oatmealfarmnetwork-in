<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<link rel="shortcut icon" href="http://www.TheAndresenGroup/AGFavIcon.ico" > 
<link rel="icon" href="http://www.TheAndresenGroup/AGFavIcon.ico" > 
<!--#Include virtual="/ConnCustomers.asp"-->
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
   <% Current = "Home" %>
  <table width = "980"  border = "0" cellpadding = "0" cellspacing = "0" bgcolor = "#EEDD99">
  <tr>
  <td >
     <table border = "0" cellspacing="0" cellpadding = "0" align = "center" height = "520" >
	<tr>
	<td  align = "center" valign = "top">
<%  response.Write("dayy=" & weekday( now() ))
'on error resume next
'Server.ScriptTimeout = 2147483647
Server.ScriptTimeout = 5000
'Server.ScriptTimeout = 21600
 Dim ObjSendMail
 
 Sub Pause(intSeconds)
  startTime = Time()
  Do Until DateDiff("s", startTime, Time(), 0, 0) > intSeconds
  Loop
 End Sub

 Set rs = Server.CreateObject("ADODB.Recordset")	

 if weekday( now() ) = 5 then
 response.Write("dayy=" & weekday( now() ))

sql = "select  Address from emaillist2  "
'response.write(sql)
rs.Open sql, connCustomers, 3, 3
If  rs.eof then
	rs.close			
else
totalrecords = rs.recordcount
rs.close
response.write("totalrecords=" & totalrecords)
'Email Contact Information to WebArtists.biz
Dim strTo, strSubject, strBody
Dim objCDONTSmail
Dim smtpServer
dim idarray(1000000)
totalrecords =10151


'Not Yahoo
'Yahoo
count = 0
CurrentID =0
foundcount = 0

while count < totalrecords and foundcount < 1
	count = count + 1	
	sql = "select  Address, SentEmailDate from emaillist2 where  alpacas = True and ReceiveEmails = True and EmailID= " & CurrentID
    'response.write(sql)	 
    if rs.state = 0 then
    else
    rs.close
    end if	 

rs.Open sql, connCustomers, 3, 3
				if not rs.eof then
	    strTo = rs("Address")
	'if rs("SentEmailDate")= FormatDateTime(now, 2) or rs("SentEmailDate")= "1/08/2013" or rs("SentEmailDate")= "1/09/2013"   or InStr(lcase(strTo), "aol.com") > 0 or InStr(lcase(strTo), "gmail.com") > 0 or InStr(lcase(strTo), "msn.com") > 0 or InStr(lcase(strTo), "hotmail.com") > 0  or InStr(lcase(strTo), "comcast.net") > 0 or InStr(lcase(strTo), "yahoo") > 0 Then
	if  rs("SentEmailDate")= FormatDateTime(now, 2) or Address= "alpacasofmadisoncounty@yahoo.com" or InStr(lcase(strTo), "yahoo") > 0 or InStr(lcase(strTo), "gmail") > 0 or InStr(lcase(strTo), "att") > 0 or InStr(lcase(strTo), "aol") > 0 or InStr(lcase(strTo), "bellsouth") > 0 Then
	
	else
		foundcount =foundcount  + 1
 'Pause(460)
    	Query =  " UPDATE emaillist2 set SentEmailDate = '" & FormatDateTime(now, 2) & "'" 
	Query =  Query & " where EmailID =" & CurrentID & ";" 
'response.write(Query)
   connCustomers.Execute(Query) 

   connCustomers.close
   set connCustomer = nothing
%>
<!--#Include file="IndepenceDaySendSingleEmail.asp"-->
<!--#Include virtual="/ConnCustomers.asp"-->
<% response.write("Sent CurrentID=" & CurrentID & "strTo=" & strTo & "<BR>")
response.write( "<BR>time= " & now)



end if
end if

CurrentID = CurrentID + 1
wend





'Gmail
count = 0
CurrentID =0
foundcount = 0

while count < totalrecords and foundcount < 0
	count = count + 1	
	sql = "select  Address, SentEmailDate from emaillist2 where  alpacas = True and ReceiveEmails = True and EmailID= " & CurrentID
    'response.write(sql)	 
  If not rs.State = adStateClosed Then
  rs.close
End If   

rs.Open sql, connCustomers, 3, 3
				if not rs.eof then
	    strTo = rs("Address")
	'if rs("SentEmailDate")= FormatDateTime(now, 2) or rs("SentEmailDate")= "1/08/2013" or rs("SentEmailDate")= "1/09/2013"   or InStr(lcase(strTo), "aol.com") > 0 or InStr(lcase(strTo), "gmail.com") > 0 or InStr(lcase(strTo), "msn.com") > 0 or InStr(lcase(strTo), "hotmail.com") > 0  or InStr(lcase(strTo), "comcast.net") > 0 or InStr(lcase(strTo), "yahoo") > 0 Then
	if  rs("SentEmailDate")= FormatDateTime(now, 2) or Address= "alpacasofmadisoncounty@yahoo.com" or not InStr(lcase(strTo), "gmail") > 0  Then
	
	else
		foundcount =foundcount  + 1
 'Pause(460)
    	Query =  " UPDATE emaillist2 set SentEmailDate = '" & FormatDateTime(now, 2) & "'" 
	Query =  Query & " where EmailID =" & CurrentID & ";" 
'response.write(Query)
   connCustomers.Execute(Query) 

   connCustomers.close
   set connCustomer = nothing
%>
<!--#Include file="IndepenceDaySendSingleEmail.asp"-->
<!--#Include virtual="/ConnCustomers.asp"-->
<% response.write("Sent CurrentID=" & CurrentID & "strTo=" & strTo & "<BR>")
response.write( "<BR>time= " & now)



end if
end if

CurrentID = CurrentID + 1
wend

'Yahoo
count = 0
CurrentID =0
foundcount = 0

while count < totalrecords and foundcount < 0
	count = count + 1	
	sql = "select  Address, SentEmailDate from emaillist2 where  alpacas = True and ReceiveEmails = True and EmailID= " & CurrentID
    'response.write(sql)	 
  If not rs.State = adStateClosed Then
  rs.close
End If   

rs.Open sql, connCustomers, 3, 3
				if not rs.eof then
	    strTo = rs("Address")
	'if rs("SentEmailDate")= FormatDateTime(now, 2) or rs("SentEmailDate")= "1/08/2013" or rs("SentEmailDate")= "1/09/2013"   or InStr(lcase(strTo), "aol.com") > 0 or InStr(lcase(strTo), "gmail.com") > 0 or InStr(lcase(strTo), "msn.com") > 0 or InStr(lcase(strTo), "hotmail.com") > 0  or InStr(lcase(strTo), "comcast.net") > 0 or InStr(lcase(strTo), "yahoo") > 0 Then
	if  rs("SentEmailDate")= FormatDateTime(now, 2) or Address= "alpacasofmadisoncounty@yahoo.com" or not InStr(lcase(strTo), "yahoo") > 0  Then
	
	else
		foundcount =foundcount  + 1
 'Pause(460)
    	Query =  " UPDATE emaillist2 set SentEmailDate = '" & FormatDateTime(now, 2) & "'" 
	Query =  Query & " where EmailID =" & CurrentID & ";" 
'response.write(Query)
   connCustomers.Execute(Query) 

   connCustomers.close
   set connCustomer = nothing
%>
<!--#Include file="IndepenceDaySendSingleEmail.asp"-->
<!--#Include virtual="/ConnCustomers.asp"-->
<% response.write("Sent CurrentID=" & CurrentID & "strTo=" & strTo & "<BR>")
response.write( "<BR>time= " & now)



end if
end if

CurrentID = CurrentID + 1
wend



'AOL
count = 0
CurrentID =0
foundcount = 0
while count < totalrecords and foundcount < 0
	count = count + 1	
	sql = "select  Address, SentEmailDate from emaillist2 where alpacas = True and ReceiveEmails = True and EmailID= " & CurrentID
	'response.write(sql)	
    if rs.state = 0 then
    else
    rs.close
    end if		
				rs.Open sql, connCustomers, 3, 3
				if not rs.eof then
	    strTo = rs("Address")
	'if rs("SentEmailDate")= FormatDateTime(now, 2) or rs("SentEmailDate")= "1/08/2013" or rs("SentEmailDate")= "1/09/2013"   or InStr(lcase(strTo), "aol.com") > 0 or InStr(lcase(strTo), "gmail.com") > 0 or InStr(lcase(strTo), "msn.com") > 0 or InStr(lcase(strTo), "hotmail.com") > 0  or InStr(lcase(strTo), "comcast.net") > 0 or InStr(lcase(strTo), "yahoo") > 0 Then
	if rs("SentEmailDate")= FormatDateTime(now, 2) or Address= "alpacasofmadisoncounty@yahoo.com" or not InStr(lcase(strTo), "AOL") > 0  Then

	else
		foundcount =foundcount  + 1
 'Pause(460)
    	Query =  " UPDATE emaillist2 set SentEmailDate = '" & FormatDateTime(now, 2) & "'" 
	Query =  Query & " where EmailID =" & CurrentID & ";" 
response.write(Query)
   connCustomers.Execute(Query) 
%>
<!--#Include file="IndepenceDaySendSingleEmail.asp"-->
<!--#Include virtual="/ConnCustomers.asp"-->
<% response.write("Sent CurrentID=" & CurrentID & "strTo=" & strTo & "<BR>")
response.write( "<BR>time= " & now)



end if
end if
rs.close
CurrentID = CurrentID + 1
wend





'Att
count = 0
CurrentID =0
foundcount = 0
while count < totalrecords and foundcount < 0
	count = count + 1	
	sql = "select  Address, SentEmailDate from emaillist2 where alpacas = True and ReceiveEmails = True and EmailID= " & CurrentID
	'response.write(sql)
    
    if rs.state = 0 then
    else
    rs.close
    end if			
				rs.Open sql, connCustomers, 3, 3
				if not rs.eof then
	    strTo = rs("Address")
	'if rs("SentEmailDate")= FormatDateTime(now, 2) or rs("SentEmailDate")= "1/08/2013" or rs("SentEmailDate")= "1/09/2013"   or InStr(lcase(strTo), "aol.com") > 0 or InStr(lcase(strTo), "gmail.com") > 0 or InStr(lcase(strTo), "msn.com") > 0 or InStr(lcase(strTo), "hotmail.com") > 0  or InStr(lcase(strTo), "comcast.net") > 0 or InStr(lcase(strTo), "yahoo") > 0 Then
	if rs("SentEmailDate")= FormatDateTime(now, 2) or Address= "alpacasofmadisoncounty@yahoo.com" or not InStr(lcase(strTo), "att") > 0  Then
	
	else
		foundcount =foundcount  + 1
 'Pause(460)
    	Query =  " UPDATE emaillist2 set SentEmailDate = '" & FormatDateTime(now, 2) & "'" 
	Query =  Query & " where EmailID =" & CurrentID & ";" 
response.write(Query)
   connCustomers.Execute(Query) 
  
%>
<!--#Include file="IndepenceDaySendSingleEmail.asp"-->
<% response.write("Sent CurrentID=" & CurrentID & "strTo=" & strTo & "<BR>")
response.write( "<BR>time= " & now)



end if
end if
rs.close
CurrentID = CurrentID + 1
wend





'Bellsouth
count = 0
CurrentID =0
foundcount = 0
while count < totalrecords and foundcount < 0
	count = count + 1	
	sql = "select  Address, SentEmailDate from emaillist2 where alpacas = True and ReceiveEmails = True and EmailID= " & CurrentID
	'response.write(sql)			
				rs.Open sql, connCustomers, 3, 3
				if not rs.eof then
	    strTo = rs("Address")
	'if rs("SentEmailDate")= FormatDateTime(now, 2) or rs("SentEmailDate")= "1/08/2013" or rs("SentEmailDate")= "1/09/2013"   or InStr(lcase(strTo), "aol.com") > 0 or InStr(lcase(strTo), "gmail.com") > 0 or InStr(lcase(strTo), "msn.com") > 0 or InStr(lcase(strTo), "hotmail.com") > 0  or InStr(lcase(strTo), "comcast.net") > 0 or InStr(lcase(strTo), "yahoo") > 0 Then
	if  rs("SentEmailDate")= FormatDateTime(now, 2) or Address= "alpacasofmadisoncounty@yahoo.com" or not InStr(lcase(strTo), "bellsouth") > 0 Then
	
	else
		foundcount =foundcount  + 1
 'Pause(460)
    	Query =  " UPDATE emaillist2 set SentEmailDate = '" & FormatDateTime(now, 2) & "'" 
	Query =  Query & " where EmailID =" & CurrentID & ";" 
response.write(Query)
   connCustomers.Execute(Query) 
%>
<!--#Include file="IndepenceDaySendSingleEmail.asp"-->
<% response.write("Sent CurrentID=" & CurrentID & "strTo=" & strTo & "<BR>")
response.write( "<BR>time= " & now)



end if
end if
rs.close
CurrentID = CurrentID + 1
wend
end if

end if
'response.write(  CurrentID &  "<BR>")
connCustomers.Close
Set connCustomers = Nothing
%>
</td>
</tr>
</table>

</body>
</html>
