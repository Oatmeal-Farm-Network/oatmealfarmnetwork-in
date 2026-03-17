<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Remove Image</title>
<BODY  ">
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
<%

'rowcount = CInt
rowcount = 1

PagelayoutID=Request.Form("PagelayoutID") 



Query =  " UPDATE Pagelayout Set TopImage = ''  " 
Query =  Query & " where PagelayoutID = " & PagelayoutID & "" 


response.write(Query)	
Conn.Execute(Query) 

Response.Redirect("AdminPageData.asp?PagelayoutID=" & PagelayoutID & "#TextblockTop")
%>

	
 </Body>
</HTML>
