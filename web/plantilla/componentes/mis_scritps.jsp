    
    <!-- jQuery -->
    <script src="plantilla/vendor/jquery/jquery.min.js"></script>
    

    <!-- Bootstrap Core JavaScript -->
    <script src="plantilla/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="plantilla/vendor/metisMenu/metisMenu.min.js"></script>
    
    <!-- DataTables JavaScript -->
    <script src="plantilla/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="plantilla/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <script src="plantilla/vendor/datatables-responsive/dataTables.responsive.js"></script>
    
    <!-- DataTables JavaScript MELVIN -->
    <script src="plantilla/vendor/datatables/js/jquery.dataTables.min.js"></script>
    

    <!-- BOTONES JavaScript MELVIN -->
    <script src="plantilla/vendor/datatables/js/dataTables.buttons.min.js"></script>
    <script src="plantilla/vendor/datatables/js/buttons.html5.min.js"></script>
    <script src="plantilla/vendor/datatables/js/buttons.bootstrap.min.js"></script>
    
    
    <script src="plantilla/vendor/datatables/js/pdfmake.min.js"></script>
    <script src="plantilla/vendor/datatables/js/vfs_fonts.js"></script>
    
    <!-- Custom Theme JavaScript -->
    <script src="plantilla/dist/js/sb-admin-2.js"></script>
    

    <!-- Page-Level Demo Scripts - Tables - Use for reference -->
    <script>
    $(document).ready(function() {
        $('#dataTables-example').DataTable({
            
            language: {
                        "sProcessing":     "Procesando...",
                        "sLengthMenu":     "Mostrar _MENU_ registros",
                        "sZeroRecords":    "No se encontraron resultados",
                        "sEmptyTable":     "Ningún dato disponible en esta tabla",
                        "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                        "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
                        "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
                        "sInfoPostFix":    "",
                        "sSearch":         "Buscar:",
                        "sUrl":            "",
                        "sInfoThousands":  ",",
                        "sLoadingRecords": "Cargando...",
                        "oPaginate": {
                            "sFirst":    "Primero",
                            "sLast":     "Último",
                            "sNext":     "Siguiente",
                            "sPrevious": "Anterior"
                        },
                        "oAria": {
                            "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
                            "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                        }
                    },
                    
            responsive: true,
            dom: 'Bfrtip',
            buttons: [
                    {
                        text: 'Reporte a PDF',
                        extend: 'pdfHtml5',
                        filename: 'estado_cuenta',
                        orientation: 'landscape',
                        pageSize: 'LEGAL'
                    }
                    ],
        });
    });
    </script>

