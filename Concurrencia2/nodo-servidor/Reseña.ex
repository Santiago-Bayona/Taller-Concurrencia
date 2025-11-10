defmodule Resena do

  defstruct id: nil, texto: ""

  def nueva_resena(id, texto) do
    %Resena{id: id, texto: texto}
  end


  def limpiar(resena) do
    :timer.sleep(Enum.random(5..15) * 1000)
    resena.texto
    |> String.downcase()
    |> String.normalize(:nfd)
    |> String.replace(~r/[\p{Mn}]/u, "")
    |> String.replace(~r/[^a-zñ\s]/u, "")
    |> String.trim()

  end

  def secuencial(lista) do
    nueva_lista = Enum.map(lista, fn x -> {x.id, limpiar(x)} end)
    nueva_lista
  end

  def concurrente(lista) do
    tareas = Enum.map(lista, fn x -> Task.async( fn -> {x.id, limpiar(x)} end) end)
    nueva_lista = Task.await_many(tareas, :infinity)
    nueva_lista
  end

end
