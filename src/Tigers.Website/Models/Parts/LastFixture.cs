using System;
using System.Linq;
using N2;
using N2.Persistence;
using N2.Templates.Mvc.Models.Parts;
using Tigers.Website.Models.Pages;

namespace Tigers.Website.Models.Parts
{
    [PartDefinition("Last Fixture",
        Description = "The last fixture that happened",
        SortOrder = 160)]
    public class LastFixture : PartBase
    {
        public virtual Fixture Fixture
        {
            get
            {
                return GenericFind<ContentItem, ContentItem>.Items.Where.Type.Eq(typeof (Fixture))
                    .Select<Fixture>().Where(x => x.FixtureDate <= DateTime.Now)
                    .OrderByDescending(x => x.FixtureDate).ToList().FirstOrDefault();
            }
        }
    }
}