using System.Collections.Generic;
using System.Linq;
using N2;
using N2.Collections;
using N2.Integrity;
using N2.Templates.Mvc.Models.Pages;
using N2.Definitions;

namespace Tigers.Website.Models.Pages
{
    [PageDefinition("Fixture Container",
    Description = "A list of fixtures. Fixtures can be added to this page.",
    SortOrder = 150)]
    [RestrictParents(typeof(Team))]
    public class FixtureContainer : ContentPageBase
    {
        public IList<Fixture> FixtureItems
        {
            get { return GetChildren().OfType<Fixture>().OrderBy(x => x.FixtureDate).ToList(); }
        }
    }
}