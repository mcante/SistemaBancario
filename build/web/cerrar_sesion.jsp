<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="../imagenes/favicon.ico">
        <title>Cerrar Sesión</title>
    </head>
    <body>
        <%
            HttpSession sesionOK=request.getSession();
            request.getSession().removeAttribute("usuario");
            sesionOK.invalidate();
            request.getRequestDispatcher("index.jsp").forward(request, response);
            %>
    </body>
</html>
