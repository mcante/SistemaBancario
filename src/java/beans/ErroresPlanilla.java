package beans;

public class ErroresPlanilla {
    String op, planilla, ctaOrigen, ctaDestino, operacion, estado, saldoIO, saldoFO, saldoID, saldoFD, monto;

    public ErroresPlanilla(String op, String planilla, String ctaOrigen, String ctaDestino, String operacion, String estado, String saldoIO, String saldoFO, String saldoID, String saldoFD, String monto) {
        this.op = op;
        this.planilla = planilla;
        this.ctaOrigen = ctaOrigen;
        this.ctaDestino = ctaDestino;
        this.operacion = operacion;
        this.estado = estado;
        this.saldoIO = saldoIO;
        this.saldoFO = saldoFO;
        this.saldoID = saldoID;
        this.saldoFD = saldoFD;
        this.monto = monto;
    }

    public String getOp() {
        return op;
    }

    public void setOp(String op) {
        this.op = op;
    }

    public String getPlanilla() {
        return planilla;
    }

    public void setPlanilla(String planilla) {
        this.planilla = planilla;
    }

    public String getCtaOrigen() {
        return ctaOrigen;
    }

    public void setCtaOrigen(String ctaOrigen) {
        this.ctaOrigen = ctaOrigen;
    }

    public String getCtaDestino() {
        return ctaDestino;
    }

    public void setCtaDestino(String ctaDestino) {
        this.ctaDestino = ctaDestino;
    }

    public String getOperacion() {
        return operacion;
    }

    public void setOperacion(String operacion) {
        this.operacion = operacion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getSaldoIO() {
        return saldoIO;
    }

    public void setSaldoIO(String saldoIO) {
        this.saldoIO = saldoIO;
    }

    public String getSaldoFO() {
        return saldoFO;
    }

    public void setSaldoFO(String saldoFO) {
        this.saldoFO = saldoFO;
    }

    public String getSaldoID() {
        return saldoID;
    }

    public void setSaldoID(String saldoID) {
        this.saldoID = saldoID;
    }

    public String getSaldoFD() {
        return saldoFD;
    }

    public void setSaldoFD(String saldoFD) {
        this.saldoFD = saldoFD;
    }

    public String getMonto() {
        return monto;
    }

    public void setMonto(String monto) {
        this.monto = monto;
    }
    
    
}
