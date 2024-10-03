package uniandes.edu.co.proyecto.controller;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import uniandes.edu.co.proyecto.MS;
import uniandes.edu.co.proyecto.modelo.Orden_compra;
import uniandes.edu.co.proyecto.repositorio.Orden_compraRepository;

@RestController
public class Ordenes_compraController {

    @Autowired
    private Orden_compraRepository orden_compraRepository;

    /**
     * Extrae las instancas de la tabla ordenes_compra
     * @return collection de instacias de la clase Orden_compra
     */
    @GetMapping("/ordenes_compra")
    public Collection<Orden_compra> darOrdens_compra() {
        return orden_compraRepository.findAll();
    }

    /**
     * Extre la orden de compra que tiene el id proporcionado
     * @param id identificador de la orden de compra
     * @return collecion de ordenes de compra - tamanio = 1
     */
    public Collection<Orden_compra> darOrden_compra(Integer id) {
        return orden_compraRepository.darOrden_compra(id);
    }

    /**
     * Aniade una orden de compra a la tabla ordenes_compra
     * @param orden_compra orden de compra que se quiere crear
     * @return resultado de la transaccion
     */
    @PostMapping("/ordenes_compra/new/save")
    public ResponseEntity<Map<String,Object>> orden_compraGuardar(@RequestBody Orden_compra orden_compra) {
        try {
            orden_compraRepository.insertarOrden_compra(orden_compra.getFecha_creacion(),
                                                        orden_compra.getFecha_esperada(),
                                                        orden_compra.getEstado(),
                                                        orden_compra.getId_bodega().getId(),
                                                        orden_compra.getId_proveedor().getId());
            orden_compra.setId(__getLast().getId());
            Map<String,Object> response = MS.response("ok","create",orden_compra);
            return new ResponseEntity<>(response, HttpStatus.CREATED);
        } catch (Exception e) {
            Map<String,Object> response = MS.response("not ok","create",e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Cambia el estado de una orden de compra de vigente a anulada, en otros casos no hace nada
     * @param id identificador de la orden de compra a actualizar
     * @return resultado de la transaccion
     */
    @PostMapping("/ordenes_compra/{id}/anular")
    public ResponseEntity<Map<String,Object>> orden_compraEditarGuardar(@PathVariable("id") Integer id) {
        try {
            Orden_compra orden_compra = ((List<Orden_compra>) darOrden_compra(id)).get(0);
            if(orden_compra.getEstado().equalsIgnoreCase("entregada") || orden_compra.getEstado().equalsIgnoreCase("anulada")) 
                    throw new Exception("No se puede anular una orden de compra en estado entregada o anulada");
            orden_compraRepository.anularOrden_compra(id);
            Map<String,Object> response = MS.response("ok","update",orden_compra);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            Map<String,Object> response = MS.response("not_ok","update",e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Devuelve la ultima instancia creada
     * @return ultima fila aniadida
     */
    public Orden_compra __getLast(){
        return orden_compraRepository.getLast().iterator().next();
    }
    
}