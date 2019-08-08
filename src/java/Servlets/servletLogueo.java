/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.*;
import utils.ConexionDB;
import javax.servlet.http.HttpSession;

/**
 *
 * @author SENIOR
 */
@WebServlet(name = "servletLogueo", urlPatterns = {"/servletLogueo"})
public class servletLogueo extends HttpServlet {

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
        
        String usuario=request.getParameter("TxtUsuario");
        String password=request.getParameter("TxtPassword");
        String nom="";
        
        Connection cnx=ConexionDB.getConexion();
                
        try{
            PreparedStatement sta=cnx.prepareStatement
                    ("select * from logueo where USUARIO=? and PASSWORD=? AND ACTIVO=?");
            sta.setString(1, usuario);
            sta.setString(2, password);
            sta.setString(3, "S");
            ResultSet rs=sta.executeQuery();
            
            if(rs.next()){
                HttpSession sesionOK=request.getSession();
                sesionOK.setAttribute("usuario", usuario);
                sesionOK.setAttribute("nombre", rs.getString(1));
                sesionOK.setAttribute("apellido", rs.getString(2));
                sesionOK.setAttribute("rol", rs.getString(6));
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }else{
                request.setAttribute("msg", "Error de Usuario o Contraseña, también verifique que el usuario esté activo");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            
        }catch(Exception e){System.out.print(e);}
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
