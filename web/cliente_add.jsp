<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.*"%>
<%@page import="beans.Cliente"%>
<%@page session="true"%>
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
                    <h1 class="page-header">Crear Nuevo Cliente</h1>
                </div>
            </div>
                
                
            <!-- /.row -->
            <div class="row">
                
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <div class="col-lg-6">
                
                    <form action="serClientesFull" role="form">
                                               
                        <table border="0" width="300" align="left">
                            
                            <tr>
                                <td> 
                                    <div class="form-group">
                                        <label>DPI</label>
                                        <input type="text" name="txtDpi" value="" class="form-control" placeholder="DPI de cliente" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td> 
                                    <div class="form-group">
                                        <label>PATENTE</label>
                                        <input type="text" name="txtPatente" value="" class="form-control" placeholder="No. Patente"/>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td> 
                                    <div class="form-group">
                                        <label>FECHA REGISTRO</label>
                                        <input type="text" name="txtFechaReg" value="" class="form-control" placeholder="Fecha Registro"/>
                                    </div>
                                </td>
                            </tr>
                            
                            <th colspan="2">
                                <button type="submit" class="btn btn-primary" value="InsertarCliente" name="accion">Crear Cliente</button>
                                
                            </th> 
                            
                        </table>
                            
                        
                    </form>
                        
                    </div>
                    
                    
                </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->       
            
            <%@include file="plantilla/componentes/mis_scritps.jsp" %>

        </div>

            
    </body>
    
    
</html>
