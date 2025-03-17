package uniandes.edu.co.proyecto.model.entities;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Inheritance;
import jakarta.persistence.InheritanceType;
import jakarta.persistence.Table;

@Entity
@Table(name="especialidades")


public abstract class EspecialidadEntity {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
        private long id_especialidad;
        private String nombre;

        public EspecialidadEntity(String nombre) {
            this.nombre = nombre;
        }

        public EspecialidadEntity(){;}

        public long getId_especialidad() {
            return id_especialidad;
        }

        public void setId_especialidad(long id_especialidad) {
            this.id_especialidad = id_especialidad;
        }

        public String getNombre() {
            return nombre;
        }

        public void setNombre(String nombre) {
            this.nombre = nombre;
        }

}
