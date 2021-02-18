### This is a pure Lua library that provides a set of utility functions for dealing with strings,tables,files and some others.

### debug

first you must require the module if you need use it in your code.

```lua
local debug = require 'utils.debug'
```

- `print()` print a scalar value or table

  **Notice**:

  a) can not print nil value .

  b) will print json format if the params is table.

  ```lua
  local a = 56
  debug.print('hello',a) --output: hello  56
  debug.print(false,true,3.4)  --output:false true 3.4
  debug.print({1,2,3,4}) --output json:[1,2,3,4]
  ```

- `die()` Output a message and terminate the current script

  ```lua
  debug.print("hello") --output:hello
  debug.die("this is die") --output: this is die
  debug.print("can not print this line")
  ```

  

### string

first you must require the module if you need use it in your code.

```lua
local util_string = require 'utils.string'
```

- `trim()` Strip whitespace from the beginning and end of a string

  ```lua
  print(util_string.trim(" hello ")) -- output:"hello"
  print(util_string.trim("helloaa",'a')) -- output:"hello"
  ```

- `ltrim()` Strip whitespace from the beginning of a string

  ```lua
  print(util_string.ltrim(" hello ")) --output:"hello "
  print(util_string.ltrim("ahelloa",'a')) -- output:"helloa"
  ```

- `rtrim()`  Strip whitespace from the end of a string

  ```lua
  print(util_string.rtrim(" hello ")) --output:" hello"
  print(util_string.rtrim("ahelloa",'a')) -- output:"ahello"
  ```

- `startswith()` check whether a string is start with some charactors

  ```lua
  print(util_string.startswith("hello",'he')) --output:true
  print(util_string.startswith("hello",'H')) --output:false
  ```

- `endswith()` check whether a string is end with some charactors

  ```lua
  print(util_string.endswith("hello",'o')) -- output:true
  print(util_string.endswith("hello",'O')) -- output:false
  ```

- `split()` split a string into table

  ```lua
  util_string.split("a#b#c#d",'#') --output:{'a','b','c','d'}
  ```

- `contains()` Checks if a value exists in a string

  ```lua
  print(util_string.contains("hello world",'H')) --output:false
  print(util_string.contains("hello world",'e')) --output:true
  ```

- `replace()` Replace all occurrences of the search string with the replacement string

  ```lua
  print(util_string.replace("hello world world",'world','lua')) -- output:hello lua lua
  ```

- `len()` get string length

  ```lua
  print(util_string.len("hello")) -- output:5
  ```

- `upper()` Make a string uppercase

  ```lua
  print(util_string.upper("hello world")) -- output:HELLO WORLD
  ```

- `lower()` Make a string lowercase

  ```lua
  print(util_string.lower("Hello world")) -- output:hello world
  ```

- `ucwords()` Uppercase the first character of each word in a string

  ```lua
  print(util_string.ucwords("hello world")) --output:Hello World
  print(util_string.ucwords("hello#world",'#')) -- output:Hello#World
  ```

- `ucfirst()` Make a string's first character uppercase

  ```lua
  print(util_string.ucfirst("hello world")) --output:Hello world
  ```

- `reverse()` Reverse a string

  ```lua
  print(util_string.reverse("hello")) -- output:olleh
  ```

- `substr()` Return part of a string

  ```lua
  print(util_string.substr("hello",2,3)) -- output:el
  
  print(util_string.substr("hello",-3)) --output:llo
  ```

### table

first you must require the module if you need use it in your code.

```lua
local util_table = require 'utils.table'
```

- `is_empty()` Determine whether a variable is empty,return true or false

  ```lua
  util_table.is_empty({})  -- output:true
  util_table.is_empty({name="json"})  -- output:false
  ```

- `reverse()` Return an array with elements in reverse order

  ```lua
  debug.print(util_table.reverse({'a','b','c'})) -- output:{'c','b','a'}
  ```

- `unique()` Removes duplicate values from an array

  ```lua
  debug.print(util_table.unique({'a','b','a','c'})) -- output:{'a','b','c'}
  ```

- `implode()`  Join array elements with a string

  ```lua
  debug.print(util_table.implode({'a','b','a','c'},'#')) -- output:a#b#a#c
  ```

