# LexJsonTool
##english
map2json string,basic types of dart were supported. provide 2 method for use.just like js's stringify.for flutter.
you can use it with copy that code to your project,or,add the depend's options to your pubspec.yaml.

Map2JsonString-that can be Decode with jsonDecode or json.decode

##chinese
map2json可以将复杂map转化为可供jsonDecode正常转换的String字符串，所以你可以像在js中一般的使用它。你可以直接复制工具类到你的项目中，或者在你的pubspec.yaml中添加依赖。

##tips
`com.github.lexoops:LexJsonTool:1.0`


##for example【示例】

* 1，convert map to string 将map转化为string
```${dart}
final jsonstr =LexTool.stringify({
        "arr":[
          1
        ],
        "c":[
          {
            "name":"fern"
          },
          {
            "name":"tomi"
          },
          {
            "name":"janie",
            "collects":[
              {
                "sex":"women"
              }
            ]
          },
        ]
      })
```

* 2,decode this 解开它
```${dart}
json.decode(jsonstr)
```

* 3,
 ![image](https://github.com/lexoops/LexJsonTool/assets/33716494/25ba3257-8487-4b8b-84fe-77fef92d5ff1)
