//using N2.Collections;
//using N2.Templates.Mvc.Models.Pages;
//using N2.Templates.Mvc.Models;
//using N2.Web;
//using N2.Web.Mvc;
//using Tigers.Website.Models.Pages;

//namespace N2.Templates.Mvc.Controllers
//{
//    [Controls(typeof(GalleryList))]
//    public class GalleryListController : ContentController<GalleryList>
//    {
//        public override System.Web.Mvc.ActionResult Index()
//        {
//            var galleries = CurrentItem.GetChildren(new AccessFilter(), new TypeFilter(typeof(ImageGallery))).Cast<GalleryItem>();
//            foreach (var gallery in galleries)
//            {
		        
//            }
//            //var galleryItems = CurrentItem.GetChildren(new AccessFilter(), new TypeFilter(typeof (GalleryItem))).Cast<GalleryItem>();

//            return View(CurrentItem);
//        }
//    }
//}