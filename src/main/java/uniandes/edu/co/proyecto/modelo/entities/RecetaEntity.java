package uniandes.edu.co.proyecto.model.entities;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Inheritance;
import jakarta.persistence.InheritanceType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.util.*;


@Entity
@Table(name="receta")


public abstract class RecetaEntity {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
        private long id_receta;
        private Date fecha;
        private String tipo;
        private int afiliado_id;
        private int medico_id;
        private int servicio_id;
       
    
        public RecetaEntity(Date fecha, String tipo, int afiliado_id, int medico_id, int servicio_id,
                AfiliadoEntity afiliado) {
            this.fecha = fecha;
            this.tipo = tipo;
            this.afiliado_id = afiliado_id;
            this.medico_id = medico_id;
            this.servicio_id = servicio_id;
            this.afiliado = afiliado;
        }

        public long getId_receta() {
            return id_receta;
        }

        public void setId_receta(long id_receta) {
            this.id_receta = id_receta;
        }

        public Date getFecha() {
            return fecha;
        }

        public void setFecha(Date fecha) {
            this.fecha = fecha;
        }

        public String getTipo() {
            return tipo;
        }

        public void setTipo(String tipo) {
            this.tipo = tipo;
        }

        public int getAfiliado_id() {
            return afiliado_id;
        }

        public void setAfiliado_id(int afiliado_id) {
            this.afiliado_id = afiliado_id;
        }

        public int getMedico_id() {
            return medico_id;
        }

        public void setMedico_id(int medico_id) {
            this.medico_id = medico_id;
        }

        public int getServicio_id() {
            return servicio_id;
        }

        public void setServicio_id(int servicio_id) {
            this.servicio_id = servicio_id;
        }

        public AfiliadoEntity getAfiliado() {
            return afiliado;
        }

        public void setAfiliado(AfiliadoEntity afiliado) {
            this.afiliado = afiliado;
        }
        public RecetaEntity(){;}

        @ManyToOne
        @JoinColumn(name = "afiliado_id", nullable = false)
        private AfiliadoEntity afiliado;

        @ManyToOne
        @JoinColumn(name = "medico_id", nullable = false)
        private MedicoEntity medico;

        @ManyToOne
        @JoinColumn(name = "servicio_id", nullable = false)
        private ServicioEntity servicio;



}
