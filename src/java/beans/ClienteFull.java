package beans;


public class ClienteFull {
    private String id_cliente;
    private String dpi, NIT, NOMBRE, APELLIDO;
    private String id_patente1, nit_emp, empresa; 
    private String no_cuenta, saldo_disponible, saldo_reserva, tipo, status;

    public ClienteFull(String id_cliente, String NIT, String NOMBRE, String APELLIDO, String nit_emp, String empresa, String no_cuenta, String saldo_disponible, String saldo_reserva, String tipo, String status, String dpi, String id_patente1) {
        this.id_cliente = id_cliente;
        this.dpi = dpi;
        this.NIT = NIT;
        this.NOMBRE = NOMBRE;
        this.APELLIDO = APELLIDO;
        this.id_patente1 = id_patente1;
        this.nit_emp = nit_emp;
        this.empresa = empresa;
        this.no_cuenta = no_cuenta;
        this.saldo_disponible = saldo_disponible;
        this.saldo_reserva = saldo_reserva;
        this.tipo = tipo;
        this.status = status;
    }

    public String getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(String id_cliente) {
        this.id_cliente = id_cliente;
    }

    public String getDpi() {
        return dpi;
    }

    public void setDpi(String dpi) {
        this.dpi = dpi;
    }

    public String getNIT() {
        return NIT;
    }

    public void setNIT(String NIT) {
        this.NIT = NIT;
    }

    public String getNOMBRE() {
        return NOMBRE;
    }

    public void setNOMBRE(String NOMBRE) {
        this.NOMBRE = NOMBRE;
    }

    public String getAPELLIDO() {
        return APELLIDO;
    }

    public void setAPELLIDO(String APELLIDO) {
        this.APELLIDO = APELLIDO;
    }

    public String getId_patente1() {
        return id_patente1;
    }

    public void setId_patente1(String id_patente1) {
        this.id_patente1 = id_patente1;
    }

    public String getNit_emp() {
        return nit_emp;
    }

    public void setNit_emp(String nit_emp) {
        this.nit_emp = nit_emp;
    }

    public String getEmpresa() {
        return empresa;
    }

    public void setEmpresa(String empresa) {
        this.empresa = empresa;
    }

    public String getNo_cuenta() {
        return no_cuenta;
    }

    public void setNo_cuenta(String no_cuenta) {
        this.no_cuenta = no_cuenta;
    }

    public String getSaldo_disponible() {
        return saldo_disponible;
    }

    public void setSaldo_disponible(String saldo_disponible) {
        this.saldo_disponible = saldo_disponible;
    }

    public String getSaldo_reserva() {
        return saldo_reserva;
    }

    public void setSaldo_reserva(String saldo_reserva) {
        this.saldo_reserva = saldo_reserva;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
    
    
    
    
}
