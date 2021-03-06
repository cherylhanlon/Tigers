﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using N2.Web.Mvc;
using N2.Templates.Mvc.Models.Pages;

namespace N2.Templates.Mvc.Web
{
	public class ThemedMasterViewEngine : WebFormViewEngine
	{
		string masterPageFile = "~/Views/Shared/Site.master";

		public override ViewEngineResult FindView(ControllerContext controllerContext, string viewName, string masterName, bool useCache)
		{
			if (!controllerContext.IsChildAction)
			{
				if (!string.IsNullOrEmpty(masterPageFile))
					masterName = masterPageFile;

				var root = Find.Closest<StartPage>(controllerContext.RouteData.CurrentPage()) ?? Find.ClosestStartPage;
				if (root != null)
				{
					string theme = root.Theme;
					if (!string.IsNullOrEmpty(theme))
					{
						string potentialMaster = string.Format("~/Views/Shared/{0}.master", theme);
						if (base.FileExists(controllerContext, potentialMaster))
						{
							masterName = potentialMaster;
						}
					}
				}
			}

			return base.FindView(controllerContext, viewName, masterName, useCache);
		}
	}
}
