defmodule Iva do

  defstruct nombre: nil, stock: 0, precio_sin: 0, iva: 0.0

  def precio_final(producto) do
    (producto.precio_sin * (1 + producto.iva)) |> Float.round(0)
  end

  def secuencial (lista) do

    nueva_lista = Enum.map(lista, fn x -> {x.nombre, precio_final(x) } end)
    IO.inspect(nueva_lista)
    nueva_lista

  end

  def concurrente (lista) do
    tareas = Enum.map(lista, fn x -> Task.async ( fn -> {x.nombre, precio_final(x)} end) end)

    nueva_lista = Task.await_many(tareas)
    nueva_lista
  end


end
