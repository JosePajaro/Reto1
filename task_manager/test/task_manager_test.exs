defmodule TaskManagerTest do
  use ExUnit.Case
  doctest TasksManager

  test "testing the add_task/2" do
    test = :ets.new(:test, [:set, :private, :named_table])
    assert TasksManager.add_task(test, "Test 1") == :ok
    :ets.delete(test)
  end

  test "Testing the list_tasks" do
    test = :ets.new(:test, [:set, :private, :named_table])
    TasksManager.add_task(test, "Test 1")
    TasksManager.add_task(test, "Test 2")
    assert TasksManager.list_tasks(test) == [
      {1, %{"completed" => false, "description" => "Test 1", "id" => 1}},
      {2, %{"completed" => false, "description" => "Test 2", "id" => 2}}
    ]
    :ets.delete(test)
  end

  test "Testing the completed_task/2" do
    test = :ets.new(:test, [:set, :private, :named_table])
    TasksManager.add_task(test, "Test 1")
    [{_,task}] = :ets.lookup(test, 1)
    assert task["completed"] == false
    assert TasksManager.completed_task(test, task["id"]) == :ok
    [{_,task}] = :ets.lookup(test, 1)
    assert task["completed"] == true
    :ets.delete(test)
  end
end
