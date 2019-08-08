<%@page session="true"%>
        
/*index.jsp == login.jsp*/

<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="Melvin Canté">
        
        <title>Sistema Bancario UMG</title>
    </head>
    <body>
        <h1 align="center">USUARIOS DEL SISTEMA</h1>
        <table border="1" width="600" align="center">
            <tr bgcolor="skyblue">
                <th>Estado</th>
                <th>Usuario</th>
                <th>Contraseña</th>
            </tr>
        
        <%
            /*VARIABLES PARA LA CONEXIÓN*/
            Connection con = null;
            Statement sta = null;
            ResultSet rs = null;
            
            try {
                    /*CADENA DE CONEXIÓN*/
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","mrcante","160587");
                    
                    /*EJECUTAR UNA CONSULTA*/
                    sta=con.createStatement();
                    rs=sta.executeQuery("select * from empleado");
                    
                    while (rs.next()){
                        %>
                        <tr>
                            <th><%=rs.getString(5)%></th>
                            <th><%=rs.getString(6)%></th>
                            <th><%=rs.getString(7)%></th>
                        </tr>
                        
                        <%
                    }
                    
                    sta.close();
                    rs.close();
                    con.close();

                    
                } catch (Exception e) {
                    out.println("Error: " + e);
                }
        %>
        </table>
    </body>
</html>
