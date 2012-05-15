<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<LeagueList>" Title="" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PostContent" runat="server">
	<div class="list">
	    <% if(Model.Leagues.Any()) { %>
	    <ul>
	    <% for (int i = 0; i < Model.Leagues.Count; i++ ) {
            League league = Model.Leagues[i]; %>
            <li><%= Html.Encode(league.LeagueName)%></li>
	    <% } %>
	    </ul>
	    <% } %>
	</div>
</asp:Content>