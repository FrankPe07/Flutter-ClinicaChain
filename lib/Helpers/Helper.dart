

class TimeZoneCustom
{

  static String getDia( int hour ){

    int hora;

    hora = DateTime.now().hour;

    if( hora < 12 ){
      return 'Buenos Dias!';
    }else if( hora > 12 && hora < 18 ){
      return 'Buenas Tardes!';
    }else if( hora < 24 && hora > 18 ){
      return 'Buenas Noches!';
    }else{
      return 'Buenas!';
    }
    
  }

}