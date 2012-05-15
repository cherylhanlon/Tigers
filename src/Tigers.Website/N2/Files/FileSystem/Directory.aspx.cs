﻿using System;
using System.Linq;
using N2.Edit.Web;
using N2.Collections;
using N2.Edit.FileSystem.Items;
using N2.Resources;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using N2.Web;

namespace N2.Edit.FileSystem
{
	public partial class Directory1 : EditPage
	{
		protected override void RegisterToolbarSelection()
		{
			string script = GetToolbarSelectScript("preview");
			Register.JavaScript(this, script, ScriptPosition.Bottom, ScriptOptions.ScriptTags);
		}

		protected IEnumerable<ContentItem> ancestors;

		IList<Directory> directories;
		IList<File> files;

		protected override void OnInit(EventArgs e)
		{
			base.OnInit(e);

			hlNewFile.NavigateUrl = Selection.ActionUrl("upload");

			ancestors = Find.EnumerateParents(Selection.SelectedItem, null, true).Where(a => a is AbstractNode).Reverse();

			Reload();

			Refresh(Selection.SelectedItem, ToolbarArea.Navigation);
		}

		private void Reload()
		{
			var dir = Selection.SelectedItem as Directory;
			directories = dir.GetDirectories();
			files = dir.GetFiles();

			rptDirectories.DataSource = directories;
			rptFiles.DataSource = files;
			DataBind();
		}

		public void OnDeleteCommand(object sender, CommandEventArgs args)
		{
			Delete(Request.Form["directory"], directories.Select(f => f.Url), Engine.Resolve<IFileSystem>().DeleteDirectory);
			Delete(Request.Form["file"], files.Select(f => f.Url), Engine.Resolve<IFileSystem>().DeleteFile);
		}

		private void Delete(string itemsToDelete, IEnumerable<string> allowed, Action<string> deleteAction)
		{
			if (string.IsNullOrEmpty(itemsToDelete))
				return;

			var items = itemsToDelete.Split(',');
			foreach (string item in items.Select(i => i.TrimEnd('/')).Intersect(allowed.Select(a => a.TrimEnd('/'))))
			{
				deleteAction(item);
			}

			Reload();
		}
	}
}
