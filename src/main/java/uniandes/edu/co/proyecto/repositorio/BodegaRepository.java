package uniandes.edu.co.proyecto.repositorio;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import uniandes.edu.co.proyecto.modelo.Bodega;

public interface BodegaRepository extends JpaRepository<Bodega, Integer> {

    /**
     * RF1.1 : Crea una bodega dada su información.
     * SQL   : Inserta un nuevo registro en la tabla 'bodegas'
     *         con un ID generado automáticamente y valores
     *         específicos para nombre, tamaño y sucursal.
     *
     * @param nombre      Nombre de la bodega.
     * @param tamanio     Tamaño de la bodega en metros cuadrados.
     * @param id_sucursal Identificador de la sucursal asociada.
     */
    @Modifying
    @Transactional
    @Query(
        value = """
            INSERT INTO bodegas (
                nombre,
                tamanio,
                id_sucursal
            )
            VALUES (
                :nombre,
                :tamanio,
                :id_sucursal
            )
            """,
        nativeQuery = true
    )
    void insertarBodega(@Param("nombre") String nombre,
                        @Param("tamanio") String tamanio,
                        @Param("id_sucursal") Integer id_sucursal);

    /**
     * RF3.2 : Borra una bodega.
     * SQL   : Elimina un registro de la tabla 'bodegas' cuyo ID
     *         coincide con el valor proporcionado.
     *
     * @param id Identificador de la bodega que se desea eliminar.
     */
    @Modifying
    @Transactional
    @Query(
        value = """
            DELETE FROM bodegas
            WHERE id = :id
            """,
        nativeQuery = true
    )
    void eliminarBodega(@Param("id") Integer id);

    /**
     * Obtiene la última bodega creada.
     *
     * @return Collection<Bodega> con un único elemento que será el último ID creado.
     */
    @Query(
        value = """
            SELECT *
            FROM bodegas
            WHERE id = (
                SELECT MAX(id)
                FROM bodegas
            )
            """,
        nativeQuery = true
    )
    Collection<Bodega> getLast();

}
