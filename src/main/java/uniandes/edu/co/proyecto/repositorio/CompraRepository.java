package uniandes.edu.co.proyecto.repositorio;

import org.springframework.data.jpa.repository.JpaRepository;

import uniandes.edu.co.proyecto.modelo.Compra;
import uniandes.edu.co.proyecto.modelo.CompraPK;

public interface CompraRepository extends JpaRepository<Compra,CompraPK>{

}
