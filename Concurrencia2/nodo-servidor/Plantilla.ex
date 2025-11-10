defmodule Tpl do
  defstruct id: "", nombre: "", vars: %{}

  def render(%Tpl{id: id, nombre: nombre, vars: vars}) do

    plantilla = "Hola %{nombre}, tu pedido %{pedido} está %{estado}."

    html =
      Enum.reduce(vars, plantilla, fn {clave, valor}, acc ->
        String.replace(acc, "%{#{clave}}", to_string(valor))
      end)

    :timer.sleep(Enum.random(10..25))
    IO.puts("Renderizado template #{id} (#{nombre})")
    {id, html}
  end

  def procesar_secuencial(plantillas) do
    Enum.map(plantillas, &render/1)
  end

  def procesar_concurrente(plantillas) do
    plantillas
    |> Enum.map(fn tpl -> Task.async(fn -> render(tpl) end) end)
    |> Task.await_many()
  end
end
