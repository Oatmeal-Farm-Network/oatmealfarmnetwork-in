<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Transfer Alpaca to Another farm</title>
<meta name="Title" content="Alpaca Infinity Membersistration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/alpacachamps/infinityknot.ico" /> 
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="MembersGlobalVariables.asp"-->

   <% 
   Current2="AlpacasHome"
   Current3="TransferOwnership" %> 
<!--#Include file="MembersHeader.asp"-->
   <br /> 
   
<% If not rs.State = adStateClosed Then
  rs.close
End If   	%>

 <!--#Include file="MembersAnimalsTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Transfer Animal to Another Ranch</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />
 <table width = "900"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
<td class = "body" valign = "top">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" >
<tr><td class = "roundedtop" align = "left" width = "500">
		<H3><div align = "left">Confirm Your Transfer</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />



<%

	AlpacaID=Request.Form("AlpacaID" ) 
	NewOwnerID=Request.Form("NewOwnerID" ) 
		
'response.write("AlpacaID=")
'response.write(AlpacaID)
'response.write("NewOwnerID=")
'response.write(NewOwnerID)

sql2 = "select PeopleID, Businessname, People.PeopleFirstName, People.PeopleLastName from people, business where people.BusinessID=business.BusinessID and accesslevel > 0 and People.AISubscription = True and PeopleID = " & NewOwnerID & " order by Businessname"
Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
 acounter = 1
While Not rs2.eof  
		UserIDArray = rs2("PeopleID")
		Businessname = rs2("Businessname")
		PeopleFirstName  = rs2("PeopleFirstName")
		PeopleLastName  = rs2("PeopleLastName")

	

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing

		sql2 = "select * from Animals where ID = " & AlpacaID
		Set rs2 = Server.CreateObject("ADODB.Recordset")
		rs2.Open sql2, conn, 3, 3 
			AlpacasName = rs2("FullName")
		rs2.close
%>
<form  action="TransferAnimal3.asp" method = "post" name = "t2">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body" align = "center">

Please confirm that you wish to transfer <b><%=AlpacasName %></b><br>
to <b><%=PeopleFirstName %> <%=PeopleLastName %> 
	<% If Len(BusinessName) > 1 then %>
		of  <%=BusinessName %>
	<% End If %></b><br>
		

						<input type = "hidden" name="AlpacaID" value= "<%= AlpacaID %>" >
							<input type = "hidden" name="NewOwnerID" value= "<%= NewOwnerID %>" >
	
				<input type=submit Value = "Submit" class = "regsubmit2" >
				</td>
			  </tr>
		    </table>
		  </form>
	</td>
</tr>
</table>
	</td>
</tr>
</table>
<br>
	</td>
</tr>
</table><br>
<!--#Include virtual="/Footer.asp"--> </Body>
</HTML>
