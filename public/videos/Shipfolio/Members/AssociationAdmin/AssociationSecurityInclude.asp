<%
Wizard = request.QueryString("Wizard")
currentHour = hour(now)
currentminute = Minute(now)
currentday = day(now)
currentMonth = Month(now)
currentyear = year(now)
d=CDate( currentYear & "-" & Currentmonth & "-" & Currentday & " " & CurrentHour & ":" & Currentminute)
EndTime = dateadd("h" , 1, d)

'response.write("AssociationID = " & session("AssociationID") )
if Len(Session("AssociationID")) > 1 then
Response.Cookies("AssociationID")=Session("AssociationID")
Response.Cookies("AssociationID").Expires=EndTime 
end if
'response.write("cookie=" & Request.Cookies("AssociationID"))
if Len(Session("AssociationID")) < 1 then
Session("AssociationID") = Request.Cookies("AssociationID")
end if

'response.write("AssociationID=" & Session("AssociationID"))
'response.write("AssociationID=" & Session("LoggedIn"))

'if Len(Session("AssociationID")) < 1 And  Not (loginpage = True) and not (Wizard=True) then
'Response.Redirect("/associationadmin/associationLogin.asp")
' end if 
 
AssociationID = Session("AssociationID")
 
 %>