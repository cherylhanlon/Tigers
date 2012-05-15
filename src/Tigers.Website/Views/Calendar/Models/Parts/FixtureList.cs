using System;
using System.Collections.Generic;
using System.Linq;
using N2;
using N2.Collections;
using N2.Details;
using N2.Templates.Mvc.Models.Parts;
using Tigers.Website.Models.Pages;

namespace Tigers.Website.Models.Parts
{
    [PartDefinition("Fixture List",
        Description = "A fixture list",
        SortOrder = 160)]
    public class FixtureList : PartBase
    {
        [EditableLink("Fixture container", 100)]
        public virtual FixtureContainer Container { get; set; }

        [EditableTextBox("Max fixtures", 120)]
        public virtual int MaxFixtures { get; set; }

        public virtual IList<Fixture> Fixtures
        {
            get
            {
                IList<Fixture> fixtures;

                if (Container == null)
                {
                    fixtures = Find.Items.Where.Type.Eq(typeof(Fixture))
                        .Select<Fixture>().Where(x => x.FixtureDate > DateTime.Now)
                        .OrderBy(x => x.FixtureDate).ToList();
                }
                else
                {
                    fixtures = Container.GetChildren().OfType<Fixture>().Where(x => x.FixtureDate > DateTime.Now)
                        .OrderBy(x => x.FixtureDate).ToList();
                }

                if (MaxFixtures < fixtures.Count())
                {
                    return fixtures.ToList().GetRange(0, MaxFixtures);
                }
                return fixtures;
            }
        }
    }
}