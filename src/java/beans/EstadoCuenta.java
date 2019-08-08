package beans;

public class EstadoCuenta {
    String tipoOperacion, noCuenta, nombre, empresa, estado, saldoInicial, monto, saldoFinal, letras, tipoDocumento, fecha, agencia, usuario;

    public EstadoCuenta(String tipoOperacion, String noCuenta, String nombre, String empresa, String estado, String saldoInicial, String monto, String saldoFinal, String letras, String tipoDocumento, String fecha, String agencia, String usuario) {
        this.tipoOperacion = tipoOperacion;
        this.noCuenta = noCuenta;
        this.nombre = nombre;
        this.empresa = empresa;
        this.estado = estado;
        this.saldoInicial = saldoInicial;
        this.monto = monto;
        this.saldoFinal = saldoFinal;
        this.letras = letras;
        this.tipoDocumento = tipoDocumento;
        this.fecha = fecha;
        this.agencia = agencia;
        this.usuario = usuario;
    }

    public String getTipoOperacion() {
        return tipoOperacion;
    }

    public void setTipoOperacion(String tipoOperacion) {
        this.tipoOperacion = tipoOperacion;
    }

    public String getNoCuenta() {
        return noCuenta;
    }

    public void setNoCuenta(String noCuenta) {
        this.noCuenta = noCuenta;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEmpresa() {
        return empresa;
    }

    public void setEmpresa(String empresa) {
        this.empresa = empresa;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getSaldoInicial() {
        return saldoInicial;
    }

    public void setSaldoInicial(String saldoInicial) {
        this.saldoInicial = saldoInicial;
    }

    public String getMonto() {
        return monto;
    }

    public void setMonto(String monto) {
        this.monto = monto;
    }

    public String getSaldoFinal() {
        return saldoFinal;
    }

    public void setSaldoFinal(String saldoFinal) {
        this.saldoFinal = saldoFinal;
    }

    public String getLetras() {
        return letras;
    }

    public void setLetras(String letras) {
        this.letras = letras;
    }

    public String getTipoDocumento() {
        return tipoDocumento;
    }

    public void setTipoDocumento(String tipoDocumento) {
        this.tipoDocumento = tipoDocumento;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getAgencia() {
        return agencia;
    }

    public void setAgencia(String agencia) {
        this.agencia = agencia;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }
    
    
}
