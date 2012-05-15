<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<Fixture>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TextContent" runat="server">
	
	<span class="opponent"><%= Html.DisplayContent(m => m.WhoIsPlaying)%></span>
	<p class="gameDate">When: <%= Html.DisplayContent(m => m.FixtureDateString)%></p>
	<p class="venue">Where:  <%= Html.DisplayContent(m => m.Venue)%></p>
	<p class="league">League:  <%= Html.DisplayContent(m => m.League)%></p>
	
    <% if (Model.HasResult) { %>
	    <p></p><span class="opponent">Result: <%= Html.Encode(Model.ResultDescription)%></span>
	<%} %>
	<%= Html.DisplayContent(m => m.Text).WrapIn("p", new { @class = "longDesc" })%>
</asp:Content>