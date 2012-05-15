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
    [PageDefinition("Players",
    Description = "A list of Players. Players can be added to this page.",
    SortOrder = 150)]
    [AvailableZone("Players", Zones.Content)]
    public class PlayerList : ContentPageBase, IStructuralPage
    {
        public PlayerList()
        {
            base.Name = "Players";
            base.Title = "Players";
        }

        public virtual IList<Player> Players
        {
            get
            {
                IList<Player> Players = GetChildren<Player>();
                return Players != null ? Players.OrderBy(x => x.FirstName).ToList() : new List<Player>();
            }
        }
    }
}