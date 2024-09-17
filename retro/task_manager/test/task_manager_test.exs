defmodule TaskManagerTest do
  use ExUnit.Case
  doctest TasksManager
  #{"completed":false,"description":"prueba1","id":1}

  test "TasksManager.add_task(description)" do
    assert TasksManager.add_task("prueba 1") == :ok
  end

  test "TaskManager.list_tasks()" do
    assert TasksManager.list_tasks() == []
    assert TasksManager.add_task("prueba 1") == :ok
    assert TasksManager.list_tasks() == [%{"id"=>1,"description"=>"prueba 1","completed"=>false}]
  end

  test "TaskManager.completed_task(id)" do
    assert TasksManager.completed_task(1) == :ok
  end
end
