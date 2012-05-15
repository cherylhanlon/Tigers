using System.Web.Mvc;

namespace Tigers.Website.Controllers
{
    public class RedirectToUrlController : Controller
    {
        public RedirectResult RedirectToUrl(string url)
        {
            Response.StatusCode = 301;
            return Redirect(url);
        }
    }
}