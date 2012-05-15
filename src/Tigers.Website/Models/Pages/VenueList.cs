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
    [PageDefinition("Venues",
        Description = "A list of Venues. Venues can be added to this page.",
        SortOrder = 150)]
    [AvailableZone("Venues", Zones.Content)]
    public class VenueList : ContentPageBase, IStructuralPage
    {
        public VenueList()
        {
            base.Name = "Venues";
            base.Title = "Venues";
        }

        public virtual IList<Venue> Venues
        {
            get
            {
                IList<Venue> venues = GetChildren<Venue>();
                return venues != null ? venues.OrderBy(x => x.VenueName).ToList() : new List<Venue>();
            }
        }
    }
}