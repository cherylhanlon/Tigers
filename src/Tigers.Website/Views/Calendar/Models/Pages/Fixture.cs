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

                return FixtureDate.Value.ToString();
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
                int scoreFor;
                int scoreAgainst;
                if (int.TryParse(ScoreFor, out scoreFor) && int.TryParse(ScoreAgainst, out scoreAgainst))
                {
                    return scoreFor + "-" + scoreAgainst;
                }
                return "vs.";
            }
        }

        string ISyndicatable.Summary
        {
            get { return Team + " " + Result + " " + Opponent; }
        }

        public virtual bool Syndicate { get; set; }
    }
}