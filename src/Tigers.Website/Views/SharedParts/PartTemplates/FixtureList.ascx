<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<FixtureList>" %>
<%@ Import Namespace="Tigers.Website.Models.Parts"%>

<h4>Upcoming Fixtures</h4>
<% if (Model.Fixtures.Any())
   { %>
<%for (var i = 0; i < Model.Fixtures.Count; i++)
  {%>
    <div class="left match future secondary">
		<ul>
		    <% Fixture fixture = Model.Fixtures[i]; %>	    
	        <li class="opponent"><a href="<%=fixture.Url%>"><%=Html.Encode(fixture.Team)%> <%=Html.Encode(fixture.Result)%> <%=Html.Encode(fixture.Opponent)%></a></li>
	        <li class="info"><%= Html.Encode(fixture.FixtureDate.GetValueOrDefault().ToShortDateString())%> <%= Html.Encode(fixture.FixtureDate.GetValueOrDefault().ToShortTimeString())%></li>
	        <li class="matchLink"><a href="<%=fixture.Url%>">Game Info</a></li>
		</ul>
    </div>
<%}%>
<%}%>
<% else {%>
    <span>We don't have any upcoming fixtures to display.</span>
<%}%>
<div class="right moreLink"><a href="/upcoming-matches">View All Upcoming Matches >></a></div>
