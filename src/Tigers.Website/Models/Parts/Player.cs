using N2;
using N2.Details;
using N2.Edit.FileSystem;
using N2.Persistence.Serialization;
using N2.Templates.Mvc.Models.Parts;
using N2.Web.Drawing;

namespace Tigers.Website.Models.Parts
{
    [PageDefinition("Player", Description = "Add a player", SortOrder = 150)]
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

        [EditableTextBox("First Name", 1)]
        public virtual string FirstName { get; set; }

        [EditableTextBox("Last Name", 2)]
        public virtual string LastName { get; set; }

        [EditableTextBox("Preferred Position", 3)]
        public virtual string PreferredPosition { get; set; }

        [EditableTextBox("Secondary Position", 4)]
        public virtual string SecondaryPosition { get; set; }
        
        [EditableTextBox("Tiger Title", 5)]
        public virtual string TigerTitle { get; set; }

        [EditableTextBox("Favourite Food", 7)]
        public virtual string Noms { get; set; }

        [EditableTextBox("Favourite Movie", 8)]
        public virtual string Movie { get; set; }

        [EditableTextBox("Favourite Song", 9)]
        public virtual string Song { get; set; }

        [EditableTextBox("Nick Name", 5)]
        public virtual string NickName { get; set; }

        [EditableTextBox("Other Hobbies", 6, 1000)]
        public virtual string OtherHobbies { get; set; }

        [EditableTextBox("Claim to Fame", 6, 1000)]
        public virtual string ClaimToFame { get; set; }

        [EditableTextBox("Random Fact", 6, 1000)]
        public virtual string RandomFact { get; set; }

        [EditableTextBox("Tell us a Joke", 20, 1000)]
        public virtual string Joke { get; set; }

        [TeamDropDown(Title = "Tiger Team")]
        public virtual string TigerTeam { get; set; }

        [FileAttachment, EditableFileUpload("Image", 40)]
        public virtual string ImageUrl
        {
            get { return (string)base.GetDetail("ImageUrl"); }
            set { base.SetDetail("ImageUrl", value); }
        }

        public virtual string GetThumbnailFileName()
        {
            if (ImageUrl != null)
            {
                string extension = System.IO.Path.GetExtension(ImageUrl);
                var filenameWithoutExtension = ImageUrl.Remove(ImageUrl.IndexOf(extension)).Replace("~/", "").Replace("/upload", "upload"); /* last replace is for unknown tiger thumb to work on team page */
                return string.Format("{0}{1}{2}", filenameWithoutExtension,"_thumb", extension);
            }
            return string.Empty;
        }
    }
}