

package Servlets;

import beans.Cliente;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.ConexionDB;
import java.sql.CallableStatement;
import java.sql.Statement;

/**
 *
 * @author MrCante
 */
@WebServlet(name = "serClientes", urlPatterns = {"/serClientes"})
public class serClientes extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        
        String accion=request.getParameter("accion");
        
        
        
        Connection cnx=ConexionDB.getConexion();
        
        
        
        //****************************  LISTAR   *********************************
        if (accion.equals("listar")) {           
            
            try {
                
                PreparedStatement sta = cnx.prepareStatement("select * from persona");
                ResultSet rs = sta.executeQuery();
                 
                ArrayList<Cliente> lista=new ArrayList<Cliente>();
                
                while (rs.next()) {
                    Cliente c=new Cliente(rs.getString(1), rs.getString(2), rs.getString(3), 
                            rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7));
                    lista.add(c);
                }
                 
                request.setAttribute("lista", lista);
                
                sta.close();
                
                System.out.println("Listo, LISTAR TODO");
                
                request.getRequestDispatcher("clientes_listar.jsp").forward(request, response);
                

            } catch (Exception e) {
                System.out.print(e);
            }
            
            
        //****************************  CONSULTAR POR DPI   *********************************
        }else if(accion.equals("consultar")) {
            
            String dpi=request.getParameter("txtDpi");
            
            
            try {
                
                PreparedStatement sta = cnx.prepareStatement("select * from persona where dpi=?");
                sta.setString(1, dpi);
                ResultSet rs = sta.executeQuery();
                 
                ArrayList<Cliente> lista=new ArrayList<Cliente>();
                
                while (rs.next()) {
                    Cliente c=new Cliente(rs.getString(1), rs.getString(2), rs.getString(3), 
                            rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7));
                    lista.add(c);
                }
                 
                request.setAttribute("lista", lista);
                
                sta.close();
                
                System.out.println("Listo, CONSULTAR");
                
                request.getRequestDispatcher("clientes_listar.jsp").forward(request, response);
                
                
            } catch (Exception e) {
                System.out.print(e);
            }
            
            
        //****************************  CREAR NUEVO   *********************************
        }else if(accion.equals("insertar")) {
            
            String dpi=request.getParameter("txtDpi");
            String nit=request.getParameter("txtNit");
            String nombre=request.getParameter("txtNombre");
            String apellido=request.getParameter("txtApellido");
            String telefono=request.getParameter("txtTel");
            String fechaNac=request.getParameter("txtFechaNac");
            String direccion=request.getParameter("txtDireccion");
            
            
            
            try {
                PreparedStatement sta=cnx.prepareStatement("INSERT INTO PERSONA VALUES (?,?,?,?,?,?,?)");
                sta.setString(1, dpi);
                sta.setString(2, nit);
                sta.setString(3, nombre);
                sta.setString(4, apellido);
                sta.setString(5, fechaNac);
                sta.setString(6, telefono);
                sta.setString(7, direccion);
                                
                sta.executeUpdate();
                sta.close();

                request.getRequestDispatcher("serClientes?accion=listar").forward(request, response);
                
                System.out.println("Listo, INSERT");

            } catch (Exception e) {
            }
            
            
        //****************************  PASAR LOS DATOS AL FORMULARIO PARA ACTUALIZAR   *********************************
        }else if(accion.equals("Editar")) {
            
            String dpi=request.getParameter("txtDpi");
            
            
            try {
                
                PreparedStatement sta = cnx.prepareStatement("select * from persona where dpi=?");
                sta.setString(1, dpi);
                ResultSet rs = sta.executeQuery();
                 
                ArrayList<String> lista=new ArrayList<String>();
                rs.next();
                lista.add(rs.getString(1));
                lista.add(rs.getString(2));
                lista.add(rs.getString(3));
                lista.add(rs.getString(4));
                lista.add(rs.getString(5));
                lista.add(rs.getString(6));
                lista.add(rs.getString(7));
                
                request.setAttribute("lista", lista);
                sta.close();
                
                request.getRequestDispatcher("cliente_update.jsp").forward(request, response);
                
                System.out.println("Listo, LISTAR DATOS DE USUARIO");

            } catch (Exception e) {
                System.out.print(e);
            }

            
        //****************************  UPDATE DATOS DE USUARIO   *********************************
        }else if(accion.equals("Update")) {
            
            String dpi=request.getParameter("txtDpi");
            String nit=request.getParameter("txtNit");
            String nombre=request.getParameter("txtNombre");
            String apellido=request.getParameter("txtApellido");
            String telefono=request.getParameter("txtTel");
            String fechaNac=request.getParameter("txtFechaNac");
            String direccion=request.getParameter("txtDireccion");
            
            System.out.println("dpi " + dpi);
            System.out.println("nit " + nit);
            System.out.println("nombre " + nombre);
            System.out.println("apellido " + apellido);
            System.out.println("telefono " + telefono);
            System.out.println("fecha nac " + fechaNac);
            System.out.println("direccion " + direccion);

            try {
                String query ="update persona set nit='" + nit + "', nombre='"+ nombre +"', apellido='"+ apellido +"', "
                        + "fecha_nacimiento='"+ fechaNac +"', no_telefono='"+ telefono +"', direccion='"+ direccion +"' WHERE dpi='"+ dpi +"'";
                Statement sta=cnx.createStatement();

                System.out.println("Query " + query);
                
                int executeUpdate = sta.executeUpdate(query);
                System.out.println("Estado " + executeUpdate);
                sta.close();
                
                System.out.println("Listo, UPDATE");

                request.getRequestDispatcher("serClientes?accion=listar").forward(request, response);
                
            } catch (Exception e) {
            }
            
            
        }
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
