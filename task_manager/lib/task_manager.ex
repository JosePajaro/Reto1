defmodule TasksManager do

  def tasks() do
   :ets.new(:tasks, [:set, :public, :named_table])
  end

  def add_task(tasks,description) do
    new_task = %{"id"=> :ets.info(tasks, :size) + 1, "description"=> description, "completed"=> false}
    :ets.insert_new(tasks, {new_task["id"], new_task})
    IO.puts ("Your task has as id: #{new_task["id"]}, '#{new_task["description"]}' as a description and '#{new_task["completed"]}' as a status!")
  end

  def list_tasks(tasks) do
    :ets.tab2list(tasks)
  end

  def completed_task(tasks, id) do
    size = :ets.info(tasks, :size)
    if size != 0 do
      if id > size || id <= 0 do
        IO.puts("This task does not exist")
        :ok
      else
        [{_, updated_task}] = :ets.lookup(tasks, id)
        updated_task = Map.put(updated_task, "completed", true)
        :ets.insert(tasks, {id, updated_task})
        IO.puts("Task #{id} has been marked as completed!")
        :ok
      end
    else
      IO.puts("List_task is empty")
      :ok
    end
  end

  def run() do
    IO.puts("\nWelcome to Task Manager!\nChoose an option:\n1. Add a task\n2. List tasks\n3. Mark a task as completed\n0. Exit!")
    n = IO.gets(":")
    case Integer.parse(n) do
      {1,_} ->
          des = IO.gets("Insert a description for your task: ")
          IO.inspect(add_task(:tasks, des))
          run()
      {2,_} ->
          IO.inspect(list_tasks(:tasks))
          run()
      {3,_} ->
          {id,_} = Integer.parse(IO.gets("Insert the id edit your tasks: "))
          IO.inspect(completed_task(:tasks, id))
          run()
      {0,_} ->
          IO.puts("Exiting...")
          :ets.delete(:tasks)
          :ok
      _ ->
          IO.puts("Invalid option")
          run()
    end
  end
end
