<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<NextFixture>" %>

<div class="matchHeaderFuture" id="matchHeaderFuture">
    <ul>
        <li class="matchType">Next Match:</li>
        <%if (Model.Fixture != null)
          { %>
        <li class="opponent next"><%=Html.Encode(Model.Fixture.WhoIsPlaying)%></li>
        <li class="info"><%=Html.Encode(Model.Fixture.FixtureDateString)%></li>
        <li class="matchLink"><a href="<%=Model.Fixture.Url %>">Game Info</a></li>
         <%} else {%>
         <li class="opponent next">Awaiting Fixtures</li>
         <%} %>
         
    </ul>
</div>