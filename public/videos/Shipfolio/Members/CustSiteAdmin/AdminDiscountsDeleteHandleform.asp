<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Delete a Coupon</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">


</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include virtual="/Administration/GlobalVariables.asp"-->



<%

dim OldCouponID
	OldCouponID2=Request.Form("OldCouponID" ) 
 


If Len(OldCouponID2)  > 0 then
sql = "select * from Coupons where CouponID  = " & OldCouponID2 & " order by CouponID "
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  
if not rs.eof then
    CouponCompany = rs("CouponID")
end if

sql = "select * from PageLayout where Pagename = 'Coupons-" &  CouponCompany & "'"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  
if not rs.eof then
    PageLayoutID = rs("PageLayoutID")
end if



	Query =  "Delete * From Coupons where CouponID = " &  OldCouponID2 & "" '
	'response.write(Query)
		Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 

if len(PageLayoutID) > 0 then
	Query =  "Delete * From PageLayout where PageLayoutID = " &  PageLayoutID & "" '

DataConnection.Execute(Query) 

	Query =  "Delete * From PageLayout2 where PageLayoutID = " &  PageLayoutID & "" '

DataConnection.Execute(Query) 
end if
DataConnection.close
end if
Set DataConnection = Nothing
 
 Response.redirect("AdminCouponsDeleteUser.asp?Message=The coupon has successfully been deleted.")
 %>
 

 </Body>
</HTML>
