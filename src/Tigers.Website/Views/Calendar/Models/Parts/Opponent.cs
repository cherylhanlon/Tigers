using N2;
using N2.Details;
using N2.Integrity;
using N2.Templates.Mvc.Models.Parts;
using Tigers.Website.Models.Pages;

namespace Tigers.Website.Models.Parts
{
    [PageDefinition("Opponent",
        Description = "Add an Opponent",
        SortOrder = 150)]
    [RestrictParents(typeof (OpponentList))]
    public class Opponent : PartBase
    {
        public Opponent()
        {
            base.Visible = false;
        }

        public override string Title
        {
            get { return OpponentName; }
        }

        [EditableTextBox("Name", 20)]
        public virtual string OpponentName { get; set; }

        [EditableFreeTextArea("Description", 40)]
        public virtual string Description { get; set; }
    }
}