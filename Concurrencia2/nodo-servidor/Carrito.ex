defmodule Carrito do

  defstruct id: "", items: [], cupon: ""

  def crear_carrito(id, items, cupon) do
    %Carrito{id: id, items: items, cupon: cupon}
  end


  def total_con_descuentos(%Carrito{id: id, items: items, cupon: cupon}) do
    # Sumamos el total de los items
    subtotal = Enum.reduce(items, 0, fn {_, precio, _, cantidad}, acc ->
      acc + precio * cantidad
    end)

    # Regla 1: cupón 10%
    total_desc =
      case cupon do
        "DESC10" -> subtotal * 0.9
        "2x1" ->
          # quitar el producto más barato si hay al menos 2 productos
          if length(items) >= 2 do
            {_, precio_min, _, _} = Enum.min_by(items, fn {_, p, _, _} -> p end)
            subtotal - precio_min
          else
            subtotal
          end
        _ -> subtotal
      end

    # Regla 2: descuento por categoría “alimentos”
    tiene_alimentos = Enum.any?(items, fn {_, _, categoria, _} -> categoria == "alimentos" end)
    total_final = if tiene_alimentos, do: total_desc * 0.95, else: total_desc

    # Simulamos trabajo pesado
    :timer.sleep(Enum.random(5..15))

    IO.puts("Descuento aplicado Carrito #{id}")

    {id, Float.round(total_final, 2)}
  end
  
  def procesar_carritos_secuencial(carritos) do
    Enum.map(carritos, &total_con_descuentos/1)
  end

  def procesar_carritos_concurrente(carritos) do
    Enum.map(carritos, fn carrito ->
      Task.async(fn -> total_con_descuentos(carrito) end)
    end)
    |> Task.await_many()
  end

end
