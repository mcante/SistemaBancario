        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                
                <a class="navbar-brand" href="index.html"> <%=rol%>, <%=nombre%> <%=apellido%> </a>
                                
                
            </div>
            <!-- /.navbar-header -->

            
            
            
            
            <!-- /.navbar-login -->
            <ul class="nav navbar-top-links navbar-right">
                
                
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>

                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="#"><i class="fa fa-user fa-fw"></i> Perfil de usuario </a>
                        </li>
                        <li><a href="#"><i class="fa fa-gear fa-fw"></i> Configuración </a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="cerrar_sesion.jsp"><i class="fa fa-sign-out fa-fw"></i> Salir </a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->

            
            
            
            
            
            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li class="sidebar-search">
                            <div class="input-group custom-search-form">
                                <input type="text" class="form-control" placeholder="Search...">
                                <span class="input-group-btn">
                                <button class="btn btn-default" type="button">
                                    <i class="fa fa-search"></i>
                                </button>
                            </span>
                            </div>
                            <!-- /input-group -->
                        </li>
                        <li>
                            <a href="index.jsp"><i class="fa fa-home fa-fw"></i> Principal </a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-users fa-fw"></i> Usuarios <span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="clientes.jsp">Gestionar Usuarios</a>
                                </li>
                                <li>
                                    <a href="serClientesFull?accion=listar">Listar Clientes</a>
                                </li>
                                
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                        
                        
                        <li>
                            <a href="#"><i class="fa fa-money"></i> Operaciones <span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                
                                <li>
                                    <a href="transferenciasA_B.jsp">Transferencias</a>
                                </li>
                                <li>
                                    <a href="deposito_monetario.jsp">Crédito Monetario</a>
                                </li>
                                <li>
                                    <a href="deposito_ahorro.jsp">Crédito Ahorro</a>
                                </li>
                                <li>
                                    <a href="debito_monetario.jsp">Débito Monetario</a>
                                </li>
                                <li>
                                    <a href="debito_ahorro.jsp">Débito Ahorro</a>
                                </li>
                                
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                        
                        <li>
                            <a href="subir_archivo.jsp"><i class="fa fa-table fa-fw"></i> Pago Planilla </a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-flag-checkered"></i>  Reportes<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="serDebitosDepositivos?accion=operaciones">Operaciones</a>
                                </li>
                                <li>
                                    <a href="estado_cuenta.jsp">Estado de Cuenta</a>
                                </li>
                                <li>
                                    <a href="#">Mayor transferencia</a>
                                </li>
                                <li>
                                    <a href="#">Pagos de planitlla</a>
                                </li>
                                <li>
                                    <a href="#">Clientes concurrentes</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-sitemap fa-fw"></i> Administración de Sistema<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="#">Usuarios</a>
                                </li>
                                
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                        <li>
                            <a href="cerrar_sesion.jsp"><i class="fa fa-files-o fa-fw"></i> Salir<span class="fa arrow"></span></a>
                            
                        </li>
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>
