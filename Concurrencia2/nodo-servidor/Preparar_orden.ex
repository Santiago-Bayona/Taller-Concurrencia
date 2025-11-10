defmodule Preparar_orden do

  def preparar(%Orden{id: id, item: item, prep_ms: prep_ms}) do
  :timer.sleep(prep_ms)
  IO.puts("Ticket ##{id}: #{item} (#{prep_ms}ms)")
  {item, prep_ms}
end


  def ordenes_secuencial(ordenes) do
  Enum.map(ordenes, &preparar/1)
  |>Enum.sort_by(fn {_orden, prep_ms} -> prep_ms end)
end


def ordenes_conncurrente(ordenes)do
    Enum.map(ordenes, fn orden ->
      Task.async(fn -> preparar(orden) end)
    end)
    |> Task.await_many()
    |> Enum.sort_by(fn {_orden, prep_ms} -> prep_ms end)
  end



end
