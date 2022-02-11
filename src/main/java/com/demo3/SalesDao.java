package com.demo3;

import java.sql.*;

import static java.lang.System.out;

public class SalesDao
{
    String dbURL = "jdbc:postgresql://ec2-50-19-32-96.compute-1.amazonaws.com:5432/d65mb698aandvt"; //ni url dri heroku database
    String user = "ffkacpfvbcmcwa";
    String pass = "3939ef811721250f3db1595eb911cfcbac4e294a582158f13f9ef08dc63786bf";

    protected Connection getConnection()
    {
        Connection connection = null;
        try
        {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(dbURL, user, pass);
        }
        catch (SQLException e) {e.printStackTrace();}
        catch (ClassNotFoundException e) {e.printStackTrace();}
        return connection;
    }

    public void addSales(sales sl) throws SQLException
    {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement("insert into sales (salesamount,salesdate,saleswalkin,salesbooking,branchid) values(?,?,?,?,?)");)
        {
            preparedStatement.setDouble(1, sl.getSalesAmount());
            preparedStatement.setString(2, sl.getSalesDate());
            preparedStatement.setDouble(3, sl.getSalesWalkin());
            preparedStatement.setDouble(4, sl.getSalesBooking());
            preparedStatement.setString(5, sl.getBranchID());
            out.println(preparedStatement);
            preparedStatement.executeUpdate();

        }
        catch (SQLException e) {printSQLException(e);}
    }

    public boolean updateSales(sales sl) throws SQLException
    {
        boolean rowUpdated;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement("UPDATE sales set salesamount=?,salesdate=?,saleswalkin=?, salesbooking=?,branchid=? where salesid=?");)
        {
            statement.setDouble(1, sl.getSalesAmount());
            statement.setString(2, sl.getSalesDate());
            statement.setDouble(3, sl.getSalesWalkin());
            statement.setDouble(4, sl.getSalesBooking());
            statement.setString(5, sl.getBranchID());
            statement.setInt(6, sl.getSalesID());

            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    private void printSQLException(SQLException ex)
    {
        for (Throwable e : ex)
        {
            if (e instanceof SQLException)
            {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null)
                {
                    out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
