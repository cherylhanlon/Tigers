<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<FixtureContainer>" Title="" %>
<%@ Import Namespace="Tigers.Website.Models.Pages"%>

<asp:Content ID="Content1" ContentPlaceHolderID="PostContent" runat="server">
    <div class="list">
    <% if (Model.FixtureItems.Any()) { %>
    <%for(var i = 0; i < Model.FixtureItems.Count; i++){%>
        <div class="item i<%=i%> a<%=i % 2%>">
			<div class="item">
			    <span class="title"><a href="<%=Model.FixtureItems[i].Url%>"><%=Model.FixtureItems[i].Team%> <%=Model.FixtureItems[i].Result%> <%=Model.FixtureItems[i].Opponent%></a></span>
				<p class="gameDate"><%= Model.FixtureItems[i].FixtureDateString%></span>
			</div>
        </div>
    <%}%>
    <%}%>
    </div>
</asp:Content>