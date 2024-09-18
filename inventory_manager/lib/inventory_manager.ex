defmodule InventoryManager do

  def inventory() do
    :ets.new(:inventory,[:set, :public, :named_table])
  end

  def cart() do
    :ets.new(:cart,[:set, :public, :named_table])
  end

  def add_product(inventory, name, price, stock)do
    new_product = %{"id"=> :ets.info(inventory, :size) + 1, "name"=> name , "price"=> price, "stock"=> stock}
    :ets.insert_new(inventory, {new_product["id"],new_product})
    IO.puts ("Su producto fue creado con el id: #{new_product["id"]}!")
  end

  def list_products(inventory) do
    :ets.tab2list(inventory)
  end

  def increase_stock(inventory, id, new_stock) do
    size = :ets.info(inventory, :size)
    if size != 0 do
      if id > size || id <= 0 do
        IO.puts("The Product not exist!!")
      else
        [{_, product}] = :ets.lookup(inventory, id)
        product = Map.put(product, "stock", new_stock + product["stock"])
        :ets.insert(inventory, {id, product})
        IO.puts("The stock of the product with the id #{id} was increased in #{product["stock"]}!")
        :ok
      end
    else
      IO.puts("Inventory is empty")
    end
  end

  def sell_product(inventory, id, quantity) do
    sizeI = :ets.info(inventory, :size)
    sizeC = :ets.info(:cart, :size)
    if sizeI != 0 do
      if id > sizeI || id <= 0 do
        IO.puts("The Product not exist!!")
      else
        [{_,product}] = :ets.lookup(inventory, id)
        new_stock = product["stock"] - quantity
        case new_stock >= 0 do
          :true ->
            product = Map.put(product, "stock" , new_stock)
            :ets.insert(inventory, {id, product})
            IO.puts("The stock of the product with the #{id} was decreased!")
            :ets.insert_new(:cart,{sizeC+1,{id, quantity}})
            IO.puts("The product add to cart was successfully")
          _ ->
            IO.inspect("Insufficient stock")
          end
      end
    else
      IO.puts("Inventory is empty")
    end
  end

  def view_cart(cart) do
    list_Cart = :ets.tab2list(cart)
    list_Inventory = :ets.tab2list(:inventory)
    IO.puts("Cart:\n------------------------------------------\nItems     | ID | Quantity | Price | Total\n------------------------------------------")
    if :ets.info(cart, :size) > 0 do
      total = Enum.reduce(list_Cart,0, fn {_,{id,quantity}}, total ->
        {_,product} = Enum.find(list_Inventory, fn {_,product} -> product["id"] == id end)
        IO.puts("#{product["name"]}  | #{id}      #{quantity}       #{product["price"]}   #{product["price"] * quantity}")
        total + quantity * product["price"]
      end)
      IO.puts("------------------------------------------\nTotal: $#{total}")
    else
      IO.inspect("Cart is empty")
    end
  end

  def checkout(cart) do
    :ets.delete(cart)
    cart()
  end

  def run() do
    IO.puts("------------------------------------------\nWelcome to the Inventory Manager!\n1. Add a product\n2. View inventory\n3. Increase stock\n4. Sell a product\n5. View cart\n6. Checkout\n7. Exit\n------------------------------------------")
    {n,_} = IO.gets("Insert the options: ")
    |>Integer.parse()
    case n do
      1 ->
        name = IO.gets("Enter the product name: ")
        {price,_} = Float.parse(IO.gets("Enter the product price: "))
        {stock,_} = Integer.parse(IO.gets("Enter the product stock: "))
        IO.puts(add_product(:inventory, name, price, stock))
        run()
      2->
        IO.puts("Inventory...")
        IO.inspect(list_products(:inventory))
        run()
      3 ->
        {id,_} = Integer.parse(IO.gets("Enter the product ID: "))
        {new_stock,_} = Integer.parse(IO.gets("Enter the new stock: "))
        increase_stock(:inventory, id, new_stock)
        run()
      4 ->
        {id,_} = Integer.parse(IO.gets("Enter the product ID: "))
        {quantity,_} = Integer.parse(IO.gets("Enter the quantity to sell: "))
        sell_product(:inventory, id, quantity)
        run()
      5 ->
        IO.puts("Your Cart")
        view_cart(:cart)
        run()
      6 ->
        IO.puts("Checkout sucessfully")
        checkout(:cart)
        run()
      7 ->
        IO.puts("Bye!")
        :ets.delete(:inventory)
        :ets.delete(:cart)
        :ok
      _ ->
        IO.puts("Invalid option, please try again.")
        run()
      end
  end
end
