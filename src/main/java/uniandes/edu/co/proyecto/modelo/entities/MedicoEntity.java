package uniandes.edu.co.proyecto.model.entities;

import java.util.Date;
import java.util.List;

import jakarta.persistence.CascadeType;
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
@Table(name="medicos")


public abstract class MedicoEntity {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
        private long id_medico;
        private String nombre;
        private int especialidad_id;
        private String registro_medico;
        private int ips_id;        
        public MedicoEntity(){;}

        
        public MedicoEntity(String nombre, int especialidad_id, String registro_medico, int ips_id,
                EspecialidadEntity especialidad, IPSEntity ips, List<CitaEntity> citas, List<RecetaEntity> recetas,
                List<OrdenServicioEntity> ordenesServicio) {
                this.nombre = nombre;
                this.especialidad_id = especialidad_id;
                this.registro_medico = registro_medico;
                this.ips_id = ips_id;
                this.especialidad = especialidad;
                this.ips = ips;
                this.citas = citas;
                this.recetas = recetas;
                this.ordenesServicio = ordenesServicio;
        }

        public long getId_medico() {
            return id_medico;
        }

        public void setId_medico(long id_medico) {
            this.id_medico = id_medico;
        }

        public String getNombre() {
            return nombre;
        }

        public void setNombre(String nombre) {
            this.nombre = nombre;
        }

        public int getEspecialidad_id() {
            return especialidad_id;
        }

        public void setEspecialidad_id(int especialidad_id) {
            this.especialidad_id = especialidad_id;
        }

        public String getRegistro_medico() {
            return registro_medico;
        }

        public void setRegistro_medico(String registro_medico) {
            this.registro_medico = registro_medico;
        }

        public int getIps_id() {
            return ips_id;
        }

        public void setIps_id(int ips_id) {
            this.ips_id = ips_id;
        }

        public EspecialidadEntity getEspecialidad() {
            return especialidad;
        }

        public void setEspecialidad(EspecialidadEntity especialidad) {
            this.especialidad = especialidad;
        }

        public IPSEntity getIps() {
            return ips;
        }

        public void setIps(IPSEntity ips) {
            this.ips = ips;
        }

        public List<CitaEntity> getCitas() {
            return citas;
        }

        public void setCitas(List<CitaEntity> citas) {
            this.citas = citas;
        }

        public List<RecetaEntity> getRecetas() {
            return recetas;
        }

        public void setRecetas(List<RecetaEntity> recetas) {
            this.recetas = recetas;
        }

        public List<OrdenServicioEntity> getOrdenesServicio() {
            return ordenesServicio;
        }

        public void setOrdenesServicio(List<OrdenServicioEntity> ordenesServicio) {
            this.ordenesServicio = ordenesServicio;
        }

        @ManyToOne
        @JoinColumn(name = "especialidad_id", nullable = false)
        private EspecialidadEntity especialidad;
    
        @ManyToOne
        @JoinColumn(name = "ips_id", nullable = false)
        private IPSEntity ips;
    
        @OneToMany(mappedBy = "medico", cascade = CascadeType.ALL, orphanRemoval = true)
        private List<CitaEntity> citas;
    
        @OneToMany(mappedBy = "medico", cascade = CascadeType.ALL, orphanRemoval = true)
        private List<RecetaEntity> recetas;
    
        @OneToMany(mappedBy = "medico", cascade = CascadeType.ALL, orphanRemoval = true)
        private List<OrdenServicioEntity> ordenesServicio;

}
