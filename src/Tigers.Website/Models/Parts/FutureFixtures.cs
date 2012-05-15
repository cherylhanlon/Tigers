using System;
using System.Collections.Generic;
using System.Linq;
using N2;
using N2.Templates.Mvc.Models.Parts;
using Tigers.Website.Models.Pages;

namespace Tigers.Website.Models.Parts
{
    [PartDefinition("Future Result List",
        Description = "A result list",
        SortOrder = 160)]
    public class FutureFixtures : PartBase
    {
        public virtual IList<Fixture> Results
        {
            get
            {
                return Find.Items.Where.Type.Eq(typeof(Fixture)).Select<Fixture>().Where(x => x.FixtureDate.GetValueOrDefault().Date >= DateTime.Now.Date).OrderBy(x => x.FixtureDate).ToList();
            }
        }
    }
}