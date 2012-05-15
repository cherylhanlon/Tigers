using System.Collections.Generic;
using System.Linq;
using N2;
using N2.Integrity;
using N2.Templates.Mvc;
using N2.Templates.Mvc.Models.Pages;
using N2.Definitions;

namespace Tigers.Website.Models.Pages
{
    [PageDefinition("Galleries List",
        Description = "A list of galleries.",
        SortOrder = 150)]
    [AvailableZone("Galleries", Zones.Content)]
    public class GalleryList : ContentPageBase, IStructuralPage
    {
        public virtual IList<ImageGallery> Galleries    
        {
            get
            {
                IList<ImageGallery> galleries = GetChildren<ImageGallery>();
                return galleries != null ? galleries.OrderByDescending(x => x.Created).ToList() : new List<ImageGallery>();
            }
        }
    }
}