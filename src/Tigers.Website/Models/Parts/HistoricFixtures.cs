using System;
using System.Collections.Generic;
using System.Linq;
using N2;
using N2.Templates.Mvc.Models.Parts;
using Tigers.Website.Models.Pages;

namespace Tigers.Website.Models.Parts
{
    [PartDefinition("Historic Fixture",
        Description = "fixtures in the past",
        SortOrder = 160)]
    public class HistoricFixtures : PartBase
    {
        public virtual IList<Fixture> Results
        {
            get
            {
                return Find.Items.Where.Type.Eq(typeof(Fixture)).Select<Fixture>().Where(x => x.FixtureDate < DateTime.Now).OrderByDescending(x => x.FixtureDate).ToList();
            }
        }
    }
}