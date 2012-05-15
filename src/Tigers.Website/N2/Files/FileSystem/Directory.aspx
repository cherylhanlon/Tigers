﻿<%@ Page Language="C#" MasterPageFile="~/N2/Content/Framed.Master" AutoEventWireup="true" CodeBehind="Directory.aspx.cs" Inherits="N2.Edit.FileSystem.Directory1" %>
<%@ Import Namespace="N2.Management" %>
<%@ Import Namespace="N2.Edit" %>
<%@ Register TagPrefix="edit" Namespace="N2.Edit.Web.UI.Controls" Assembly="N2.Management" %>
<asp:Content ContentPlaceHolderID="Toolbar" runat="server">
	<asp:HyperLink ID="hlNewFile" runat="server" Text="Upload file(s)" CssClass="command" meta:resourceKey="hlNewFile" />
	<asp:LinkButton ID="btnDelete" runat="server" Text="Delete selected" CssClass="command" OnCommand="OnDeleteCommand" OnClientClick="return confirm('Delete selected files and folders?');" meta:resourceKey="btnDelete" />
</asp:Content>
<asp:Content ContentPlaceHolderID="Content" runat="server">	
	<h1><% foreach (N2.ContentItem node in ancestors) { %>/<a href="<%= GetPreviewUrl(node) %>"><%= node.Title %></a><% } %></h1>
	<div class="directory">
		<asp:Repeater ID="rptDirectories" runat="server">
			<ItemTemplate>
				<div class="file">
					<label>
						<input name="directory" value="<%# Eval("Path") %>" type="checkbox" />
						<asp:Image ImageUrl='<%# Eval("IconUrl") %>' runat="server" />
					</label>
					<a href="<%# GetPreviewUrl((N2.ContentItem)Container.DataItem) %>" class="file">
						<%# Eval("Title") %>
					</a>
				</div>
			</ItemTemplate>
		</asp:Repeater>
		
		<asp:Repeater ID="rptFiles" runat="server">
			<ItemTemplate>
				<div class="file">
					<label style='background-image:url(<%# N2.Edit.Web.UI.Controls.ResizedImage.GetResizedImageUrl((string)Eval("Url"), 100, 100, N2.Web.Drawing.ImageResizeMode.Fit) %>)'>
						<input name="file" value="<%# Eval("Url") %>" type="checkbox" />
						<asp:Image ID="Image1" ImageUrl='<%# Eval("IconUrl") %>' runat="server" />
					</label>
					<a href="<%# GetPreviewUrl((N2.ContentItem)Container.DataItem) %>">
						<%# Eval("Title") %>
					</a>
				</div>
			</ItemTemplate>
		</asp:Repeater>
	</div>
</asp:Content>
