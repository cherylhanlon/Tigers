<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<TopMenuModel>" %>

<ul class="topMenu menu">
	<%foreach(var item in Model.MenuItems){%><li class="<%= item.Name %><%= item.Url == Model.CurrentItem.Url ? " current" : "" %>"><a href="<%=ResolveUrl(item.Url)%>"><%=item.Title%></a></li><%}%>
</ul>