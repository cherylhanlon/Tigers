using System;
using System.Collections.Generic;
using System.Linq;
using N2;
using N2.Collections;
using N2.Details;
using N2.Persistence.Finder;
using N2.Templates.Mvc.Models.Parts;
using Tigers.Website.Models.Pages;

namespace Tigers.Website.Models.Parts
{
    [PartDefinition("Result List",
        Description = "A result list",
        SortOrder = 160)]
    public class ResultList : PartBase
    {
        [EditableLink("Fixture container", 100)]
        public virtual FixtureContainer Container { get; set; }

        [EditableTextBox("Max results", 120)]
        public virtual int MaxResults { get; set; }

        public virtual IList<Fixture> Results
        {
            get
            {
                IList<Fixture> results;

                if (Container == null)
                {
                    results = Find.Items.Where.Type.Eq(typeof(Fixture))
                        .Select<Fixture>().Where(x => x.FixtureDate < DateTime.Now)
                        .OrderBy(x => x.FixtureDate).ToList();
                }
                else
                {
                    results = Container.GetChildren().OfType<Fixture>().Where(x => x.FixtureDate < DateTime.Now)
                        .OrderBy(x => x.FixtureDate).ToList();
                }

                if (MaxResults < results.Count())
                {
                    return results.ToList().GetRange(results.Count - MaxResults, MaxResults);
                }
                return results;
            }
        }
    }
}