using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DotNetNuke.Modules.Events
{
    using System.Web.Services;

    public partial class AjaxBridge : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod(EnableSession = true)]
        public static int Control_GetTest()
        {
            return EventMonth.blaChanged();
        }
    }
}
