using System;
using System.Linq;
using N2;
using N2.Persistence;
using N2.Templates.Mvc.Models.Parts;
using Tigers.Website.Models.Pages;

namespace Tigers.Website.Models.Parts
{
    [PartDefinition("Next Fixture",
        Description = "The next fixture that happened",
        SortOrder = 160)]
    public class NextFixture : PartBase
    {
        public virtual Fixture Fixture
        {
            get
            {
                return GenericFind<ContentItem, ContentItem>.Items.Where.Type.Eq(typeof(Fixture))
                    .Select<Fixture>().Where(x => x.FixtureDate >= DateTime.Now)
                    .OrderBy(x => x.FixtureDate).ToList().FirstOrDefault();
            }
        }
    }
}