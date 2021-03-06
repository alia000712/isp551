<%--
  Created by IntelliJ IDEA.
  User: ALIA
  Date: 27/1/2022
  Time: 3:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Sales</title>
    <style>
        .admin-sales{
            margin-left: 20%;
        }
        h1{
            font-size: 40px;
            font-family: "Inter", sans-serif;
        }
        hr{
            border: 1px solid honeydew;
            width: 70%;
            height: 8px;
            background: white;
            border-radius: 30px;
        }
        table{
            text-align: center;
            padding: 20px;
            width: 90%;
        }
        table tr, td{
            padding: 20px;
        }
        th{
            border-bottom: 3px solid white;
        }
    </style>
</head>
<body>
<%@include file="../../menuHtml/menuAdminSales.html"%>
<div class="admin-sales">
    <center>
        <br><br>
        <h1>MANAGE SALES</h1>
        <hr>
        <table>
            <tr>
                <th>ID</th>
                <th>PERSON IN CHARGE</th>
                <th>AMOUNT</th>
                <th>SALES DATE</th>
                <th>SALES WALKIN</th>
                <th>SALES BOOKING</th>
                <th>BRANCH ID</th>
                <th>ACTION</th>
            </tr>
            <%
                try
                {
                    Class.forName("org.postgresql.Driver"); // ni stay
                    String dbURL = "jdbc:postgresql://ec2-50-19-32-96.compute-1.amazonaws.com:5432/d65mb698aandvt"; //ni url dri heroku database
                    String user = "ffkacpfvbcmcwa"; //ni user dri heroku database
                    String pass = "3939ef811721250f3db1595eb911cfcbac4e294a582158f13f9ef08dc63786bf"; //ni password dri heroku database
                    Connection conn = DriverManager.getConnection(dbURL, user, pass);

                    String sql  ="SELECT s.salesid,s.salesamount,s.salesdate," +
                            "s.saleswalkin,s.salesbooking,s.branchid,s.adminid,s.workerid," +
                            "b.branchname FROM SALES s join branch b " +
                            "on (s.branchid=b.branchid) order by s.salesid";

                    if (conn != null)
                    {
                        DatabaseMetaData dm = conn.getMetaData();
                        System.out.println("Driver name: " + dm.getDriverName());
                        System.out.println("Driver version: " + dm.getDriverVersion());
                        System.out.println("Product Name: " + dm.getDatabaseProductName());
                        System.out.println("Product version: " + dm.getDatabaseProductVersion());


                        Statement statement = conn.createStatement();
                        ResultSet res = statement.executeQuery(sql);

                        while (res.next())
                        {

            %>
            <tr>
                <td><%=res.getInt("salesid")%></td>
                <%
                    if(res.getInt("adminid")==1)
                    {
                %>
                <td><%=res.getInt("adminid")%></td>
                <%
                    }
                    else
                    {
                %>
                <td><%=res.getInt("workerid")%></td>
                <%
                    }
                %>

                <td><%=res.getDouble("salesamount")%></td>
                <td><%=res.getDate("salesdate")%></td>
                <td><%=res.getDouble("saleswalkin")%></td>
                <td><%=res.getDouble("salesbooking")%></td>
                <td><%=res.getString("branchid")%></td>

                <form action="" method="post">
                    <input type="hidden" name="salesid" value="<%=res.getInt("salesid")%>">
                    <input type="hidden" name="salesamount" value="<%=res.getDouble("salesamount")%>">
                    <input type="hidden" name="salesdate" value="<%=res.getDate("salesdate")%>">
                    <input type="hidden" name="saleswalkin" value="<%=res.getDouble("saleswalkin")%>">
                    <input type="hidden" name="salesbooking" value="<%=res.getDouble("salesbooking")%>">
                    <input type="hidden" name="branchid" value="<%=res.getString("branchid")%>">
                    <input type="hidden" name="branchname" value="<%=res.getString("branchname")%>">
                    <input type="hidden" name="adminid" value="<%=res.getInt("adminid")%>">
                    <input type="hidden" name="workerid" value="<%=res.getInt("workerid")%>">
                    <input type="hidden" name="action" value="viewsalesadmin">
                    <td><button type="submit" name="submit" onclick="form.action='../../SalesServlet'" >EDIT</button></td>
                </form>
            </tr>
            <%
                        }
                    }
                }
                catch (Exception e) {e.printStackTrace();}
            %>
        </table>
    </center>
</div>
</body>
</html>
