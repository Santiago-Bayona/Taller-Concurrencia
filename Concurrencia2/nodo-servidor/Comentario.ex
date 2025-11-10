defmodule Comentario do


  defstruct id: "", contenido: ""

  def crear_comentario(id, contenido) do
    %Comentario{id: id, contenido: contenido}
  end

  @palabras_prohibidas ["spam", "oferta falsa", "click aquí", "gratis"]

   def moderar_comentario(%Comentario{id: id, contenido: contenido}) do
    # Verifica si contiene palabras prohibidas o es muy largo
    contiene_prohibidas? =
      Enum.any?(@palabras_prohibidas, fn palabra ->
        String.contains?(String.downcase(contenido), palabra)
      end)

    estado =
      cond do
        contiene_prohibidas? -> :rechazado
        String.length(contenido) > 150 -> :rechazado
        true -> :aprobado
      end

    :timer.sleep(Enum.random(5..12))
    IO.puts("Comentario #{id} moderado -> #{estado}")
    {id, estado}
  end


  def procesar_comnetario_secuencial(comentarios) do
    Enum.map(comentarios, &moderar_comentario/1)
  end

  def procesar_comentario_concurrente(comentarios) do
    Enum.map(comentarios, fn comentario ->
      Task.async(fn -> moderar_comentario(comentario) end)
    end)
    |> Task.await_many()
  end





end
