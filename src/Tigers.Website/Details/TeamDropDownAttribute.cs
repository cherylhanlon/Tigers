using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using N2.Edit.Workflow;
using N2.Templates.Details;
using N2.Templates.Mvc;
using Tigers.Website.Models.Pages;

namespace Tigers.Website.Details
{
    [AttributeUsage(AttributeTargets.Property)]
    public class TeamDropDownAttribute : DropDownAttribute
    {
        public TeamDropDownAttribute(string title, int sortOrder)
            : base(title, null, sortOrder)
        {
        }

        protected override IEnumerable<ListItem> GetListItems(Control container)
        {
            yield return new ListItem("Select a team", null);
            foreach (Team team in Find.Items.Where.Type.Eq(typeof(Team)).Select().Where(x => x.State == ContentState.Published))
            {
                yield return new ListItem(team.TeamName, team.TeamName);
            }
        }
    }
}