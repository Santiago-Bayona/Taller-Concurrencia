defmodule Sucursal do

  defstruct id: "", ventas_diarias: [{"", 0}]

  def crear_sucursal(id, ventas_diarias) do
    %Sucursal{id: id, ventas_diarias: ventas_diarias}
  end

  def generar_reporte(%Sucursal{id: id, ventas_diarias: ventas}) do
    total_ventas = ventas |> Enum.map(&elem(&1, 1)) |> Enum.sum()
    top3 = ventas |> Enum.sort_by(fn {_item, cont} -> cont end, :desc) |> Enum.take(3)
    ms = Enum.random(50..120)
    :timer.sleep(ms)
    IO.puts("Reporte listo Sucursal #{id}")

    # Retornamos un resumen (puede guardarse o enviarse)
    %{
      id: id,
      total_ventas: total_ventas,
      top3: top3,
      simulated_ms: ms
    }
  end

  def procesar_secuencial(sucursales) do
    Enum.map(sucursales, &generar_reporte/1)
  end



    def procesar_concurrente(sucursales)do
    Enum.map(sucursales, fn sucursal ->
      Task.async(fn -> generar_reporte(sucursal) end)
    end)
    |> Task.await_many()
  end





  end
