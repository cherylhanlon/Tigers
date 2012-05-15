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
    public class OpponentDropDownAttribute : DropDownAttribute
    {
        public OpponentDropDownAttribute(string title, int sortOrder)
            : base(title, null, sortOrder)
        {
        }

        protected override IEnumerable<ListItem> GetListItems(Control container)
        {
            yield return new ListItem("Select an opponent", null);
            foreach (Opponent opponent in Find.Items.Where.Type.Eq(typeof(Opponent)).Select().Where(x => x.State == ContentState.Published))
            {
                yield return new ListItem(opponent.OpponentName, opponent.OpponentName);
            }
        }
    }
}