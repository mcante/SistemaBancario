<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.*"%>
<%@page import="beans.ErroresPlanilla"%>
<%@page session="true"%>
<%!
double operado=0.00;
%>
<%
    String nombre="";
    String apellido="";
    String rol="";
    HttpSession sesionOK=request.getSession();
    if(sesionOK.getAttribute("usuario")==null){
    %>
    <jsp:forward page="login.jsp">
        <jsp:param name="msg" value="Tiene que loguearse"/>
    </jsp:forward>
     <%
        }else{
    nombre=(String)sesionOK.getAttribute("nombre");
    apellido=(String)sesionOK.getAttribute("apellido");
    rol=(String)sesionOK.getAttribute("rol");
        }
        %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="../imagenes/favicon.ico">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="Melvin Canté">
        
        <title>Sistema Bancario UMG</title>
        
        <%@include file="plantilla/componentes/head.html" %>

    </head>
    <body>
        
        <div id="wrapper">
            <%@include file="plantilla/componentes/navegacion.jsp" %>
            
            
            <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Reporte de Planilla </h1>
                    <br>
                    
                </div>
            </div>
                
                
            <!-- /.row -->
            <div class="row">
                
                <div class="box-body">
                    
                    <div class="panel-body">
                        
                        <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">

                            <thead>
                                    
                                    <th>OP</th>
                                    <th>PLANI</th>
                                    <th>CTA. ORIGEN</th>
                                    <th>CTA. DESTINO</th>
                                    <th>OPERACION</th>
                                    <th>ESTADO</th>
                                    <th>SALDO INICIAL ORIGEN</th>
                                    <th>SALDO FINAL ORIGEN</th>
                                    <th>SALDO INICIAL DESTINO</th>
                                    <th>SALDO FINAL DESTINO</th>
                                    <th>MONTO</th>
                            </thead>
                                <tbody>

                                    <% 
                                        ArrayList<ErroresPlanilla> lista=(ArrayList<ErroresPlanilla>)request.getAttribute("lista");

                                    for (int i=0; i<lista.size(); i++) {
                                            ErroresPlanilla errores=lista.get(i);
                                    %>

                                    <tr>
                                        <td><%=errores.getOp()%></td>
                                        <td><%=errores.getPlanilla()%></td>
                                        <td><%=errores.getCtaOrigen()%></td>
                                        <td><%=errores.getCtaDestino()%></td>
                                        <td><%=errores.getOperacion()%></td>
                                        <td><%=errores.getEstado()%></td>
                                        <td>Q.<%=errores.getSaldoIO()%></td>
                                        <td>Q.<%=errores.getSaldoFO()%></td>
                                        <td>Q.<%=errores.getSaldoID()%></td>
                                        <td>Q.<%=errores.getSaldoFD()%></td>
                                        <td>Q.<%=errores.getMonto()%></td>
                                    </tr>
                                    <%
                                       operado=operado+Double.parseDouble(errores.getMonto());
                                    }
                                    %>
                                </tbody>
                        </table>
                                <h1>Total a operar: Q.<%=operado %></h1>
                                <%
                                    operado=0.00;
                                %>
                    </div>
                <!-- /.row -->
            </div>
            <!-- /#page-wrapper -->       
            
            <%@include file="plantilla/componentes/mis_scritps.jsp" %>

        </div>

            
    </body>
</html>
