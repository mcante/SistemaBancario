package beans;


public class Cliente {
    private String DPI;
    private String NIT, NOMBRE, APELLIDO, NO_TELEFONO, DIRECCION;
    private String FECHA_NACIMIENTO; 

    public Cliente(String DPI, String NIT, String NOMBRE, String APELLIDO, String NO_TELEFONO, String DIRECCION, String FECHA_NACIMIENTO) {
        this.DPI = DPI;
        this.NIT = NIT;
        this.NOMBRE = NOMBRE;
        this.APELLIDO = APELLIDO;
        this.NO_TELEFONO = NO_TELEFONO;
        this.DIRECCION = DIRECCION;
        this.FECHA_NACIMIENTO = FECHA_NACIMIENTO;
    }

    public String getDPI() {
        return DPI;
    }

    public void setDPI(String DPI) {
        this.DPI = DPI;
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

    public String getNO_TELEFONO() {
        return NO_TELEFONO;
    }

    public void setNO_TELEFONO(String NO_TELEFONO) {
        this.NO_TELEFONO = NO_TELEFONO;
    }

    public String getDIRECCION() {
        return DIRECCION;
    }

    public void setDIRECCION(String DIRECCION) {
        this.DIRECCION = DIRECCION;
    }

    public String getFECHA_NACIMIENTO() {
        return FECHA_NACIMIENTO;
    }

    public void setFECHA_NACIMIENTO(String FECHA_NACIMIENTO) {
        this.FECHA_NACIMIENTO = FECHA_NACIMIENTO;
    }
    
    
    
    
}
