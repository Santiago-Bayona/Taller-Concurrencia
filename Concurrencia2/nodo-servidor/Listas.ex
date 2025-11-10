defmodule Listas do
  def ordenes() do
    o1 = %Iva{nombre: "Sandwich", stock: 10, precio_sin: 3000, iva: 0.19}
    o2 = %Iva{nombre: "Ensalada", stock: 5, precio_sin: 1000, iva: 0.19}
    o3 = %Iva{nombre: "Jugo", stock: 15, precio_sin: 1500, iva: 0.05}
    o4 = %Iva{nombre: "Café", stock: 20, precio_sin: 2000, iva: 0.19}

    ordenes = [o1, o2, o3, o4]
  end

  def productos() do
    p1 = %Iva{nombre: "Libro A", stock: 10, precio_sin: 20000, iva: 0.10}
    p2 = %Iva{nombre: "Libro B", stock: 5, precio_sin: 15000, iva: 0.10}
    p3 = %Iva{nombre: "Libro C", stock: 8, precio_sin: 30000, iva: 0.10}
    p4 = %Iva{nombre: "Libro D", stock: 12, precio_sin: 25000, iva: 0.10}

    productos = [p1, p2, p3, p4]
  end

  def paquetes() do
    pa1 = Paquete.crear_paquete("1", 5, true)
    pa2 = Paquete.crear_paquete("2", 10, false)
    pa3 = Paquete.crear_paquete("3", 3, true)
    pa4 = Paquete.crear_paquete("4", 7, false)

    paquetes = [pa1, pa2, pa3, pa4]
  end

  def resenas() do
    r1 = Resena.nueva_resena("1", "¡Excelente producto! Lo recomiendo mucho.")
    r2 = Resena.nueva_resena("2", "El producto llegó en mal estado :(")
    r3 = Resena.nueva_resena("3", "Muy buen servicio y atención al cliente.")
    r4 = Resena.nueva_resena("4", "No cumplió con mis expectativas.")

    resenas = [r1, r2, r3, r4]
  end

  def usuarios() do
    u1 = Usuario.nuevo("usuario1", 17, "usuario1@example.com")
    u2 = Usuario.nuevo("usuario2", 22, "usuario2example.com")
    u3 = Usuario.nuevo("usuario3", -30, "usuario3@example.com")
    u4 = Usuario.nuevo("", 25, "usuario4@example.com")

    usuarios = [u1, u2, u3, u4]
  end

  def tareas() do
    [:reindex, :purge_cache, :build_sitemap, :unknown_task]
  end

  def plantillas() do
    t1 = %Tpl{id: "1", nombre: "Pedido Enviado", vars: %{nombre: "Juan", pedido: "1234", estado: "enviado"}}
    t2 = %Tpl{id: "2", nombre: "Pedido Procesando", vars: %{nombre: "María", pedido: "5678", estado: "procesando"}}
    t3 = %Tpl{id: "3", nombre: "Pedido Entregado", vars: %{nombre: "Carlos", pedido: "9101", estado: "entregado"}}
    t4 = %Tpl{id: "4", nombre: "Pedido Cancelado", vars: %{nombre: "Ana", pedido: "1121", estado: "cancelado"}}

    plantillas = [t1, t2, t3, t4]
  end

end
