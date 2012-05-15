using N2;
using N2.Details;
using N2.Integrity;
using N2.Templates.Mvc.Models.Parts;
using Tigers.Website.Models.Pages;

namespace Tigers.Website.Models.Parts
{
    [PageDefinition("Player",
        Description = "Add a player",
        SortOrder = 150)]
    [RestrictParents(typeof(Team))]
    public class Player : PartBase
    {
        public Player()
        {
            base.Visible = false;
        }

        public override string Title
        {
            get { return FirstName + " " + LastName; }
        }

        [EditableTextBox("First Name", 20)]
        public virtual string FirstName { get; set; }

        [EditableTextBox("Last Name", 30)]
        public virtual string LastName { get; set; }

        [EditableTextBox("Preferred Position", 40)]
        public virtual string PreferredPosition { get; set; }

        [EditableTextBox("Secondary Position", 50)]
        public virtual string SecondaryPosition { get; set; }
    }
}