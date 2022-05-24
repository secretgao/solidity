// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract TodoList{
    struct Todo{
        string text;
        bool completed;
    }

    Todo[] public todo_arr;

    function create(string calldata _text) external{
        todo_arr.push(Todo({
            text:_text,
            completed:false
        }));
    }

    function updateText(uint _index,string calldata _text) external{
        //35138 gas
        todo_arr[_index].text = _text;
     // todo_arr[_index].text = _text;
     // todo_arr[_index].text = _text;
     // todo_arr[_index].text = _text;
     //假如结构体中只有一个字段要更新 上面的方法会节约gas 
   //假如结构体中有很多字段要更新 下面的方法会节约gas

        //34578 gas
  //      Todo storage todo = todo_arr[_index];
    //    todo.text = _text;
    //    todo.text = _text;
    //    todo.text = _text;
    //    todo.text = _text;
    
    }

    function get(uint _index) external view returns (string memory,bool){
        //storage - 29397
        //memory - 29480
        Todo storage todo = todo_arr[_index];
        return (todo.text,todo.completed);
    }
    //改变代办列表的完成状态 
    function toggleCompleted(uint _index) external{
        //                          用！取反             
        todo_arr[_index].completed = !todo_arr[_index].completed;
    }
}
