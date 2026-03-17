<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="John Andresen">
    <meta name="generator" content="LOTW">
    <title>Global Grange</title>
<!--#Include file="MembersGlobalVariables.asp"-->
</head>
<body>




<% Current3 = "Logo" 
  Filename = request.querystring("Logo")%>
<!--#Include file="MembersHeader.asp"-->
<!--#Include file="MembersAccountJumpLinks.asp"-->
<div class ="container roundedtopandbottom">
    <div class ="row">
        <div class ="col" style="min-height:500px">
 <H1>My Logo</H1>
            <br>
            <img src = "<%=Filename %>" width ="300"> <br>
            <br>
            <b>Your logo has been uploaded</b>
            <br>
            <br>
            <br>
            <br>
            <br>


        </div>
    </div>
</div>


</body>
</html>