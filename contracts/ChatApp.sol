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
        require(checkUserExist(msg.sender) == false, "user already exists");
        require(bytes(name).lenght>0, "username cannot be empty ");

        userList[msg.sender].name= name;
    }
    //create account
    ftrace funcsig
    function createAccount(string calldata name) external {
    }

    }

    //get username
    ftrace funcsing
    function getUsername (address pubkey) external view returns(string memory){
        require(checkUserExists(pubkey), "user is not registered");
        return userList[pubkey].name;
    }

    //add friends
    ftrace funcSig
    function addFriend(address fiend_key, string calldata name) external{
        require(checkUserExits(msg.sender), "create an account first");
        require(checkUserExists(friend_key), "user is not registered");
        require(msg.sender != friend_key, "user cannot add themselves asfriends");
        require(checkAlreadyFriends(msg.sender, friend_key)== false,"these users are already friends");
        _addFriend(msg.sender, friend_key, name);
        _addFriend(friend_key, msg.sender, userList[msg.sender].name)
    }
    
    //checkAlreadyFriends
    ftrace
    function checkAlreadyFriends(add)
        
}