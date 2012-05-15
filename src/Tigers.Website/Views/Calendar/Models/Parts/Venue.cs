using N2;
using N2.Details;
using N2.Integrity;
using N2.Templates.Mvc.Models.Parts;
using Tigers.Website.Models.Pages;

namespace Tigers.Website.Models.Parts
{
    [PageDefinition("Venue",
        Description = "Add a venue",
        SortOrder = 150)]
    [RestrictParents(typeof(VenueList))]
    public class Venue : PartBase
    {
        public Venue()
        {
            base.Visible = false;
        }

        public override string Title
        {
            get { return VenueName; }
        }

        [EditableTextBox("Name", 20)]
        public virtual string VenueName { get; set; }

        [EditableFreeTextArea("Description", 40)]
        public virtual string Description { get; set; }
    }
}