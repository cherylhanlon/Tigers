using System.Collections.Generic;
using System.Linq;
using N2;
using N2.Definitions;
using N2.Integrity;
using N2.Templates.Mvc;
using N2.Templates.Mvc.Models.Pages;
using Tigers.Website.Models.Parts;

namespace Tigers.Website.Models.Pages
{
    [PageDefinition("Leagues",
    Description = "A list of Leagues. Leagues can be added to this page.",
    SortOrder = 150)]
    [AvailableZone("Leagues", Zones.Content)]
    public class LeagueList : ContentPageBase, IStructuralPage
    {
        public LeagueList()
        {
            base.Name = "Leagues";
            base.Title = "Leagues";
        }

        public virtual IList<League> Leagues
        {
            get
            {
                IList<League> leagues = GetChildren<League>();
                return leagues != null ? leagues.OrderBy(x => x.LeagueName).ToList() : new List<League>();
            }
        }
    }
}