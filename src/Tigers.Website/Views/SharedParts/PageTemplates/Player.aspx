<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<Player>" %>
<%@ Import Namespace="Tigers.Website.Models.Parts"%>

<asp:Content ID="Content1" ContentPlaceHolderID="TextContent" runat="server">
	<h3><%= Html.DisplayContent(m => m.FirstName) %> <%= Html.DisplayContent(m => m.LastName) %></h3>

	<div class="playerPhoto">
	    <p><!-- Photo: --> <img alt="<%= Model.FirstName %>" src="<%= ResolveUrl(Model.ImageUrl) %>" /></p>
	</div>

	<div class="playerPosition">
	    <div><p>Preferred Position:</p><%= Html.DisplayContent(m => m.PreferredPosition).WrapIn("p", new { @class = "position1" }) %></div>
	    <div><p>Secondary Position:</p><%= Html.DisplayContent(m => m.SecondaryPosition).WrapIn("p", new { @class = "position2" }) %></div>
	</div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Sidebar" runat="server">
    <div class="playerInfo">
	    <p><strong>Favourite Food:</strong> <%= Html.DisplayContent(m => m.Noms) %></p>
	    <p><strong>Favourite Movie:</strong> <%= Html.DisplayContent(m => m.Movie) %></p>
	    <p><strong>Favourite Song:</strong> <%= Html.DisplayContent(m => m.Song) %></p>
	    <p><strong>Nickname:</strong> <%= Html.DisplayContent(m => m.NickName) %></p>
	    <p><strong>Claim To Fame:</strong> <%= Html.DisplayContent(m => m.ClaimToFame) %></p>
	    <p><strong>Random Fact:</strong> <%= Html.DisplayContent(m => m.RandomFact) %></p>
	    <p><strong>Joke:</strong> <%= Html.DisplayContent(m => m.Joke) %></p>
	</div>
</asp:Content>