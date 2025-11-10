defmodule NodoServidor do
  @nombre_servicio_local :servicio_trabajo_grados

  def main() do
    Util.mostrar_mensaje("SERVIDOR INICIADO")
    registrar_servicio(@nombre_servicio_local)
    procesar_mensajes()
  end


  defp registrar_servicio(nombre_servicio_local), do: Process.register(self(), nombre_servicio_local)
  defp procesar_mensajes() do
    receive do
      {productor, mensaje} ->
      respuesta = procesar_mensaje(mensaje)
      send(productor, respuesta)
      # Llama recursivamente para seguir recibiendo mensajes
      if respuesta != :fin, do: procesar_mensajes()
    end
  end
  defp procesar_mensaje(:fin), do: :fin

  defp procesar_mensaje(:iva) do
    Iva.concurrente(Listas.productos())
  end

  defp procesar_mensaje(:resena) do
    Resena.concurrente(Listas.resenas())
  end

  defp procesar_mensaje(:paquete) do
    Paquete.concurrente(Listas.paquetes())
  end

  defp procesar_mensaje(:tarea) do
    Mantenimiento.concurrente(Listas.tareas())
  end

  defp procesar_mensaje(:usuario) do
    Usuario.concurrente(Listas.usuarios())
  end

  defp procesar_mensaje(:plantilla) do
    Tpl.procesar_concurrente(Listas.plantillas())
  end

  defp procesar_mensaje(mensaje), do: "El comando \"#{mensaje}\" es desconocido."

end
NodoServidor.main()
