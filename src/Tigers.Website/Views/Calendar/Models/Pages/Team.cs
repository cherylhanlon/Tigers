using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using N2;
using N2.Definitions;
using N2.Details;
using N2.Integrity;
using N2.Templates.Mvc;
using N2.Templates.Mvc.Models.Pages;
using Tigers.Website.Details;
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

        public virtual IList<Player> Players
        {
            get
            {
                IList<Player> players = GetChildren<Player>();
                return players != null ? players.OrderBy(x => x.LastName).ToList() : new List<Player>();
            }
        }
    }
}

