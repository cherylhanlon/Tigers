<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<TeamList>" Title="" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PostContent" runat="server">
    <div class="list">
    <h4>Click the Team for stats, results and to meet the team...</h4>
    <% if (Model.Teams.Any()) { %>
    <%for (var i = 0; i < Model.Teams.Count; i++)
      {%>
        <div class="item i<%=i%> a<%=i % 2%>">
        
            <%
                var team = Model.Teams[i]; 
            %>
            <a href="<%=team.Url%>">
        	
        	<!-- Change to specific team image -->
        	<img src="../../../Content/Img/<%=team.TeamName%>.png" alt="<%=team.TeamName%>" />
        	
        	<div class="item">
			    
			    <% if (team.LatestResult != null)
                   {%>
                     <p>
                        <strong>Last Result:</strong> vs <%=team.LatestResult.Opponent %> - <%=team.LatestResult.ResultDescription%>
                     </p>
                <% }%>
                
                <% if (team.NextFixture != null)
                   {%>
                    <p>
                        <strong>Next Match:</strong> vs <%=team.NextFixture.Opponent %>  on <%= team.NextFixture.FixtureDateString %>
                    </p>
                <% }%>
                
			</div>
			
			</a>
			
		</div>
        <%}%>
    <%}%>
    </div>
</asp:Content>