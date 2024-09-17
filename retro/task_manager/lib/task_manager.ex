defmodule TasksManager do

  def tasks() do
    :ets.new(:tasks, [:set, :public, :named_table])
  end

  defp to_json(task) do
    {:ok, json_version} = Jason.encode(task)
    json_version
  end

  defp to_file(strn) do
    File.write("Tasks.json", strn)
  end

  def list_tasks(tasks) do
    :ets.match(tasks, :"$1")
  end

  def list_tasks() do
    File.stream!("Tasks.json")
    |> Enum.random()
    |> Jason.decode!()
  end

  def add_task(tasks,description) do
    new_task = %{"id"=> :ets.info(tasks, :size) + 1, "description"=> description, "completed"=> false}
    :ets.insert_new(tasks, {new_task})
    IO.puts ("Su tarea fue creada con el id: #{new_task["id"]}, '#{new_task["description"]}' como descripcion y '#{new_task["completed"]}' como estado!")
  end

  def add_task(description) do
    tasks = list_tasks()
    new_task = %{id: length(tasks) + 1, description: description, completed: false}
    IO.puts ("Su tarea fue creada con el id: #{new_task.id}, '#{new_task.description}' como descripcion y '#{new_task.completed}' como estado!")
    [new_task|tasks]
    |>to_json
    |>to_file
  end

  def completed_task(tasks, id) do
    if tasks != nil do
      updated_task = Enum.find(tasks, fn x -> x["id"] == id end)
      if updated_task != nil do
        updated_task
        |>Map.put("completed", true)
        tasks = Enum.reject(tasks, fn x -> x["id"] == id end)
        [updated_task|tasks]
        |>to_json
        |>to_file
      else
        IO.puts("Task not found")
        :ok
      end
    else
      IO.puts("List_task is empty")
      :ok
    end
  end

  def completed_task(id) do
    tasks = list_tasks()
    if tasks != nil do
      updated_task = Enum.find(tasks, fn x -> x["id"] == id end)
      if updated_task != nil do
        updated_task
        |>Map.put("completed", true)
        tasks = Enum.reject(tasks, fn x -> x["id"] == id end)
        [updated_task|tasks]
        |>to_json
        |>to_file
      else
        IO.puts("Task not found")
        :ok
      end
    else
      IO.puts("List_task is empty")
      :ok
    end
  end

  def run() do
    :ets.new(:tasks, [:set, :public, :named_table])
    IO.puts("\nWelcome to Task Manager!")
    IO.puts("Choose an option:\n1. Add a task\n2. List tasks\n3. Mark a task as completed\n0. Exit!")
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
          {id,} = Integer.parse(IO.gets("Insert the id edit your tasks: "))
          IO.inspect(completed_task(:tasks, id))
          run()
      {0,_} ->
          IO.puts("Exiting...")
      _ ->
          IO.puts("Invalid option")
          run()
    end
  end
end
