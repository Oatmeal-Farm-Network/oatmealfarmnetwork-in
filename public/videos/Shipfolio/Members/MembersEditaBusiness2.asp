<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <title>Pricing Page</title>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include file="MembersGlobalVariables.asp"--> 
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
BFSID=Request.Form("BFSID") 

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

Query =  " UPDATE BusinessForSale Set "
if len(BFSGrossIncome) > 0 then
Query =  Query & " BFSGrossIncome = " & BFSGrossIncome & " ,"
end if
if len(BFSCashFlow) > 0 then
Query =  Query & " BFSCashFlow= '" & BFSCashFlow & "' , "	
end if
if len(BFSFFandE) > 0 then
Query =  Query & " BFSFFandE = '" & BFSFFandE & "' , "
end if
if len(BFSEBITDA) > 0 then
Query =  Query & " BFSEBITDA = '" & BFSEBITDA & "', "
end if
Query =  Query & " BFSEstablished = '" & BFSEstablished & "', "
Query =  Query & " BFSEmployees = '" & BFSEmployees & "', "
Query =  Query & " BFSStreet1 = '" & BFSStreet1 & "', "
Query =  Query & " BFSStreet2 = '" & BFSStreet2 & "', "
Query =  Query & " BFSCity = '" & BFSCity & "', "
Query =  Query & " BFSState= '" & BFSState & "', "
Query =  Query & " BFSZip = '" & BFSZip & "', "
Query =  Query & " BFSSold = " & BFSSold & " ,"

Query =  Query & " BFSAskingPrice = " & BFSAskingPrice & " , "
Query =  Query & " BFSDescription = '" & BFSDescription & "' , "
Query =  Query & " BFSForSale = " & BFSForSale & " , "
Query =  Query & " BFSWebsite1 = '" & BFSWebsite1 & "' , "
Query =  Query & " BFSWebsite2 = '" & BFSWebsite2 & "' , "
Query =  Query & " BFSWebsite3 = '" & BFSWebsite3 & "' , "
if len(BFSInventory) > 0 then
Query =  Query & " BFSInventory = " & BFSInventory & " , "
end if
if len(BFSRealEstate) > 0 then
Query =  Query & " BFSRealEstate= " & BFSRealEstate & ", "
end if
if len(PropID) > 0 then
Query =  Query & " PropID = " & PropID & ",  "
end if
Query =  Query & " BFSName = '" & BFSName & "'  "
Query =  Query & " where BFSID = " & BFSID & ";" 
response.write(query)
Conn.Execute(Query) 
Conn.Close
Set Conn = Nothing 
response.redirect("EditBusinessForSale0.asp?BFSID=" & BFSID )
 %>
 </Body>
</HTML>
