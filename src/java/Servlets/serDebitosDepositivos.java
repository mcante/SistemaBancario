
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.ConexionDB;

import Servlets.serDebitosDepositivos;
import beans.EstadoCuenta;
import java.sql.Date;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

/**
 *
 * @author MrCante
 */
@WebServlet(name = "serDebitosDepositivos", urlPatterns = {"/serDebitosDepositivos"})
public class serDebitosDepositivos extends HttpServlet {

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
        
        //****************************  CREAR NUEVO   *********************************
        if(accion.equals("TransferenciaAB")) {

            Connection cnx=ConexionDB.getConexion();
            
            String Origen=request.getParameter("txtOrigen");
            String Destino=request.getParameter("txtDestino");
            String Monto=request.getParameter("txtMonto");
            
            try {
                CallableStatement TransferirAB = cnx.prepareCall("{call TRANSFERENCIA(?,?,?)}");
                
                TransferirAB.setString(1, Origen);
                TransferirAB.setString(2, Destino);
                TransferirAB.setDouble(3, Double.parseDouble(Monto));
                                
                TransferirAB.execute();
                TransferirAB.close();

                request.getRequestDispatcher("serClientesFull?accion=listar").forward(request, response);
                
                System.out.println("Listo, TransferenciaAB");
                cnx.close();

            } catch (Exception e) {
            }
            
            
            
        //****************************  DÉBITO MONETARIO   *********************************
        }else if(accion.equals("debito_monetario")) {

            Connection cnx=ConexionDB.getConexion();
            
            String Monto=request.getParameter("txtMonto");
            String Origen=request.getParameter("txtOrigen");
            String Cheque=request.getParameter("txtCheque");
            
            try {
                CallableStatement debitoMonetario = cnx.prepareCall("{call DEBITO_MONETARIA(?,?,?)}");
                
                debitoMonetario.setDouble(1, Double.parseDouble(Monto));
                debitoMonetario.setString(2, Origen);                
                debitoMonetario.setInt(3, Integer.parseInt(Cheque));
                
                debitoMonetario.execute();
                debitoMonetario.close();

                request.getRequestDispatcher("serClientesFull?accion=listar").forward(request, response);
                
                System.out.println("Listo, Debito Monetario");
                cnx.close();

            } catch (Exception e) {
            }
            
            
            
            
        //****************************  DÉBITO AHORRO   *********************************
        }else if(accion.equals("debito_ahorro")) {

            Connection cnx=ConexionDB.getConexion();
            
            String Monto=request.getParameter("txtMonto");
            String Origen=request.getParameter("txtOrigen");
            String Libreta=request.getParameter("txtLibreta");
            
            try {
                CallableStatement debitoAhorro = cnx.prepareCall("{call DEBITO_AHORRO(?,?,?)}");
                
                debitoAhorro.setDouble(1, Double.parseDouble(Monto));
                debitoAhorro.setString(2, Origen);
                debitoAhorro.setInt(3, Integer.parseInt(Libreta));      
                
                debitoAhorro.execute();
                debitoAhorro.close();

                request.getRequestDispatcher("serClientesFull?accion=listar").forward(request, response);
                
                System.out.println("Listo, Debito Ahorro");
                cnx.close();

            } catch (Exception e) {
            }
        
            
            //****************************  DEPÓSITO AHORRO   *********************************
        }else if(accion.equals("deposito_ahorro")) {

            Connection cnx=ConexionDB.getConexion();
            
            String Monto=request.getParameter("txtMonto");
            String Origen=request.getParameter("txtOrigen");
            String Libreta=request.getParameter("txtLibreta");
            
            try {
                CallableStatement depositoAhorro = cnx.prepareCall("{call DEPOSITO_AHORRO(?,?,?)}");
                
                depositoAhorro.setDouble(1, Double.parseDouble(Monto));
                depositoAhorro.setString(2, Origen);
                depositoAhorro.setInt(3, Integer.parseInt(Libreta));      
                
                depositoAhorro.execute();
                depositoAhorro.close();

                request.getRequestDispatcher("serClientesFull?accion=listar").forward(request, response);
                
                System.out.println("Listo, Deposito Ahorro");
                cnx.close();

            } catch (Exception e) {
            }
        
            
        //****************************  DEPOSITO_MONETARIA_EFECTIVO   *********************************
        }else if(accion.equals("deposito_monetario")) {

            Connection cnx=ConexionDB.getConexion();
            
            String Monto=request.getParameter("txtMonto");
            String Origen=request.getParameter("txtOrigen");
            
            try {
                CallableStatement depositoAhorro = cnx.prepareCall("{call DEPOSITO_MONETARIA_EFECTIVO(?,?)}");
                
                depositoAhorro.setDouble(1, Double.parseDouble(Monto));
                depositoAhorro.setString(2, Origen);   
                
                depositoAhorro.execute();
                depositoAhorro.close();

                request.getRequestDispatcher("serClientesFull?accion=listar").forward(request, response);
                
                System.out.println("Listo, Deposito Monetario");
                cnx.close();

            } catch (Exception e) {
            }
            
            
        //****************************  OPERACIONES   *********************************
        }else if(accion.equals("operaciones")) {

            try {
                Connection cnx=ConexionDB.getConexion();
                
                PreparedStatement sta = cnx.prepareStatement("SELECT * FROM ESTADO_CUENTA");
                ResultSet rs = sta.executeQuery();
                 
                ArrayList<EstadoCuenta> lista=new ArrayList<EstadoCuenta>();
                //13 datos
                while (rs.next()) {
                    EstadoCuenta o = new EstadoCuenta(rs.getString(1), rs.getString(2), rs.getString(3), 
                            rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9),
                            rs.getString(10) ,rs.getString(11), rs.getString(12), rs.getString(13));
                    lista.add(o);
                }
                 
                request.setAttribute("lista", lista);
                
                sta.close();
                
                System.out.println("Listo, Operaciones");
                
                request.getRequestDispatcher("operaciones.jsp").forward(request, response);
                cnx.close();

            } catch (Exception e) {
                System.out.print(e);
            }
            
