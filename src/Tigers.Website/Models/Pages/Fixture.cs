using System;
using System.Web.UI.WebControls;
using N2;
using N2.Definitions;
using N2.Details;
using N2.Integrity;
using N2.Templates.Mvc;
using N2.Templates.Mvc.Models.Pages;
using Tigers.Website.Details;

namespace Tigers.Website.Models.Pages
{
    [PageDefinition("Fixture",
        Description = "A fixture in the fixture container.",
        SortOrder = 110,
        IconUrl = "~/Content/Img/calendar_view_day.png")]
    [RestrictParents(typeof(FixtureContainer))]
    public class Fixture : ContentPageBase, ISyndicatable
    {
        public Fixture()
        {
            Visible = false;
        }

        [Displayable(typeof(Label), "Text")]
        public virtual string Team
        {
            get
            {
                var team = Parent.Parent as Team;
                if (team != null) return team.TeamName;
                return "Error";
            }
        }

        [OpponentDropDown("Opponent", 20, ContainerName = Tabs.Content)]
        [Displayable(typeof(Label), "Text")]
        public virtual string Opponent { get; set; }

        [EditableDate("Fixture date", 30, ContainerName = Tabs.Content)]
        public virtual DateTime? FixtureDate { get; set; }

        [DisplayableLiteral]
        public virtual string FixtureDateString
        {
            get
            {
                if (!FixtureDate.HasValue) return null;
                if (FixtureDate.Value.TimeOfDay.TotalSeconds == 0) return FixtureDate.Value.ToShortDateString();

                return string.Format("{0} - {1}", FixtureDate.Value.ToShortDateString(), FixtureDate.Value.ToShortTimeString());
            }
        }

        [VenueDropDown("Venue", 40, ContainerName = Tabs.Content)]
        [Displayable(typeof(Label), "Text")]
        public virtual string Venue { get; set; }

        [LeagueDropDown("League", 50, ContainerName = Tabs.Content)]
        [Displayable(typeof(Label), "Text")]
        public virtual string League { get; set; }

        [EditableTextBox("Score For", 60, ContainerName = Tabs.Content)]
        public virtual string ScoreFor { get; set; }

        [EditableTextBox("Score Against", 70, ContainerName = Tabs.Content)]
        public virtual string ScoreAgainst { get; set; }

        [DisplayableLiteral]
        public virtual string Result
        {
            get
            {
                if(ActualScoreFor == 0 && ActualScoreAgainst == 0)
                {
                    return "vs.";
                }
                return ActualScoreFor + "-" + ActualScoreAgainst;
            }
        }

        public virtual bool HasResult
        {
            get
            {
                return !string.IsNullOrEmpty(ScoreFor) && !string.IsNullOrEmpty(ScoreAgainst);
            }   
        }

        [Displayable(typeof(Label), "Text")]
        public virtual string WhoIsPlaying
        {
            get { return string.Format("{0} vs {1}", Team, Opponent); }
        }

        public virtual int ActualScoreFor
        {
            get
            {
                int score = 0;
                int.TryParse(ScoreFor, out score);
                return score;
            }
        }

        public virtual int ActualScoreAgainst
        {
            get
            {
                int score = 0;
                int.TryParse(ScoreAgainst, out score);
                return score;
            }
        }

        public virtual string Outcome
        {
            get
            {
                if (ActualScoreFor == 0 && ActualScoreAgainst == 0)
                {
                    return "Awaiting Result";
                }
                return ActualScoreFor <= ActualScoreAgainst ? (ActualScoreFor == ActualScoreAgainst ? "Drew" : "Lost") : "Won";
            }
        }

        

        public virtual string ResultDescription
        {
            get
            {
                if (Outcome == "Awaiting Result")
                {
                    return "Awaiting Result";
                }
                return Outcome + " " + Result;
            }
        }

        string ISyndicatable.Summary
        {
            get { return Team + " " + Result + " " + Opponent; }
        }

        public virtual bool Syndicate { get; set; }
    }
}