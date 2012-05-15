using System.Collections.Generic;
using System.Linq;
using N2;
using N2.Integrity;
using N2.Templates.Mvc;
using N2.Templates.Mvc.Models.Pages;
using N2.Definitions;

namespace Tigers.Website.Models.Pages
{
    [PageDefinition("Team List",
        Description = "A list of Teams. Teams can be added to this page.",
        SortOrder = 150)]
    [AvailableZone("Teams", Zones.Content)]
    public class TeamList : ContentPageBase, IStructuralPage
    {
        public virtual IList<Team> Teams
        {
            get
            {
                IList<Team> teams = GetChildren<Team>();
                return teams != null ? teams.Where(x => x.TeamIsActive).OrderBy(x => x.TigersTeamOrder).ToList() : new List<Team>();
            }
        }
    }
}