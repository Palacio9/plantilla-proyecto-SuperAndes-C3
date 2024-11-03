package uniandes.edu.co.proyecto.repositorio;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import uniandes.edu.co.proyecto.modelo.Ciudad;

public interface CiudadRepository extends JpaRepository<Ciudad, Integer> {

    /**
     * RF1 : Crea una ciudad.
     * SQL : Inserta un nuevo registro en la tabla 'ciudades'
     *       con un ID generado automáticamente y un nombre
     *       especificado.
     *
     * @param nombre Nombre de la ciudad.
     */
    @Modifying
    @Transactional
    @Query(
        value = """
            INSERT INTO ciudades (
                nombre
            )
            VALUES (
                :nombre
            )
            """,
        nativeQuery = true
    )
    void insertarCiudad(@Param("nombre") String nombre);

    /**
     * Obtiene la última ciudad creada.
     *
     * @return Collection<Ciudad> con un único elemento que será el último ID creado.
     */
    @Query(
        value = """
            SELECT *
            FROM ciudades
            WHERE id = (
                SELECT MAX(id)
                FROM ciudades
            )
            """,
        nativeQuery = true
    )
    Collection<Ciudad> getLast();

}
