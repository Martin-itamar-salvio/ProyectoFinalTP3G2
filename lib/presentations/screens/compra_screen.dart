import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final_grupo_6/presentations/providers/carrito_provider.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/app_bar.dart';
import 'package:proyecto_final_grupo_6/presentations/providers/usuario_provider.dart';
import 'package:proyecto_final_grupo_6/services/firebase_services.dart';
import '../entities/compra.dart';
import '../widgets/drawer_menu.dart';
import 'carga_screen.dart';

class CompraScreen extends ConsumerStatefulWidget {
  static const String name = "compra_screen";

  CompraScreen({Key? key}) : super(key: key);

  @override
  _CompraScreenState createState() => _CompraScreenState();
}

class _CompraScreenState extends ConsumerState<CompraScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController tarjetaController;
  late TextEditingController codigoController;
  late TextEditingController titularController;
  late TextEditingController emailController;
  late TextEditingController codigoPostalController;
  late TextEditingController direccionController;

  String? _selectedCountry;

  @override
  void initState() {
    super.initState();
    tarjetaController = TextEditingController();
    codigoController = TextEditingController();
    titularController = TextEditingController();
    emailController = TextEditingController();
    codigoPostalController = TextEditingController();
    direccionController = TextEditingController();
  }
//esto es para sacar de la memoria dps de usado cada controlador de input de texto
  @override
  void dispose() {
    tarjetaController.dispose();
    codigoController.dispose();
    titularController.dispose();
    emailController.dispose();
    codigoPostalController.dispose();
    direccionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usuario = ref.watch(usuarioProvider);
    final carrito = ref.watch(carritoProvider);
    final subTotal = ref.watch(subTotalProvider);

    if (usuario == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Compra'),
        ),
        body: const Center(
          child: Text('No se ha iniciado sesión'),
        ),
      );
    }

    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const DrawerMenu(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Tarjeta de Detalles del Carrito
                Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Detalles del Carrito',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        ...carrito.map((producto) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${producto.nombre} x${producto.cantidad}', style: const TextStyle(fontSize: 16.0)),
                              Text('\$${producto.precio * producto.cantidad}', style: const TextStyle(fontSize: 16.0)),
                            ],
                          ),
                        )),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Precio Total:',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$$subTotal',
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _buildTextFormField(
                  controller: tarjetaController,
                  labelText: 'Número de tarjeta',
                  hintText: '1234 5678 9012 3456',
                  keyboardType: TextInputType.number,
                  errorMessage: 'Por favor, ingrese el número de tarjeta',
                  validator: _validateCreditCardNumber,
                ),
                const SizedBox(height: 10),
                _buildTextFormField(
                  controller: codigoController,
                  labelText: 'Código verificador',
                  hintText: '123',
                  keyboardType: TextInputType.number,
                  errorMessage: 'Por favor, ingrese el código verificador',
                  validator: _validateCVV,
                ),
                const SizedBox(height: 10),
                _buildTextFormField(
                  controller: titularController,
                  labelText: 'Nombre del titular',
                  hintText: 'Nombre y apellido',
                  keyboardType: TextInputType.text,
                  errorMessage: 'Por favor, ingrese el nombre del titular',
                ),
                const SizedBox(height: 10),
                _buildTextFormField(
                  controller: emailController,
                  labelText: 'Email',
                  hintText: 'correo@example.com',
                  keyboardType: TextInputType.emailAddress,
                  errorMessage: 'Por favor, ingrese su email',
                  validator: _validateEmail,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'País',
                  ),
                  value: _selectedCountry,
                  items: ['Argentina', 'Brasil', 'Chile', 'Uruguay']
                      .map((country) => DropdownMenuItem<String>(
                            value: country,
                            child: Text(country),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCountry = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, seleccione un país';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                _buildTextFormField(
                  controller: codigoPostalController,
                  labelText: 'Código postal',
                  hintText: 'Código postal',
                  keyboardType: TextInputType.number,
                  errorMessage: 'Por favor, ingrese el código postal',
                ),
                const SizedBox(height: 10),
                _buildTextFormField(
                  controller: direccionController,
                  labelText: 'Dirección',
                  hintText: 'Dirección de facturación',
                  keyboardType: TextInputType.text,
                  errorMessage: 'Por favor, ingrese la dirección',
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final compra = Compra(
                        usuario: usuario,
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        direccion: direccionController.text,
                        codigoPostal: codigoPostalController.text,
                        total: subTotal,
                        carteras: carrito,
                      );

                      try {
                        int i = 0;
                        bool puedoComprar = true;

                        while (puedoComprar && i < carrito.length) {
                          puedoComprar = (carrito[i].stock - carrito[i].cantidad) >= 0;
                          if (!puedoComprar) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('No puede realizar la compra: No hay suficiente stock de "${carrito[i].nombre}"')),
                            );
                          }
                          i += 1;
                        }

                        if (puedoComprar) {
                          // Actualizar Stock de todas las carteras
                          for (var cartera in carrito){
                            cartera.stock = cartera.stock - cartera.cantidad;
                            cartera.estado = cartera.stock == 0 ? 'delete' : '';
                            await actualizarStockCartera(cartera);
                          }

                          // Agregar a usuarios
                          await agregarCompraAlUsuario(usuario, compra);
                        
                          // Vaciar el carrito
                          ref.read(carritoProvider.notifier).vaciarCarrito();

                          // Ir a la pantalla de carga
                          context.goNamed(CargaScreen.name, extra: compra);
                        }
                      } catch (e) {
                        // Manejar error si falla la compra
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error al realizar la compra: $e')),
                        );
                      }
                    }
                  },
                  child: const Text('Realizar compra'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required TextInputType keyboardType,
    required String errorMessage,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 16.0),
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        return null;
      },
    );
  }

  String? _validateCreditCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el número de tarjeta';
    }
    // Validacin simple para el número de tarjeta de crédito (longitud y dígitos)
    if (!RegExp(r'^[0-9]{16}$').hasMatch(value)) {
      return 'Número de tarjeta inválido';
    }
    return null;
  }

  String? _validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el código verificador';
    }
    // Validación para el código verificador (CVV) (esto se fja q sea numero de 3 o 4 digitos)
    if (!RegExp(r'^[0-9]{3,4}$').hasMatch(value)) {
      return 'Código verificador inválido';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su email';
    }
    // Validación para el formato del email, exp regular de "texto, @ texto.texto"
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Por favor, ingrese un email válido';
    }
    return null;
  }
}
