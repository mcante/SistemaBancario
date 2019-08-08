<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                    <h1 class="page-header">Usuarios</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
           
            <!-- /.row -->
            <div class="row">
                
                <table border="0" width="700" align="left">
                    <tr>
                        <th> <a href="serClientes?accion=listar"> Listar
                                <img src="imagenes/listar.png" width="80" height="80"> 
                            </a> </th>
                        <th> <a href="cliente_consultar.jsp"> Consultar
                                <img src="imagenes/consultar.jpg" width="80" height="80"> 
                            </a> </th>
                        
                        <th colspan="2"> 
                        <a href="cliente_nuevo.jsp"> Añadir
                            <img src="imagenes/insertar.png" width="80" height="80"> 
                        </a> </th>

                    </tr>

                </table>
                
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->
        
 
            <%@include file="plantilla/componentes/mis_scritps.jsp" %>

        </div>
            

    </body>
</html>
