defmodule NodoCliente do
  @nombre_servicio_local :servicio_respuesta
  @servicio_local {@nombre_servicio_local, :nodocliente@cliente}
  @nodo_remoto :"nodoservidor@localhost"
  @servicio_remoto {:servicio_trabajo_grados, @nodo_remoto}

  def main() do
    Util.mostrar_mensaje("PROCESO PRINCIPAL")
    @nombre_servicio_local
    |> registrar_servicio()
    establecer_conexion(@nodo_remoto)
    |> iniciar_produccion()
  end

  defp registrar_servicio(nombre_servicio_local), do: Process.register(self(), nombre_servicio_local)

  defp establecer_conexion(nodo_remoto) do
    Node.connect(nodo_remoto)
  end

  defp iniciar_produccion(false), do: Util.mostrar_error("No se pudo conectar con el nodo servidor")

  defp iniciar_produccion(true) do
    Util.mostrar_mensaje("Comandos disponibles:
    -iva
    -resena
    -paquete
    -tarea
    -usuario
    -plantilla
    -fin")
    loop_usuario()
  end

  def loop_usuario()do
    comando = "Ingrese el comando:"
    |>Util.ingresar(:texto)
    |>String.trim()
    |>String.downcase()

    cond do
      comando == "fin" ->
        send(@servicio_remoto, {@servicio_local, :fin})
      comando == "iva" ->
        send(@servicio_remoto, {@servicio_local, :iva})
        recibir_respuestas()
        loop_usuario()
      comando == "resena" ->
        send(@servicio_remoto, {@servicio_local, :resena})
        recibir_respuestas()
        loop_usuario()
      comando == "paquete" ->
        send(@servicio_remoto, {@servicio_local, :paquete})
        recibir_respuestas()
        loop_usuario()
      comando == "tarea" ->
        send(@servicio_remoto, {@servicio_local, :tarea})
        recibir_respuestas()
        loop_usuario()
      comando == "plantilla" ->
        send(@servicio_remoto, {@servicio_local, :plantilla})
        recibir_respuestas()
        loop_usuario()
      comando == "usuario" ->
        send(@servicio_remoto, {@servicio_local, :usuario})
        recibir_respuestas()
        loop_usuario()
      true ->
        Util.mostrar_error("Comando no reconocido")
        loop_usuario()
    end
  end

  defp recibir_respuestas() do
    receive do
      respuesta ->
        Util.mostrar_mensaje("\t -> \"#{inspect(respuesta)}\"")
    after
      20000 -> # opcional: timeout en ms por si algo falla
        Util.mostrar_error("Tiempo de espera agotado al recibir respuesta.")
    end
  end

end
NodoCliente.main()
