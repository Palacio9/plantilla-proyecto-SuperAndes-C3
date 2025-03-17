package uniandes.edu.co.proyecto;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

public class MS {

    public static final String BODEGA_ELIMINADA =
            "Bodega eliminada correctamente";
    public static final String EXCEPTION_ANULAR_ORDEN_COMPRA_ENTREGADA_O_ANULADA =
            "No se puede anular una orden de compra en estado entregada o anulada";
    public static final String DEMASIADAS_ENTRADAS_EXCEPTION =
            "Demasiadas entradas";
    public static final String SIN_RESULTADOS_EXCEPTION =
            "No se encontraron resultados";
    public static final String BODEGA_SIN_SUCURSAL_EXCEPTION =
            "Se proporcionó la bodega pero no la sucursal";
    public static final String SIN_PARAMETROS_EXCEPTION =
            "No se recibió ningún parámetro";
    public static final String LISTA_VACIA_EXCEPTION =
            "Se dio una lista vacía :(";

    /**
     * Crea un mapa con la respuesta dado sus resultados.
     * Este será incluido como argumento principal en una ResponseEntity.
     *
     * @param resultado Estado de la operación (ok o not ok).
     * @param accion    Acción que se ejecutó (create, get, update, delete).
     * @param object    Objeto importante para la respuesta, puede ser una clase del modelo o un String.
     * @return Mapa con la respuesta de la transacción.
     */
    public static Map<String, Object> response(String resultado, String accion, Object object) {
        if (object == null) {
            return response("not ok", accion, "object not found - object = null");
        }
        Map<String, Object> out = new HashMap<>();
        out.put("resultado", resultado.toUpperCase());
        out.put("accion", accion.toUpperCase());
        
        if (object instanceof String) {
            out.put("message", object);
        } else {
            Map<String, Object> map0 = new HashMap<>();
            Class<?> clase = object.getClass();
            Field[] campos = clase.getDeclaredFields();
            
            for (Field campo : campos) {
                campo.setAccessible(true);
                try {
                    map0.put(campo.getName(), campo.get(object));
                } catch (IllegalAccessException e) {
                    return response(resultado, accion, e.getMessage());
                }
            }
            out.put(object.getClass().getName(), map0);
        }
        return out;
    }
}
