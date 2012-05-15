<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<OpponentList>" Title="" %>
<%@ Import Namespace="Tigers.Website.Models.Pages"%>
<%@ Import Namespace="Tigers.Website.Models.Parts"%>
<asp:Content ID="Content1" ContentPlaceHolderID="PostContent" runat="server">
	<div class="list">
	    <% if(Model.Opponents.Any()) { %>
	    <ul>
	    <% for (int i = 0; i < Model.Opponents.Count; i++ ) {
            Opponent opponent = Model.Opponents[i]; %>
            <li><%= Html.Encode(opponent.OpponentName)%></li>
	    <% } %>
	    </ul>
	    <% } %>
	</div>
</asp:Content>