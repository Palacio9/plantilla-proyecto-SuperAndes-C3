package uniandes.edu.co.proyecto.Services;

import java.util.Collection;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import uniandes.edu.co.proyecto.MS;
import uniandes.edu.co.proyecto.modelo.Contiene;
import uniandes.edu.co.proyecto.modelo.Orden_compra;
import uniandes.edu.co.proyecto.repositorio.ContieneRepository;
import uniandes.edu.co.proyecto.repositorio.DocumentoRepository;
import uniandes.edu.co.proyecto.repositorio.Orden_compraRepository;

@Service
public class RegistroIngresoService {

    @Autowired
    private ContieneRepository contieneRepository;

    @Autowired
    private DocumentoRepository documentoRepository;

    @Autowired
    private Orden_compraRepository orden_compraRepository;

    /**
     * Transacción que llama a los 7 RNF que cumplen con ejecutar el RF10
     *
     * Se utiliza la anotación Transaccional para que si se lanza una excepción, se haga rollback,
     *     la excepción la recibe el PostMapping de ContieneController
     *
     * @param id_bodega           Identificador de la bodega
     * @param id_orden_compra     Identificador de la orden de compra
     * @return ResponseEntity<?>  Resultado de la transacción
     */
    @Transactional(rollbackFor = Exception.class)
    public ResponseEntity<?> registrarIngresoProducto(Integer id_bodega, Integer id_orden_compra)
            throws Exception{
        Map<String, Object> response;
        documentoRepository.addDocumento(id_orden_compra);
        Collection<Integer> productos = orden_compraRepository.getProductos(id_orden_compra);
        for (Integer id_producto : productos){
            Collection<Contiene> contiene_list = contieneRepository.getPorPK(   id_bodega,
                                                                                id_producto);
            if(contiene_list.isEmpty()){
                contieneRepository.createFila(  id_bodega,
                                                id_producto,
                                                id_orden_compra);
            }else{
                contieneRepository.actualizarFila(  id_bodega,
                                                    id_producto,
                                                    id_orden_compra);
            }
        }
        Orden_compra orden = orden_compraRepository.darOrden_compra(id_orden_compra).iterator().next();
        if(orden.getEstado().equals("vigente")){
            orden_compraRepository.actualizarEstadoAEntregado(id_orden_compra);
        }else{
            if (orden.getEstado().equals("entregada"))
                throw new Exception("La orden ya fue entregada");
            if (orden.getEstado().equals("anulada"))
                throw new Exception("La orden fue anulada");
        }

        response = MS.response("ok", "create", "ingreso de producto registrado correctamente");
        return ResponseEntity.ok(response);
    }
}
