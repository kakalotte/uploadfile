using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication2
{
    /// <summary>
    /// upload1 的摘要说明
    /// </summary>
    public class upload1 : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            if (context.Request.Files != null && context.Request.Files.Count > 0)
            {
                HttpFileCollection col = context.Request.Files;
                HttpPostedFile file = col[0];
                string filename = DateTime.Now.ToString("yyyyMMddHHmmss") + file.FileName;
                file.SaveAs("e:\\" + filename);
                context.Response.ContentType = "text/plain";
                context.Response.Write(filename);
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}