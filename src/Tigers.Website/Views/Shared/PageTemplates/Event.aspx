<%@ Page Title="" Language="C#" MasterPageFile="../Site.master" AutoEventWireup="true"
	Inherits="System.Web.Mvc.ViewPage<Event>" %>

<asp:Content ID="cpc" ContentPlaceHolderID="TextContent" runat="server">
	<%= Html.DisplayContent(m => m.Title)%>
	<%= Html.DisplayContent("EventDateString").WrapIn("p", new { @class = "eventDate" }) %>
	<%= Html.DisplayContent(m => m.Introduction).WrapIn("p", new { @class = "shortDesc" }) %>
	<%= Html.DisplayContent(m => m.Text).WrapIn("p", new { @class = "longDesc" })%>
</asp:Content>