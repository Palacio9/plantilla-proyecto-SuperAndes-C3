package uniandes.edu.co.proyecto.modelo;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name="contiene")
public class Contiene {

    @EmbeddedId
    private ContienePK pk;

    private Integer cantidad;

    private Integer capacidad;

    private Float costo_promedio;
    
    private Integer cantidad_minima;
    
    public Contiene() {
    }

    public Contiene(Bodega id_bodega, Producto id_producto, Integer cantidad, Integer capacidad, Float costo_promedio, Integer cantidad_minima) {
        this.pk = new ContienePK(id_bodega, id_producto);
        this.cantidad = cantidad;
        this.capacidad = capacidad;
        this.costo_promedio = costo_promedio;
        this.cantidad_minima = cantidad_minima;
    }

    public ContienePK getPk() {
        return pk;
    }

    public void setPk(ContienePK pk) {
        this.pk = pk;
    }

    public Integer getCantidad() {
        return cantidad;
    }

    public void setCantidad(Integer cantidad) {
        this.cantidad = cantidad;
    }

    public Integer getCapacidad() {
        return capacidad;
    }

    public void setCapacidad(Integer capacidad) {
        this.capacidad = capacidad;
    }

    public Float getCosto_promedio() {
        return costo_promedio;
    }

    public void setCosto_promedio(Float costo_promedio) {
        this.costo_promedio = costo_promedio;
    }

    public Integer getCantidad_minima() {
        return cantidad_minima;
    }

    public void setCantidad_minima(Integer cantidad_minima) {
        this.cantidad_minima = cantidad_minima;
    }

}
