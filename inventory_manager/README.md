# Inventory Manager
Esta prueba se basa en manipular/gestionar un inventario de productos, permitiendole 
	⁃	agregar productos al inventario
	⁃	Listar los productos del inventario
	⁃	incrementar el stock de los productos
	⁃	añadirlos al carrito de compra y disminuir a su vez el estock
	⁃	ver el carrito de compras con sus cantidades y costo total 
	⁃	Vaciar el carrito 
## Como ejecutar la prueba
	1.	Debes asegurarte de tener instalado La maquina de Erlang/OTP y Elixir
	2.	Clona el repositorio Reto1 
	3.	Ve a la carpeta incentory_manager
	4.	Abre tu terminal y ejecuta mix deps.get para bajar las dependencias de la prueba
	5.	Ejecuta iex.bat -S mix o iex -S mix cual de los dos te funcione para compilar la aplicacion y lanzarla en la maquina de Erlang
	6.	Ejecuta la funcion run() del modulo principal InventoryManager para que empieces a interactuar con la app InventoryManager.run()
## Como funciona la prueba 
Esta prueba se sive de dos archivos .json para almacenar el inventario y el carrito de compras gracias a dos funciones to_json() que convierte la informacion el formanto Json y to_file() que ecribe la informacion en el archivo .
Tiene una funcion "principal" run() que despliega un menu para la interaccion con el usuario a travez del modulo principal IO del Kernel de Elixir.
	1.	add_product()
	  ⁃	Recibe 3 parametros, un String con el nombre del producto, un float con el valor del producto y un entrero con el stock 
	  ⁃	Agrega un ID auto incrementado segun la cantidad de productos en el archivo
	  ⁃	Convierte la informacion en un mapa y la manda a convertir a Json para luego ser escrita en una lista y enviarla al archivo .json
	2.	list_product()
	  ⁃	Esa funcion no recibe ningun parametro, se esncarga de leer el archivo .json con el inventario de productos existentes
	3.	increase_stock()
	  ⁃	esta funcion recibe 2 para metros, el ID y el Stock del producto del que se desea incrementar el stock y suma el existente con el nuevo stock
	  ⁃	Leer el inventario y filtra la lista, si no encuentra el producto con el ID retorna un mensaje informando que no existe, si lo encuentra devuelve un mapa del producto, lo elimina de la lista para incrementar su stock agregarlo nuevamente a la lista y envía la lista al archivo
	4.	sell_product()
	  ⁃	Recibe dos parametros, un ID y una Cantidad 
	  ⁃	Leer el inventario y filtra la lista, si no encuentra el producto con el ID retorna un mensaje informando que no existe, si lo encuentra devuelve un mapa del producto, lo elimina de la lista para disminuir su stock, agregarlo nuevamente a la lista y enviarlo a la lista al archivo nuevamente
	  ⁃	la cantidad restada es enviada al archivo cart con su ID
  5. view_cart()
    - Lee el archivo cart.json y lista los productos con su nombre, id, precio y costo total y al final muestra un total de la compra
  6. chechout()
    - Reescribe el archivo con una lista vacia

