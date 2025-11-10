defmodule Usuario do
  defstruct nombre: "", edad: 0, email: ""

  def nuevo(nombre, edad, email) do
    %Usuario{nombre: nombre, edad: edad, email: email}
  end

  def verificar_usuario(usuario) do
    :timer.sleep(Enum.random(3..10))

    arroba = usuario.email
    |> String.contains?("@")

    mayor= usuario.edad >= 0

    vacio = usuario.nombre != ""

    if arroba && mayor && vacio do
      :ok
    else
      {:error, "Usuario no valido"}

    end

  end

  def secuencial ( lista ) do
    nueva_lista = Enum.map(lista, fn x -> {x.email, verificar_usuario(x)} end)
    nueva_lista
  end

  def concurrente ( lista ) do
    tareas = Enum.map(lista, fn x -> Task.async(fn -> {x.email, verificar_usuario(x)} end) end)

    nueva_lista = Task.await_many(tareas, :infinity)
    nueva_lista
  end

end
