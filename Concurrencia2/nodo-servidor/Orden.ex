defmodule Orden do

  defstruct id: "", item: "", prep_ms: 0

  def crear_orden(id, item, prep_ms) do
    %Orden{id: id, item: item, prep_ms: prep_ms}
  end

end
