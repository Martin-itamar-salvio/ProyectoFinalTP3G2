import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/cartera.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/app_bar.dart';
import 'package:proyecto_final_grupo_6/presentations/widgets/drawer_menu.dart';
import 'package:proyecto_final_grupo_6/services/firebase_services.dart';

class GestionScreen extends StatelessWidget {
  static const String name = "gestion_screen";

  const GestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      drawer: DrawerMenu(),
      body: Center(
        child: _GestionView(),
      ),
    );
  }
}

class _GestionView extends StatefulWidget {
  const _GestionView();

  @override
  _GestionViewState createState() => _GestionViewState();
}

class _GestionViewState extends State<_GestionView> {
  Cartera? _carteraEncontrada;
  final _formKeyModificar = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildAgregarCartera(context),
        _buildModificarCartera(context),
        _buildEliminarCartera(context),
      ],
    );
  }

  // Agregar cartera
  Widget _buildAgregarCartera(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String nombre = '';
    double precio = 0.0;
    String imagen = '';
    int cantidad = 0;
    String modelo = '';
    String? descripcion;
    String? estado;
    int stock = 0;

    return ExpansionTile(
      title: const Text('Agregar Cartera'),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese un nombre';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) {
                      nombre = value;
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Precio'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese un precio';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) {
                      precio = double.parse(value);
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Stock'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese el stock';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) {
                      stock = int.parse(value);
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Modelo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese el modelo';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) {
                      modelo = value;
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Descripcion'),
                  onSaved: (value) {
                    if (value != null) {
                      descripcion = value;
                    }
                  },
                ),
                FutureBuilder<List<String>>(
                  future: getImagenesCargadas(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final images = snapshot.data!;

                    return DropdownButtonFormField<String>(
                      items: images.map((url) {
                        return DropdownMenuItem<String>(
                          value: url,
                          child: Image.network(url, width: 100, height: 100),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          imagen = value;
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: 'Seleccionar Imagen'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, selecciona una imagen';
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      formKey.currentState?.save();
                      final nuevaCartera = Cartera(
                        nombre: nombre,
                        precio: precio,
                        imagen: imagen,
                        cantidad: cantidad,
                        modelo: modelo,
                        descripcion: descripcion,
                        estado: estado,
                        stock: stock,
                      );
                      agregarCartera(nuevaCartera);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Cartera agregada correctamente')),
                      );
                    }
                  },
                  child: const Text('Agregar'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Modificar cartera
  Widget _buildModificarCartera(BuildContext context) {
    String nombreBuscado = '';
    double precio = 0.0;
    String modelo = '';
    String? descripcion;
    String? estado;
    int stock = 0;

    return ExpansionTile(
      title: const Text('Modificar Cartera'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKeyModificar,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Buscar por Nombre'),
                  onChanged: (value) {
                    nombreBuscado = value;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    final cartera = await buscarCarteraPorNombre(nombreBuscado);
                    if (cartera != null) {
                      setState(() {
                        _carteraEncontrada = cartera;
                      });
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cartera no encontrada')),
                      );
                    }
                  },
                  child: const Text('Buscar'),
                ),
                if (_carteraEncontrada != null) ...[
                  TextFormField(
                    key: ValueKey(_carteraEncontrada!.modelo),
                    initialValue: _carteraEncontrada!.modelo,
                    decoration: const InputDecoration(labelText: 'Modelo'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese el modelo';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        modelo = value;
                      }
                    },
                  ),
                  TextFormField(
                    key: ValueKey(_carteraEncontrada!.precio),
                    initialValue: _carteraEncontrada!.precio.toString(),
                    decoration: const InputDecoration(labelText: 'Precio'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese un precio';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        precio = double.parse(value);
                      }
                    },
                  ),
                  TextFormField(
                    key: ValueKey(_carteraEncontrada!.stock),
                    initialValue: _carteraEncontrada!.stock.toString(),
                    decoration: const InputDecoration(labelText: 'Stock'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese el stock';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        stock = int.parse(value);
                      }
                    },
                  ),
                  TextFormField(
                    key: ValueKey(_carteraEncontrada!.descripcion),
                    initialValue: _carteraEncontrada!.descripcion,
                    decoration: const InputDecoration(labelText: 'Descripcion'),
                    onSaved: (value) {
                      if (value != null) {
                        descripcion = value;
                      }
                    },
                  ),
                  TextFormField(
                    key: ValueKey(_carteraEncontrada!.estado),
                    initialValue: _carteraEncontrada!.estado,
                    decoration: const InputDecoration(labelText: 'Estado'),
                    onSaved: (value) {
                      if (value != null) {
                        estado = value;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKeyModificar.currentState?.validate() ?? false) {
                        _formKeyModificar.currentState?.save();
                        final carteraModificada = Cartera(
                          nombre: _carteraEncontrada!.nombre,
                          precio: precio,
                          imagen: _carteraEncontrada!.imagen,
                          cantidad: _carteraEncontrada!.cantidad,
                          modelo: modelo,
                          descripcion: descripcion,
                          estado: estado,
                          stock: stock,
                        );
                        actualizarCartera(carteraModificada);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Cartera modificada correctamente')),
                        );
                      }
                    },
                    child: const Text('Modificar'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Eliminar cartera
  Widget _buildEliminarCartera(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String? nombreSeleccionado;

    return ExpansionTile(
      title: const Text('Eliminar Cartera'),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Carteras')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final carteras = snapshot.data!.docs;

                    return DropdownButtonFormField<String>(
                      value: nombreSeleccionado,
                      items: carteras.map((doc) {
                        return DropdownMenuItem<String>(
                          value: doc['nombre'],
                          child: Text(doc['nombre']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        nombreSeleccionado = value;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Seleccionar Cartera'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, selecciona una cartera';
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      // Llamar al método para eliminar la cartera
                      eliminarCartera(nombreSeleccionado!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Cartera eliminada correctamente')),
                      );
                    }
                  },
                  child: const Text('Eliminar'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
