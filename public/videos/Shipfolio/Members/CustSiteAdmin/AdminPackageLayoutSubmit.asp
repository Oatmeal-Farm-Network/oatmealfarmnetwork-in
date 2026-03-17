<HEAD>
<!--#Include file="GlobalVariables.asp"-->
       <link rel="stylesheet" type="text/css" href="/Administration/framestyle.css">


<%
packageID = request.form("packageID")
ListingDesignID = request.form("ListingDesignID")
LinkMouseoverColor = Session("LinkMouseoverColor")
BackgroundColor = Session("BackgroundColor")
BorderColor  = Session("BorderColor")
Image = Session("Image")
HeaderTextFontType = Session("HeaderTextFontType")
HeaderTextFontColor = Session("HeaderTextFontColor")
BodyTextFontType   = Session("BodyTextFontType")
BodyTextFontColor = Session("BodyTextFontColor")
LinkColor   = Session("LinkColor")

If Not Len(LinkMouseoverColor) > 1 Then
	LinkMouseoverColor= "Black"
End If 
If Not Len(BackgroundColor) > 1 Then
	BackgroundColor = "AntiqueWhite"
End If 
If Not Len(BorderColor) > 1 Then
	BorderColor  = "Black"
End If 
If Not Len(HeaderTextFontType ) > 1 Then
	HeaderTextFontType = "Arial"
End If 
If Not Len(HeaderTextFontColor) > 1 Then
	HeaderTextFontColor= "Navy"
End If 
If Not Len(BodyTextFontType) > 1 Then
	BodyTextFontType = "Arial"
End If 
If Not Len(BodyTextFontColor) > 1 Then
	BodyTextFontColor = "White"
End If 
If Not Len(LinkColor) > 1 Then
	LinkColor = "Navy"
End If 

	Query =  " UPDATE ListingDesign Set LinkMouseoverColor= '" & LinkMouseoverColor & "' ,"
	Query =  Query & " BackgroundColor = '" & BackgroundColor & "' ,"
	Query =  Query & " BorderColor  = '" & BorderColor & "' ,"
	Query =  Query & " Image = '" & Image & "' ,"
	Query =  Query & " HeaderTextFontType  = '" & HeaderTextFontType  & "' ,"
	Query =  Query & " HeaderTextFontColor  = '" & HeaderTextFontColor  & "' ,"
	Query =  Query & " BodyTextFontType = '" & BodyTextFontType & "' ,"
	Query =  Query & " BodyTextFontColor = '" & BodyTextFontColor & "' ,"
	Query =  Query & " LinkColor  = '" & LinkColor   & "' "
    Query =  Query & " where ListingDesignID = " & ListingDesignID
	'response.write(Query)	
	Conn.Execute(Query) 
	Conn.Close
	Set Conn = Nothing 


redirectpath = "PackagesEditFrame.asp?packageid="& packageid
'response.write(redirectpath)
Response.Redirect(redirectpath) %>
</HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
 </Body>
</HTML>
