<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Upload Photos Page</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">


<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">



<!--#Include virtual="/Administration/Header.asp"--> 
<!--#Include virtual="/Administration/adminDetailDBInclude.asp"--> 
<!--#Include virtual="/Administration/Dimensions.asp"-->

<%



dim Caption
Dim captionid

ID = Session("AnimalID")
'response.write (ID)

'rowcount = CInt
rowcount = 1

Caption=Request.Form("Caption") 
CaptionID=Request.Form("CaptionID") 
 rowcount =1
CaptionName = "PhotoCaption" & CaptionID
'Response.write("CaptionName=")
'Response.write(CaptionName)
str1 = CaptionName
str2 = ","
If InStr(str1,str2) > 0 Then
	CaptionName= Replace(str1, ",", "")
End If

str1 = Caption
str2 = "'"
If InStr(str1,str2) > 0 Then
	Caption= Replace(str1, "'", "''")
End If

Query =  " UPDATE Photos Set " & CaptionName & " = '" &  Caption & "' " 
	Query =  Query + " where ID = " & ID & ";" 

'response.write(Query)	


Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 


DataConnection.Execute(Query) 

	  rowcount= rowcount +1


IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 End If

	DataConnection.Close
	Set DataConnection = Nothing 

%>

 <!-- #include file="PhotoFormInclude.asp" -->
 </Body>
</HTML>
