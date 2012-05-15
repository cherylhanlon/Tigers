<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<NewsContainerModel>" %>
<% for(var i = 0; i < Model.News.Count; i++){ %>
    <div class="item i<%= i + Model.Skip %> a<%= i % 2 %>">
        <span class="title"><a href="<%= Model.News[i].Url %>"><%= Model.News[i].Title %></a></span>
        <p class="pubDate"><%= Model.News[i].Published %></span>
        <p class="shortDesc"><%= Model.News[i].Introduction %></p>
    </div>
<% } %>

<% if (!Model.IsLast) { %>
<%= Html.ActionLink(string.Format("{0} {1}-{2} »", Model.Container.Title, (Model.Skip + Model.Take), (Model.Skip + Model.Take * 2)), Model.Container, "range", new { skip = Model.Skip + Model.Take, take = Model.Take }, new { @class = "scroller" })%>
<% } %>