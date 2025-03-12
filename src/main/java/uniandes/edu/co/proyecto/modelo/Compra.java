package uniandes.edu.co.proyecto.modelo;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name="compra")
public class Compra {

    @EmbeddedId
    private CompraPK pk;

    private Integer cantidad;

    private Float precio_unitario;

    public Compra() {
    }

    public Compra(Orden_compra id_orden_compra, Producto id_producto, Integer cantidad, Float precio_unitario) {
        this.pk = new CompraPK(id_orden_compra,id_producto);
        this.cantidad = cantidad;
        this.precio_unitario = precio_unitario;
    }

    public CompraPK getPk() {
        return pk;
    }

    public void setPk(CompraPK pk) {
        this.pk = pk;
    }

    public Integer getCantidad() {
        return cantidad;
    }

    public void setCantidad(Integer cantidad) {
        this.cantidad = cantidad;
    }

    public Float getPrecio_unitario() {
        return precio_unitario;
    }

    public void setPrecio_unitario(Float precio_unitario) {
        this.precio_unitario = precio_unitario;
    }

}
