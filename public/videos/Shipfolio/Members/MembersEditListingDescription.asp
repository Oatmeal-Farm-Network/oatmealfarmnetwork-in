<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="John Andresen">
    <meta name="generator" content="LOTW">
    <title>Livestock Of The World</title>
<!--#Include file="MembersGlobalVariables.asp"-->

<style type="text/css">
.blink_text {
-webkit-animation-name: blinker;
-webkit-animation-duration: 2s;
-webkit-animation-timing-function: linear;
-webkit-animation-iteration-count: 1;

-moz-animation-name: blinker;
-moz-animation-duration: 2s;
-moz-animation-timing-function: linear;
-moz-animation-iteration-count: 1;

 animation-name: blinker;
 animation-duration: 2s;
 animation-timing-function: linear;
 animation-iteration-count: 1;

 color: green;
}

@-moz-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@-webkit-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }
 </style>

<% category = request.QueryString("category")
PeopleID = request.QueryString("PeopleID")
if len(PeopleID) > 0 then
else
PeopleID = Request.Form("PeopleID")
end if

if len(PeopleID) > 0 then
else
PeopleID = Request.querystring("PeopleID")
end if
'response.write("ID=" & ID )



%>


<link rel="stylesheet" href="https://www.livestockoftheworld.com/members/Membersstyle.css">
</head>
<body >
<% Current1="Animals"
Current2 = "EditAnimals" 
Current3 = "Description" %> 
<!--#Include file="MembersHeader.asp"-->
<!--#Include file="MembersAccountJumpLinks.asp"-->
<div class ="container roundedtopandbottom">
<div>
    <div align=center>
        <iframe src="MembersEditListingDescriptionFrame.asp?PeopleID=<%=PeopleID %>" height = '1050' width = '100%' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
    </div>
</div>
</div>


<!--#Include file="membersFooter.asp"--> </Body>
</HTML>