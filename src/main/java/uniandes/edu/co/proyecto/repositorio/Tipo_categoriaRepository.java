package uniandes.edu.co.proyecto.repositorio;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import uniandes.edu.co.proyecto.modelo.Tipo_categoria;

public interface Tipo_categoriaRepository extends JpaRepository<Tipo_categoria, Integer> {

    /**
     * RF5.1 : Crea una nueva categoría.
     * SQL   : Inserta un nuevo tipo de categoría en la tabla 'tipos_categoria'
     *         con un ID generado automáticamente y valores específicos
     *         para nombre, descripción y características.
     *
     * @param nombre          Nombre de la categoría.
     * @param descripcion     Datos importantes de la categoría.
     * @param caracteristicas Detalles de almacenamiento específicos.
     */
    @Modifying
    @Transactional
    @Query(
        value = """
            INSERT INTO tipos_categoria (
                nombre,
                descripcion,
                caracteristicas
            )
            VALUES (
                :nombre,
                :descripcion,
                :caracteristicas
            )
            """,
        nativeQuery = true
    )
    void insertarTipo_categoria(@Param("nombre") String nombre,
                                @Param("descripcion") String descripcion,
                                @Param("caracteristicas") String caracteristicas);

    /**
     * RF5.2 : Lee una categoría por ID o nombre.
     * SQL   : Recupera el tipo de categoría de la tabla 'tipos_categoria'
     *         cuyo ID o nombre coincide con los valores especificados.
     *
     * @param id     Identificador único de la categoría.
     * @param nombre Nombre de la categoría.
     * @return Collection con la categoría(s) encontrada(s).
     */
    @Query(
        value = """
            SELECT *
            FROM tipos_categoria
            WHERE id = :id OR nombre = :nombre
            """,
        nativeQuery = true
    )
    Collection<Tipo_categoria> darTipo_categoriaPorIdONombre(   @Param("id") Integer id,
                                                                @Param("nombre") String nombre);

    /**
     * Obtiene la última categoría creada.
     *
     * @return Collection con un único elemento que será el último ID creado.
     */
    @Query(
        value = """
            SELECT *
            FROM tipos_categoria
            WHERE id = (
                SELECT MAX(id)
                FROM tipos_categoria
            )
            """,
        nativeQuery = true
    )
    Collection<Tipo_categoria> getLast();

}
