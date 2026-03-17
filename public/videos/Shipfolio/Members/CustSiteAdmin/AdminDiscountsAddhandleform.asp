<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Add Coupon</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">


</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include virtual="/Administration/Globalvariables.asp"--> 
<!--#Include virtual="/Administration/Header.asp"--> 
<%

	CouponCompany=Request.Form("CouponCompany") 
	CouponContactFirstName=Request.Form("CouponContactFirstName") 
	CouponContactLastName=Request.Form("CouponContactLastName")
	CouponEmail=Request.Form("CouponEmail")
	CouponURL=Request.Form("CouponURL")
	CouponPhone=Request.Form("CouponPhone")
	CouponPrice=Request.Form("CouponPrice")
    CouponMinQTY=Request.Form("CouponMinQTY")
    CouponCode=Request.Form("CouponCode")


str1 = CouponCode
str2 = "'"
If InStr(str1,str2) > 0 Then
	CouponCode= Replace(str1, "'", "''")
End If


str1 = ProgramPage
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProgramPage= Replace(str1, "'", "''")
End If

	        
str1 = CouponCompany
str2 = "'"
If InStr(str1,str2) > 0 Then
	CouponCompany= Replace(str1, "'", "''")
End If

str1 = CouponContactFirstName
str2 = "'"
If InStr(str1,str2) > 0 Then
	CouponContactFirstName= Replace(str1, "'", "''")
End If

str1 = CouponContactLastName
str2 = "'"
If InStr(str1,str2) > 0 Then
	CouponContactLastName= Replace(str1, "'", "''")
End If


str1 = CouponEmail
str2 = "'"
If InStr(str1,str2) > 0 Then
	CouponEmail= Replace(str1, "'", "''")
End If

str1 = CouponURL
str2 = "'"
If InStr(str1,str2) > 0 Then
	CouponURL= Replace(str1, "'", "''")
End If

str1 = CouponPhone
str2 = "'"
If InStr(str1,str2) > 0 Then
	CouponPhone= Replace(str1, "'", "''")
End If



Proceed="False"
if len(CouponCompany) < 3 then
  Message= Message & "<br>Please enter a company name."
end if 
if len(CouponCompany) > 0  then
  Proceed = "True"
else
  Proceed="False"
end if 

response.write("Proceed1=" & Proceed)

if len(CouponURL) < 3 then
  Message=Message & "<br>Please enter a website addres."
end if 

if len(CouponURL) > 0 and Proceed = "True" then
  Proceed = "True"
else
  Proceed="False"
end if 

if len(CouponCode) > 3 and Proceed = "True" then
  Proceed = "True"
else
  Proceed="False"
     Message= Message & "<br>Please enter a coupon code that is at least 4 charecters long."
end if 

if len(CouponCode) > 3 then
'response.write("Proceed2=" & Proceed)
sql2 = "select * from Coupons where CouponCode = '" & CouponCode & "'"

'response.write (sql2)
    Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
   if not rs2.eof then
    Proceed="False"
    Message= Message & "<br>That coupon code has already been used. Please enter a new coupon code."
   end if 

  rs2.close
end if  

if Proceed="True" then

Query =  "INSERT INTO Coupons(CouponContactFirstName, CouponContactLastName, CouponEmail ,CouponCompany,  CouponURL ,"
 if len(CouponPrice) > 0 then 
    Query =  Query & " CouponPrice, "
 end if 
 Query =  Query & " CouponMinQTY, CouponCode, CouponPhone)" 
	Query =  Query & " Values ('" &  CouponContactFirstName & "', "
    Query =  Query &  " '" & CouponContactLastName & "'," 
    Query =  Query &  " '" & CouponEmail & "'," 
    Query =  Query &  " '" & CouponCompany & "'," 
    Query =  Query &  " '" & CouponURL & "',"
    if len(CouponPrice) > 0 then 
    Query =  Query &  " " & CouponPrice & ","  
    end if 
    if len(CouponMinQTY) > 0 then   
   Query =  Query &  " '" & CouponMinQTY & "'," 
    else 
    Query =  Query &  " 0," 
    end if  
    Query =  Query &  " '" & CouponCode & "',"
  	Query =  Query &  " '" & CouponPhone & "' )" 

response.write(Query)	


Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";"
DataConnection.Execute(Query) 


Query =  "INSERT INTO PageLayout(PageName, LinkName, FileName , PageGroup, PageAvailable, EditLink)" 
	Query =  Query & " Values ('Coupon-" &  CouponCompany & "', "
    Query =  Query &  " 'Coupon " &  CouponCompany & "'," 
    Query =  Query &  " 'CouponStore.asp'," 
    Query =  Query &  " 'Coupon'," 
    Query =  Query &  " True," 
    Query =  Query &  " 'PageData2.asp?pagename=Coupon-" &  CouponCompany & "' )" 


response.write(Query)	


Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";"
DataConnection.Execute(Query) 
DataConnection.close
Set dataConnection = Nothing


		Set rs = Server.CreateObject("ADODB.Recordset")
		sql = "select PageLayoutID from PageLayout where PageName = 'Coupon-" &  CouponCompany & "' "
		'response.write(sql)
		rs.Open sql, conn, 3, 3
		if not rs.eof then
 			PageLayoutID = rs("PageLayoutID")
		end if

X = 0
		while X < 9
		 X = X + 1 
			Query =  "INSERT INTO PageLayout2 (PageLayoutID, BlockNum )" 
			Query =  Query & " Values (" &  PageLayoutID & ", " 
			Query =  Query &  " " &  X & " )" 
 		
		
		response.write(Query)
		Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";"	
DataConnection.Execute(Query) 
		wend


response.write(Query)	

DataConnection.close
Set dataConnection = Nothing

response.write("DatabasePath=" & DatabasePath)
	 

End if

if Proceed = "False" then
  Response.redirect("AdminCouponsadd.asp?Message=" & Message & "&CouponContactFirstName=" & CouponContactFirstName & "&CouponContactLastName=" & CouponContactLastName & "&CouponCode=" & CouponCode  & "&CouponEmail=" &  CouponEmail & "&CouponPhone=" &  CouponPhone & "&CouponURL=" & CouponURL & "&CouponCompany="  &  CouponCompany & "&CouponMinQTY=" &  CouponMinQTY & "&CouponPrice=" &  CouponPrice )
 
else
  Response.redirect("AdminCouponsadd.asp?Message2=The coupon was successfully added.")
end if
%>

<!--#Include file="AdminFooter.asp"-->
</Body>
</HTML>
