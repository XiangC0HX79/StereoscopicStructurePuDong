﻿using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Net;
using System.Web;
using System.Web.UI;

using System.IO;

public partial class Download : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            var pw = Convert.ToInt32(HttpUtility.UrlDecode(Request.Params["w"]));
            var ph = Convert.ToInt32(HttpUtility.UrlDecode(Request.Params["h"]));
            var pimg = HttpUtility.UrlDecode(Request.Params["img"]);
            var ps = HttpUtility.UrlDecode(Request.Params["scale"]);

            var rq = (HttpWebRequest)WebRequest.Create(pimg);
            var rp = (HttpWebResponse)rq.GetResponse();
            var s = rp.GetResponseStream();

            if (s == null)
            {
                Response.Write("图片不存在" + pimg);
            }
            else
            {
                var oi = Image.FromStream(s);

                var scale = ps == "NaN" ? Math.Min(1, Math.Min((Double)pw / (2 * oi.Width), (Double)ph / (oi.Height * 2))) : Convert.ToDouble(ps);
                scale = Math.Round(scale * 100) / 100;

                var w = (int)(scale * oi.Width);
                var h = (int)(scale * oi.Height);
                var ni = oi.GetThumbnailImage(w, h, () => false, IntPtr.Zero); // 对原图片进行缩放 

                var sm = new MemoryStream();
                ni.Save(sm, ImageFormat.Png);
                sm.Position = 0;
                
                //以字符流的形式下载文件
                var b = new byte[(int)sm.Length];
                sm.Read(b, 0, b.Length);
                sm.Close();

                Response.BinaryWrite(b); 
                Response.Flush();
                Response.Clear();
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }

        Response.End();
    }
}