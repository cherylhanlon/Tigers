<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<Venue>" %>
<%@ Import Namespace="Tigers.Website.Models.Parts"%>

<asp:Content ID="Content1" ContentPlaceHolderID="TextContent" runat="server">
	<%= Html.DisplayContent(m => m.VenueName).WrapIn("p", new { @class = "name" }) %>
	<p>Address:</p>
	<%= Html.DisplayContent(m => m.Description).WrapIn("p", new { @class = "address" }) %>
</asp:Content>