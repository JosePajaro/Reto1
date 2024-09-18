defmodule InventoryManagerTest do
  use ExUnit.Case
  doctest InventoryManager

  test "probando add_product" do
    test = :ets.new(:test, [:set, :private, :named_table])
    assert InventoryManager.add_product(test, "Product 1", 10000.00, 5) == :ok
    :ets.delete(test)
  end

  test "Probando list_product" do
    test = :ets.new(:test, [:set, :private, :named_table])
    InventoryManager.add_product(test, "Product 1", 10000.00, 5)
    InventoryManager.add_product(test, "Product 2", 20000.00, 5)
    assert InventoryManager.list_products(test) == [
      {1,%{"id" => 1,"name" => "Product 1","price" => 10000.0,"stock" => 5}},
      {2,%{"id" => 2,"name" => "Product 2","price" => 20000.0,"stock" => 5}}
    ]
    :ets.delete(test)
  end

  test "probando increase_stock" do
    test = :ets.new(:test, [:set, :private, :named_table])
    InventoryManager.add_product(test, "Product 1", 10000.00, 5)
    [{_,product}] = :ets.lookup(test, 1)
    assert product["stock"] == 5
    assert InventoryManager.increase_stock(test, 1, 10) == :ok
    [{_,product}] = :ets.lookup(test, 1)
    assert product["stock"] == 15
    :ets.delete(test)
  end

  test "probando sell_products" do
    test = :ets.new(:test, [:set, :private, :named_table])
    :ets.new(:cart, [:set, :private, :named_table])
    InventoryManager.add_product(test, "Product 1", 10000.00, 5)
    assert InventoryManager.sell_product(test, 1, 2) == :ok
    assert InventoryManager.sell_product(test, 1, 3) == :ok
    [{_,product}] = :ets.lookup(test, 1)
    assert product["stock"] == 0
    assert InventoryManager.list_products(:cart) == [
      {1,{1,2}},
      {2,{1,3}}
    ]
    :ets.delete(test)
    :ets.delete(:cart)
  end

  test "testiando view_cart" do
    :ets.new(:inventory, [:set, :private, :named_table])
    testC = :ets.new(:cart, [:set, :private, :named_table])
    InventoryManager.add_product(:inventory, "Product 1", 10000.00, 5)
    InventoryManager.sell_product(:inventory, 1, 2)
    InventoryManager.sell_product(:inventory, 1, 3)
    assert InventoryManager.view_cart(testC) == :ok
    assert InventoryManager.list_products(testC) == [
      {1,{1,2}},
      {2,{1,3}}
    ]
    :ets.delete(:inventory)
    :ets.delete(testC)
  end

  test "probando el chechout" do
    :ets.new(:inventory, [:set, :private, :named_table])
    :ets.new(:cart, [:set, :private, :named_table])
    InventoryManager.add_product(:inventory, "Product 1", 10000.00, 5)
    InventoryManager.sell_product(:inventory, 1, 2)
    InventoryManager.sell_product(:inventory, 1, 3)
    InventoryManager.view_cart(:cart) == :ok
    InventoryManager.list_products(:cart) == [
      {1,{1,2}},
      {2,{1,3}}
    ]
    assert InventoryManager.checkout(:cart) == :cart
    assert InventoryManager.list_products(:cart) == []
    :ets.delete(:inventory)
    :ets.delete(:cart)
  end
end
