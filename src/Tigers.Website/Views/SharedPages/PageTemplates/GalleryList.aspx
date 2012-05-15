<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<GalleryList>" Title="" %>
<asp:Content ContentPlaceHolderID="Head" runat="server">
	<script src="<%= ResolveClientUrl("~/Content/Galleria/jquery.galleria.js") %>" type="text/javascript"></script>
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentAndSidebar" runat="server">

<!-- Add in crumbtrail -->
<% Html.RenderAction<NavigationController>(c => c.Breadcrumb()); %>

<h3>Galleries</h3>
<%foreach(var gallery in Model.Galleries){ %>
	    <div class="galleryHome">
	        <h4><a href="<%=gallery.Url%>" title="<%=gallery.Title%>"><%=gallery.Title%></a></h4>
		    <%foreach(var image in gallery.Images.Take(10).ToList()) { %>
		       <a id="t<%= gallery.ID %>" href="<%=gallery.Url%>" class="thumbnail">
				    <img alt="<%= image.Title %>" src="<%= ResolveUrl(image.GetThumbnailImageUrl(Html.ResolveService<N2.Edit.FileSystem.IFileSystem>())) %>" />
			    </a>
	        <%}%>
	     </div>
<%}%>
</asp:Content>