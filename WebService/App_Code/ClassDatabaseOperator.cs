using System;
using System.Data;

using System.Data.Common;
using System.IO;

/// <summary>
/// 类：访问数据库
/// </summary>
public class ClassDatabaseOperator
{
    private readonly DbProviderFactory _dbProviderFactory;

    private readonly DbConnection _dbConnection;

    public ClassDatabaseOperator(string factoryType, string connectionString)
    {
        _dbProviderFactory = DbProviderFactories.GetFactory(factoryType);

        _dbConnection = _dbProviderFactory.CreateConnection();

// ReSharper disable PossibleNullReferenceException
        _dbConnection.ConnectionString = connectionString;
// ReSharper restore PossibleNullReferenceException
    }

    private static void WriteLog(Exception ex,string sql)
    {
        var path = System.Configuration.ConfigurationManager.AppSettings["LOG"];

        if (Directory.Exists(path))
        {
            var file = path + @"\" + DateTime.Today.ToString("yyyy-MM-dd") + ".txt";
            TextWriter tw = File.AppendText(file);
            var msg = DateTime.Now.ToString("HH:mm:ss") + " SQL:" + sql + " EX:" + ex.Message;
            tw.WriteLine(msg);
            tw.Close();
            tw.Dispose();
        }
    }
       
    public DataTable GetTable(string sql)
    {
        DataTable dt;
        try
        {
            var dbCommand = _dbConnection.CreateCommand();
            dbCommand.CommandText = sql;
           
            var dataAdapter = _dbProviderFactory.CreateDataAdapter();
    // ReSharper disable PossibleNullReferenceException
            dataAdapter.SelectCommand = dbCommand;
    // ReSharper restore PossibleNullReferenceException

            var ds = new DataSet();
            dataAdapter.Fill(ds);
            dt = ds.Tables[0];
        }
        catch(Exception ex)
        {
            WriteLog(ex, sql);
            throw;
        }

        return dt;
    }

    public object GetValue(string sql)
    {
        object scalar;
        try
        {
            _dbConnection.Open();

            var dbCommand = _dbConnection.CreateCommand();

            dbCommand.CommandText = sql;

            scalar = dbCommand.ExecuteScalar();
        }
        catch (Exception ex)
        {
            WriteLog(ex, sql);

            if ((_dbConnection != null) && (_dbConnection.State == ConnectionState.Open))
                _dbConnection.Close();
                       
            throw;
        }

        if ((_dbConnection!= null) && (_dbConnection.State == ConnectionState.Open))
            _dbConnection.Close();

        return scalar;
    }

    public int SetTable(string sql)
    {
        int count;

        try
        {
            _dbConnection.Open();

            var dbCommand = _dbConnection.CreateCommand();

            dbCommand.CommandText = sql;

            count = dbCommand.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            WriteLog(ex, sql);

            if ((_dbConnection != null) && (_dbConnection.State == ConnectionState.Open))
                _dbConnection.Close();

            throw;
        }

        if ((_dbConnection != null) && (_dbConnection.State == ConnectionState.Open))
            _dbConnection.Close();

        return count;
    }

    public int ExcuteNoQuery(string sql)
    {
        DbTransaction dbTrans = null;

        var sqls = sql.Split(';');
               
        var count = 0;

        try
        {
            _dbConnection.Open();

            dbTrans = _dbConnection.BeginTransaction();

            foreach (var p in sqls)
            {
                if (p == "") continue;

                var dbCommand = _dbConnection.CreateCommand();
                dbCommand.CommandText = p;
                dbCommand.Transaction = dbTrans;
                count += dbCommand.ExecuteNonQuery();
            }

            dbTrans.Commit();
        }
        catch (Exception ex)
        {
            WriteLog(ex, sql);

            if ((dbTrans != null) && (_dbConnection.State == ConnectionState.Open))
                dbTrans.Rollback();

            if ((_dbConnection != null) && (_dbConnection.State == ConnectionState.Open))
                _dbConnection.Close();

            throw;
        }

        if ((_dbConnection != null) && (_dbConnection.State == ConnectionState.Open))
            _dbConnection.Close();

        return count;
    }
}
