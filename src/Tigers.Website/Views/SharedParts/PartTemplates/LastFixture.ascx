<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl<LastFixture>" %>

<script type="text/javascript">
    $(function() {

        $('.matchHeaderFuture').addClass('hidden');

        $('#tab1').click(function() {
            $('#matchHeaderPast').show();
            $('#matchHeaderFuture').hide();
        });

        $('#tab2').click(function() {
            $('#matchHeaderPast').hide();
            $('#matchHeaderFuture').show();
        });

        $("#matchNav ul li").click(function() {
            $("ul li").removeClass("activeTab"); //Remove any "active" class   
            $(this).addClass("activeTab"); //Add "active" class to selected tab  
        });

    });

</script>

<div id="matchNav">
    <ul>
        <li class="activeTab"><div id="tab1"><a href="#">Last Match</a></div></li>
        <li><div id="tab2"><a href="#">Next Match</a></div></li>
    </ul>
</div>

<div class="matchHeaderPast" id="matchHeaderPast">
    <ul>
        <li class="matchType">Last Match:</li>
        <li class="opponent"><%=Html.Encode(Model.Fixture.WhoIsPlaying) %></li>
        <li class="info"><%=Model.Fixture.ResultDescription%></li>
        <li class="matchLink"><a href="<%=Model.Fixture.Url%>">Match Report</a></li>
    </ul>
</div>