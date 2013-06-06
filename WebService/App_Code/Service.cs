using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

using System.Data;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消对下行的注释。
// [System.Web.Script.Services.ScriptService]
public class Service : System.Web.Services.WebService
{
    public Service () {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }

    [WebMethod]
    public DataTable InitIcon()
    {
        DataTable table = new DataTable("Table");
        table.Columns.Add(new DataColumn("IconID", Type.GetType("System.String")));
        table.Columns.Add(new DataColumn("IconPath", Type.GetType("System.String")));

        DataRow row = table.NewRow();
        row["IconID"] = "1";
        row["IconPath"] = "../assets/image/icon_info.png";
        table.Rows.Add(row);

        return table;
    }

    [WebMethod]
    public DataTable InitSurrounding() 
    {
        DataTable table = new DataTable("Table");
        table.Columns.Add(new DataColumn("TMB_ID", Type.GetType("System.String")));
        table.Columns.Add(new DataColumn("TMB_SurroundingBitmap", Type.GetType("System.String")));

        DataRow row = table.NewRow();
        row["TMB_ID"] = "1";
        row["TMB_SurroundingBitmap"] = "../assets/image/surrounding.png";
        table.Rows.Add(row);

        return table;
    }

    [WebMethod]
    public DataTable InitKeyPoint(String buildID)
    {
        DataTable table = new DataTable("Table");
        table.Columns.Add(new DataColumn("ID", Type.GetType("System.String")));
        table.Columns.Add(new DataColumn("X", Type.GetType("System.String")));
        table.Columns.Add(new DataColumn("Y", Type.GetType("System.String")));

        DataRow row = table.NewRow();
        row["ID"] = "1";
        row["X"] = "50";
        row["Y"] = "50";
        table.Rows.Add(row);

        row = table.NewRow();
        row["ID"] = "1";
        row["X"] = "100";
        row["Y"] = "100";
        table.Rows.Add(row);

        return table;
    }

    [WebMethod]
    public DataTable InitControlRange()
    {
        DataTable table = new DataTable("Table");
        table.Columns.Add(new DataColumn("TMB_ControlRangeBitmap", Type.GetType("System.String")));
        table.Columns.Add(new DataColumn("X", Type.GetType("System.String")));
        table.Columns.Add(new DataColumn("Y", Type.GetType("System.String")));

        DataRow row = table.NewRow();
        row["TMB_ControlRangeBitmap"] = "../assets/image/gogopher.jpg";
        row["X"] = "50";
        row["Y"] = "50";
        table.Rows.Add(row);

        return table;
    }

    [WebMethod]
    public DataTable InitBuild()
    {
        DataTable table = new DataTable("Table");
        table.Columns.Add(new DataColumn("TMB_PicPath", Type.GetType("System.String")));

        DataRow row = table.NewRow();
        row["TMB_PicPath"] = "../assets/image/plant4.jpg";
        table.Rows.Add(row);

        return table;
    }

    [WebMethod]
    public DataTable InitFloor(String buildID)
    {
        DataTable table = new DataTable("Table");
        table.Columns.Add(new DataColumn("T_FloorID", Type.GetType("System.String")));
        table.Columns.Add(new DataColumn("T_FloorName", Type.GetType("System.String")));
        table.Columns.Add(new DataColumn("T_FloorPicPath", Type.GetType("System.String")));

        DataRow row = table.NewRow();
        row["T_FloorID"] = "1";
        row["T_FloorName"] = "测试";
        row["T_FloorPicPath"] = "../assets/image/gogopher.jpg";

        table.Rows.Add(row);

        return table;
    }    

    [WebMethod]
    public DataTable InitComponent(String buildID,String floorID)
    {
        DataTable table = new DataTable("Table");
        table.Columns.Add(new DataColumn("T_FloorDetailID", Type.GetType("System.String")));
        table.Columns.Add(new DataColumn("T_FloorDetailName", Type.GetType("System.String")));
        table.Columns.Add(new DataColumn("T_FloorPicimgPath", Type.GetType("System.String")));

        return table;
    }

    [WebMethod]
    public DataTable InitContingencyPlans()
    {
        DataTable table = new DataTable("Table");
        table.Columns.Add(new DataColumn("TMB_ContingencyPlans", Type.GetType("System.String")));

        DataRow row = table.NewRow();
        row["TMB_ContingencyPlans"] = "../assets/doc/东方明珠应急预案.doc";
        table.Rows.Add(row);

        return table;
    }
}
