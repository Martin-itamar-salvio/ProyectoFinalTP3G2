import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final_grupo_6/presentations/entities/cartera.dart';
import 'package:proyecto_final_grupo_6/services/firebase_services.dart';

class GestionScreen extends StatelessWidget {
  static const String name = "gestion_screen";
  // final User usuario;

  const GestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Tienda'),
      ),
      body: const Center(
        child: _GestionView(),
      ),
    );
  }
}

class _GestionView extends StatelessWidget {
  const _GestionView();

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

  Widget _buildExpansionTile(String title) {
    return ExpansionTile(
      title: Text(title),
      children: <Widget>[
        ListTile(
          title: Text('Formulario $title'),
          onTap: () {
            // Acción para el menú correspondiente
          },
        ),
      ],
    );
  }

  //Agregar cartera
  Widget _buildAgregarCartera(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
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
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese un nombre';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) {
                      descripcion = value;
                    }
                  },
                ),
                FutureBuilder<List<String>>(
                  future: getUploadedImages(),
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
                // Añade aquí más campos para cantidad, modelo, descripción, etc.
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      // Llamar al método para agregar la cartera
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
                      // Aquí debes agregar la lógica para guardar la nueva cartera en Firestore
                      addCartera(nuevaCartera);
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
    final _formKey = GlobalKey<FormState>();
    String nombreSeleccionado = ''; // Inicializa aquí
    String nombre = '';
    double precio = 0.0;
    String imagen = '';
    int cantidad = 0;
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
            key: _formKey,
            child: Column(
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Carteras')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final carteras = snapshot.data!.docs;

                    // Establece el valor inicial aquí
                    nombreSeleccionado = carteras.first['nombre'];

                    return DropdownButtonFormField<String>(
                      value: nombreSeleccionado,
                      items: carteras.map((doc) {
                        return DropdownMenuItem<String>(
                          value: doc['nombre'],
                          child: Text(doc['nombre']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          nombreSeleccionado = value;
                          final cartera = carteras.firstWhere(
                              (doc) => doc['nombre'] == nombreSeleccionado);
                          nombre = cartera['nombre'];
                          precio = cartera['precio'];
                          imagen = cartera['imagen'];
                          cantidad = cartera['cantidad'];
                          modelo = cartera['modelo'];
                          descripcion = cartera['descripcion'];
                          estado = cartera['estado'];
                          stock = cartera['stock'];
                        }
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
                TextFormField(
                  initialValue: nombre,
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
                  initialValue: precio.toString(),
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
                FutureBuilder<List<String>>(
                  future: getUploadedImages(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final images = snapshot.data!;

                    return DropdownButtonFormField<String>(
                      value: imagen,
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
                // Añade aquí más campos para cantidad, modelo, descripción, etc.
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      // Llamar al método para actualizar la cartera
                      final carteraModificada = Cartera(
                        nombre: nombre,
                        precio: precio,
                        imagen: imagen,
                        cantidad: cantidad,
                        modelo: modelo,
                        descripcion: descripcion,
                        estado: estado,
                        stock: stock,
                      );
                      updateCartera(carteraModificada);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Cartera modificada correctamente')),
                      );
                    }
                  },
                  child: const Text('Modificar'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //eliminar cartera
  Widget _buildEliminarCartera(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String nombre = '';

    return ExpansionTile(
      title: const Text('Eliminar Cartera'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
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
                      items: carteras.map((doc) {
                        return DropdownMenuItem<String>(
                          value: doc['nombre'],
                          child: Text(doc['nombre']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          nombre = value;
                        }
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
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      // Llamar al método para ocultar la cartera
                      deleteCartera(nombre);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Cartera marcada como eliminada')),
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

  void ocultarCartera(String nombre) {}
}
