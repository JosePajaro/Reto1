defmodule InventoryManager do

  defp to_json(product) do
    {:ok, json_version} = Jason.encode(product)
    json_version
  end

  defp to_inventory(products) do
    File.write("Inventory.json", products)
  end

  defp to_cart(buy) do
    File.write("cart.json", buy)
  end

  defp to_listCart() do
    File.stream!("cart.json")
    |> Enum.random()
    |> Jason.decode!()
  end

  def list_products() do
    File.stream!("Inventory.json")
    |> Enum.random()
    |> Jason.decode!()
  end

  def add_product(name, price, stock)do
    inventory = list_products()
    new_product = %{id: length(inventory) + 1, name: name , price: price, stock: stock}
    [new_product|inventory]
    |> to_json()
    |> to_inventory()
  end

  def increase_stock(id, new_stock) do
    inventory = list_products()
    if product = Enum.find(inventory, fn product -> product["id"] == id end) do
      IO.inspect(product)
      product = Map.put(product,"stock",new_stock + product["stock"])
      inventory = Enum.reject(inventory, fn product -> product["id"] == id end)
      [product|inventory]
      |>to_json()
      |> to_inventory()
    else
      IO.inspect("Product not found")
    end
  end

  def sell_product(id, quantity) do
    cart = to_listCart()
    inventory = list_products()
    product = Enum.find(inventory, fn product -> product["id"] == id end)
    if product != nil do
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
          |> to_inventory()
        _ ->
          IO.inspect("Insufficient stock")
      end
    else
      IO.inspect("The product not exiting")
    end
  end

  def view_cart() do
    cart = to_listCart()
    IO.puts("Cart:\n------------------------------------------\nItems     | ID | Quantity | Price | Total\n------------------------------------------")
    if length(cart) > 0 do
      total = Enum.reduce(cart,0, fn product, total ->
        id = product["id"]
        product1 = Enum.find(list_products(), fn product -> product["id"] == id end)
        IO.puts("#{product1["name"]}  | #{id}      #{product["quantity"]}       #{product1["price"]}   #{product1["price"] * product["quantity"]}")
        total + product["quantity"] * product1["price"]
      end)
      IO.puts("------------------------------------------\nTotal: $#{total}")
    else
      IO.inspect("Cart is empty")
    end
  end

  def checkout(), do: to_cart(to_json([]))

end
