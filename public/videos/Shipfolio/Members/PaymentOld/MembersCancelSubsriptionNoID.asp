<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
<link rel="canonical" href="<%=currenturl %>" />
<title>Membership Status Updated</title>
<meta name="title" content="<%=WebSiteName %>"/> 
<meta name="description" content=""/>  
<meta charset="UTF-8">

<meta name="revisit-after" content="never"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>


</head>
<body >
<!--#Include virtual="/members/MembersHeader.asp"-->
<!--#Include virtual="/members/MembersAccountJumpLinks.asp"-->


 <%   Query = "Update people set Subscriptionlevel = 1 where PeopleID = " & session("PeopleID")
      Conn.Execute(Query) 

  %>

<div class=" container roundedtopandbottom">
	<div class="col">
        <div class="row">

       <br /><h1>Canceled Membership</h1>
         
           <blockquote>Your paid membership has now been reduced to a free membership.</blockquote><br />
              <br />
          </div>
        </div>
    </div>


<!--#Include virtual="/Footer.asp"-->
</body></html>