package uniandes.edu.co.proyecto.repositorio;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import uniandes.edu.co.proyecto.modelo.Proveedor;

public interface ProveedorRepository extends JpaRepository<Proveedor, Integer> {

    /**
     * RF4.1 : Crea un nuevo proveedor.
     * SQL   : Inserta un nuevo proveedor en la tabla 'proveedores'
     *         con un ID generado automáticamente y valores específicos
     *         para nombre, teléfono y dirección.
     *
     * @param nombre    Nombre del proveedor.
     * @param telefono  Teléfono del proveedor.
     * @param direccion Dirección del proveedor.
     */
    @Modifying
    @Transactional
    @Query(
        value = """
            INSERT INTO proveedores (
                nombre,
                telefono,
                direccion
            )
            VALUES (
                :nombre,
                :telefono,
                :direccion
            )
            """,
        nativeQuery = true
    )
    void insertarProveedor( @Param("nombre") String nombre,
                            @Param("telefono") String telefono,
                            @Param("direccion") String direccion);

    /**
     * RF4.2 : Actualiza un proveedor.
     * SQL   : Actualiza el nombre, teléfono y dirección del proveedor
     *         en la tabla 'proveedores' para el registro cuyo ID
     *         coincide con el valor especificado.
     *
     * @param id        Identificador del proveedor.
     * @param nombre    Nombre actualizado del proveedor.
     * @param telefono  Teléfono actualizado del proveedor.
     * @param direccion Dirección actualizada del proveedor.
     */
    @Modifying
    @Transactional
    @Query(
        value = """
            UPDATE proveedores
            SET nombre = :nombre,
                telefono = :telefono,
                direccion = :direccion
            WHERE id = :id
            """,
        nativeQuery = true
    )
    void actualizarProveedor(   @Param("id") Integer id,
                                @Param("nombre") String nombre,
                                @Param("telefono") String telefono,
                                @Param("direccion") String direccion);

    /**
     * Obtiene el último proveedor creado.
     *
     * @return Collection con un único elemento que será el último ID creado.
     */
    @Query(
        value = """
            SELECT *
            FROM proveedores
            WHERE id = (
                SELECT MAX(id)
                FROM proveedores
            )
            """,
        nativeQuery = true
    )
    Collection<Proveedor> getLast();

}
