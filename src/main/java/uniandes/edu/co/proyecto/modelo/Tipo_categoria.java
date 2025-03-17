package uniandes.edu.co.proyecto.modelo;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "tipos_categoria")
public class Tipo_categoria {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer id;

    private String nombre;

    private String descripcion;

    private String caracteristicas;

    public Tipo_categoria() {
    }

    public Tipo_categoria(String nombre, String descripcion, String caracteristicas) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.caracteristicas = caracteristicas;
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

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getCaracteristicas() {
        return caracteristicas;
    }

    public void setCaracteristicas(String caracteristicas) {
        this.caracteristicas = caracteristicas;
    }

}
