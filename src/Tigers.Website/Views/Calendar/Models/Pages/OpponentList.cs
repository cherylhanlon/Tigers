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
    [PageDefinition("Opponents",
        Description = "A list of Opponents. Opponents can be added to this page.",
        SortOrder = 150)]
    [AvailableZone("Opponents", Zones.Content)]
    public class OpponentList : ContentPageBase, IStructuralPage
    {
        public OpponentList()
        {
            base.Name = "Opponents";
            base.Title = "Opponents";
        }

        public virtual IList<Opponent> Opponents
        {
            get
            {
                IList<Opponent> opponents = GetChildren<Opponent>();
                return opponents != null ? opponents.OrderBy(x => x.OpponentName).ToList() : new List<Opponent>();
            }
        }
    }
}