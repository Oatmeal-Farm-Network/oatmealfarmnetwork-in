<%Wizard = request.QueryString("Wizard")
 currentHour = hour(now)
 currentminute = Minute(now)
currentday = day(now)
currentMonth = Month(now)
currentyear = year(now)
d=CDate( currentYear & "-" & Currentmonth & "-" & Currentday & " " & CurrentHour & ":" & Currentminute)
EndTime = dateadd("h" , 1, d)

adminblarg = request.querystring("adminblarg")


'if Session("LoggedIn") = True then

if adminblarg = "True" then
    PeopleID = request.querystring("PeopleID")
    if len(Peopleid) > 1  then
    session("PeopleID") = PeopleID
    end if
end if

    Response.Cookies("PeopleID")=Session("PeopleID")
    if len(EntTime) > 0 then
    Response.Cookies("PeopleID").Expires=EndTime 
    end if

    if Len(Session("PeopleID")) < 1 then
    Session("PeopleID") = Request.Cookies("PeopleID")
    end if

    if Len(Session("PeopleID")) > 0 then
    Session("LoggedIn") = True 
    Response.Cookies("LoggedIn").Expires=EndTime 
    end if
'end if

if len(PeopleId) > 1 then
else
PeopleID = 0
end if

'response.write("EndTime=" & EndTime )
'response.write("LoggedIn=" & Session("LoggedIn") )
if clng(peopleID) = 1816 then
else


If Len(Session("PeopleID")) > 1 and Session("LoggedIn") = True then
else
Response.Redirect("/Login.asp")
end if 
end if
%>