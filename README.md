#PROYECTO “BELLIGRAU”

# Maquetado en Figma
Link: https://www.figma.com/file/d9YQl8UiTgl41cpmTbt5fI/Proyecto-Carteras?type=design&node-id=0-1&mode=design

# Repositorios
Link: https://github.com/Martin-itamar-salvio/ProyectoFinalTP3G2

# Tenemos las siguientes ramas:
- main: Rama principal (Final a entregar)
- test: Rama para probar (Para probar todo unificado)
- feature_<Apellido>_<id>: Cada rama con los cambios de cada uno para después hacer el merge.

# Análisis Funcional
- Login / Registro de cada usuario/admin:
  - Puede ingresar su nombre de usuario y password para ingresar a la aplicación. Verificar las credenciales correctamente.
  - Puede registrarse con todos sus datos personales.
  - Editar cualquier dato personal.
  - Dar de baja a su usuario.
  - Existen 2 Roles → Administrador (Quien Vende) / Usuario (Quien Compra)
- Pantalla principal para visualizar todas las carteras que se venden:
  - Botón estático de Carrito de Compras.
  - Buscador de Productos
  - Barra de tareas o Menú lateral para:
    - Perfil (Editar, darse de baja, etc).
    - Historial de compras/ventas (Dependiendo el rol).
    - Productos (Para permitir filtro de carteras por tipos por ej.)
    - Visualizar Favoritos
    - Configuración básica de aplicación.
    - Cerrar sesión.
  - Seleccionar una cartera para comprar:
- Producto seleccionado donde:
  - Botón para Añadir al Carrito
  - Botón para Añadir a Favoritos
  - Visualizar todos los datos a detalle del producto
- Perfil de Cliente
  - Visualizar los datos de cada usuario
  - Editar los datos
  - Eliminar usuario
  - Datos de facturación y dirección de retiro (Propio del Vendedor)
- Carrito de Compras:
  - Visualizar todo el carrito
  - Eliminar un producto agregado
  - Volver para agregar mas productos
- Facturación/Recibo:
  - Comprar todos los productos del carrito (Detalle mínimo de precio unitario y producto)
  - Total de la compra
  - Donde retira el producto (Información del Vendedor)
  - Botón para concretar Compra → Se le notificará con un mail los datos de pago para transferir al vendedor. Tiene 24hs para realizar la transferencia. (Al vendedor se le notifica y aprueba el     pago? (Analizar))
- Favoritos:
  - Visualizar todos los productos agregados
  - Eliminar un producto de favoritos
- Historial de Ventas/Compras:
  - Visualizar todos los productos vendidos/comprados
  - Configuración (Básico de aplicación, modo oscuro, etc)
- El Administrador (Vendedor) puede:
  - Publicar productos (Es decir, ABM de producto cartera).
    - Aumentar el stock de producto existente.
  - Comprar productos
  - Revisar historial de ventas
- El Usuario (Comprador) puede:
  - Comprar productos
  - Revisar historial de compras
- Base de Datos a utilizar → Firebase
