using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using N2;
using N2.Details;
using N2.Integrity;
using N2.Templates.Mvc;
using N2.Templates.Mvc.Models.Pages;
using Tigers.Website.Models.Parts;

namespace Tigers.Website.Models.Pages
{
    [PageDefinition("Team",
        Description = "A team in the team container. Contains a list of players. Players can be added to this page.",
        SortOrder = 110)]
    [RestrictParents(typeof(TeamList))]
    public class Team : ContentPageBase
    {
        public Team()
        {
            Visible = false;
        }

        [EditableTextBox("Team Name", 10, ContainerName = Tabs.Content)]
        public virtual string TeamName { get; set; }

        [EditableTextBox("Sort Order", 99)]
        public virtual string TigersTeamOrder { get; set; }

        [EditableCheckBox("Team Is Active", 99)]
        public virtual bool TeamIsActive { get; set; }

        public IList<Fixture> UpcomingFixtures
        {
            get
            {
                return
                    N2.Find.Items.Where.Type.Eq(typeof (Fixture)).Select<Fixture>().Where(x =>x.FixtureDate.GetValueOrDefault().Date >= DateTime.Now.Date && !x.HasResult && x.Team == TeamName).OrderBy(x => x.FixtureDate).ToList();
            }
        }

        public IList<Fixture> Results
        {
            get
            {
                return N2.Find.Items.Where.Type.Eq(typeof(Fixture)).Select<Fixture>().Where(x => x.FixtureDate.GetValueOrDefault().Date <= DateTime.Now.Date && x.Team == TeamName).OrderByDescending(x => x.FixtureDate).ToList();
            }
        }


        public virtual Fixture LatestResult
        {
            get
            {
                return Results.OrderByDescending(x => x.FixtureDate).FirstOrDefault();
            }
        }

        public virtual Fixture NextFixture
        {
            get
            {
                return UpcomingFixtures.OrderBy(x => x.FixtureDate).FirstOrDefault();
            }
        }

        public virtual string CurrentLeague
        {
            get
            {
                return LatestResult.League;
            }
        }

        public virtual int TotalWins
        {
            get { return Results.Count(x => x.Outcome == "Won"); }
        }

        public virtual int TotalLosses
        {
            get { return Results.Count(x => x.Outcome == "Lost"); }
        }

        public virtual int TotalDraws
        {
            get { return Results.Count(x => x.Outcome == "Drew"); }
        }

        public IList<Fixture> ThisSeasonResults
        {
            get { return GetResultsForLeague(CurrentLeague); }
        }

      
        public virtual int ThisSeasonWins
        {
            get { return ThisSeasonResults.Count(x => x.Outcome == "Won"); }
        }

        public virtual int ThisSeasonLosses
        {
            get { return ThisSeasonResults.Count(x => x.Outcome == "Lost"); }
        }

        public virtual int ThisSeasonDraws
        {
            get { return ThisSeasonResults.Count(x => x.Outcome == "Drew"); }
        }

        public virtual int ThisSeasonGoalsFor
        {
            get { return ThisSeasonResults.Sum(x => x.ActualScoreFor); }
        }

        public virtual int ThisSeasonGoalsAgainst
        {
            get { return ThisSeasonResults.Sum(x => x.ActualScoreAgainst); }
        }

        public virtual IEnumerable<string> LeaguesPlayedIn
        {

            get { return Results.Select(x => x.League).Distinct(); }

        }

        public IList<Fixture> GetResultsForLeague(string league)
        {
            return Results.Where(x => x.League == league).OrderBy(x => x.FixtureDate).ToList();
        }

        public IList<Player> Players
        {
            get
            {
                return
                    N2.Find.Items.Where.Type.Eq(typeof(Player)).Select<Player>().Where(x => x.TigerTeam == TeamName).OrderBy(x => x.FirstName).ToList();
            }
        }
    }
}

