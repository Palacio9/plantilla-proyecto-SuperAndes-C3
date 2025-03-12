package uniandes.edu.co.proyecto.modelo;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "ofrece")
public class Ofrece {

    @EmbeddedId
    private OfrecePK pk;

    public Ofrece() {
    }

    public Ofrece(Proveedor id_proveedor, Producto id_producto) {
        this.pk = new OfrecePK(id_proveedor, id_producto);
    }

    public OfrecePK getPk() {
        return pk;
    }

    public void setPk(OfrecePK pk) {
        this.pk = pk;
    }
    
}
