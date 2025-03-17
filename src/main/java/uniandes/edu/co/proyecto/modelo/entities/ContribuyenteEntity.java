package uniandes.edu.co.proyecto.model.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Inheritance;
import jakarta.persistence.InheritanceType;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrimaryKeyJoinColumn;
import jakarta.persistence.Table;

@Entity
@Table(name="contribuyentes")
@PrimaryKeyJoinColumn(name="id_afiliado")

public abstract class ContribuyenteEntity extends AfiliadoEntity{

    @OneToMany
    private AfiliadoEntity contribuyente_id;




}
