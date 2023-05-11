import 'dart:convert';

class EasyCode{
  static String getStringSafeSub(String str, int length, {String putStr ="..."}){
    if (str==""){
      return "";
    }
    if (str.length >length){
      return str.toString().substring( 0, length) +putStr;
    }
    return str;
  }

  //判断一个值是否能采用原型
  static bool needPrototype(dynamic value){
    if(value is int){
      return true;
    }else if(value is double){
      return true;
    }
    else if(value is bool){
      return true;
    }
    else if(value== null){
      return true;
    }
    return false;
  }

  /*
  * summary Map2JsonString-that can be Decode with jsonDecode or json.decode .*/
  static String stringify(Map<String, dynamic> hash){
    try{
      String result ="";
      int index =hash.length;
      hash.map((key, value){
        if(value is Map){
          final valueStr =EasyCode.stringify(value.map((key, value) => MapEntry("$key", value)));
          result +='"$key":$valueStr${index >0?",":""}';
        }
        if(value is List){
          //转化arr的对象
          final List<dynamic> list =[];
          for(dynamic item in value){
            if(item is Map){
              final valueStr =EasyCode.stringify(item.map((key, value) => MapEntry("$key", value)));
              list.add(valueStr);
            }
            //如果是个原型
            else if(EasyCode.needPrototype(item)){
              list.add(item);
            }
            //转化为string
            else{
              list.add('"$item"');
            }
          }
          result +='"$key":$list,';
        }
        else{
          final dynamic prototypeOrStr =EasyCode.needPrototype(value)?value:'\"$value"';
          result +='"$key":$prototypeOrStr,';
        }
        index -=1;
        return MapEntry(key, value);
      });
      //如果末尾是逗号，将其截断 if there are contains quotation,drop it
      if(result.substring(result.length-1).contains(",")){
        result =result.substring(0,result.length -1);
      }
      return '{$result}';
    }catch(e){
      return "";
    }
  }


  Map<String, String> toJson(String str){
    return json.decode(str);
  }


}