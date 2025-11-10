defmodule Paquete do

  defstruct id: nil, peso: 0, fragil: false

  def crear_paquete(id, peso, fragil) do
    %Paquete{id: id, peso: peso, fragil: fragil}
  end

  def etiquetar(paquete) do
    if paquete.fragil == true do
      "Se etiqueta el paquete con id #{paquete.id} y se advierte que es fragil"
    else
      "Se etiqueta el paquete con id #{paquete.id}"
    end
  end

  def pesar(paquete) do
    "El paquete tiene un peso de #{paquete.peso}"
  end

  def emabalar(paquete) do
    if paquete.fragil == true do
      "Se embala con mayor cuidado y con más plastico"
    else
      "Se embala de manera normal"
    end
  end

  def preparar(paquete) do
    # Solo ejecuta las pausas, no imprime nada
    etiquetar(paquete)
    :timer.sleep(3000)
    pesar(paquete)
    :timer.sleep(4000)
    emabalar(paquete)
    :timer.sleep(5000)
    "Paquete #{paquete.id} preparado correctamente"
  end

  def tiempo_preparacion(paquete) do
    tiempo = Benchmark.determinar_tiempo_ejecucion({__MODULE__, :preparar, [paquete]})
    "Listo en #{tiempo} ms"
  end

  def secuencial(lista) do
    nueva_lista = Enum.map(lista, fn x -> {x.id, tiempo_preparacion(x)} end)
    nueva_lista
  end

  def concurrente(lista) do
    tareas = Enum.map(lista, fn x -> Task.async(fn -> {x.id, tiempo_preparacion(x)} end) end)
    nueva_lista = Task.await_many(tareas, :infinity)
    nueva_lista
  end

end
