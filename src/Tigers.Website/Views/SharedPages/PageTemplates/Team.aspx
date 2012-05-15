<%@ Page Language="C#" MasterPageFile="~/Views/Shared/site.master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<Team>" Title="" %>
<%@ Import Namespace="Tigers.Website.Models.Pages"%>
<%@ Import Namespace="Tigers.Website.Models.Parts"%>
<asp:Content ID="Content1" ContentPlaceHolderID="TextContent" runat="server">

<script type="text/javascript">
    $(function() {
        $('#tab1').click(function() {
            $('#tab1div').show();
            $('#tab2div').hide();
            $('#tab3div').hide();
            $('#tab4div').hide();
            $('#tab5div').hide();
        });
        $('#tab2').click(function() {
            $('#tab1div').hide();
            $('#tab2div').show();
            $('#tab3div').hide();
            $('#tab4div').hide();
            $('#tab5div').hide();
        });
        $('#tab3').click(function() {
            $('#tab1div').hide();
            $('#tab2div').hide();
            $('#tab3div').show();
            $('#tab4div').hide();
            $('#tab5div').hide();
        });
        $('#tab4').click(function() {
            $('#tab1div').hide();
            $('#tab2div').hide();
            $('#tab3div').hide();
            $('#tab4div').show();
            $('#tab5div').hide();
        });

        $('#tab5').click(function() {
            $('#tab1div').hide();
            $('#tab2div').hide();
            $('#tab3div').hide();
            $('#tab4div').hide();
            $('#tab5div').show();
        });
        
        $("#tabs ul li").click(function() {
            $("ul.tabs li").removeClass("activeTab"); //Remove any "active" class   
            $(this).addClass("activeTab"); //Add "active" class to selected tab  
        });

    });

