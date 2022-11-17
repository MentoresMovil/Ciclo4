import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'drawablemenu.dart';
import 'listasitios.dart';

class PerfilSitios extends StatefulWidget {
  final dk;
  const PerfilSitios(this.dk, {Key? key}) : super(key: key);

  @override
  State<PerfilSitios> createState() => _PerfilSitiosState();
}

class _PerfilSitiosState extends State<PerfilSitios> {
  @override
  Widget build(BuildContext context) {
    var k = widget.dk; // leo variable de otro widget
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lista de Sitios'),
        ),
        // drawer: DrawableMenu(),
        body: Padding(
          padding: EdgeInsets.all(5),
          child: StreamBuilder<QuerySnapshot>(
            // consultar en base de datos usuarios
            stream: FirebaseFirestore.instance.collection('users').where('logo',isNotEqualTo: '' ).snapshots(),
            // stream: FirebaseFirestore.instance.collection('usuario').where('id',isEqualTo:k).snapshots(),

            builder: (context, snapshot) {
              print('******kkkkk**** ${k} ******kkkkk****');
              if (snapshot.hasError) {
                return Text('Existe un error en la consulta');
              } // fin if
              if (!snapshot.hasData) {
                return Text('No tiene datos en la consulta');
              } // fin if
              else {
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      QueryDocumentSnapshot usuarioFB =
                          snapshot.data!.docs[index];
                      return Column(
                        children: [
                          Card(
                            elevation: 5,
                            color: Color.fromARGB(
                              100,
                              index * 10,
                              index * 100,
                              index * 200,
                            ),
                            child: ListTile(
                              leading: Image.network(usuarioFB['logo']),
                              title: Text(
                                ' ${usuarioFB['name']} :  ',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  // color: Colors.black
                                ),
                              ),

                              subtitle: Text(
                                ' ${usuarioFB['name']} :  \n ${usuarioFB['descCorta']} ',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              // leading: Image.network(usuarioFB['logo']),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListaSitios(usuarioFB['uid'])));
                              },
                            ),
                          ),
                        ],
                      );
                    });
              } // fin else
            },
          ),
        ),
      ),
    );
  }
}
