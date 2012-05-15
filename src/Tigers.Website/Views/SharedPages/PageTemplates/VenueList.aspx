<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<VenueList>" Title="" %>
<%@ Import Namespace="Tigers.Website.Models.Pages"%>
<%@ Import Namespace="Tigers.Website.Models.Parts"%>
<asp:Content ID="Content1" ContentPlaceHolderID="PostContent" runat="server">
	<div class="list">
	    <% if(Model.Venues.Any()) { %>
	    <ul>
	    <% for (int i = 0; i < Model.Venues.Count; i++ ) {
            Venue venue = Model.Venues[i]; %>
            <li><%= Html.Encode(venue.VenueName)%></li>
	    <% } %>
	    </ul>
	    <% } %>
	</div>
</asp:Content>