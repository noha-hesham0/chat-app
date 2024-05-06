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

    struct AlluserStruck{
        string name;
        address accountAddress;
    }
        
    AlluserStruck[] getAllusers;

    mapping(address => User) userList;
    mapping(bytes32 => message[]) allMessages;

    function checkUserExists(address pubkey) public  view  returns(bool){
        return  bytes(userList[pubkey].name).length >0 ;
    }

    //create account
    function createAccount(string calldata name) external {
        require(checkUserExists(msg.sender) == false, "user already exists");
        require(bytes(name).lenght>0, "username cannot be empty ");

        userList[msg.sender].name= name;

        getAllusers.push(AlluserStruck(name, msg.sender));
    }
   
    //get username
    function getUsername (address pubkey) external view returns(string memory){
        require(checkUserExists(pubkey), "user is not registered");
        return userList[pubkey].name;
    }

    //add friends
   
    function addFriend(address friend_key, string calldata name) external{
        require(checkUserExists(msg.sender), "create an account first");
        require(checkUserExists(friend_key), "user is not registered");
        require(msg.sender != friend_key, "user cannot add themselves asfriends");
        require(checkAlreadyFriends(msg.sender, friend_key)== false,"these users are already friends");
        _addFriend(msg.sender, friend_key, name);
        _addFriend(friend_key, msg.sender, userList[msg.sender].name);
    }
    
    //checkAlreadyFriends
 
    function checkAlreadyFriends(address pubkey1, address pubkey2) internal view returns (bool)
    {
        if(userList[pubkey1].friendList.length> userList[pubkey2].friendList.length ){
           address tmp = pubkey1;
           pubkey1 = pubkey2;
           pubkey2 = tmp;
        }

        for(uint256 i = 0; i < userList[pubkey1].friendList.length; i++){
           if(userList[pubkey1].friendList[i].pubkey == pubkey2)return true; 
        }
        return false;
    }
   
    function _addFriend(address me, address friend_key,string memory name) internal{
        friend memory newFriend = friend(friend_key, name);
        userList[me].friendList.push(newFriend);
    }

    //GETMY FRIEND
    
    function getMyfriendList() external view returns(friend[] memory){
        return userList[msg.sender].friendList;
    }

    //get chat code
  
    function getchatcode(address pubkey1, address pubkey2) internal pure returns(bytes32){
        if(pubkey1 < pubkey2){
            return keccak256(abi.encodePacked(pubkey1, pubkey2 ));
        } 
        else {
             return keccak256(abi.encodePacked(pubkey2, pubkey1));
        }

    }
        //send message
        function sendMessage (address friend_key, string calldata msg) external{
            require(checkUserExists(friend_key), "user is not registered");
            require(checkAlreadyFriends(msg.sender, friend_key), "you are not afriend withbthe given user");

            bytes32 chatcode = getchatcode(msg.sender, friend_key);
            message memory newMsg = message(msg.sender, block.timestamp, msg);
            allMessages[chatcode].push(newMsg);
        }

        //Read Message
        function readmessage(address friend_key  , string memory newMsg) external view returns(message[] memory){
            bytes32 chatCode = getchatcode(msg.sender, friend_key);
            return allMessages[chatCode].push(newMsg);
        }
    
    function getAllAppUser() public view returns(AlluserStruck[] memory){
        return getAllusers;
    }
        
}