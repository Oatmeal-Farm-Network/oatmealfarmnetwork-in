
<%
Dim diagnostics
if Request.ServerVariables("REQUEST_METHOD") <> "POST" then
    diagnostics = TestEnvironment()
    if diagnostics<>"" then
        response.write diagnostics
        response.write "After you correct this problem, reload the page."

    else

        OutputForm()

    end if
else

    OutputForm()
    response.write SaveFiles()

end if

%>

