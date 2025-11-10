defmodule Mantenimiento do

  def ejecutar(tarea) do
    case tarea do
      :reindex ->
        :timer.sleep(2000)
        "OK tarea reindex"
      :purge_cache ->
        :timer.sleep(3000)
        "OK tarea purge_cache"
      :build_sitemap ->
        :timer.sleep(1000)
        "OK tarea build_sitemap"
      _ ->
        "Tarea no reconocida"
    end
  end

  def secuencial(lista) do
    Enum.map(lista, fn x -> ejecutar(x) end)
  end

  def concurrente(lista) do
    tareas = Enum.map(lista, fn x -> Task.async(fn -> ejecutar(x) end) end)
    nueva_lista = Task.await_many(tareas, :infinity)
    nueva_lista
  end

end
