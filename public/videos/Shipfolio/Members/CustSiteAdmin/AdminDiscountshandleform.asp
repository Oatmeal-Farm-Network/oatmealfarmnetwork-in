<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
<!--#Include file="GlobalVariables.asp"-->

 <title>Add a user</title>
       <link rel="stylesheet" type="text/css" href="style.css">

</HEAD>

<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">

<%

Dim TotalCount
dim rowcount
dim CouponID(800)
dim CouponContactFirstName(800)
dim CouponContactLastName(800)
dim CouponEmail(800)
dim CouponPhone(800)
dim CouponURL(800)
dim CouponPrice(800)  
dim CouponMinQTY(800)
dim CouponCompany(800)
dim CouponCode(800)
dim ProgramPage(800)
   
TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
rowcount = 1

while (rowcount < TotalCount)
	CouponIDcount = "CouponID(" & rowcount & ")"	
	CouponContactFirstNamecount = "CouponContactFirstName(" & rowcount & ")"
	CouponContactLastNamecount = "CouponContactLastName(" & rowcount & ")"
	CouponEmailcount = "CouponEmail(" & rowcount & ")"
	CouponPhonecount = "CouponPhone(" & rowcount & ")"
	CouponURLcount = "CouponURL(" & rowcount & ")"
    CouponPricecount = "CouponPrice(" & rowcount & ")"
    CouponMinQTYcount = "CouponMinQTY(" & rowcount & ")"
    CouponCompanycount = "CouponCompany(" & rowcount & ")"	
    CouponCodecount = "CouponCode(" & rowcount & ")"
    ProgramPagecount = "ProgramPage(" & rowcount & ")"
 
	CouponID(rowcount)=Request.Form(CouponIDcount) 
	CouponContactFirstName(rowcount)=Request.Form(CouponContactFirstNamecount) 
	CouponContactLastName(rowcount)=Request.Form(CouponContactLastNamecount )
	CouponEmail(rowcount)=Request.Form(CouponEmailcount )
	CouponPhone(rowcount)=Request.Form(CouponPhonecount )
    CouponURL(rowcount) = Request.Form(CouponURLcount)
    CouponPrice(rowcount)=Request.Form(CouponPricecount ) 
    CouponMinQTY(rowcount)=Request.Form(CouponMinQTYcount ) 
    CouponCompany(rowcount)=Request.Form(CouponCompanycount) 
    CouponCode(rowcount)=Request.Form(CouponCodecount) 
    ProgramPage(rowcount)=Request.Form(ProgramPagecount) 
  response.Write("CouponPrice(rowcount)=" & CouponPrice(rowcount) )  
	rowcount = rowcount +1
Wend

 rowcount =1

while (rowcount < TotalCount)

str1 = CouponCode(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	CouponCode(rowcount)= Replace(str1, "'", "''")
End If

str1 = ProgramPage(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProgramPage(rowcount)= Replace(str1, "'", "''")
End If

str1 = CouponContactFirstName(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	CouponContactFirstName(rowcount)= Replace(str1, "'", "''")
End If



str1 = CouponCompany(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	CouponCompany(rowcount)= Replace(str1, "'", "''")
End If


str1 = CouponPhone(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	CouponPhone(rowcount)= Replace(str1, "'", "''")
End If


str1 = CouponURL(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	CouponURL(rowcount)= Replace(str1, "'", "''")
End If


str1 = CouponEmail(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	CouponEmail(rowcount)= Replace(str1, "'", "''")
End If


str1 = CouponContactLastName(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	CouponContactLastName(rowcount)= Replace(str1, "'", "''")
End If




if len(CouponID(rowcount)) > 0 then
	Query =  " UPDATE Coupons Set CouponContactFirstName = '" &  CouponContactFirstName(rowcount) & "', " 
    Query =  Query + "  CouponContactLastName = '" & CouponContactLastName(rowcount) & "'," 
	Query =  Query + "  CouponEmail = '" & CouponEmail(rowcount) & "'," 
    Query =  Query + "  CouponURL = '" & CouponURL(rowcount) & "'," 
    Query =  Query + "  CouponCompany = '" & CouponCompany(rowcount) & "'," 
    if len(CouponPrice(rowcount)) > 1 then
    Query =  Query + " CouponPrice = " & CouponPrice(rowcount) & "," 
    end if
     if len(CouponMinQTY(rowcount)) > 0 then 
    Query =  Query + "  CouponMinQTY = " & CouponMinQTY(rowcount) & "," 
    end if 
   Query =  Query + "  CouponCode = '" & CouponCode(rowcount) & "'," 
   Query =  Query + "  ProgramPage = '" & ProgramPage(rowcount) & "'," 
    Query =  Query + "  CouponPhone = '" & CouponPhone(rowcount) & "'" 
	Query =  Query + " where CouponID = " & CouponID(rowcount) & ";" 

response.write(Query)	

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";"
DataConnection.Execute(Query) 
DataConnection.close
end if

	  rowcount= rowcount +1
	  
	  
	Wend
Set conn = Nothing

response.redirect("AdminCouponsEdit.asp")
 %>

 </Body>
</HTML>
