package uniandes.edu.co.proyecto.repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import uniandes.edu.co.proyecto.modelo.Documento;

public interface DocumentoRepository extends JpaRepository<Documento,Integer>{

    /**
     * RNF1: Agregar un documento a la tabla documentos
     *
     * @param id_orden_compra orden de compra asociada al nuevo documento
     */
    @Modifying
    @Transactional
    @Query(
        value = """
            INSERT INTO documentos (
                id_orden_compra
            )
            VALUES (
                :id_orden_compra
            )
            """,
        nativeQuery = true
    )
    void addDocumento(@Param("id_orden_compra")Integer id_orden_compra);

}
