using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Data.Common;

/// <summary>
/// 类：访问数据库
/// </summary>
public class ClsGetData
{
    private string _factoryType = "System.Data.OracleClient";
    private string _connectionString;

    private string _errorString = "";
    public string ErrorString
    {
        get { return _errorString; }
    }
    
    public DataTable ErrorTable
    {
        get
        {
            DataTable dataTable = new DataTable("Error");
            DataColumn column = new DataColumn("ErrorInfo", Type.GetType("System.String"));
            dataTable.Columns.Add(column);

            DataRow row = dataTable.NewRow();
            row["ErrorInfo"] = _errorString;
            dataTable.Rows.Add(row);

            return dataTable;
        }
    }

    public DataTable CountTable(int count)
    {
        DataTable dataTable = new DataTable("Count");
        DataColumn column = new DataColumn("Count", Type.GetType("System.Int32"));
        dataTable.Columns.Add(column);
        
        DataRow row = dataTable.NewRow();
        row["Count"] = count;
        dataTable.Rows.Add(row);

        return dataTable;
    }

    public ClsGetData()
    {
        _connectionString = "USER ID=" + System.Configuration.ConfigurationManager.AppSettings["GISDB_USER"]
                            + ";PASSWORD=" + System.Configuration.ConfigurationManager.AppSettings["GISDB_PASS"]
                            +";DATA SOURCE=(DESCRIPTION =(ADDRESS_LIST =(ADDRESS = (PROTOCOL = TCP)(HOST = "
                            + System.Configuration.ConfigurationManager.AppSettings["GISDB_SERVER"]
                            +")(PORT = 1521)))(CONNECT_DATA =(SERVICE_NAME = "
                            + System.Configuration.ConfigurationManager.AppSettings["GISDB_SERVICE"] + ")))";
    }

    public ClsGetData(string connectionString)
	{
        _connectionString = connectionString;
	}

    public ClsGetData(string factoryType, string connectionString)
    {
        _connectionString = connectionString;
        _factoryType = factoryType;
    }

    public DataTable GetTable(string selectsql)
    {
        DbProviderFactory dbProviderFactory = DbProviderFactories.GetFactory(_factoryType);
        IDbConnection dbConnection = dbProviderFactory.CreateConnection();
        dbConnection.ConnectionString = _connectionString;

        IDbCommand dbCommand = dbProviderFactory.CreateCommand();
        dbCommand.CommandText = selectsql;
        dbCommand.Connection = dbConnection;
        
        IDbDataAdapter dataAdapter = dbProviderFactory.CreateDataAdapter();
        dataAdapter.SelectCommand = dbCommand;
        
        DataSet dataSet = new DataSet();
        try
        {
            dataAdapter.Fill(dataSet);
        }
        catch (Exception errMsg)
        {
            _errorString = errMsg.Message;
            return ErrorTable;
        }
        if (dataSet.Tables.Count != 1)
            return ErrorTable;
        else
            return dataSet.Tables[0];
    }

    public object GetValue(string selectsql)
    {
        DbProviderFactory dbProviderFactory = DbProviderFactories.GetFactory(_factoryType);
        IDbConnection dbConnection = dbProviderFactory.CreateConnection();
        dbConnection.ConnectionString = _connectionString;

        IDbCommand dbCommand = dbProviderFactory.CreateCommand();
        dbCommand.CommandText = selectsql;
        dbCommand.Connection = dbConnection;

        object result;
        try
        {
            dbConnection.Open();
            result = dbCommand.ExecuteScalar();

        }
        catch (Exception errMsg)
        {
            _errorString = errMsg.Message;
            result = null;
        }

        if (dbConnection.State == ConnectionState.Open)
        {
            dbConnection.Close();
            dbConnection.Dispose();
        }

        return result;
    }

    public DataTable SetTable(string sql)
    {
        int iCount;

        DbProviderFactory dbProviderFactory = DbProviderFactories.GetFactory(_factoryType);
        IDbConnection dbConnection = dbProviderFactory.CreateConnection();
        dbConnection.ConnectionString = _connectionString;

        IDbCommand dbCommand = dbProviderFactory.CreateCommand();
        dbCommand.CommandText = sql;
        dbCommand.Connection = dbConnection;

        try
        {
            dbConnection.Open();
            iCount = dbCommand.ExecuteNonQuery();
        }
        catch (Exception errMsg)
        {
            _errorString = errMsg.Message;
            return ErrorTable;
            //iCount = 0;
        }

        if (dbConnection.State == ConnectionState.Open)
        {
            dbConnection.Close();
            dbConnection.Dispose();
        }

        return CountTable(iCount);
    }

    public DataTable ExcuteNoQuery(string sql)
    {
        string[] sqls = sql.Split(';');

        DbProviderFactory dbProviderFactory = DbProviderFactories.GetFactory(_factoryType);
        IDbConnection dbConnection = dbProviderFactory.CreateConnection();
        dbConnection.ConnectionString = _connectionString;

        IDbTransaction dbTrans = null;
        int iCount = 0;
        try
        {
            dbConnection.Open();

            dbTrans = dbConnection.BeginTransaction();

            foreach (string p in sqls)
            {
                if (p != "")
                {
                    IDbCommand dbCommand = dbProviderFactory.CreateCommand();
                    dbCommand.CommandText = p;
                    dbCommand.Connection = dbConnection;
                    dbCommand.Transaction = dbTrans;
                    iCount += dbCommand.ExecuteNonQuery();
                }
            }

            dbTrans.Commit();
        }
        catch (Exception errMsg)
        {
            if (dbConnection.State == ConnectionState.Open)
                dbTrans.Rollback();

            _errorString = errMsg.Message;
            return ErrorTable;
            //iCount = 0;
        }

        if (dbConnection.State == ConnectionState.Open)
        {
            dbConnection.Close();
            dbConnection.Dispose();
        }

        return CountTable(iCount);
    }
}
