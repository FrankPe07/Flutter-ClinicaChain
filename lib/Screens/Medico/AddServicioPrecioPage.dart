import 'package:clinicachain/Controller/DBMedico.dart';
import 'package:clinicachain/Screens/Widgets/BtnCustom.dart';
import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:clinicachain/Screens/Widgets/TextFieldCustom.dart';
import 'package:clinicachain/Screens/Widgets/Wait.dart';
import 'package:flutter/material.dart';


class AddServicioPrecioPage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Color(0xffF3F3F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextChain(text: 'Nuevo Servicio Medico', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w500, fontSize: 20),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, size: 23, color: Color(0xff2B57C0)),
          onPressed: () => Navigator.pop(context)
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextChain(text: 'Tipo de servicio', fontSize: 18),
            SizedBox(height: 10),
            Card(
              elevation: 0,
              child: InkWell(
                child: ListTile(
                  title: TextChain(text: 'Seleccionar tipo de servicio', fontSize: 17),
                  trailing: Icon(Icons.arrow_drop_down_circle_rounded, color: Color(0xff306FFD), size: 30),
                ),
                onTap: () => showModalButtomService(context),
              ),
            ),
            SizedBox(height: 10),
            TextChain(text: 'Descripción del servicio', fontSize: 18),
            SizedBox(height: 10),
            TextFieldCustomChain(fillColor: Colors.white, maxLines: 3, hint: 'Descripcion del servicio',),
            SizedBox(height: 10),
            TextChain(text: 'Precio del servicio', fontSize: 18),
            SizedBox(height: 10),
            TextFieldCustomChain(fillColor: Colors.white, hint: 'S/ 0.00', type: TextInputType.number, ),
            SizedBox(height: 20),

            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: BtnCustom(
                  text: 'Agregar Servicio',
                  borderRadius: 50,
                  colorTwo: Color(0xff306FFD),
                  onPressed: (){
                    
                  },
                )
              )
            )
          ],
        ),
      ),
     );
  }
}


showModalButtomService(BuildContext context){

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
          ),
          child: Column(
            children: [
              TextChain(text: 'Seleccione tipo de servicio', fontSize: 18),
              SizedBox(height: 10),
              Expanded(
                child: FutureBuilder<List>(
                  future: dbMedico.getTipoServicio(),
                  builder: (context, snapshot) {

                    return !snapshot.hasData
                    ? WaitMoment()
                    : ListTipoServicio(listTipo: snapshot.data );
                  },
                ),
              ),
            ],
          )
        );
      },
    );
  }

class ListTipoServicio extends StatefulWidget {

  final List listTipo;

  const ListTipoServicio({this.listTipo});

  @override
  _ListTipoServicioState createState() => _ListTipoServicioState();
}

class _ListTipoServicioState extends State<ListTipoServicio> 
{
  int selectedCard = -1;

  @override
  Widget build(BuildContext context) 
  {
    return ListView.builder(
      itemCount: widget.listTipo.length,
      itemBuilder: (context, i) {

        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: selectedCard == i ? Color(0xff1E58AC) : Colors.grey)
          ),
          child: InkWell(
            child: ListTile(
              title: Text( widget.listTipo[i]['nombreServicio']),
              trailing: selectedCard == i
                ? Icon(Icons.radio_button_checked_outlined, size: 27, color: Color(0xff306FFD))
                : Icon(Icons.radio_button_off_outlined, size: 27),
            ),
            onTap: (){
              setState(() {
                selectedCard = i;
              });
            },
          ),
        );
      },
    );
  }
}
