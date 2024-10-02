package uniandes.edu.co.proyecto.modelo;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "documentos")
public class Documento {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_orden_compra", referencedColumnName = "id")
    private Orden_compra id_orden_compra;

    public Documento() {
    }

    public Documento(Orden_compra id_orden_compra) {
        this.id_orden_compra = id_orden_compra;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Orden_compra getId_orden_compra() {
        return id_orden_compra;
    }

    public void setId_orden_compra(Orden_compra id_orden_compra) {
        this.id_orden_compra = id_orden_compra;
    }

}