defmodule InventoryManager do

  defp to_json(product) do
    {:ok, json_version} = Jason.encode(product)
    json_version
  end

  defp to_inv(products) do
    File.write("Inventory.json", products)
  end

  defp to_list() do
    File.stream!("Inventory.json")
    |> Enum.random()
    |> Jason.decode!()
  end

  def add_product(name, price, stock)do
    inventory = to_list()
    new_product = %Product{name: name , price: price, stock: stock, id: (length(inventory) + 1)}
    [new_product|inventory]
    |> to_json()
    |> to_inv()
  end

  def list_product() do
    inventory = to_list()
    inventory
  end

  def sell_product(id, quantity) do
    cart = []
    inventory = to_list()
    updated_inventory = Enum.map(inventory, fn product ->
      if product["id"] == id do
        new_stock = product.stock - quantity
        if new_stock >= 0 do
          [{product["id"],quantity}|cart]
        else
          "Insufficient stock"
        end
      end
    end)
    Enum.reject(inventory, updated_inventory)
    to_json(updated_inventory)
    |> to_inv()
  end

  def update_stock(id, new_stock) do
    inventory = to_list()
    updated_inventory = Enum.map(inventory, fn product -> product.id == id end)
    if updated_inventory do
      Enum.map(inventory, fn product ->
        if product.id == id do
          %Product{product | stock: new_stock}
        else
          product
        end
      end)
    end
    to_json(updated_inventory)
    |> to_inv()
  end

end
