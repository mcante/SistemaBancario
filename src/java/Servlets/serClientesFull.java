/*
 * Melvin Randolfo Canté Guerra
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import beans.ClienteFull;
import java.io.IOException;
import java.io.PrintWriter;
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

/**
 *
 * @author MrCante
 */
@WebServlet(name = "serClientesFull", urlPatterns = {"/serClientesFull"})
public class serClientesFull extends HttpServlet {

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
        
        
        
        //****************************  LISTAR   *********************************
        if (accion.equals("listar")) {           
            
            try {
                Connection cnx=ConexionDB.getConexion();
                
                PreparedStatement sta = cnx.prepareStatement("select * from LISTA_CLIENTES");
                ResultSet rs = sta.executeQuery();
                 
                ArrayList<ClienteFull> lista=new ArrayList<ClienteFull>();
                //13 datos
                while (rs.next()) {
                    ClienteFull c=new ClienteFull(rs.getString(1), rs.getString(2), rs.getString(3), 
                            rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9),
                            rs.getString(10) ,rs.getString(11), rs.getString(12), rs.getString(13));
                    lista.add(c);
                }
                 
                request.setAttribute("lista", lista);
                
                sta.close();
                
                System.out.println("Listo, LISTAR TODO");
                
                request.getRequestDispatcher("clientes_list_full.jsp").forward(request, response);
                cnx.close();

            } catch (Exception e) {
                System.out.print(e);
            }
            
            
        
        //****************************  CREAR NUEVO   *********************************
        }else if(accion.equals("InsertarCliente")) {

            Connection cnx=ConexionDB.getConexion();
            
            String dpi=request.getParameter("txtDpi");
            String patente=request.getParameter("txtPatente");
            String fechaReg=request.getParameter("txtFechaReg");
            
            try {
                PreparedStatement sta=cnx.prepareStatement("INSERT INTO CLIENTE (DPI, ID_PATENTE, FECHA_REGISTRO) VALUES (?,?,?)");
                sta.setString(1, dpi);
                sta.setString(2, patente);
                sta.setString(3, fechaReg);
                                
                sta.executeUpdate();
                sta.close();

                request.getRequestDispatcher("serClientesFull?accion=listar").forward(request, response);
                
                System.out.println("Listo, INSERT CLIENTE");
                cnx.close();

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
