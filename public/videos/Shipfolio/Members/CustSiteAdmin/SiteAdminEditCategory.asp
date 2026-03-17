<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
</HEAD>
<BODY bgcolor = "white">
<!--#Include file="AdminGlobalVariables.asp"-->
<% TempCategoryType=request.form("Subject") 
	If Len(Subject) < 3 then
		TempCategoryType= Request.QueryString("Subject") 
	End If

   Dim Tempcategoryname
   Dim Tempcategorytype
   Dim TempcategoryID
      Dim Categorytype

	Tempcategoryname=Request.Form("categoryname" ) 
	Tempcategorytype=Request.Form("categorytype" ) 
	TempcategoryID=Request.Form("CategoryID" ) 
	Categorytype=Request.Form("Categorytype" ) 
	
response.write(Tempcategoryname) 
response.write("Tempcategorytype=" & Tempcategorytype) 
response.write(TempcategoryID ) 
response.write("Categorytype=" & Categorytype ) 

	str1 = Tempcategoryname
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		Tempcategoryname= Replace(str1, "'", "''")
	End If

If categorytype = "category" then
	Query =  " UPDATE SFCategories Set catName = '" & Tempcategoryname & "' " 
    Query =  Query + " where catID = " & TempcategoryID & ";" 
	sLocalSQL = "SELECT catName FROM SFCategories WHERE CatId = " & TempcategoryID

End If 

If categorytype = "subcategory" then
	Query =  " UPDATE SFSubCategories Set SubCategoryname = '" &  Tempcategoryname & "' " 
    Query =  Query + " where subcatId = " & TempcategoryID & ";" 
	sLocalSQL = "SELECT SubCategoryname FROM SFSubCategories WHERE subcatId = " & TempcategoryID

End If 
response.write(sLocalSQL)
	
	'		Set rsVend = Server.CreateObject("ADODB.RecordSet")
	'		rsVend.Open sLocalSQL, cnn, adOpenDynamic, adLockOptimistic, adCmdText

	'		If Not rsVend.EOF Then
		'		rsVend.Fields("CatName")		   =	 Tempcategoryname
		'		rsVend.Update
		'	End If
		'	closeobj(rsVend)


Conn.Execute(Query) 
response.redirect("SiteAdminSetforsalecategories.asp")
%>
</Body>
</HTML>
