defmodule Items do

  defstruct nombre: "", precio: 0.0, categoria: "", cantidad: 0

  def crear_item(nombre, precio, categoria, cantidad) do
    %Items{nombre: nombre, precio: precio, categoria: categoria, cantidad: cantidad}
  end

end
