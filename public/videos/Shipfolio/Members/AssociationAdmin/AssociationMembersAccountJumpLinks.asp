
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
 

<a href = "#Top" class = "body"></a>
<br />
<div class="nav">
 <% if Current3 = "Summary" then %>
 <div class="jumplinkscellCurrent ">
    <a class="jumplinks" href="AssociationEditMembers.asp"><b>Summary</b></a>
  </div>
<% else %> 
<div class="jumplinkscell  ">
    <a class="jumplinks" aria-current="page" href="AssociationEditMembers.asp">Summary</a>
  </div>
<%end if %>

 <% if Current3 = "AddMember" then %>
 <div class="jumplinkscellCurrent ">
    <a class="jumplinks" href="AssociationAddMembers.asp"><b>Add Member</b></a>
  </div>
<% else %> 
<div class="jumplinkscell  ">
    <a class="jumplinks" aria-current="page" href="AssociationAddMembers.asp">Add Member</a>
  </div>
<%end if %>



</div>
<br />
<span class="border-bottom-3"></span>
