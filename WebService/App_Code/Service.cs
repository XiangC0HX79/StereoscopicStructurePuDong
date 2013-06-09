using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;

using System.Data;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class Service : System.Web.Services.WebService
{
    private String conStr = "";

    public Service()
    {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 

        conStr = System.Configuration.ConfigurationManager.AppSettings["CONSTR"];
    }

    [WebMethod]
    public string HelloWorld()
    {
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
    public DataTable InitBuild(String buildName)
    {
        ClsGetData clsGetData = new ClsGetData("System.Data.SqlClient", conStr);

        //String sql = "Select * FROM T_MainBulid LEFT JOIN T_MainBulid_Append ON T_MainBulid.TMB_ID = T_MainBulid_Append.TMB_ID "
        //                        + "WHERE TMB_Name = '" + buildName + "'";
        String sql = "Select * FROM T_MainBulid "
                     + "LEFT JOIN T_MainBulid_Append ON T_MainBulid.TMB_ID = T_MainBulid_Append.TMB_ID "
                     + "LEFT JOIN T_FireInformation ON T_MainBulid.TMB_ID = T_FireInformation.TMB_ID "
                     + "WHERE TMB_Name = '上海东方艺术中心'";

        DataTable result = clsGetData.GetTable(sql);

        return result;
    }

    [WebMethod]
    public DataTable InitCommandingHeights(String buildID)
    {
        ClsGetData clsGetData = new ClsGetData("System.Data.SqlClient", conStr);

        String sql = "Select * FROM T_CommandingHeights LEFT JOIN T_CommandingHeightsPIC ON T_CommandingHeights.TCH_ID = T_CommandingHeightsPIC.TCH_ID "
                    + "WHERE T_CommandingHeightsPIC.TMB_ID = " + buildID + " AND T_CommandingHeightsPIC.T_ComType = 1";

        DataTable result = clsGetData.GetTable(sql);

        return result;
    }

    [WebMethod]
    public DataTable InitCommandingHeightsPIC(String TCH_ID)
    {
        ClsGetData clsGetData = new ClsGetData("System.Data.SqlClient", conStr);

        String sql = "Select * FROM T_CommandingHeightsPIC WHERE TCH_ID = " + TCH_ID + " AND T_ComType = 2";

        DataTable result = clsGetData.GetTable(sql);

        return result;
    }

    [WebMethod]
    public DataTable InitClosedhandles(String buildID)
    {
        ClsGetData clsGetData = new ClsGetData("System.Data.SqlClient", conStr);

        String sql = "Select * FROM T_Closedhandles WHERE  TMB_ID =" + buildID;

        DataTable result = clsGetData.GetTable(sql);

        return result;
    }

    [WebMethod]
    public DataTable InitClosedhandlesPIC(String T_ClosedhandlesID)
    {
        ClsGetData clsGetData = new ClsGetData("System.Data.SqlClient", conStr);

        String sql = "Select * FROM T_ClosedhandlesPic Where T_ClosedhandlesID = " + T_ClosedhandlesID;

        DataTable result = clsGetData.GetTable(sql);

        return result;
    }
    
    [WebMethod]
    public DataTable InitTraffic(String TMB_ID)
    {
        ClsGetData clsGetData = new ClsGetData("System.Data.SqlClient", conStr);

        String sql = "Select * FROM T_Traffic "
                     + "LEFT JOIN T_TrafficPic ON T_Traffic.T_TrafficID = T_TrafficPic.T_TrafficID "
                     + "WHERE T_TrafficPic.TMB_ID = " + TMB_ID;

        DataTable result = clsGetData.GetTable(sql);

        return result;
    }
    
    [WebMethod]
    public DataTable InitHazard(String TMB_ID)
    {
        ClsGetData clsGetData = new ClsGetData("System.Data.SqlClient", conStr);

        String sql = "Select * FROM T_Hazard "
                     + "LEFT JOIN T_HazardPic ON T_Hazard.T_HazardID = T_HazardPic.T_HazardID "
                     + "WHERE T_Hazard.TMB_ID = " + TMB_ID;

        DataTable result = clsGetData.GetTable(sql);

        return result;
    }

    [WebMethod]
    public DataTable InitKeyUnits(String TMB_ID)
    {
        ClsGetData clsGetData = new ClsGetData("System.Data.SqlClient", conStr);

        String sql = " Select * FROM T_KeyUnits "
                    + "LEFT JOIN T_KeyUnitsPic ON T_KeyUnits.T_KeyUnitsID = T_KeyUnitsPic.T_KeyUnitsID "
                    + "WHERE T_KeyUnits.TMB_ID = " + TMB_ID;

        DataTable result = clsGetData.GetTable(sql);

        return result;
    }
    
    [WebMethod]
    public DataTable InitScenting(String TMB_ID)
    {
        ClsGetData clsGetData = new ClsGetData("System.Data.SqlClient", conStr);

        String sql = "Select * FROM T_Scenting "
                     + "LEFT JOIN T_ScentingImg ON T_Scenting.T_ScentingID = T_ScentingImg.T_ScentingID "
                     + "WHERE T_Scenting.TMB_ID = " + TMB_ID;

        DataTable scenting = clsGetData.GetTable(sql);

        sql = "Select * FROM T_ScentingImg "
                    + "WHERE TMB_ID = " + TMB_ID;

        DataTable img = clsGetData.GetTable(sql);

        foreach (DataRow k in img.Rows)
        {
            var s = k["T_ScentingimgOwen"].ToString().Split(',');
            foreach (var i in s)
            {
                foreach(var j in scenting.Select("T_ScentingID = " + i))
                {
                    j["T_ScentingImgName"] = k["T_ScentingImgName"];
                    j["T_ScentingimgPath"] = k["T_ScentingimgPath"];
                }
            }
        }

        return scenting;
    }
    
    [WebMethod]
    public DataTable InitTatics(String TMB_ID)
    {
        ClsGetData clsGetData = new ClsGetData("System.Data.SqlClient", conStr);

        String sql = "Select * FROM T_TacticalPoints WHERE TMB_ID = " + TMB_ID;

        DataTable result = clsGetData.GetTable(sql);

        return result;
    }

    [WebMethod]
    public DataTable InitFloor(String buildID)
    {
        ClsGetData clsGetData = new ClsGetData("System.Data.SqlClient", conStr);

        DataTable result = clsGetData.GetTable("SELECT T_Floor.T_FloorID,T_FloorName,T_FloorPicPath,T_FloorScale,T_FloorX,T_FloorY,T_FloorXRotation,T_FloorYRotation,T_FloorZRotation,T_FloorAlpha FROM T_Floor LEFT JOIN T_FloorPos ON T_Floor.T_FloorID = T_FloorPos.T_FloorID AND T_Floor.TMB_ID = T_FloorPos.TMB_ID WHERE T_Floor.TMB_ID = " + buildID + " ORDER BY T_Floor.T_Floorsque DESC");

        return result;
    }

    [WebMethod]
    public DataTable SaveFloor(String buildID, String data)
    {
        ClsGetData clsGetData = new ClsGetData("System.Data.SqlClient", conStr);

        String sql = "";

        foreach (String dataFloor in data.Split('@'))
        {
            String[] floorPos = dataFloor.Split(';');
            if (floorPos[0] != "")
            {
                sql += "DELETE FROM T_FloorPos WHERE TMB_ID = " + buildID + " AND T_FloorID = " + floorPos[0] + ";";
                sql += "INSERT T_FloorPos (TMB_ID,T_FloorID,T_FloorScale,T_FloorX,T_FloorY,T_FloorXRotation,T_FloorYRotation,T_FloorZRotation,T_FloorAlpha) VALUES (" + buildID + "," + floorPos[0] + "," + floorPos[1] + "," + floorPos[2] + "," + floorPos[3] + "," + floorPos[4] + "," + floorPos[5] + "," + floorPos[6] + "," + floorPos[7] + ");";
            }
        }

        DataTable result = clsGetData.ExcuteNoQuery(sql);

        return result;
    }

    [WebMethod]
    public DataTable InitComponent(String buildID, String floorID)
    {
        ClsGetData clsGetData = new ClsGetData("System.Data.SqlClient", conStr);

        DataTable result = clsGetData.GetTable("SELECT T_FloorDetail.T_FloorID,T_FloorDetailchildfloor,T_FloorDetailID,T_FloorDetailName,T_FloorPicimgPath,T_FloorDetailX,T_FloorDetailY,T_FloorDetailType FROM T_FloorDetail,T_FloorPic WHERE T_FloorDetail.TMB_ID = " + buildID + " AND T_FloorDetail.T_FloorPicID = T_FloorPic.T_FloorPicID ORDER BY T_FloorDetailID DESC");

        for (int i = result.Rows.Count - 1; i >= 0; i--)
        {
            DataRow row = result.Rows[i];
            String T_FloorID = row["T_FloorID"].ToString();
            if (floorID != T_FloorID)
            {
                Boolean b = false;

                String[] childfloors = row["T_FloorDetailchildfloor"].ToString().Split(',');
                foreach (String childfloor in childfloors)
                {
                    if (floorID == childfloor)
                    {
                        b = true;
                        break;
                    }
                }

                if (!b)
                    result.Rows.Remove(row);
            }
        }

        return result;
    }

    [WebMethod]
    public DataTable InitComponentMedia(String componentID)
    {
        ClsGetData clsGetData = new ClsGetData("System.Data.SqlClient", conStr);

        DataTable result = clsGetData.GetTable("SELECT * FROM T_FloorMedia WHERE T_FloorDetailID = " + componentID);

        return result;
    }
}
