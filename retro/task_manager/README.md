# TaskManager
Se desarrollaron 6 funciones, 1 funcion que ejecuta las 3 funciones principales del reto y 2 funciones auxiliares que ayudan a desminuir la complejidad del desarrollo.
La funcion que ejecuta la logica del programa es run() a la cual se puede acceder ataves del modulo principal TasksManager.run desde la terminal esto después ejecutar la consola de Erlan/OTP para Elixir que en mi caso es: iex.bat -S mix

## Para ejecutar la prueba: 
  1) Asegurate de tengas instalado Erlang y Elixir con el siguiente comando [elixir --version] 
  2) Ve a la carpeta ..\tasks_manager\ y ejecuta el siguiente comando [mix deps.get] para bajar las dependencias del proycto que en este  caso solo es la de Json para el almacenamiento de las tareas creadas.
  3) Corre la consola de Erlang y su gestor de proycto "mix" con el comando [iex.bat -S mix] o [iex -S mix] con el que te ejecute
  4) Accede al módulo principal y ejecuta la función run para utilizar la aplicación con el siguiente comando [TaskManager.run]

## Que hace la prueba
  Implementa las siguientes funciones para hacer crear, listar y modificar una tarea
  1. add_task("Description") Esta funcion recibe un String como parametro para crear una tarea.
    - Le asigna un id autoincrementado según el número de tareas existentes
    - Guarda el parametro recibido en la descripcion de la tarea
    - Marca el estado de la tarea como false indicando que no ha sido realizada
    - Convierte la tarea en un mapa y lo pasa a formato json
    - Guarda la tarea en una lista de mapas dentro de un archivo llamado Tasks.json
  2. list_tasks() Esta funcion no recibe ningun parametro ya solo lista las tareas que se encuentran en el archivo Tasks.json
    - LLama al acrivo .json y lo decodifica en una lista de mapas
  3. completed_task(id) Esta funcion recibe un Integer como parametro para marcar una tarea como completa
    - Llama a la funcion list_tasks() y la guarda en una variable
    - Filtar la lista de mapas con el id pasado como parametro y guarda la tarea en una variable
    - Elimina la tarea que tiene el id de la lista de mapas
    - Marca la tarea guardada modificandole el estado a true
    - Agrega la tarea en la lista nuevamente
    - Envia la lista de mapas el crchivo nuevamente

## Testing
Los test de la prueba siguen en desarrollo