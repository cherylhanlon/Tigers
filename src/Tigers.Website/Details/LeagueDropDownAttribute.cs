using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using N2.Edit.Workflow;
using N2.Templates.Details;
using N2.Templates.Mvc;
using Tigers.Website.Models.Parts;

namespace Tigers.Website.Details
{
    [AttributeUsage(AttributeTargets.Property)]
    public class LeagueDropDownAttribute : DropDownAttribute
    {
        public LeagueDropDownAttribute(string title, int sortOrder)
            : base(title, null, sortOrder)
        {
        }

        protected override IEnumerable<ListItem> GetListItems(Control container)
        {
            yield return new ListItem("Select a league", null);
            foreach (League league in Find.Items.Where.Type.Eq(typeof(League)).Select().Where(x => x.State == ContentState.Published))
            {
                yield return new ListItem(league.LeagueName, league.LeagueName);
            }
        }
    }
}