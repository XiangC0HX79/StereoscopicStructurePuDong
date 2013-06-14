using System;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Web.Services;

using System.Data;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class Service : WebService
{
    private readonly ClsGetData _clsGetData;

    public Service()
    {
        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 

        _clsGetData = new ClsGetData("System.Data.SqlClient", System.Configuration.ConfigurationManager.AppSettings["CONSTR"]);
    }

    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
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
        row["IconPath"] = "../Icon/CommandingHeight.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "2";
        row["IconPath"] = "../Icon/CloseHandle.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "3";
        row["IconPath"] = "../Icon/Traffic.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "6";
        row["IconPath"] = "../Icon/FireHydrant.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "7";
        row["IconPath"] = "../Icon/KeyUnit.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "8";
        row["IconPath"] = "../Icon/Scenting.png";
        table.Rows.Add(row);

        row = table.NewRow();
        row["IconID"] = "9";
        row["IconPath"] = "../Icon/ImportExport.png";
        table.Rows.Add(row);

        return table;
    }
    
    [WebMethod]
    public DataTable SaveSurrouding(String data)
    {
        var sql = "";
        var tmbId = "";

        var s1 = data.Split(';');

        foreach (var s2 in s1.Select(i => i.Split(' ')))
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
                    tmbId = s2[1];
                    sql += "INSERT T_FireHydrant (TMB_ID,T_FireHydrantX,T_FireHydrantY) VALUES (" + s2[1] + "," +s2[2] + "," + s2[3] + ");";
                    break;
                case "7":
                    sql += "UPDATE T_KeyUnits SET T_KeyUnitsX = " + s2[2] + ",T_KeyUnitsY = " + s2[3] + " WHERE T_KeyUnitsID = " + s2[1] + ";";
                    break;
                case "8":
                    sql += "UPDATE T_Scenting SET T_ScentingX = " + s2[2] + ",T_ScentingY = " + s2[3] + " WHERE T_ScentingID = " + s2[1] + ";";
                    break;
            }
        }

        sql = "DELETE FROM T_FireHydrant WHERE TMB_ID = " + tmbId + ";" + sql;

        return _clsGetData.ExcuteNoQuery(sql);
    }

    [WebMethod]
    public DataTable InitBuild(String buildName)
    {
        var sql = "Select * FROM T_MainBulid "
                     + "LEFT JOIN T_MainBulidAppend ON T_MainBulid.TMB_ID = T_MainBulidAppend.TMB_ID "
                     + "LEFT JOIN T_FireInformation ON T_MainBulid.TMB_ID = T_FireInformation.TMB_ID "
                     + "WHERE TMB_Name = '" + buildName + "'";

        return _clsGetData.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitCommandingHeights(String tmbId)
    {
        var sql = "Select * FROM T_CommandingHeights "
                     + "LEFT JOIN T_CommandingHeightsPIC "
                     + "ON T_CommandingHeights.TCH_ID = T_CommandingHeightsPIC.TCH_ID "
                     + "AND T_CommandingHeightsPIC.T_ComType = 1 "
                     + "WHERE T_CommandingHeights.TMB_ID = " + tmbId;

        return _clsGetData.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitCommandingHeightsPic(String tchId)
    {
        var sql = "Select * FROM T_CommandingHeightsPIC WHERE TCH_ID = " + tchId + " AND T_ComType = 2";

        return _clsGetData.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitClosedhandles(String buildId)
    {
        var sql = "Select * FROM T_Closedhandles WHERE  TMB_ID =" + buildId;

        return _clsGetData.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitClosedhandlesPic(String closedhandlesId)
    {
        var sql = "Select * FROM T_ClosedhandlesPic Where T_ClosedhandlesID = " + closedhandlesId;

        return _clsGetData.GetTable(sql);
    }
    
    [WebMethod]
    public DataTable InitTraffic(String tmbId)
    {
        var sql = "Select * FROM T_Traffic "
                     + "LEFT JOIN T_TrafficPic ON T_Traffic.T_TrafficID = T_TrafficPic.T_TrafficID "
                     + "WHERE T_Traffic.TMB_ID = " + tmbId;

        return _clsGetData.GetTable(sql);
    }
    
    [WebMethod]
    public DataTable InitHazard(String tmbId)
    {
        var sql = "Select * FROM T_Hazard "
                     + "LEFT JOIN T_HazardPic ON T_Hazard.T_HazardID = T_HazardPic.T_HazardID "
                     + "WHERE T_Hazard.TMB_ID = " + tmbId;

        return _clsGetData.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitFireHydrant(String tmbId)
    {
        var sql = "Select * FROM T_FireHydrant "
                     + "WHERE TMB_ID = " + tmbId;

        return _clsGetData.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitKeyUnits(String tmbId)
    {
        var sql = " Select * FROM T_KeyUnits "
                    + "LEFT JOIN T_KeyUnitsPic ON T_KeyUnits.T_KeyUnitsID = T_KeyUnitsPic.T_KeyUnitsID "
                    + "WHERE T_KeyUnits.TMB_ID = " + tmbId;

        return _clsGetData.GetTable(sql);
    }
    
    [WebMethod]
    public DataTable InitScenting(String tmbId)
    {
        var sql = "Select * FROM T_Scenting "
                     + "LEFT JOIN T_ScentingImg ON T_Scenting.T_ScentingID = T_ScentingImg.T_ScentingID "
                     + "WHERE T_Scenting.TMB_ID = " + tmbId;

        var scenting = _clsGetData.GetTable(sql);

        sql = "Select * FROM T_ScentingImg "
                    + "WHERE TMB_ID = " + tmbId;

        var img = _clsGetData.GetTable(sql);

        foreach (DataRow k in img.Rows)
        {
            var s = k["T_ScentingimgOwen"].ToString().Split(',');
            foreach (var j in s.SelectMany(i => scenting.Select("T_ScentingID = " + i)))
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

        return _clsGetData.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitFloorPic(String tmbId)
    {
        var sql = "SELECT * FROM T_FloorPic " +
                  "WHERE TMB_ID = " + tmbId;

        return _clsGetData.GetTable(sql);
    }

    [WebMethod]
    public DataTable InitFloor(String buildId)
    {
        var sql = "SELECT * FROM T_Floor " +
                  "LEFT JOIN T_FloorPos ON T_Floor.T_FloorID = T_FloorPos.T_FloorID AND T_Floor.TMB_ID = T_FloorPos.TMB_ID " +
                  "WHERE T_Floor.TMB_ID = " + buildId + " " +
                  "ORDER BY T_Floor.T_Floorsque DESC";

        return _clsGetData.GetTable(sql);
    }

    [WebMethod]
    public DataTable SaveFloor(String buildId, String data)
    {
        var sql = "";

        foreach (var floorPos in data.Split('@').Select(dataFloor => dataFloor.Split(';')).Where(floorPos => floorPos[0] != ""))
        {
            sql += "DELETE FROM T_FloorPos WHERE TMB_ID = " + buildId + " AND T_FloorID = " + floorPos[0] + ";";
            sql += "INSERT T_FloorPos (TMB_ID,T_FloorID,T_FloorScale,T_FloorX,T_FloorY,T_FloorXRotation,T_FloorYRotation,T_FloorZRotation,T_FloorAlpha) VALUES (" + buildId + "," + floorPos[0] + "," + floorPos[1] + "," + floorPos[2] + "," + floorPos[3] + "," + floorPos[4] + "," + floorPos[5] + "," + floorPos[6] + "," + floorPos[7] + ");";
        }

        return _clsGetData.ExcuteNoQuery(sql);
    }

    [WebMethod]
    public DataTable InitComponent(String buildId, String floorId)
    {
        var sql = "SELECT * FROM T_FloorDetail " +
                  "WHERE TMB_ID = " + buildId + 
                  " ORDER BY T_FloorDetailID DESC";
        var result = _clsGetData.GetTable(sql);

        for (var i = result.Rows.Count - 1; i >= 0; i--)
        {
            var row = result.Rows[i];

            if (floorId == row["T_FloorID"].ToString()) continue;

            var childfloors = row["T_FloorDetailchildfloor"].ToString().Split(',');
            var b = childfloors.Any(childfloor => floorId == childfloor);

            if (!b)
                result.Rows.Remove(row);
        }

        return result;
    }

    [WebMethod]
    public DataTable InitComponentMedia(String componentId)
    {
        var result = _clsGetData.GetTable("SELECT * FROM T_FloorMedia WHERE T_FloorDetailID = " + componentId);

        return result;
    }

    [WebMethod]
    public DataTable InitPassage(String tmbId)
    {
        var result = _clsGetData.GetTable("Select * FROM T_Passage where tmb_ID = " + tmbId);

        return result;
    }

    [WebMethod]
    public DataTable InitImportExport(String tmbId)
    {
        var result = _clsGetData.GetTable("Select * FROM T_ImportExport where tmb_ID = " + tmbId);

        return result;
    }

    [WebMethod]
    public DataTable InitImportExportPic(String tmbId)
    {
        var result = _clsGetData.GetTable("Select * FROM T_ImportExportPic where tmb_ID = " + tmbId);

        return result;
    }

    [WebMethod]
    public String GetBitmapSize(String url)
    {
        try
        {
            var root = System.Web.HttpContext.Current.Request.Url.AbsoluteUri;
            root = root.Substring(0, root.IndexOf("Service.asmx"));

            var index = url.IndexOf(root);
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
}
