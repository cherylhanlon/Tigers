<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<Opponent>" %>
<%@ Import Namespace="Tigers.Website.Models.Parts"%>

<asp:Content ID="Content1" ContentPlaceHolderID="TextContent" runat="server">
	<%= Html.DisplayContent(m => m.OpponentName).WrapIn("p", new { @class = "name" })%>
	<%= Html.DisplayContent(m => m.Description).WrapIn("p", new { @class = "description" }) %>
</asp:Content>