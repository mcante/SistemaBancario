
package utils;
import java.sql.*;


public class ConexionDB {
    
    public static Connection getConexion(){
        Connection con=null;
       try{
           Class.forName("oracle.jdbc.driver.OracleDriver");
           con=DriverManager.getConnection
           //("jdbc:oracle:thin:@localhost:1521:xe","USUARIOBD","160587");
           //aa78c123ae
           //("jdbc:oracle:thin:@localhost:1521:xe","mrcante","160587");
           //("jdbc:oracle:thin:@localhost:1521:xe","USUARIOBD","160587");
           ("jdbc:oracle:thin:@192.168.1.3:1521:BD","USUARIOBD","USUARIOBD");
           System.out.println("Conexion Satisfactoria");
       }catch(Exception e){
           System.out.println("Error: "+e);
       }
       return con;
    }
    
    
    public static void main(String[] args) {
        ConexionDB.getConexion();
    }
    
}
