<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalvariables.asp"--> 

</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<%

BFSGrossIncome=Request.Form("BFSGrossIncome" ) 
BFSCashFlow=Request.Form("BFSCashFlow" ) 
BFSFFandE=Request.Form("BFSFFandE" ) 
BFSEBITDA=Request.Form("BFSEBITDA" ) 
BFSEstablished=Request.Form("BFSEstablished" ) 
BFSEmployees=Request.Form("BFSEmployees" ) 
BFSStreet1=Request.Form("BFSStreet1" ) 
BFSStreet2=Request.Form("BFSStreet2" ) 
BFSCity=Request.Form("BFSCity" ) 
BFSState=Request.Form("BFSState" ) 
BFSZip=Request.Form("BFSZip" ) 
BFSSold=Request.Form("BFSSold") 
BFSName=Request.Form("BFSName" ) 
BFSAskingPrice=Request.Form("BFSAskingPrice" ) 
BFSDescription=Request.Form("BFSDescription") 
BFSForSale=Request.Form("BFSForSale") 
BFSWebsite1=Request.Form("BFSWebsite1") 
BFSWebsite2=Request.Form("BFSWebsite2") 
BFSWebsite3=Request.Form("BFSWebsite3") 
BFSInventory=Request.Form("BFSInventory") 
BFSRealEstate=Request.Form("BFSRealEstate") 
PropID=Request.Form("PropID") 

str1 = BFSGrossIncome
str2 = ","
If InStr(str1,str2) > 0 Then
	BFSGrossIncome= Replace(str1, ",", "")
End If

str1 = BFSGrossIncome
str2 = "'"
If InStr(str1,str2) > 0 Then
BFSGrossIncome= Replace(str1, "'", "''")
End If

str1 = BFSCashFlow
str2 = ","
If InStr(str1,str2) > 0 Then
BFSCashFlow= Replace(str1, ",", "")
End If

str1 = BFSCashFlow
str2 = "'"
If InStr(str1,str2) > 0 Then
BFSCashFlow= Replace(str1, "'", "''")
End If

str1 = BFSFFandE
str2 = ","
If InStr(str1,str2) > 0 Then
BFSFFandE= Replace(str1, ",", "")
End If

str1 = BFSFFandE
str2 = "'"
If InStr(str1,str2) > 0 Then
BFSFFandE= Replace(str1, "'", "''")
End If


str1 = BFSEBITDA
str2 = ","
If InStr(str1,str2) > 0 Then
BFSEBITDA= Replace(str1, ",", "")
End If

str1 = BFSEBITDA
str2 = "'"
If InStr(str1,str2) > 0 Then
BFSEBITDA= Replace(str1, "'", "''")
End If





str1 = lcase(BFSWebsite1)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	BFSWebsite1= right(BFSWebsite1, len(BFSWebsite1) - 7)
End If  

str1 = lcase(BFSWebsite2)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	BFSWebsite2= right(BFSWebsite2, len(BFSWebsite2) - 7)
End If  

str1 = lcase(BFSWebsite3)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	BFSWebsite3= right(BFSWebsite3, len(BFSWebsite3) - 7)
End If  

str1 = lcase(BFSWebsite4)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	BFSWebsite4= right(BFSWebsite4, len(BFSWebsite4) - 7)
End If  

str1 = BFSDescription
str2 = "'"
If InStr(str1,str2) > 0 Then
	BFSDescription= Replace(str1, "'", "''")
End If

str1 = BFSName
str2 = "'"
If InStr(str1,str2) > 0 Then
	BFSName= Replace(str1, "'", "''")
End If

str1 = BFSFFandE 
str2 = "'"
If InStr(str1,str2) > 0 Then
BFSFFandE = Replace(str1, "'", "''")
End If

str1 = BFSEBITDA
str2 = "'"
If InStr(str1,str2) > 0 Then
BFSEBITDA = Replace(str1, "'", "''")
End If

