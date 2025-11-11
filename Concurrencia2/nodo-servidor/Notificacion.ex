defmodule Notificacion do


  defstruct canal: "", usuario: "", plantilla: ""

  def crear_notificacion(canal, usuario, plantilla) do
    %Notificacion{canal: canal, usuario: usuario, plantilla: plantilla}
  end


  # Define el costo por canal (en milisegundos)
  def costo_por_canal("email"), do: 100
  def costo_por_canal("sms"), do: 70
  def costo_por_canal("push"), do: 50
  def costo_por_canal(_), do: 60

  # Simula el envío de una notificación
  def enviar(%Notificacion{canal: canal, usuario: usuario, plantilla: plantilla}) do
    ms = costo_por_canal(canal)
    :timer.sleep(ms)
    IO.puts("Enviada a usuario #{usuario} (canal #{canal}) usando plantilla '#{plantilla}'")
    {usuario, canal, ms}
  end

  # Procesamiento secuencial
  def procesar_notificaciones_secuencial(lista_notifs) do
    Enum.map(lista_notifs, &enviar/1)
  end

  # Procesamiento concurrente (un proceso por notificación)
  def procesar_notificaciones_concurrente(lista_notifs) do
    lista_notifs
    |> Enum.map(fn notif ->
      Task.async(fn -> enviar(notif) end)
    end)
    |> Task.await_many()
  end


end
