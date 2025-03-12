package uniandes.edu.co.proyecto.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import uniandes.edu.co.proyecto.MS;
import uniandes.edu.co.proyecto.Services.RegistroIngresoService;


@RestController
public class ContieneController {

    @Autowired
    private RegistroIngresoService registroIngresoService;

    /**
     * Transacción de registrar el ingreso de productos a una bodega
     *
     * @param id_bodega           Bodega a la que se le ingresaran productos.
     * @param id_orden_compra     Orden de compra la cual se va a registrar dentor de la bodega.
     * @return ResponseEntity<?>  Resultado de la transacción.
     */
    @PostMapping("/contiene/{id_bodega}/{id_orden_compra}/new/save")
    public ResponseEntity<?> registrarIngresoProductoEnBodegaDadaOrdenCompra(   @PathVariable("id_bodega") Integer id_bodega,
                                                                                @PathVariable("id_orden_compra") Integer id_orden_compra){
        try {
            return registroIngresoService.registrarIngresoProducto(id_bodega, id_orden_compra);
        } catch (Exception e) {
            Map<String,Object> response = MS.response("not_ok","create",e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
        
    }

}
