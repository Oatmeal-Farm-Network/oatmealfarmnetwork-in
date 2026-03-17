<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="revisit-after" content="7 Days" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

    <meta charset="utf-8">
    <meta name="author" content="Global Grange inc.">
    <!--#Include virtual="/includefiles/globalvariables.asp"-->

<%
    ' Define the function to validate and correct the link
Function ValidateAndFixLink(link)
    ' Check if the link starts with "https://"
    If Left(link, 8) <> "https://" Then
        ' If not, prepend "https://" to the link
        link = "https://" & link
    End If
    
    ' Check if the link is a valid URL
    If InStr(link, "://") > 0 And InStr(link, " ") = 0 Then
        ' If it is, return the corrected link
        ValidateAndFixLink = link
    Else
        ' If not, return an empty string (or handle the error as per your requirement)
        ValidateAndFixLink = ""
    End If
End Function
    
   AdID= request.querystring("AdID")
   AdLink = Request.querystring("AdLink")
   AdType= Request.querystring("AdType")
    
    
   AdLink = ValidateAndFixLink(AdLink)


    Query =  "insert into Adstats (AdType, ClickDate, AdID, click, WebsiteID) values('" & AdType & "', CONVERT(varchar(10), GETDATE(), 101) , " & AdID & ", 1,  1 )"
    response.write("Query=" & Query) 

    Conn.Execute(Query) 
    
    response.redirect(AdLink)
    %>

</head>
<body>

</body>
</html>