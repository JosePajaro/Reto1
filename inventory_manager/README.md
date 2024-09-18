# Inventory Manager
Esta prueba se basa en manipular/gestionar un inventario de productos, permitiendole 
	⁃	agregar productos al inventario
	⁃	Listar los productos del inventario
	⁃	incrementar el stock de los productos
	⁃	añadir productos al carrito de compra y disminuir a su vez el stock del producto en su inventario
	⁃	ver el carrito de compras con sus cantidades y costo total 
	⁃	Vaciar el carrito 
## Como ejecutar la prueba
	1.	Debes asegurarte de tener instalado La maquina de Erlang/OTP y Elixir
	2.	Clona el repositorio Reto1 
	3.	Ve a la carpeta inVentory_manager
	4.	Ejecuta iex.bat -S mix o iex -S mix cual de los dos te funcione para compilar la aplicacion y lanzarla en la maquina de Erlang
	5.	Ejecuta InventoryManager.inventory() para crear el contenedor del invenatio e InventoryManager.cart() para el del carrito 
	6.	Ejecuta la funcion Inventory.run() para empezar a interactuar con la app
## Como funciona la prueba 
Esta prueba se sive de dos (ETS) - Almacenamiento de términos de Erlang, para almacenar el inventario y el carrito de compras gracias a dos funciones a que nos brinda la posibilidad de almacenar datos en momoria de manera volatil.
Tiene una funcion "principal" run() que despliega un menu para la interaccion con el usuario a travez del modulo principal IO del Kernel de Elixir con las siguientes funciones. 
	
 	1. add_product/4
	  ⁃	Recibe 4 parametros, un ETS del inventario, un String con el nombre del producto, un float con el valor del producto y un entrero con el stock 
	  ⁃	Agrega un ID auto incrementado segun la cantidad de productos en el ETS
	  ⁃	Convierte la informacion en una tupla que contiene un indice y un mapa ya que el ETS recibe unicamente una tipla tipo clave valor donde su valor puede ser cualquier tiepo de dato que en este caso es un mapa 
	2.	list_product/1
	  ⁃	Esa funcion recibe 1 parametro, el inventario. Se esncarga de leer el ETS y mostrarlo como una lista de tuplas con su clave y valor
	3.	increase_stock/3
	  ⁃	esta funcion recibe 3 para metros, el inventario, un ID y el Stock que desea incrementar el producto existente y suma el existente con el nuevo stock
	  ⁃	Leer el inventario y filtra la lista, si no encuentra el producto con el ID retorna un mensaje informando que no existe, si lo encuentra devuelve un mapa del producto, incrementa su Stock y lo reescribe nuevamente en el inventario
	4.	sell_product/3
	  ⁃	Recibe 3 parametros, el inventario, un ID y la Cantidad 
	  ⁃	Leer el inventario y filtra la lista, si no encuentra el producto con el ID retorna un mensaje informando que no existe, si lo encuentra devuelve un mapa del producto, decrementa su stock y lo reescribe nuevamente en el inventario
	  ⁃	la cantidad restada es enviada al ETS cart con su ID 
   	5. view_cart/1
	- Recibe 1 parametro que es Cart 
    - Lee el ETS cart y lo lista clave como item, id, precio y costo total y al final muestra un total de la compra
  	6. chechout/2
	- Recibe 2 parametros el inventario y el cart para el calculo del total y realizar el cobro
    - Realiza los calculos del total, borra el carrito y lo crea nuevamnete para que quede disponiblo por si desea realizar otra compra

