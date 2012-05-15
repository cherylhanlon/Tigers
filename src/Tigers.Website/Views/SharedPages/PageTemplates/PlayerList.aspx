<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<PlayerList>" Title="" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PostContent" runat="server">
<h4>Click on a player to see their profile...</h4>
<% if(Model.Players.Any()) { %>
    <% for (int i = 0; i < Model.Players.Count; i++ ) {
        Player player = Model.Players[i]; %>
            <div class="playerCard">
	            <a href="<%=player.Url%>">
	                <img alt="<%= player.NickName %>" src="<%= player.GetThumbnailFileName() %>" class="thumb"/>
                    <%= Html.Encode(string.Format("{0} {1}", player.FirstName, player.LastName))%>
	            </a>
	        </div>
    <% } %>
<% } %>
</asp:Content>