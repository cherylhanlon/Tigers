<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<ResultList>" %>
<%@ Import Namespace="Tigers.Website.Models.Parts"%>
<br /><br />
<h4>Latest Results</h4>
<% if (Model.Results.Any())
   { %>
<%for (var i = 0; i < Model.Results.Count; i++)
  {%>
    <div class="left match past">
		<ul>
		    <% Fixture result = Model.Results[i]; %>	    
	        <li class="opponent"><a href="<%=result.Url%>"><%=Html.Encode(result.Team)%> <%=Html.Encode(result.Result)%> <%=Html.Encode(result.Opponent)%></a></li>
	        <li class="info"><%= Html.Encode(result.FixtureDate.GetValueOrDefault().ToShortDateString())%> <%= Html.Encode(result.FixtureDate.GetValueOrDefault().ToShortTimeString())%></li>
	        <li class="matchLink"><a href="<%=result.Url%>">Game Info</a></li>
		</ul>
    </div>
<%}%>
<%}%>
<% else {%>
    <span>We don't have any results to display.</span>
<%}%>
<div class="right moreLink noMargin"><a href="/past-matches">View All Past Matches >></a></div>