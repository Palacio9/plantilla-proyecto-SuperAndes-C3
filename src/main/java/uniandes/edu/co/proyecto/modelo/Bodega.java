package uniandes.edu.co.proyecto.modelo;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "bodegas")
public class Bodega {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer id;

    private String nombre;

    private String tamanio;

    @ManyToOne
    @JoinColumn(name = "id_sucursal", referencedColumnName = "id")
    private Sucursal id_sucursal;

    public Bodega() {
    }

    public Bodega(String nombre, String tamanio, Sucursal id_sucursal) {
        this.nombre = nombre;
        this.tamanio = tamanio;
        this.id_sucursal = id_sucursal;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTamanio() {
        return tamanio;
    }

    public void setTamanio(String tamanio) {
        this.tamanio = tamanio;
    }

    public Sucursal getId_Sucursal() {
        return id_sucursal;
    }

    public void setId_sucursal(Sucursal id_sucursal) {
        this.id_sucursal = id_sucursal;
    }
    
}
