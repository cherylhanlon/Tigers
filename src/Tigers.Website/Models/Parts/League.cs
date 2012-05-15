using N2;
using N2.Details;
using N2.Integrity;
using N2.Templates.Mvc.Models.Parts;
using Tigers.Website.Models.Pages;

namespace Tigers.Website.Models.Parts
{
    [PageDefinition("League",
    Description = "Add a league",
    SortOrder = 150)]
    [RestrictParents(typeof(LeagueList))]
    public class League : PartBase
    {
        public League()
        {
            base.Visible = false;
        }

        public override string Title
        {
            get { return LeagueName; }
        }

        [EditableTextBox("Name", 20)]
        public virtual string LeagueName { get; set; }

        [EditableFreeTextArea("Description", 40)]
        public virtual string Description { get; set; }
    }
}