str1 =  BFSEstablished 
str2 = "'"
If InStr(str1,str2) > 0 Then
BFSEstablished  = Replace(str1, "'", "''")
End If


 sql2 = "select * from BusinessForSale where PeopleID = " & session("PeopleID") & " and BFSName = '" & BFSName & "'" 
			'response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   

   If not rs2.eof Then
		BFSID = rs2("BFSID")

	else

Query =  "INSERT INTO BusinessForSale (BFSName,  PeopleID,  BFSDescription,   BFSStreet2, BFSCity, BFSState, BFSZip,  "
if len(BFSAskingPrice) > 0 then       
Query = Query & " BFSAskingPrice,  " 
end if
 if len(BFSGrossIncome) > 0 then       
Query = Query & " BFSGrossIncome , " 
end if
 if len(BFSCashFlow) > 0 then       
Query = Query & " BFSCashFlow , " 
end if
 if len(BFSFFandE) > 0 then       
Query = Query & " BFSFFandE , " 
end if
 if len(BFSEBITDA) > 0 then       
Query = Query & " BFSEBITDA , " 
end if
 if len(BFSEstablished) > 0 then       
Query = Query & " BFSEstablished , " 
end if
 if len(BFSEmployees) > 0 then       
Query = Query & "  BFSEmployees , " 
end if
 if len(PropID) > 0 then       
Query = Query & "  PropID , " 
end if
if len(BFSInventory) > 0 then
Query = Query & " BFSInventory, "
end if
if len(BFSRealEstate) > 0 then
Query = Query & " BFSRealEstate, "
end if

Query = Query & " BFSStreet1, BFSSold, BFSForSale, BFSWebsite1, BFSWebsite2, BFSWebsite3 )" 
		Query =  Query & " Values ('" &  BFSName & "'," 	
 		Query =  Query & " " &  Session("PeopleID") & "," 
		Query = Query & " '"  &  BFSDescription & "', " 
		Query = Query & " '"  &  BFSStreet2 & "', " 
		Query = Query & " '"  &  BFSCity & "', " 
		Query = Query & " '"  &  BFSState & "', " 
		Query = Query & " '"  &  BFSZip & "', " 
 if len(BFSAskingPrice) > 0 then       
Query = Query & " "  &    BFSAskingPrice & ", " 
end if
 if len(BFSGrossIncome) > 0 then       
Query = Query & " "  &    BFSGrossIncome & ", " 
end if
 if len(BFSCashFlow) > 0 then       
Query = Query & " "  &    BFSCashFlow & ", " 
end if
 if len(BFSFFandE) > 0 then       
Query = Query & " "  &    BFSFFandE & ", " 
end if
 if len(BFSEBITDA) > 0 then       
Query = Query & " "  &   BFSEBITDA & ", " 
end if
 if len(BFSEstablished) > 0 then       
Query = Query & " '"  &    BFSEstablished & "', " 
end if
 if len(BFSEmployees) > 0 then       
Query = Query & " '"  &    BFSEmployees & "' , " 
end if
 if len(PropID) > 0 then       
Query = Query & " "  &  PropID & ", " 
end if

if len(BFSInventory) > 0 then
Query = Query & " '"  &  BFSInventory & "', "
end if
if len(BFSRealEstate) > 0 then
Query = Query & " '"  &  BFSRealEstate & "', "
end if

Query = Query & " '"  &  BFSStreet1 & "', "
Query = Query & " "  &  BFSsold & " , "
Query = Query & " "  &  BFSForSale & " , "
Query = Query & " '"  & BFSWebsite1 & "' , "
Query = Query & " '"  &  BFSWebsite2 & "' , "
Query = Query & " '"  &  BFSWebsite3 &  "' )"
response.write("query=" & query)
Conn.Execute(Query) 

sql2 = "select * from BusinessForSale where PeopleID = " & session("PeopleID") & " and BFSName = '" & BFSName & "'" 
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if not rs2.eof then
BFSID = rs2("BFSID")
end if
Conn.Close
Set Conn = Nothing 
 end if
response.redirect("EditBusinessForSale0.asp?BFSID=" & BFSID )

 %>
 </Body>
</HTML>