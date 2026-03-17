<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Pricing Page</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">


<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

		<!--#Include virtual="/Administration/Dimensions.asp"-->
		<!--#Include virtual="/Administration/Header.asp"--> 
		<!--#Include virtual="/administration/adminDetailDBInclude.asp"--> 



<%

Dim valdefaultRate
Dim valBaseRate
Dim valAddedRate

'rowcount = CInt
rowcount = 1

valdefaultRate=Request.Form("valdefaultRate") 

valBaseRate=Request.Form("valBaseRate") 
valAddedRate=Request.Form("valAddedRate") 

If Len(valdefaultRate)< 1 Then
   valdefaultRate = 0
End If

If Len(valBaseRate)< 1 Then
   valBaseRate = 0
End If

If Len(valAddedRate)< 1 Then
   valAddedRate = 0
End If

    Query =  " UPDATE SFStandardShipping Set valdefaultRate = " & valdefaultRate & " ,"
	Query =  Query & "valBaseRate =" & valBaseRate & " ,"
	Query =  Query & "valAddedRate = " & valAddedRate & " "
    Query =  Query & " where ValID = 1;" 


response.write(Query)	


Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};UID=Studio;Password=Smonkey;DBQ=" & Server.MapPath(DatabasePath) 	& " ;" 


DataConnection.Execute(Query) 

	  rowcount= rowcount +1


IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 End If

	DataConnection.Close
	Set DataConnection = Nothing 

		Response.Redirect("shippingrates.asp")
%>

</td>
    </tr>
	</table>

		<!--#Include virtual="/administration/Footer.asp"--></Body>
</HTML>

 </Body>
</HTML>
