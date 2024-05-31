import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
        // ExpansionTile(
        //   title: const Text('Usuarios'),
        //   children: [
        //     _buildExpansionTile('Modificar Usuario'),
        //     _buildExpansionTile('Eliminar Usuario'),
        //     _buildExpansionTile('Mostrar Usuario'),
        //   ],
        // ),
        ExpansionTile(
          title: const Text('Cartera'),
          children: [
            _buildAgregarCartera(context),
            _buildModificarCartera(context),
            _buildEliminarCartera(context),
          ],
        ),
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



  //agregar cartera
  Widget _buildAgregarCartera(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String nombre = '';
    double precio = 0.0;
    String imagen = '';
    int stock = 0;
    String modelo = '';
    String descripcion = '';

    return ExpansionTile(
      title: const Text('Agregar Cartera'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  onSaved: (value) {
                    nombre = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Precio'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    precio = double.tryParse(value ?? '0') ?? 0.0;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Imagen (URL)'),
                        onSaved: (value) {
                          imagen = value ?? '';
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.upload_file),
                      onPressed: () async {
                        final url = await uploadImage();
                        if (url != null) {
                          imagen = url;
                        }
                      },
                    ),
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Stock'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    stock = int.tryParse(value ?? '0') ?? 0;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Modelo'),
                  onSaved: (value) {
                    modelo = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Descripción'),
                  onSaved: (value) {
                    descripcion = value ?? '';
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      formKey.currentState?.save();
                      final cartera = Cartera(
                        nombre: nombre,
                        precio: precio,
                        imagen: imagen,
                        stock: stock,
                        modelo: modelo,
                        descripcion: descripcion,
                      );
                      createCartera(cartera);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Cartera creada exitosamente')),
                      );
                    }
                  },
                  child: const Text('Crear'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  //modiciar cartera
  Widget _buildModificarCartera(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String nombre = '';
    double precio = 0.0;
    String imagen = '';
    int stock = 0;
    String modelo = '';
    String descripcion = '';

    return ExpansionTile(
      title: const Text('Modificar Cartera'),
      children: <Widget>[
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Carteras').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final carteras = snapshot.data!.docs;

            return Column(
              children: [
                DropdownButtonFormField<String>(
                  items: carteras.map((doc) {
                    return DropdownMenuItem<String>(
                      value: doc['nombre'],
                      child: Text(doc['nombre']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      final selectedCartera = carteras
                          .firstWhere((doc) => doc['nombre'] == value)
                          .data() as Map<String, dynamic>;
                      nombre = selectedCartera['nombre'];
                      precio = selectedCartera['precio'].toDouble();
                      imagen = selectedCartera['imagen'];
                      stock = selectedCartera['stock'];
                      modelo = selectedCartera['modelo'];
                      descripcion = selectedCartera['descripcion'];
                    }
                  },
                  decoration:
                      const InputDecoration(labelText: 'Seleccionar Cartera'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          initialValue: nombre,
                          decoration:
                              const InputDecoration(labelText: 'Nombre'),
                          onSaved: (value) {
                            nombre = value ?? '';
                          },
                        ),
                        TextFormField(
                          initialValue: precio.toString(),
                          decoration:
                              const InputDecoration(labelText: 'Precio'),
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            precio = double.tryParse(value ?? '0') ?? 0.0;
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: imagen,
                                decoration: const InputDecoration(
                                    labelText: 'Imagen (URL)'),
                                onSaved: (value) {
                                  imagen = value ?? '';
                                },
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.upload_file),
                              onPressed: () async {
                                final url = await uploadImage();
                                if (url != null) {
                                  imagen = url;
                                }
                              },
                            ),
                          ],
                        ),
                        TextFormField(
                          initialValue: stock.toString(),
                          decoration: const InputDecoration(labelText: 'Stock'),
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            stock = int.tryParse(value ?? '0') ?? 0;
                          },
                        ),
                        TextFormField(
                          initialValue: modelo,
                          decoration:
                              const InputDecoration(labelText: 'Modelo'),
                          onSaved: (value) {
                            modelo = value ?? '';
                          },
                        ),
                        TextFormField(
                          initialValue: descripcion,
                          decoration:
                              const InputDecoration(labelText: 'Descripción'),
                          onSaved: (value) {
                            descripcion = value ?? '';
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              formKey.currentState?.save();
                              final cartera = Cartera(
                                nombre: nombre,
                                precio: precio,
                                imagen: imagen,
                                stock: stock,
                                modelo: modelo,
                                descripcion: descripcion,
                              );
                              updateCarteraByName(nombre, cartera);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Cartera modificada exitosamente')),
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
          },
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

  Future<String?> uploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    }

    final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference storageRef =
        FirebaseStorage.instance.ref().child('carteras/$fileName');
    final UploadTask uploadTask = storageRef.putFile(File(image.path));
    final TaskSnapshot taskSnapshot = await uploadTask;

    return await taskSnapshot.ref.getDownloadURL();
  }

  void ocultarCartera(String nombre) {}
}