</script>     

    <div id="tabs">
        <ul class="tabs">
            <li class="activeTab"><div id="tab1"><a href="#">Team Stats</a></div></li>
            <li><div id="tab2"><a href="#">Upcoming Fixtures</a></div></li>
            <li><div id="tab3"><a href="#">Current Results</a></div></li>
            <li><div id="tab4"><a href="#">All Results</a></div></li>
            <li><div id="tab5"><a href="#">Meet the Team</a></div></li>
        </ul>
        <div id="tab1div">         
            <p class="leagueTitle">Current League:</p> 
            <h4><%=Model.CurrentLeague %></h4>
            
            <!--
            <ul>
                <li>Wins: <%=Model.ThisSeasonWins %></li>
                <li>Losses: <%=Model.ThisSeasonLosses %></li>
                <li>Draws: <%=Model.ThisSeasonDraws %></li>
                <li>Goals For: <%=Model.ThisSeasonGoalsFor%></li>
                <li>Goals Against: <%=Model.ThisSeasonGoalsAgainst %></li>
            </ul>
            -->
            
            <table cellpadding="0" cellspacing="0">
                <tr>
                    <th>Wins</th>
                    <th>Losses</th>
                    <th>Draws</th>
                    <th>Goals For</th>
                    <th>Goals Against</th>
                </tr>
                <tr>
                    <td><%=Model.ThisSeasonWins %></td>
                    <td><%=Model.ThisSeasonLosses %></td>
                    <td><%=Model.ThisSeasonDraws %></td>
                    <td><%=Model.ThisSeasonGoalsFor%></td>
                    <td><%=Model.ThisSeasonGoalsAgainst %></td>
                </tr>
            </table>
            
            
            <h4>All Time</h4>
            
            <!--
            <ul>
                <li>Wins: <%=Model.TotalWins %></li>
                <li>Losses: <%=Model.TotalLosses %></li>
                <li>Draws: <%=Model.TotalDraws %></li>
            </ul>
            -->

            <table cellpadding="0" cellspacing="0">
                <tr>
                    <th>Wins</th>
                    <th>Losses</th>
                    <th>Draws</th>
                </tr>
                <tr>
                    <td><%=Model.TotalWins %></td>
                    <td><%=Model.TotalLosses %></td>
                    <td><%=Model.TotalDraws %></td>
                </tr>
            </table>


        </div>
        
        <div id="tab2div" style="display: none">
            <p class="leagueTitle">Current League:</p> 
            <h4><%=Model.CurrentLeague %></h4>
            <% if (Model.UpcomingFixtures.Any()) 
               { %>
                  <table cellspacing="0" cellpadding="0">
                    <tr>
                        <th>Team</th>
                        <th>Opponent</th>
                        <th>When</th>
                        <th>Where</th>
                    </tr>
                
                    <% foreach (var fixture in Model.UpcomingFixtures) 
                       {%>
                        <tr>
    	                    <td><a href="<%=fixture.Url%>"><%=Html.Encode(fixture.Team)%></a></td>
    	                    <td><a href="<%=fixture.Url%>"><%=Html.Encode(fixture.Opponent)%></a></td>
    	                    <td><a href="<%=fixture.Url%>"><%=Html.Encode(fixture.FixtureDateString)%></a></td>
    	                    <td><a href="<%=fixture.Url%>"><%=Html.Encode(fixture.Venue)%></a></td>
    	                </tr>
                    <% }%>
                </table>
            <% }%>
        </div>
        
        <div id="tab3div" style="display: none">
        <% if (Model.ThisSeasonResults.Any()) { %>
            <p class="leagueTitle">Current League:</p>
            <h4><%=Model.CurrentLeague %></h4>
                <table cellspacing="0" cellpadding="0">
                <tr>
                    <th>Team</th>
                    <th>Result</th>
                    <th>Opponent</th>
                    <th>Outcome</th>
                    <th>Date</th>
                </tr>
                
               <% var results = Model.ThisSeasonResults;
                if (results.Any()) 
                { %>
                    
                    <%foreach(var result in results) 
                      {%>
        	            <tr>
        	                <td><a href="<%=result.Url%>"><%=Html.Encode(result.Team)%></a></td>
        	                <td><a href="<%=result.Url%>"><%=Html.Encode(result.Result)%></a></td>
        	                <td><a href="<%=result.Url%>"><%=Html.Encode(result.Opponent)%></a></td>
        	                <td><a href="<%=result.Url%>"><%=Html.Encode(result.Outcome)%></a></td>
        	                <td><a href="<%=result.Url%>"><%=Html.Encode(result.FixtureDateString)%></a></td>
        	            </tr>	                    
                    <% }%>
                <%} %>
                </table>
        <% }%>
        </div>
        
        <div id="tab4div" style="display: none">
        <%foreach (var league in Model.LeaguesPlayedIn)
          {%>
            <p class="leagueTitle">League:</p>
             <h4><%=Html.Encode(league) %></h4>
                <table cellspacing="0" cellpadding="0">
                <tr>
                    <th>Team</th>
                    <th>Result</th>
                    <th>Opponent</th>
                    <th>Outcome</th>
                    <th>Date</th>
                </tr>
                
               <% var results = Model.GetResultsForLeague(league);
                if (results.Any()) 
                { %>
                    
                    <%foreach(var result in results) 
                      {%>
        	            <tr>
        	                <td><a href="<%=result.Url%>"><%=Html.Encode(result.Team)%></a></td>
        	                <td><a href="<%=result.Url%>"><%=Html.Encode(result.Result)%></a></td>
        	                <td><a href="<%=result.Url%>"><%=Html.Encode(result.Opponent)%></a></td>
        	                <td><a href="<%=result.Url%>"><%=Html.Encode(result.Outcome)%></a></td>
        	                <td><a href="<%=result.Url%>"><%=Html.Encode(result.FixtureDateString)%></a></td>
        	            </tr>	                    
                    <% }%>
                <%} %>
                </table>
         <%} %>
        </div>
        
        <div id="tab5div" style="display: none">
        <p class="leagueTitle"><%=Html.Encode(Model.TeamName) %>:</p> 
        <h4>Click on a player to see their profile...</h4>
            <% if(Model.Players.Any()) { %>
                <% for (int i = 0; i < Model.Players.Count; i++ ) {
                    Player player = Model.Players[i]; %>
                        <div class="playerCard">
	                        <a href="<%=player.Url%>">
	                            <img alt="<%= player.NickName %>" src="../<%= player.GetThumbnailFileName() %>" class="thumb"/>
                                <%= Html.Encode(string.Format("{0} {1}", player.FirstName, player.LastName))%>
	                        </a>
	                    </div>
                <% } %>
            <% } %>
        </div>
</div> 
</asp:Content>

