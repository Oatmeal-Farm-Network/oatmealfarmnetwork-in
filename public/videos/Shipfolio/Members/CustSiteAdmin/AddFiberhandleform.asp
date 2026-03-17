<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Fiber Data Results Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/administration/Header.asp"--> 
<%

	Dim TotalCount
	dim rowcount, ID

	dim FullName(300)
	dim SampleDate(300)
	dim Average(300)
	dim StandardDev(300)
	dim COV(300)
	dim GreaterThan30(300)
	dim CF(300)
	dim Curve(300)
	dim ShearWeight(300)
	dim BlanketWeight(300)
	dim Length(300)
	dim CrimpPerInch(300)


TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 0

	FullNamecount = "FullName(" & rowcount & ")"
	SampleDatecount = "SampleDate(" & rowcount & ")"
	Averagecount = "Average(" & rowcount & ")"
	StandardDevcount = "StandardDev(" & rowcount & ")"
	COVcount = "COV(" & rowcount & ")"
	GreaterThan30count = "GreaterThan30(" & rowcount & ")"
	CFcount = "CF(" & rowcount & ")"
	Curvecount = "Curve(" & rowcount & ")"
	ShearWeightcount = "ShearWeight(" & rowcount & ")"
	BlanketWeightcount = "BlanketWeight(" & rowcount & ")"
	Lengthcount = "Length(" & rowcount & ")"
	CrimpPerInchcount = "CrimpPerInch(" & rowcount & ")"
	
	ID=Request.Form("ID")
	FullName(rowcount)=Request.Form(FullNamecount) 
	SampleDate(rowcount)=Request.Form(SampleDatecount )
	Average(rowcount)=Request.Form(Averagecount) 
	StandardDev(rowcount)=Request.Form(StandardDevcount) 
	COV(rowcount)=Request.Form(COVcount) 
	GreaterThan30(rowcount)=Request.Form(GreaterThan30count) 
	CF(rowcount)=Request.Form(CFcount) 
	Curve(rowcount)=Request.Form(Curvecount) 
	ShearWeight(rowcount)=Request.Form(ShearWeightcount) 
	BlanketWeight(rowcount)=Request.Form(BlanketWeightcount) 
	Length(rowcount)=Request.Form(Lengthcount) 
	CrimpPerInch(rowcount)=Request.Form(CrimpPerInchcount) 


if len(ID) < 1 then
	response.write("<center>Your changes could not be made. Please select an Alpaca's Name</center>")
	
else

Query =  "INSERT INTO Fiber ( ID, SampleDate,  Average, StandardDev, COV, CF, Curve, ShearWeight, BlanketWeight, Length, CrimpPerInch, GreaterThan30)" 
	Query =  Query + " Values (" +  ID + " ,"
	Query =  Query +  " '" + SampleDate(rowcount) + "', " 
    Query =  Query +  " '" + Average(rowcount) + "'," 
    Query =  Query +   " '" + StandardDev(rowcount) + "'," 
    Query =  Query +  " '" +  COV(rowcount) + "'," 
	Query =  Query +   " '" + CF(rowcount) + "'," 
    Query =  Query +  " '" +  Curve(rowcount) + "'," 
	Query =  Query +  " '" +  ShearWeight(rowcount) + "'," 
	Query =  Query +  " '" +  BlanketWeight(rowcount) + "'," 
	Query =  Query +  " '" +  Length(rowcount) + "'," 
	Query =  Query +  " '" +  CrimpPerInch(rowcount) + "'," 
    Query =  Query +  " '" + GreaterThan30(rowcount)  + "')" 

'response.write(Query)	

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath("../../db/AlpacaDB.mdb") & ";" 



DataConnection.Execute(Query) 



IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 %>
<div align = "center"><H2>
<%
     response.write("Your changes have successfully been made.")
  %></H2>
</div>
<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 
end if 
%>

<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  class = "Links" href="FiberData.asp"> Return to Fiber Data Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>
