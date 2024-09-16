defmodule InventoryManagerTest do
  use ExUnit.Case
  doctest InventoryManager

  test "probando add_product" do
    assert InventoryManager.add_product("prueba 1",0.00,0) == :ok
  end

  test "Probando list_product" do
    assert InventoryManager.list_products() == [%{"id"=>1,"name"=>"prueba 1","price"=>0.0,"stock"=>0}]
    assert InventoryManager.add_product("prueba 2",0.00,0) == :ok
    assert InventoryManager.list_products() == [%{"id"=>2,"name"=>"prueba 2","price"=>0.0,"stock"=>0},%{"id"=>1,"name"=>"prueba 1","price"=>0.0,"stock"=>0}]
  end

  test "probando increase_stock" do
    assert InventoryManager.increase_stock(1,5) == :ok
  end

  test "probando sell_products" do
    assert InventoryManager.sell_product(1,2) == :ok
  end

  test "testiando view_cart" do
    assert InventoryManager.view_cart() == :ok
  end

  test "probando el chechout" do
    assert InventoryManager.chechout() == :ok
  end

end
