// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract chatApp{
    struct User{
        string name;
        friend[] friendList;
    }

    struct friend{
        address pubkey;
        string name;
    }

    struct message{
        address sender;
        uint256 timestamp;
        string msg;
    }

    mapping(address => user) userlist;
    mapping(bytes32 => message[]) allMessages;

    function checkUserExists(address pubkey) public  view  returns(bool){
        return  bytes(userlist[pubkey].name).length >0 ;
    }
    //create account
    function createAccount(string calldata name) external {
        require(checkUserExist(msg.sender) == false, "user already exists);
        require(bytes(name).lenght>0, "username cannot be empty");

        userList[msg.sender].name= name;
    }

}