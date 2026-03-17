<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="John Andresen">
    <meta name="generator" content="Oatmeal Farm Network">
    <title>Oatmeal Farm Network</title>
<!--#Include file="MembersGlobalVariables.asp"-->
<% Current2="Animals" 
Current3 = "AddAnimals"
Current1 = "MembersHome"
BladeSection = "accounts" 
pagename = BusinessName
Hidelinks = True %>

<!--#Include file="MembersHeader.asp"-->


<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
   var submitcount=0;
   function checkSubmit() {

      if (submitcount == 0)
      {
      submitcount++;
      document.Surv.submit();
      }
   }


function wordCounter(field, countfield, maxlimit) {
wordcounter=0;
for (x=0;x<field.value.length;x++) {
      if (field.value.charAt(x) == " " && field.value.charAt(x-1) != " ")  {wordcounter++}  // Counts the spaces while ignoring double spaces, usually one in between each word.
      if (wordcounter > 250) {field.value = field.value.substring(0, x);}
      else {countfield.value = maxlimit - wordcounter;}
      }
   }

function textCounter(field, countfield, maxlimit) {
  if (field.value.length > maxlimit)
      {field.value = field.value.substring(0, maxlimit);}
      else
      {countfield.value = maxlimit - field.value.length;}
  }
//  End -->
</script>

<%	Dim TotalCount

	dim FullName(40000)
	dim SampleAge(40000)
	dim SampleDateDay(40000)
	dim SampleDateMonth(40000)
	dim SampleDateYear(40000)
	dim Average(40000)
	dim StandardDev(40000)
	dim COV(40000)
	dim GreaterThan30(40000)
	dim CF(40000)
	dim Curve(40000)
	dim ShearWeight(40000)
	dim BlanketWeight(40000)
	dim Length(40000)
	dim CrimpPerInch(40000)


TotalCount= Request.Form("TotalCount")
'rowcount = CInt(rowcount)
rowcount = 0

BusinessID = Request.querystring("BusinessID")

AnimalID=Request.Form("AnimalID")
if len(AnimalID) > 0 then
else
AnimalID = Request.querystring("AnimalID")
end if

if len(AnimalID) > 0 then
AnimalID = AnimalID
end if
	
SpeciesID=Request.Form("SpeciesID")
if len(SpeciesID) > 0 then
else
SpeciesID= Request.querystring("SpeciesID")
end if

NumberofAnimals = Request.Querystring("NumberofAnimals")

 sql2 = "select FullName from Animals where AnimalID = " &  AnimalID & ";" 	
	Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
    If not rs2.eof Then
      Name = rs2("FullName")
    end if

	sql2 = "select * from fiber where AnimalID = " &  AnimalID & ";" 
	Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
    If rs2.eof Then


For rowcount = 1 To 10
	FullNamecount = "FullName(" & rowcount & ")"
	SampleDateMonthcount = "SampleDateMonth(" & rowcount & ")"
		SampleDateDaycount = "SampleDateDay(" & rowcount & ")"
			SampleDateYearcount = "SampleDateYear(" & rowcount & ")"
	Averagecount = "Average(" & rowcount & ")"
	StandardDevcount = "StandardDev(" & rowcount & ")"
	COVcount = "COV(" & rowcount & ")"
	GreaterThan30count = "GreaterThan30(" & rowcount & ")"
	CFcount = "CF(" & rowcount & ")"
	Curvecount = "Curve(" & rowcount & ")"
	SampleAgecount = "SampleAge(" & rowcount & ")"
	ShearWeightcount = "ShearWeight(" & rowcount & ")"
	BlanketWeightcount = "BlanketWeight(" & rowcount & ")"
	Lengthcount = "Length(" & rowcount & ")"
	CrimpPerInchcount = "CrimpPerInch(" & rowcount & ")"
	
	
	FullName(rowcount)=Request.Form(FullNamecount) 
	SampleDateMonth(rowcount)=Request.Form(SampleDateMonthcount )
		SampleDateDay(rowcount)=Request.Form(SampleDateDaycount )
			SampleDateYear(rowcount)=Request.Form(SampleDateYearcount )
	Average(rowcount)=Request.Form(Averagecount) 
	StandardDev(rowcount)=Request.Form(StandardDevcount) 
	COV(rowcount)=Request.Form(COVcount) 
	GreaterThan30(rowcount)=Request.Form(GreaterThan30count) 
	CF(rowcount)=Request.Form(CFcount) 
	Curve(rowcount)=Request.Form(Curvecount) 
	SampleAge(rowcount)=Request.Form(SampleAgecount) 
	ShearWeight(rowcount)=Request.Form(ShearWeightcount) 
	BlanketWeight(rowcount)=Request.Form(BlanketWeightcount) 
	Length(rowcount)=Request.Form(Lengthcount) 
	CrimpPerInch(rowcount)=Request.Form(CrimpPerInchcount) 


    

Query =  "INSERT INTO Fiber ( AnimalID, "
if len(SampleDateMonth(rowcount)) > 0 then
    Query =  Query & "SampleDateMonth, "
end if
if len(SampleDateDay(rowcount)) > 0 then
	Query =  Query & " SampleDateDay, "
end if
if len(SampleDateYear(rowcount)) > 0 then		
	Query =  Query & " SampleDateYear,"
end if			
		Query =  Query & " Average, StandardDev, COV,  ShearWeight, CF, Curve,  CrimpPerInch, Length, BlanketWeight, GreaterThan30)" 
	Query =  Query & " Values (" &  AnimalID & " ,"
	if len(SampleDateMonth(rowcount)) > 0 then
	Query =  Query &  " '" & SampleDateMonth(rowcount) & "', " 
	end if
if len(SampleDateDay(rowcount)) > 0 then
	Query =  Query &  " '" & SampleDateDay(rowcount) & "', "
	end if
if len(SampleDateYear(rowcount)) > 0 then	 
	Query =  Query &  " '" & SampleDateYear(rowcount) & "', " 
end if
    Query =  Query &  " '" & Average(rowcount) & "'," 
    Query =  Query &   " '" & StandardDev(rowcount) & "'," 
    Query =  Query &  " '" &  COV(rowcount) & "'," 
	Query =  Query &  " '" &  ShearWeight(rowcount) & "'," 
	Query =  Query &  " '" & CF(rowcount) & "'," 
	Query =  Query &  " '" & Curve(rowcount) & "'," 
	Query =  Query &  " '" &  CrimpPerInch(rowcount) & "'," 
	Query =  Query &  " '" &  Length(rowcount) & "'," 
	Query =  Query &  " '" &  BlanketWeight(rowcount) & "'," 
    Query =  Query &  " '" & GreaterThan30(rowcount)  & "')" 


Conn.Execute(Query) 

next
conn.close
set conn=nothing
 End If
%>

<% 

'If rs2.State = adStateOpen Then
	'rs2.close
'end if%> 


<div class ="container roundedtopandbottom">
  <div class="row">
     <div class="col-sm-12">
         <br />   <H3>Description</H3><a name="Top"></a>
     </div>
</div>
<div class ="row">
  <div class ="col-sm-12" align =  "Center">
   <iframe src="membersAnimalsdescriptionFrame.asp?AnimalID=<%=AnimalID%>&BusinessID=<%=BusinessID %>&SpeciesID=<%=SpeciesID %>&NumberofAnimals=<%=NumberofAnimals%>" height = '568' width = '90%' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
  </div>
</div>
	</div>
<!--#Include file="MembersFooter.asp"--> </Body>
</HTML>
