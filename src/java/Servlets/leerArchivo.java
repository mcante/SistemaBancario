package Servlets;


import beans.ErroresPlanilla;
import java.io.FileWriter;

import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.CallableStatement;
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
@WebServlet(urlPatterns = {"/leerArchivo"})
public class leerArchivo extends HttpServlet {
    
    public String[][] cuentas = new String[100][2]; //MATRIZ PARA GUARDAR CUENTA Y MONTO
    public int planilla = 0;
    public double montoTotal =0.00;
    public String ctaOrigen = "";

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet leerArchivo</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet leerArchivo at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        
        String contentType = request.getContentType();
        
        
        if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
            DataInputStream in = new DataInputStream(request.getInputStream());
                       
            
            /**
             * Obtenermos la longitud y el contenido del tipo de datos (Content type)
             */
            int formDataLength = request.getContentLength(); //Longitud de datos desde el formulario
            byte dataBytes[] = new byte[formDataLength]; //Guardar los bytes obtenidos
            int byteRead = 0; //Contador
            int totalBytesRead = 0; //Contador
            
            
            /**
             * Convertir el archivo cargado a bytes
             */
            while (totalBytesRead < formDataLength) {
                byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
                totalBytesRead += byteRead;
            }
                        
            String file = new String(dataBytes); //Convertir los bytes leidos a cadena
            //System.out.println("Request: " + file);
            String contenido = file.substring(file.indexOf("text/plain") + 12); //Obtener el contenido sin cabeceras
            String[] lineas = contenido.split("\n"); //Quitar los saltos de linea y guardar los contenidos en un arreglo
            
            //String cuenta = file.substring(file.indexOf("origen") + 15, file.indexOf("origen") + 18); //Obtener el contenido sin cabeceras
            //System.out.println("Origen: " + cuenta);
            
            //INICIA EN 1 PARA NO LEER EL ENCABEZADO DEL TXT Y TERMINA EN -1 
            //PARA NO VER EL PIE DE PÁGINA
            for (int i = 1; i < lineas.length-1; i++) { 
                //System.out.println(lineas[i]);
                String[] parts = lineas[i].split(","); //DIVIDE LA CADENA POR LA COMA, LADO IZQ ES LA CUENTA Y DERECHO ES EL MONTO
                cuentas[i-1][0] = parts[0].replace(" ", ""); //ELIMINA LOS ESPACIOS DE LA CUENTA Y SE ALMACENA EN LA MATRIZ CUENTAS
                cuentas[i-1][1] = parts[1].replace(" ", ""); //ELIMINA LOS ESPACIOS DEL MONTO Y SE ALMACENA EN LA MATRIZ CUENTAS

            }
            
            //MOSTRAR MATRIZ EN CONSOLA
            System.out.println("Cuenta Origen: " + cuentas[0][0]);
            ctaOrigen = cuentas[0][0];
            for (int i = 1; i < lineas.length-2; i++) {
                System.out.println("Destino: " + cuentas[i][0] + "  Monto: Q" + cuentas[i][1]);
            }
            
            
            //************ PRIMER INSERT EN PLANILLA ************//
            
            
            try {
                Connection cnx=ConexionDB.getConexion();
                
                java.util.Date utilDate = new java.util.Date();
                java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
                
                String fecha =  sqlDate.getDay() + "-" + sqlDate.getMonth() + "-" + sqlDate.getYear();
                //System.out.println("Cta Origen: " + ctaOrigen  + "  Fecha: " + fecha);

                // PASO 1 HACER EL INSERT A OPERACIÓN PLANILLA
                PreparedStatement sta=cnx.prepareStatement("INSERT INTO OPERACION_PLANILLA (NO_CUENTA_ORIGEN, FECHA_HORA_INICIO, FECHA_HORA_FIN, TOTAL_PAGADO, STATUS) VALUES (?,?,?,?,?)");
                sta.setString(1, ctaOrigen+"");
                sta.setString(2, fecha);
                sta.setString(3, fecha);
                sta.setString(4, "0.00");
                sta.setString(5, "EN PROCESO");

                sta.executeUpdate();
                
                
                // PASO 2 CONSULTAR EL ID DE OPERACIÓN PLANILLA ASIGNADO
                PreparedStatement sta2 = cnx.prepareStatement("SELECT MAX(ID_OPERACION_PLANILLA) FROM OPERACION_PLANILLA");
                ResultSet rs = sta2.executeQuery();
                
                rs.next();
                planilla = Integer.parseInt(rs.getString(1));
                System.out.println("ID planilla: " + planilla);
                
                
                // PASO 3
                //EJECUTAR LAS TRANSACCIONES, CUENTA POR CUENTA POR MEDIO DEL PROCEDIMIENTO DE ALMACENADO
                
                for (int i = 1; i < lineas.length-2; i++) {
                    //System.out.println("Destino: " + cuentas[i][0] + "  Monto: Q" + cuentas[i][1]);
                    
                    CallableStatement pagoPlanilla = cnx.prepareCall("{call TRANSFERENCIA_PLANILLA(?,?,?,?)}");
                    // cargar parametros al pP
                    pagoPlanilla.setInt(1, planilla);
                    pagoPlanilla.setString(2, ctaOrigen);
                    pagoPlanilla.setString(3, cuentas[i][0]);
                    pagoPlanilla.setDouble(4, Double.parseDouble(cuentas[i][1]));
    
                    // ejecutar el SP
                    pagoPlanilla.execute();
                    // confirmar si se ejecuto sin errores
                    cnx.commit();
                }
                                
                
                
                
                

            } catch (Exception e) {
            }

            
            
