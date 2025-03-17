package uniandes.edu.co.proyecto.model.entities;

import java.util.Date;
import java.util.List;

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

@Entity
@Table(name="servicios")


public abstract class ServicioEntity {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
        private long id_afiliado;
        private String nombre;
        private int tipo;
        private String direccion;
        private String telefono;
        private Date fecha_nacimiento; 
        private int contribuyente_id; 
        private String parentesco;
       

        public ServicioEntity(String nombre, int tipo, String direccion, String telefono, Date fecha_nacimiento,
                int contribuyente_id, String parentesco, EspecialidadEntity especialidad, List<CitaEntity> citas,
                List<OrdenServicioEntity> ordenesServicio) {
            this.nombre = nombre;
            this.tipo = tipo;
            this.direccion = direccion;
            this.telefono = telefono;
            this.fecha_nacimiento = fecha_nacimiento;
            this.contribuyente_id = contribuyente_id;
            this.parentesco = parentesco;
            this.especialidad = especialidad;
            this.citas = citas;
            this.ordenesServicio = ordenesServicio;
        }

        public long getId_afiliado() {
            return id_afiliado;
        }

        public void setId_afiliado(long id_afiliado) {
            this.id_afiliado = id_afiliado;
        }

        public String getNombre() {
            return nombre;
        }

        public void setNombre(String nombre) {
            this.nombre = nombre;
        }

        public int getTipo() {
            return tipo;
        }

        public void setTipo(int tipo) {
            this.tipo = tipo;
        }

        public String getDireccion() {
            return direccion;
        }

        public void setDireccion(String direccion) {
            this.direccion = direccion;
        }

        public String getTelefono() {
            return telefono;
        }

        public void setTelefono(String telefono) {
            this.telefono = telefono;
        }

        public Date getFecha_nacimiento() {
            return fecha_nacimiento;
        }

        public void setFecha_nacimiento(Date fecha_nacimiento) {
            this.fecha_nacimiento = fecha_nacimiento;
        }

        public int getContribuyente_id() {
            return contribuyente_id;
        }

        public void setContribuyente_id(int contribuyente_id) {
            this.contribuyente_id = contribuyente_id;
        }

        public String getParentesco() {
            return parentesco;
        }

        public void setParentesco(String parentesco) {
            this.parentesco = parentesco;
        }

        public EspecialidadEntity getEspecialidad() {
            return especialidad;
        }

        public void setEspecialidad(EspecialidadEntity especialidad) {
            this.especialidad = especialidad;
        }

        public List<CitaEntity> getCitas() {
            return citas;
        }

        public void setCitas(List<CitaEntity> citas) {
            this.citas = citas;
        }

        public List<OrdenServicioEntity> getOrdenesServicio() {
            return ordenesServicio;
        }

        public void setOrdenesServicio(List<OrdenServicioEntity> ordenesServicio) {
            this.ordenesServicio = ordenesServicio;
        }
        public ServicioEntity(){;}

        @ManyToOne
        @JoinColumn(name = "especialidad_id")
        private EspecialidadEntity especialidad;

        @OneToMany(mappedBy = "servicio")
        private List<CitaEntity> citas;

        @OneToMany(mappedBy = "servicio")
        private List<OrdenServicioEntity> ordenesServicio;

}