- `copy()` Deep copies a table into a new table.

  ```lua
  local a = {'a','b','c'}
  local b = util_table.copy(a)
  debug.print(a==b) -- output:false
  ```

- `is_array`() Finds whether a variable is an array

  ```lua
  local a = {'a','b','c'}
  debug.print(util_table.is_array(a)) -- output:true
  debug.print(util_table.is_array('hello')) -- output:false
  debug.print(util_table.is_array({name='json',age=32})) -- output:false
  ```

- `merge()` Merge arrays into a new array. if the key is same, and the after element will override the before. 

  ```lua
  local a = {'a','b','c','d'}
  local b = {1,2}
  debug.print(util_table.merge(a,b))  -- output:{1,2,'c','d'}
  
  local a = {name='json',age=32}
  local b = {1,2}
  debug.print(util_table.merge(a,b))  --output:{1,2,name='json',age=32}
  ```

- `contains()` Checks if a value exists in a table,return true or false

  ```lua
  local a = {'a','b','c'}
  debug.print(util_table.contains(a,'a')) -- output:true
  
  debug.print(util_table.contains(a,'11')) --output:false
  ```

- `keys()` return a table containing the keys of the provided table

  ```lua
  local a = {name='json',age=32}
  debug.print(util_table.keys(a))  -- output:{'name','json'}
  ```

- `values()` return a table containing the values of the provided table

  ```lua
  local a = {name='json',age=32}
  debug.print(util_table.values(a)) -- output:{'json',32}
  ```

- `append()` append the contents of (array-like) table b into table a

  ```lua
  local a = {'a','b','c'}
  local b = {1,2,3}
  util_table.append(a,b)
  debug.print(a)  -- output:{'a','b','c',1,2,3}
  ```

- `push()` Push one or more elements onto the end of table

  ```lua
  local a = {'a','b','c'}
  util_table.push(a,1,2,3)
  debug.print(a)  -- output:{'a','b','c',1,2,3}
  ```

- `pop()` Pop the element off the end of table

  ```lua
  local a = {'a','b','c'}
  util_table.pop(a)
  debug.print(a)  -- output:{'a','b'}
  ```

- `unshift()` Prepend one or more elements to the beginning of an table

  ```lua
  local a = {'a','b','c'}
  util_table.unshift(a,1,2,3)
  debug.print(a)  -- output:{3,2,1,'a','b','c'}
  ```

- `shift()` Shift an element off the beginning of table

  ```lua
  local a = {'a','b','c'}
  util_table.shift(a)
  debug.print(a) -- output:{'b','c'}
  ```

- `key_exists()` Checks if the given key or index exists in the table, return true or false

  ```lua
  local tab = {name='json',age=32}
  debug.print(util_table.key_exists('info',tab)) -- output:false
  debug.print(util_table.key_exists('name',tab)) -- output:true
  ```

- `search()` Searches the table for a given value and returns the first corresponding key if successful

  ```lua
  local tab = {name='json',age=32}
  debug.print(util_table.search('json',tab)) -- output:name
  debug.print(util_table.search('info',tab)) -- output:nil
  ```

- `slice(tab,index,length)` Extract a slice of the table. the first argument is the table, the second is the index, and the third is the slice length, default is the last if you not give.

  if the index is negative, and the slice with count from back.

  ```lua
  local tab = {'a','b','c','d'}
  debug.print(util_table.slice(tab,2))  -- output:{'b','c','d'}
  debug.print(util_table.slice(tab,2,2)) --output:{'b','c'}  
  debug.print(util_table.slice(tab,-3)) --output:{'b','c','d'}
  ```

- `to_array()`  convert table to list

  ```lua
  local tab = {name='json',age=32,}
  debug.print(util_table.to_array(tab))  -- output:{'json',32}
  ```

- `sort()` sort with a function

  ```lua
  local tab = {4,2,-6,3}
  util_table.sort(tab)
  debug.print(tab)  --output:{-6,2,3,4}
  
  util_table.sort(tab,function(a,b) 
      return math.abs( a ) < math.abs( b ) 
  end)
  debug.print(tab)  --output:{2,3,4,-6}
  ```

- `filter(tab,callback)` Filters elements of an array using a callback function. filter the false value if you not give the function,  and If the callback function returns true, the current value from table is returned into the result array.

  ```lua
  local tab = {4,2,false,3}
  
  debug.print(util_table.filter(tab))  --output:{4,2,3}
  
  local a = util_table.filter(tab,function(a)
      return a and a%2==1
  end)
  debug.print(a)  --output:{3}
  ```

