<%@ Page Language="C#" MasterPageFile="../Site.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<News>" %>

<asp:Content ContentPlaceHolderID="TextContent" runat="server">
	<%= Html.DisplayContent(m => m.Title) %>
	<%= Html.DisplayContent("Published").WrapIn("p", new { @class = "pubDate" })%>
	<%= Html.DisplayContent(m => m.Introduction).WrapIn("p", new { @class = "shortDesc" }) %>
	<%= Html.DisplayContent(m => m.Text).WrapIn("p", new { @class = "longDesc" })%>
</asp:Content>