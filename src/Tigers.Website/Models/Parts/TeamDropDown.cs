using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using N2.Details;
using Tigers.Website.Models.Pages;

namespace Tigers.Website.Models.Parts
{
    public class TeamDropDown : EditableDropDownAttribute
    {
        public TeamDropDown()
            : base("Upload Root Folder", 10)
        {
            Name = "Name";
            Required = true;
        }

        protected override ListItem[] GetListItems()
        {
            IList<ListItem> list = N2.Find.Items.Where.Type.Eq(typeof(Team)).Select<Team>().Select(team => new ListItem(team.TeamName)).ToList();
            list.Insert(0, new ListItem("Not Set"));
            return list.ToArray();
        }
    }
}
