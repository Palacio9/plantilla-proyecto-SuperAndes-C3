package uniandes.edu.co.proyecto.modelo;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "productos")
public class Producto {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer id;

    private String nombre;

    private Date fecha_expiracion;

    private String codigo_barras;

    private Float volumen;

    private Float peso;

    @ManyToOne
    @JoinColumn(name = "id_tipo_categoria", referencedColumnName = "id")
    private Tipo_categoria id_tipo_categoria;

    public Producto() {
    }

    public Producto(String nombre, Date fecha_expiracion, String codigo_barras, Float volumen, Float peso,
            Tipo_categoria id_tipo_categoria) {
        this.nombre = nombre;
        this.fecha_expiracion = fecha_expiracion;
        this.codigo_barras = codigo_barras;
        this.volumen = volumen;
        this.peso = peso;
        this.id_tipo_categoria = id_tipo_categoria;
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

    public Date getFecha_expiracion() {
        return fecha_expiracion;
    }

    public void setFecha_expiracion(Date fecha_expiracion) {
        this.fecha_expiracion = fecha_expiracion;
    }

    public String getCodigo_barras() {
        return codigo_barras;
    }

    public void setCodigo_barras(String codigo_barras) {
        this.codigo_barras = codigo_barras;
    }

    public Float getVolumen() {
        return volumen;
    }

    public void setVolumen(Float volumen) {
        this.volumen = volumen;
    }

    public Float getPeso() {
        return peso;
    }

    public void setPeso(Float peso) {
        this.peso = peso;
    }

    public Tipo_categoria getId_tipo_categoria() {
        return id_tipo_categoria;
    }

    public void setId_tipo_categoria(Tipo_categoria id_tipo_categoria) {
        this.id_tipo_categoria = id_tipo_categoria;
    }

}
