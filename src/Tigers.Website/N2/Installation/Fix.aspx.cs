using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using N2.Configuration;

namespace N2.Edit.Install
{
	public partial class Fix : System.Web.UI.Page
	{
        string tablePrefix = N2.Context.Current.Resolve<DatabaseSection>().TablePrefix;
        
        protected override void OnInit(EventArgs e)
		{
			rptCns.DataSource = ConfigurationManager.ConnectionStrings;
			rptCns.DataBind();

			string connectionStringName = Request.QueryString["cn"] ?? ConfigurationManager.ConnectionStrings[0].Name;
			sdsItems.ConnectionString = ConfigurationManager.ConnectionStrings[connectionStringName].ConnectionString;

			if (!IsPostBack)
			{
				LoadItems();
			}
			base.OnInit(e);
		}

        protected void Page_Load(object sender, EventArgs e)
        {
            sdsItems.SelectCommand = string.Format("SELECT * FROM [{0}Item]", tablePrefix); 
			sdsItems.DeleteCommand = string.Format("DELETE FROM [{0}detail] WHERE [ItemID] = @ID DELETE FROM [{0}detailCollection] WHERE [ItemID] = @ID DELETE FROM [{0}AllowedRole] WHERE [ItemID] = @ID DELETE FROM [{0}Item] WHERE [ID] = @ID" , tablePrefix); 
			sdsItems.InsertCommand = string.Format("INSERT INTO [{0}Item] ([Type], [Updated], [Name], [ZoneName], [Title], [Created], [Published], [Expires], [SortOrder], [Visible], [SavedBy], [VersionOfID], [ParentID]) VALUES (@Type, @Updated, @Name, @ZoneName, @Title, @Created, @Published, @Expires, @SortOrder, @Visible, @SavedBy, @VersionOfID, @ParentID)" , tablePrefix);
            sdsItems.UpdateCommand = string.Format("UPDATE [{0}Item] SET [Type] = @Type, [Updated] = @Updated, [Name] = @Name, [ZoneName] = @ZoneName, [Title] = @Title, [Created] = @Created, [Published] = @Published, [Expires] = @Expires, [SortOrder] = @SortOrder, [Visible] = @Visible, [SavedBy] = @SavedBy, [VersionOfID] = @VersionOfID, [ParentID] = @ParentID WHERE [ID] = @ID", tablePrefix); 
        }

		private void LoadItems()
		{
			gvItems.DataSourceID = sdsItems.ID;
			try
			{
				lblError.Text = "";
				gvItems.DataBind();
			}
			catch (Exception ex)
			{
				gvItems.DataSourceID = "";
				lblError.Text = ex.Message;
			}
		}
	}
}