- `pluck(tab,column,index_key)` Return the values from a single column in the input array

  returns the values from a single column of the array, identified by the column_key. Optionally, an index_key may be provided to index the values in the returned array by the values from the index_key column of the input array.

  ```lua
  local list = {
      {id='1',name='json',age=32},
      {id='2',name='fanqingxuan',age=29},
      {id='3',name='lua',age=45}
  }
  
  debug.print(util_table.pluck(list,'name')) --output:{'json','fanqingxuan','lua'}
  debug.print(util_table.pluck(list,'name','id')) --putput:{['1']='json',['2']='fanqingxuan',['3']='lua'}
  
  debug.print(util_table.pluck(list,nil,'id'))
  --oputput:{['1']={id='1',name='json',age=32},['2']={id='2',name='fanqingxuan',age=29},['3']={id='3',name='lua',age=45}}
  
  ```

### io

first you must require the module if you need use it in your code.

```lua
local io = require 'utils.io'
```

- `file_get_contents`  get contents from file, return the content str and err

  ```lua
  local data,err = io.file_get_contents('./utils/cjson.lua')
  debug.print(data) -- output the content in file cjson.lua
  ```

- `file_put_contents(file,data,mode)` Write file contents.

  return true upon success, or false + error message on failure

  ```lua
  io.file_put_contents('a.txt',"hello world") -- will clear a.txt content, then write 'hello world' to a.txt
  
  io.file_put_contents('a.txt',"hello world","a+") -- will append 'hello world' to a.txt
  ```

- `file_exists()` Checks whether a file exists

  ```lua
  debug.print(io.file_exists("index.lua") )-- output:true
  
  local exists,err = io.file_exists("index1.lua")
  
  if not exists then
  	print("file not exists with err:"..err)
  end
  ```

- `execute_cmd()`Execute an external program

  ```lua
  local data,err = io.execute_cmd('ls -ll')
  ```

### console

first you must require the module if you need use it in your code.

```lua
local console = require 'utils.console'
```

This library is for command, and can print some text with colors.

```lua
console.red(" this is red color");
console.yellow(" this is yellow color");
console.white(" this is white color");
console.blue(" this is blue color");
console.green(" this is green color");
console.magenta(" this is magenta color");
console.cyan(" this is cyan color");
```

And you can also write log with diffent color:

```lua
console.log("this is log")
console.trace("this is trace log")
console.info("this is info log")
console.warn("this is warn log")
console.error("this is error log")
console.debug("this is debug log")
console.fatal("this is fatal log")
```

The module also provide two function for sucess or fail output:

```lua
console.success("the code run success")
console.error("there something error")
```

### json

first you must require the module if you need use it in your code.

```lua
local json = require 'utils.cjson'
```

**Notice**: you must confirm you have installed cjson library in your system, if not please install it with luarocks.

- `encode()` Returns the JSON representation of a value

  ```lua
  local arr = {
      name = 'json',
      age = 32
  }
  debug.print(json.encode(arr)) -- output string:{"age":32,"name":"json"}
  ```

- `decode()` Decodes a JSON string

  ```lua
  local str = '{"age":32,"name":"json"}'
  debug.print(json.decode(str).name) --output:json
  ```


### other library

The project also collect some useful third library, You can click the link and read the detail document.

- [ansicolors](https://github.com/kikito/ansicolors.lua) a useful library for output color text
- [argparse](https://github.com/mpeterv/argparse) a library for parse arguments from command line
- [classic](https://github.com/rxi/classic/blob/master/classic.lua) a library that you can make your lua code more like oop
- [date](https://github.com/Tieske/date) a library that for date and time calculations
- [dkjson](https://github.com/LuaDist/dkjson) a module for encoding and decoding JSON data
- [md5](https://github.com/kikito/md5.lua) a module for generating md5 string
- [redis-lua](https://github.com/nrk/redis-lua/) you can use redis with this module
- [memcached](https://github.com/silentbicycle/lua-memcached) you can play with memcached
- [net-url](https://github.com/golgote/neturl) a library that can parse URL with querystring and build new URL easily