            // PASO 4
            // GENERAR EL REPORTE
            try {
                Connection cnx=ConexionDB.getConexion();

                PreparedStatement sta3 = cnx.prepareStatement("SELECT NO_OPERACION, ID_OPERACION_PLANILLA, NO_CUENTA_ORIGEN, NO_CUENTA_DESTINO, TIPO_OPERACION, STATUS, SALDO_INICIAL_ORIGEN, SALDO_FINAL_ORIGEN, SALDO_INICIAL_DESTINO, SALDO_FINAL_DESTINO, MONTO_TOTAL_OPERADO " +
                                                                "FROM OPERACION " +
                                                                "WHERE ID_OPERACION_PLANILLA=? AND NO_CUENTA_ORIGEN=?");
                sta3.setInt(1, planilla);
                sta3.setString(2, ctaOrigen);
                ResultSet rs2 = sta3.executeQuery();

                String Resultado = "";

                ArrayList<ErroresPlanilla> lista=new ArrayList<ErroresPlanilla>();
                
                while (rs2.next()) {
                    ErroresPlanilla errores=new ErroresPlanilla(rs2.getString(1), rs2.getString(2), rs2.getString(3), rs2.getString(4), rs2.getString(5), 
                            rs2.getString(6), rs2.getString(7),rs2.getString(8),rs2.getString(9),rs2.getString(10),rs2.getString(11));
                    lista.add(errores);
                    Resultado = Resultado + "ID: " + rs2.getString(1) + " idPlanilla: " +  rs2.getString(2) + " CtaOrigen: " + rs2.getString(3) +
                            " CtaDestino: " + rs2.getString(4) + " Operacion: " + rs2.getString(5) + " Estado: " + rs2.getString(6) + 
                            " Saldo Inical Origen " + rs2.getString(7) + " Saldo Final Origen: " +  rs2.getString(8) + " Saldo Inicial Destino: " +  rs2.getString(9) + 
                            " Saldo Final Destino " + rs2.getString(10) + " Monto Operado: " + rs2.getString(11) + "\n";
                    //montoTotal = montoTotal + rs2.getString(11);
                    
                }
                
                request.setAttribute("lista", lista);
                
                sta3.close();
                
                System.out.println(Resultado);

                String fileName = "C:\\Salida\\Reporte_Planilla.txt";
                FileOutputStream fileOS = new java.io.FileOutputStream(fileName, false);
                OutputStreamWriter writer = new java.io.OutputStreamWriter(fileOS,"UTF-8");
                BufferedWriter files = new java.io.BufferedWriter(writer);
                files.write(Resultado);
                files.close();


                System.out.println("Listo REPORTE DE PLANILLA");
                
                
                cnx.close();
            } catch (Exception e) {
            }

            request.getRequestDispatcher("reporte_planilla.jsp").forward(request, response);
            
            
        }
        
        
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
