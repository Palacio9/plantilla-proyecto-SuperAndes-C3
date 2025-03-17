package uniandes.edu.co.proyecto.modelo;

import java.io.Serializable;

import jakarta.persistence.Embeddable;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Embeddable
public class CompraPK implements Serializable{

    @ManyToOne
    @JoinColumn(name = "id_orden_compra", referencedColumnName = "id")
    private Orden_compra id_orden_compra;

    @ManyToOne
    @JoinColumn(name = "id_producto", referencedColumnName = "id")
    private Producto id_producto;

    public CompraPK() {
        super();
    }

    public CompraPK(Orden_compra id_orden_compra, Producto id_producto) {
        super();
        this.id_orden_compra = id_orden_compra;
        this.id_producto = id_producto;
    }

    public Orden_compra getId_orden_compra() {
        return id_orden_compra;
    }

    public void setId_orden_compra(Orden_compra id_orden_compra) {
        this.id_orden_compra = id_orden_compra;
    }

    public Producto getId_producto() {
        return id_producto;
    }

    public void setId_producto(Producto id_producto) {
        this.id_producto = id_producto;
    }
    
}
