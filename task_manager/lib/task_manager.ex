defmodule TasksManager do

  defp to_json(task) do
    {:ok, json_version} = Jason.encode(task)
    json_version
  end

  defp to_file(strn) do
    File.write("Tasks.json", strn)
  end

  defp list_tasks() do
    File.stream!("Tasks.json")
    |> Enum.random()
    |> Jason.decode!()
  end

  defp add_task(description) do
    tasks = list_tasks()
    new_task = %{id: length(tasks) + 1, description: description, completed: false}
    [new_task|tasks]
    |>to_json
    |>to_file
  end

  defp completed_task(id) do
    tasks = list_tasks()
    updated_task = Enum.find(tasks, fn x -> x["id"] == id end)
    |>Map.put("completed", true)
    tasks = Enum.reject(tasks, fn x -> x["id"] == id end)
    [updated_task|tasks]
    |>to_json
    |>to_file
  end

  def run() do
    IO.puts("\nWelcome to Task Manager!")
    IO.puts("Choose an option:\n1. Add a task\n2. List tasks\n3. Mark a task as completed\n0. Exit!")
    n = IO.gets(":")
    case Integer.parse(n) do
      {1,_} ->
          des = IO.gets("Insert a description for your task: ")
          IO.inspect(add_task(des))
          run()
      {2,_} ->
          IO.inspect(list_tasks())
          run()
      {3,_} ->
          id = IO.gets("Insert the id edit your tasks: ")
          case Integer.parse(id) do
            {num,_} ->
              IO.inspect(completed_task(num))
              run()
          end
      {0,_} ->
          IO.puts("Exiting...")
      _ ->
          IO.puts("Invalid option")
          run()
    end
  end
end
