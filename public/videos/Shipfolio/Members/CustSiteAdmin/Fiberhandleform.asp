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
dim rowcount
dim ID(300)
	dim FiberID(300)
	dim FiberOrder(300)
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
rowcount = 1

while (rowcount < TotalCount)
	IDcount = "ID(" & rowcount & ")"	
	FiberIDcount = "FiberID(" & rowcount & ")"	
	FiberOrdercount = "FiberOrder(" & rowcount & ")"	
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
	Curvecount = "Curve(" & rowcount & ")"
	CrimpPerInchcount = "CrimpPerInch(" & rowcount & ")"

	ID(rowcount)=Request.Form(IDcount)
	FiberID(rowcount)=Request.Form(FiberIDcount) 
	FiberOrder(rowcount)=Request.Form(FiberOrdercount) 
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

	rowcount = rowcount +1
Wend

 rowcount =1


while (rowcount < TotalCount)


	Query =  " UPDATE Fiber Set SampleDate = '" &  SampleDate(rowcount) & "', " 
	Query =  Query & " fiberorder = " &  fiberorder(rowcount) & "," 
	Query =  Query & " Average = '" &  Average(rowcount) & "'," 
    Query =  Query & " StandardDev = '" &   StandardDev(rowcount) & "'," 
    Query =  Query & " COV = '" &  COV(rowcount) & "'," 
    Query =  Query & " GreaterThan30 = '"  &  GreaterThan30(rowcount) & "'," 
	Query =  Query & " CF = '" &  CF(rowcount) & "'," 
    Query =  Query & " Curve = '"  &  Curve(rowcount) & "'," 
	 Query =  Query & " ShearWeight = '"  &  ShearWeight(rowcount) & "'," 
    Query =  Query & " BlanketWeight = '"  &  BlanketWeight(rowcount) & "'," 
	Query =  Query & " Length = '"  &  Length(rowcount) & "'," 
	Query =  Query & " CrimpPerInch = '"  &  CrimpPerInch(rowcount) & "'," 
    Query =  Query & "  ID = " & ID(rowcount) & " " 
	Query =  Query & " where FiberID = " & FiberID(rowcount) & ";" 

'response.write(Query)	

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath("../../db/AlpacaDB.mdb") & ";" 



DataConnection.Execute(Query) 

	  rowcount= rowcount +1
	Wend

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
