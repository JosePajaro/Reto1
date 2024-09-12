defmodule InventoryManagerTest do
  use ExUnit.Case
  doctest InventoryManager

  test "greets the world" do
    assert InventoryManager.hello() == :world
  end
end
