using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

using System.Data;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class Service : WebService
{
    private readonly ClassDatabaseOperator _databaseOperator;

    public Service()
    {
        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 

        _databaseOperator = new ClassDatabaseOperator("System.Data.SqlClient", System.Configuration.ConfigurationManager.AppSettings["CONSTR"]);
    }

    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
    }

    [WebMethod]
    public DataTable Test()
    {
        return _databaseOperator.GetTable("Select * FROM sdaf");
    }

    [WebMethod]
    public DataTable InitIcon()
    {
        var table = new DataTable("Table");

        // ReSharper disable AssignNullToNotNullAttribute
        table.Columns.Add(new DataColumn("IconID", Type.GetType("System.String")));
        // ReSharper restore AssignNullToNotNullAttribute

        // ReSharper disable AssignNullToNotNullAttribute
        table.Columns.Add(new DataColumn("IconPath", Type.GetType("System.String")));
        // ReSharper restore AssignNullToNotNullAttribute

        var row = table.NewRow();
        row["IconID"] = "1";
        row["IconPath"] = "../Icon/Map/CommandingHeight.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "2";
        row["IconPath"] = "../Icon/Map/CloseHandle.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "3";
        row["IconPath"] = "../Icon/Map/Traffic.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "41";
        row["IconPath"] = "../Icon/Map/Eletric.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "42";
        row["IconPath"] = "../Icon/Map/Gas.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "43";
        row["IconPath"] = "../Icon/Map/Can.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "6";
        row["IconPath"] = "../Icon/Map/FireHydrant.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "7";
        row["IconPath"] = "../Icon/Map/KeyUnit.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "8";
        row["IconPath"] = "../Icon/Map/Scenting.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "9";
        row["IconPath"] = "../Icon/Map/ImportExport.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "10";
        row["IconPath"] = "../Icon/Map/Video.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "c2";
        row["IconPath"] = "../Icon/Cursor/CursorVideoAdd.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "c3";
        row["IconPath"] = "../Icon/Cursor/CursorVideoDel.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "c4";
        row["IconPath"] = "../Icon/Cursor/CursorFireAdd.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "c5";
        row["IconPath"] = "../Icon/Cursor/CursorFireDel.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "m0";
        row["IconPath"] = "../Icon/Menu/Default.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "m1";
        row["IconPath"] = "../Icon/Menu/Save.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "m2";
        row["IconPath"] = "../Icon/Menu/FireAdd.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "m3";
        row["IconPath"] = "../Icon/Menu/FireDel.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "m4";
        row["IconPath"] = "../Icon/Menu/ClosedAdd.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "m5";
        row["IconPath"] = "../Icon/Menu/ClosedDel.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "m6";
        row["IconPath"] = "../Icon/Menu/ScentingAdd.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "m7";
        row["IconPath"] = "../Icon/Menu/ScentingDel.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "m8";
        row["IconPath"] = "../Icon/Menu/VideoAdd.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "m9";
        row["IconPath"] = "../Icon/Menu/VideoDel.png";
        table.Rows.Add(row);

        return table;
    }
    
    [WebMethod]
    public int SaveSurrouding(String data)
    {
        var sql = "";

        foreach (var s2 in data.Split(';').Select(i => i.Split(' ')))
        {
            switch (s2[0])
            {
                case "1":
                    sql += "UPDATE T_CommandingHeights SET TCH_X = " + s2[2] + ",TCH_Y = " + s2[3] + " WHERE TCH_ID = " + s2[1] + ";";
                    break;
                case "2":
                    sql += "UPDATE T_Closedhandles SET T_ClosedX = " + s2[2] + ",T_ClosedY = " + s2[3] + " WHERE T_ClosedhandlesID = " + s2[1] + ";";
                    break;
                case "3":
                    sql += "UPDATE T_Traffic SET T_TrafficX = " + s2[2] + ",T_TrafficY = " + s2[3] + " WHERE T_TrafficID = " + s2[1] + ";";
                    break;
                case "4":
                    sql += "UPDATE T_Hazard SET T_HazardX = " + s2[2] + ",T_HazardY = " + s2[3] + " WHERE T_HazardID = " + s2[1] + ";";
                    break;
                case "6":
                    sql += "UPDATE T_FireHydrant SET T_FireHydrantX = " + s2[2] + ",T_FireHydrantY = " + s2[3] + " WHERE T_FireHydrantID = " + s2[1] + ";";
                    break;
                case "7":
                    sql += "UPDATE T_KeyUnits SET T_KeyUnitsX = " + s2[2] + ",T_KeyUnitsY = " + s2[3] + " WHERE T_KeyUnitsID = " + s2[1] + ";";
                    break;
                case "8":
                    sql += "UPDATE T_Scenting SET T_ScentingX = " + s2[2] + ",T_ScentingY = " + s2[3] + " WHERE T_ScentingID = " + s2[1] + ";";
                    break;
            }
        }

        return _databaseOperator.ExcuteNoQuery(sql);
    }
       
    [WebMethod]
    public int AddClosedLine(String json)
    {
        var d = FromJsonTo<Dictionary<string, object>>(json);

        var sql = "INSERT T_ClosedhandlesLine (TMB_ID,T_ClosedLineStartX,T_ClosedLineStartY,T_ClosedLineEndX,T_ClosedLineEndY) VALUES ("
            + d["TMB_ID"] + "," + d["T_ClosedLineStartX"] + "," + d["T_ClosedLineStartY"] + "," + d["T_ClosedLineEndX"] + "," + d["T_ClosedLineEndY"] + ");";

        _databaseOperator.ExcuteNoQuery(sql);

        return Convert.ToInt32(_databaseOperator.GetValue("select IDENT_CURRENT('T_ClosedhandlesLine')"));
    }

    [WebMethod]
    public int DelClosedLine(String id)
    {
        var sql = "DELETE FROM T_ClosedhandlesLine WHERE T_ClosedhandlesLineID = " + id;

        return _databaseOperator.ExcuteNoQuery(sql);
    }

    [WebMethod]
    public int AddFireHydrant(String data)
    {
        var s = data.Split(' ');

        var sql = "INSERT T_FireHydrant (TMB_ID,T_FireHydrantX,T_FireHydrantY) VALUES (" + s[0] + "," + s[1] + "," + s[2]  + ");";

        _databaseOperator.ExcuteNoQuery(sql);

        return Convert.ToInt32(_databaseOperator.GetValue("select IDENT_CURRENT('T_FireHydrant')"));
    }

    [WebMethod]
    public int DelFireHydrant(String id)
    {
        var sql = "DELETE FROM T_FireHydrant WHERE T_FireHydrantID = " + id;

        return _databaseOperator.ExcuteNoQuery(sql);
    }


    [WebMethod]
    public int AddScentingLine(String json)
    {
        var d = FromJsonTo<Dictionary<string, object>>(json);

        var sql = "INSERT T_ScentingLine (TMB_ID,T_ScentingLinePath) VALUES ("
            + d["TMB_ID"] + ",'" + d["T_ScentingLinePath"] + "');";

        _databaseOperator.ExcuteNoQuery(sql);

        return Convert.ToInt32(_databaseOperator.GetValue("select IDENT_CURRENT('T_ScentingLine')"));
    }

    [WebMethod]
    public int DelSentingLine(String id)
    {
        var sql = "DELETE FROM T_ScentingLine WHERE T_ScentingLineID = " + id;

        return _databaseOperator.ExcuteNoQuery(sql);
    }

    [WebMethod]
    public DataTable InitBuild(String buildName)
    {
        var sql = "Select * FROM T_MainBulid "
                     + "LEFT JOIN T_MainBulidAppend ON T_MainBulid.TMB_ID = T_MainBulidAppend.TMB_ID "
                     + "LEFT JOIN T_FireInformation ON T_MainBulid.TMB_ID = T_FireInformation.TMB_ID "
                     + "WHERE TMB_Name = '" + buildName + "'";

        return _databaseOperator.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitCommandingHeights(String tmbId)
    {
        var sql = "Select * FROM T_CommandingHeights "
                     + "LEFT JOIN T_CommandingHeightsPIC "
                     + "ON T_CommandingHeights.TCH_ID = T_CommandingHeightsPIC.TCH_ID "
                     + "AND T_CommandingHeightsPIC.T_ComType = 1 "
                     + "WHERE T_CommandingHeights.TMB_ID = " + tmbId;

        return _databaseOperator.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitCommandingHeightsPic(String tmbId)
    {
        var sql = "Select * FROM T_CommandingHeightsPIC WHERE TMB_ID = " + tmbId + " AND T_ComType = 2";

        return _databaseOperator.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitClosedLine(String tmbId)
    {
        var sql = "Select * FROM T_ClosedhandlesLine WHERE TMB_ID =" + tmbId;

        return _databaseOperator.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitClosedhandles(String tmbId)
    {
        var sql = "Select * FROM T_Closedhandles WHERE TMB_ID =" + tmbId;

        return _databaseOperator.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitClosedhandlesPic(String tmbId)
    {
        var sql = "Select * FROM T_ClosedhandlesPic Where TMB_ID = " + tmbId;

        return _databaseOperator.GetTable(sql);
    }
    
    [WebMethod]
    public DataTable InitTraffic(String tmbId)
    {
        var sql = "Select * FROM T_Traffic "
                     + "WHERE TMB_ID = " + tmbId;

        return _databaseOperator.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitTrafficPic(String tmbId)
    {
        var sql = "Select * FROM T_TrafficPic "
                     + "WHERE TMB_ID = " + tmbId;

        return _databaseOperator.GetTable(sql);
    }
    
    [WebMethod]
    public DataTable InitHazard(String tmbId)
    {
        var sql = "Select * FROM T_Hazard "
                     + "LEFT JOIN T_HazardPic ON T_Hazard.T_HazardID = T_HazardPic.T_HazardID "
                     + "WHERE T_Hazard.TMB_ID = " + tmbId;

        return _databaseOperator.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitFireHydrant(String tmbId)
    {
        var sql = "Select * FROM T_FireHydrant "
                     + "WHERE TMB_ID = " + tmbId;

        return _databaseOperator.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitKeyUnits(String tmbId)
    {
        var sql = " Select * FROM T_KeyUnits "
                    + "LEFT JOIN T_KeyUnitsPic ON T_KeyUnits.T_KeyUnitsID = T_KeyUnitsPic.T_KeyUnitsID "
                    + "WHERE T_KeyUnits.TMB_ID = " + tmbId;

        return _databaseOperator.GetTable(sql);
    }
       
    [WebMethod]
    public DataTable InitScentingLine(String tmbId)
    {
        var sql = "Select * FROM T_ScentingLine WHERE TMB_ID =" + tmbId;

        return _databaseOperator.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitScenting(String tmbId)
    {
        var sql = "Select * FROM T_Scenting "
                     + "LEFT JOIN T_ScentingImg ON T_Scenting.T_ScentingID = T_ScentingImg.T_ScentingID "
                     + "WHERE T_Scenting.TMB_ID = " + tmbId;

        var scenting = _databaseOperator.GetTable(sql);

        sql = "Select * FROM T_ScentingImg "
                    + "WHERE TMB_ID = " + tmbId;

        var img = _databaseOperator.GetTable(sql);

        foreach (DataRow k in img.Rows)
        {
            var s = k["T_ScentingimgOwen"].ToString().Split(',');
            foreach (var j in from i in s where i != "" from j in scenting.Select("T_ScentingID = " + i) select j)
            {
                j["T_ScentingImgName"] = k["T_ScentingImgName"];
                j["T_ScentingimgPath"] = k["T_ScentingimgPath"];
            }
        }

        return scenting;
    }
    
    [WebMethod]
    public DataTable InitTatics(String tmbId)
    {
        var sql = "Select * FROM T_TacticalPoints WHERE TMB_ID = " + tmbId;

        return _databaseOperator.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitFloorPic(String tmbId)
    {
        var sql = "SELECT * FROM T_FloorPic " +
                  "WHERE TMB_ID = " + tmbId;

        return _databaseOperator.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitFloor(String buildId)
    {
        var sql = "SELECT *,0 T_BitmapWidth,0 T_BitmapHeight FROM T_Floor " +
                  "LEFT JOIN T_FloorPos ON T_Floor.T_FloorID = T_FloorPos.T_FloorID AND T_Floor.TMB_ID = T_FloorPos.TMB_ID " +
                  "WHERE T_Floor.TMB_ID = " + buildId + " " +
                  "ORDER BY T_Floor.T_Floorsque DESC";

        var dt = _databaseOperator.GetTable(sql);

        foreach (DataRow row in dt.Rows)
        {
            var path = row["T_FloorPicPath"].ToString();
            path =path.Replace("..","~");

            try
            {
                var img = Image.FromFile(Server.MapPath(path));
                row["T_BitmapWidth"] = img.Width;
                row["T_BitmapHeight"] = img.Height;
            }
            catch
            {
            }
        }

        return dt;
    }

    [WebMethod]
    public int SaveFloor(String buildId, String data)
    {
        var sql = "";

        foreach (var floorPos in data.Split('@').Select(dataFloor => dataFloor.Split(';')).Where(floorPos => floorPos[0] != ""))
        {
            sql += "DELETE FROM T_FloorPos WHERE TMB_ID = " + buildId + " AND T_FloorID = " + floorPos[0] + ";";
            sql += "INSERT T_FloorPos (TMB_ID,T_FloorID,T_FloorScale,T_FloorX,T_FloorY,T_FloorXRotation,T_FloorYRotation,T_FloorZRotation,T_FloorAlpha) VALUES (" + buildId + "," + floorPos[0] + "," + floorPos[1] + "," + floorPos[2] + "," + floorPos[3] + "," + floorPos[4] + "," + floorPos[5] + "," + floorPos[6] + "," + floorPos[7] + ");";
        }

        return _databaseOperator.ExcuteNoQuery(sql);
    }

    [WebMethod]
    public DataTable InitComponent(String buildId)
    {
        var sql = "SELECT * FROM T_FloorDetail " +
                  "WHERE TMB_ID = " + buildId;

        return _databaseOperator.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitComponentMedia(String tmbId)
    {
        var sql = "SELECT * FROM T_FloorMedia WHERE TMB_ID = " + tmbId;

        return _databaseOperator.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitPassage(String tmbId)
    {
        var result = _databaseOperator.GetTable("Select * FROM T_Passage where tmb_ID = " + tmbId);

        return result;
    }

    [WebMethod]
    public DataTable InitImportExport(String tmbId)
    {
        var result = _databaseOperator.GetTable("Select * FROM T_ImportExport where tmb_ID = " + tmbId);

        return result;
    }

    [WebMethod]
    public DataTable InitImportExportPic(String tmbId)
    {
        var result = _databaseOperator.GetTable("Select * FROM T_ImportExportPic where tmb_ID = " + tmbId);

        return result;
    }

    [WebMethod]
    public DataTable InitVideo(String tmbId)
    {
        var result = _databaseOperator.GetTable("Select * FROM T_Video where tmb_ID = " + tmbId);

        return result;
    }
       
    [WebMethod]
    public int AddVideo(String data)
    {
        var s = data.Split(' ');

        var sql = "INSERT T_Video (TMB_ID,T_PassageID,T_VideoX,T_VideoY) VALUES (" + s[0] + "," + s[1] + "," + s[2] + "," + s[3] + ");";

        _databaseOperator.ExcuteNoQuery(sql);

        return Convert.ToInt32(_databaseOperator.GetValue("select IDENT_CURRENT('T_Video')"));
    }

    [WebMethod]
    public int DelVideo(String id)
    {
        var sql = "DELETE FROM T_Video WHERE T_VideoID = " + id;

        return _databaseOperator.ExcuteNoQuery(sql);
    }
      
    [WebMethod]
    public int SavePassage(String data)
    {
        var sql = "";
        foreach (var f in data.Split(';').Select(s => s.Split(' ')))
        {
            switch (f[0])
            {
                case "10":
                    sql += "UPDATE T_Video SET T_VideoX = " + f[2] + ",T_VideoY = " + f[3] + " WHERE T_VideoID = " + f[1] + ";";
                    break;

                case "11":
                    sql += "UPDATE T_ImportExport SET T_ImportExportX = " + f[2] + ",T_ImportExportY = " + f[3] + " WHERE T_ImportExportID = " + f[1] + ";";
                    break;
            }
        }

        return _databaseOperator.ExcuteNoQuery(sql);
    }

    [WebMethod]
    public String GetBitmapSize(String url)
    {
        try
        {
            var root = HttpContext.Current.Request.Url.AbsoluteUri;
            root = root.Substring(0, root.IndexOf("Service.asmx", StringComparison.Ordinal));

            var index = url.IndexOf(root, StringComparison.Ordinal);
            if (index != 0)
            {
                return "0 0";
            }
            
            var u = url.Substring(root.Length);
            var img = Image.FromFile(Server.MapPath(u));
            return img.Width + " " + img.Height;
        }
        catch
        {
            return "0 0";
        }
    }

    public T FromJsonTo<T>(string jsonString)
    {
        var jss = new JavaScriptSerializer();

        try
        {
            //将指定的 JSON 字符串转换为 T 类型的对象
            return jss.Deserialize<T>(jsonString);
        }

        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }

    }
}
