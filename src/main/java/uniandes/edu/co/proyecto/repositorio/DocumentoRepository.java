package uniandes.edu.co.proyecto.repositorio;

import java.util.Collection;

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

    @Query(
        value = """
            select do.id, do.fecha_creacion, prov.id id_p, prov.nombre proveedor from documentos do
join ordenes_compra oc ON oc.id = do.id_orden_compra
join proveedores prov ON prov.id = oc.id_proveedor
join bodegas bo ON bo.id = oc.id_bodega
where bo.id = 1 AND bo.id_sucursal = 1 AND do.fecha_creacion >= CURRENT_DATE - 30
            """,
        nativeQuery = true
    )
    Collection<Object> consultarDocumentos_serializable(Integer id_sucursal, Integer id_bodega);

}
