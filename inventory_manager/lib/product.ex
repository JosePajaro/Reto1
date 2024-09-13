defmodule Product do
  defstruct id: 0, name: "", price: 0.0, stock: 0

  @type t :: %Product{id: non_neg_integer(), name: String.t(), price: Float, stock: non_neg_integer()}
end
