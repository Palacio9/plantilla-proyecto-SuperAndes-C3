package uniandes.edu.co.proyecto.controller;

import java.util.Collection;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.support.TransactionTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import uniandes.edu.co.proyecto.MS;
import uniandes.edu.co.proyecto.repositorio.DocumentoRepository;

@RestController
public class DocumentoController {

    @Autowired
    private DocumentoRepository documentoRepository;

    private final TransactionTemplate transactionTemplate;

    public ContieneController(PlatformTransactionManager transactionManager) {
        this.transactionTemplate = new TransactionTemplate(transactionManager);
    }

    @GetMapping("/documentos/{id_sucursal}/{id_bodega}/serializable")
    public ResponseEntity<?> consultarDocumentosIngresoProductoBodega(  @PathVariable("id_sucursal") Integer id_sucursal,
                                                                        @PathVariable("id_bodega") Integer id_bodega) {
        return transactionTemplate.execute(status -> {
            try {
                // Temporizador de 30 segundos antes de ejecutar la consulta
                Thread.sleep(30000);

                // Ejecutar la consulta
                Collection<Object> documentos = documentoRepository.consultarDocumentos_serializable(id_sucursal, id_bodega);
                return ResponseEntity.ok(documentos);
            } catch (Exception e) {
                // Rollback automático y mensaje de error
                status.setRollbackOnly();
                Map<String, Object> response = MS.response("not_ok", "get", e.getMessage());
                return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        });
    }
}
