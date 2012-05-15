﻿<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<FutureFixtures>" %>
<%@ Import Namespace="Tigers.Website.Models.Parts"%>
<h4>All Upcoming Matches</h4>
<% if (Model.Results.Any())
   { %>
<%for (var i = 0; i < Model.Results.Count; i++)
  {%>
    <div>
		<ul>
		    <% Fixture result = Model.Results[i]; %>	    
	        <a href="<%=result.Url%>"> 
	            <li><span class="opponentSmall"><%=Html.Encode(result.WhoIsPlaying)%></span> - <span class="infoSmall"><%=Html.Encode(result.Venue)%></span>  <%= Html.Encode(result.FixtureDateString)%></li>
	        </a>
		</ul>
    </div>
<%}%>
<%}%>
<% else {%>
    <span>We don't have any results to display.</span>
<%}%>