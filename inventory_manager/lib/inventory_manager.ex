defmodule InventoryManager do

  defp to_json(product) do
    {:ok, json_version} = Jason.encode(product)
    json_version
  end

  defp to_file(products) do
    File.write("Inventory.json", products)
  end

  defp to_list() do
    File.stream!("Inventory.json")
    |> Enum.random()
    |> Jason.decode!()
  end

  defp to_cart(buy) do
    File.write("cart.json", buy)
  end

  def to_listCart() do
    File.stream!("cart.json")
    |> Enum.random()
    |> Jason.decode!()
  end

  @spec add_product(String.t(), Float, Integer) :: :ok | {:error, atom()}
  def add_product(name, price, stock)do
    inventory = to_list()
    new_product = %{id: length(inventory) + 1, name: name , price: price, stock: stock}
    [new_product|inventory]
    |> to_json()
    |> to_file()
  end

  def list_products() do
    inventory = to_list()
    inventory
  end

  def increase_stock(id, new_stock) do
    inventory = to_list()
    product = Enum.find(inventory, fn product -> product["id"] == id end)
    |>Map.put("stock",new_stock)
    inventory = Enum.reject(inventory, fn product -> product["id"] == id end)
    [product|inventory]
    |>to_json()
    |> to_file()
  end

  def sell_product(id, quantity) do
    cart = to_listCart()
    inventory = to_list()
    product = Enum.find(inventory, fn product -> product["id"] == id end)
    new_stock = product["stock"] - quantity
    case new_stock >= 0 do
      :true ->
        product = Map.put(product, "stock" , new_stock)
        tuple = %{id: product["id"], quantity: quantity}
        [tuple|cart]
        |>to_json()
        |>to_cart()
        inventory = Enum.reject(inventory, fn product -> product["id"] == id end)
        [product|inventory]
        |> to_json()
        |> to_file()
      _ ->
        IO.inspect("Insufficient stock")
    end
  end

  def view_cart(cart) do
    IO.puts("Cart:")
    IO.puts("--------------------")
    IO.puts("ID | Quantity | Price | Total")
    IO.puts("--------------------")
    IO.puts("")
    if length(cart) > 0 do
      total = 0
      Enum.each(cart, fn product ->
        id = product["id"]
        price = Enum.find(to_list(), fn product -> product["id"] == id end)["price"]
        IO.puts("#{id}, #{product["quantity"]}, #{price}, #{price * product["quantity"]}")
      end)
      IO.puts("--------------------")
      IO.puts("Total: #{total}")
    else
      IO.inspect("Cart is empty")
    end
  end

  def checkout(), do: to_cart(to_json([]))

end
