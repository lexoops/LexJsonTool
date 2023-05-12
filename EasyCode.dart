import 'dart:convert';

class LexJsonTool{
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
  * summary Map2JsonString-that can be Decode with jsonDecode or json.decode .
  * 如果在map中存在字符型json，那么请在convertJsonStr2Map中传入false。如果要将其转化为map存储，传入true
  * */
  static String stringify(Map<String, dynamic> hash,{bool convertJsonStr2Map =false}){
    try{
      String result ="";
      int index =hash.length;
      hash.map((key, value){
        //如果遇到被字符化的json map，那么打上tag
        bool isStringMap =false;
        if(value is String &&value.contains("{")){
          try{
            //确认是string型map
            isStringMap =json.decode(value) !=null;
          }catch(e){}
        }
        //匹配类型
        if(isStringMap){
          //将其作为map存储
          value =convertJsonStr2Map?json.decode(value):value.toString().replaceAll("\"", "");
        }
        if(value is Map){
          final valueStr =LexJsonTool.stringify(value.map((key, value) => MapEntry("$key", value)));
          result +='"$key":$valueStr${index >0?",":""}';
        }
        else if(value is List){
          //转化arr的对象
          final List<dynamic> list =[];
          for(dynamic item in value){
            if(item is Map){
              final valueStr =LexJsonTool.stringify(item.map((key, value) => MapEntry("$key", value)));
              list.add(valueStr);
            }
            //如果是个原型
            else if(LexJsonTool.needPrototype(item)){
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
          final dynamic prototypeOrStr =LexJsonTool.needPrototype(value)?value:'\"$value"';
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
