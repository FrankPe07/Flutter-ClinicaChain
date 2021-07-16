import 'package:clinicachain/Controller/DBPaciente.dart';
import 'package:flutter/material.dart';

class BusquedaEspecialidadPage extends SearchDelegate
{

  @override
  String get searchFieldLabel => 'Buscar Especialidad';

  @override
  List<Widget> buildActions(BuildContext context) 
  {
    return [
      IconButton(
          icon: Icon(Icons.clear_all),
          onPressed: () => query = '',
      ),
      IconButton(
          icon: Icon(Icons.search),
          onPressed: () => query = '',
      )
    ];
  }
  
  @override
  Widget buildLeading(BuildContext context) 
  {
    return IconButton(
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () => close(context, null)
    );
  }
  
  @override
  Widget buildResults(BuildContext context) 
  {
    return null;
  }
  
  @override
  Widget buildSuggestions(BuildContext context) 
  {
    if( query.isEmpty) return Container();

    return FutureBuilder(
          future: dbPaciente.getEspecialidadesQuery(query),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot){

              return snapshot.hasData 
              ? ListView.builder(
                    itemCount: snapshot.hasData == null ? 0 : snapshot.data.length,
                    itemBuilder: ( context, i){
              
                      return Container(
                          padding: EdgeInsets.only( left: 3.0, right: 3.0),
                          child: Card(
                                elevation: 0.0,
                                child: InkWell(
                                  child: ListTile(
                                          title:  Text(snapshot.data[i]['Especialidad'].toString(), style: TextStyle(fontFamily: 'Inter', fontSize: 18)),
                                          subtitle: Text( snapshot.data[i]['Descripcion'].toString(), style: TextStyle(fontFamily: 'Inter')),
                                          trailing: Icon(Icons.arrow_forward_ios, size: 17.0),
                                        ),
                                        onTap: (){
                                            // Navigator.of(context).push(MaterialPageRoute(builder: ( BuildContext context ) => PageEditEspecialidades( list: list, index: i )));
                                        },
                                )
                              )
                      );
                    },
              )
              : Center(child: CircularProgressIndicator());

          }
      );
  }
  
}

