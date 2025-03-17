package uniandes.edu.co.proyecto.model.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Inheritance;
import jakarta.persistence.InheritanceType;
import jakarta.persistence.PrimaryKeyJoinColumn;
import jakarta.persistence.Table;

@Entity
@Table(name="Beneficiarios")
@PrimaryKeyJoinColumn(name="id_afiliado")

public abstract class BeneficiarioEntity extends AfiliadoEntity{
    private String us;
}