        //****************************  CONSULTAR POR CUENTA, FECHA INICIO Y FECHA FINAL   *********************************
        }else if(accion.equals("consultar")) {
            
            String cuenta=request.getParameter("txtCuenta");
            String fechaInicio=request.getParameter("txtFechaInicio");
            String fechaFinal=request.getParameter("txtFechaFinal");
            
            SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
            
                
                System.out.println("Fecha Inicio: " + format.format(java.sql.Date.valueOf(fechaInicio)));
                System.out.println("Fecha Final: " + format.format(java.sql.Date.valueOf(fechaFinal)));
            
            try {
                Connection cnx=ConexionDB.getConexion();
                
                
                
                PreparedStatement sta = cnx.prepareStatement("SELECT * FROM ESTADO_CUENTA WHERE NO_CUENTA =? AND FECHA_HORA>=? AND FECHA_HORA <=?+1");
                sta.setString(1, cuenta);
                sta.setDate(2, java.sql.Date.valueOf(fechaInicio));
                sta.setDate(3, java.sql.Date.valueOf(fechaFinal));
                
                ResultSet rs = sta.executeQuery();
                 
                ArrayList<EstadoCuenta> lista=new ArrayList<EstadoCuenta>();
                
                while (rs.next()) {
                    EstadoCuenta o = new EstadoCuenta(rs.getString(1), rs.getString(2), rs.getString(3), 
                            rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9),
                            rs.getString(10) ,rs.getString(11), rs.getString(12), rs.getString(13));
                    lista.add(o);
                }
                 
                request.setAttribute("lista", lista);
                
                sta.close();
                
                System.out.println("Listo, CONSULTAR");
                
                request.getRequestDispatcher("operaciones.jsp").forward(request, response);
                
                
            } catch (Exception e) {
                System.out.print(e);
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
