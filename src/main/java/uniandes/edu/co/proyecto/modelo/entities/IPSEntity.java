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
@Table(name="ips")


public abstract class IPSEntity {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
        private long id_ips;
        private String NIT;
        private String nombre;
        private String direccion;
        private String telefono;
        private List servicios_prestados;
       
        public IPSEntity(String nIT, String nombre, String direccion, String telefono, List servicios_prestados,
                List<MedicoEntity> medicos, List<CitaEntity> citas, List<OrdenServicioEntity> ordenesServicio,
                EPSEntity eps) {
            NIT = nIT;
            this.nombre = nombre;
            this.direccion = direccion;
            this.telefono = telefono;
            this.servicios_prestados = servicios_prestados;
            this.medicos = medicos;
            this.citas = citas;
            this.ordenesServicio = ordenesServicio;
            this.eps = eps;
        }

        public long getId_ips() {
            return id_ips;
        }

        public void setId_ips(long id_ips) {
            this.id_ips = id_ips;
        }

        public String getNIT() {
            return NIT;
        }

        public void setNIT(String nIT) {
            NIT = nIT;
        }

        public String getNombre() {
            return nombre;
        }

        public void setNombre(String nombre) {
            this.nombre = nombre;
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

        public List getServicios_prestados() {
            return servicios_prestados;
        }

        public void setServicios_prestados(List servicios_prestados) {
            this.servicios_prestados = servicios_prestados;
        }

        public List<MedicoEntity> getMedicos() {
            return medicos;
        }

        public void setMedicos(List<MedicoEntity> medicos) {
            this.medicos = medicos;
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

        public EPSEntity getEps() {
            return eps;
        }

        public void setEps(EPSEntity eps) {
            this.eps = eps;
        }

        public IPSEntity(){;}
        @OneToMany(mappedBy = "ips")
        private List<MedicoEntity> medicos;

        @OneToMany(mappedBy = "ips")
        private List<CitaEntity> citas;

        @OneToMany(mappedBy = "ips")
        private List<OrdenServicioEntity> ordenesServicio;

        @ManyToOne
        @JoinColumn(name = "eps_id")
        private EPSEntity eps;



}
