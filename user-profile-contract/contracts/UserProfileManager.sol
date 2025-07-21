// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserProfileManager {
    
    // creating a struct for user data
    struct User {
        string name;
        uint age;
        string email;
        uint registrationTimestamp;
        bool isRegistered;
    }
    
    // mapping to store users
    mapping(address => User) public users;
    
    // keeping track of total users
    uint public totalUsers;
    
    // register new user
    function register(string memory _name, uint _age, string memory _email) public {
        // check if user already registered
        require(!users[msg.sender].isRegistered, "already registered!");
        
        // some basic validation
        require(bytes(_name).length > 0, "name required");
        require(_age > 0, "age must be greater than 0");
        require(bytes(_email).length > 0, "email required");
        
        // create new user
        users[msg.sender] = User(_name, _age, _email, block.timestamp, true);
        totalUsers++;
    }
    
    // update profile info
    function updateProfile(string memory _name, uint _age, string memory _email) public {
        // make sure user is registered first
        require(users[msg.sender].isRegistered, "not registered yet");
        
        require(bytes(_name).length > 0, "name required");
        require(_age > 0, "age must be greater than 0");
        require(bytes(_email).length > 0, "email required");
        
        // update the user data
        users[msg.sender].name = _name;
        users[msg.sender].age = _age;
        users[msg.sender].email = _email;
    }
    
    // get profile information
    function getProfile(address userAddress) public view returns (string memory, uint, string memory, uint, bool) {
        User memory user = users[userAddress];
        return (user.name, user.age, user.email, user.registrationTimestamp, user.isRegistered);
    }
    
    // helper function to check if user exists
    function checkIfRegistered(address userAddress) public view returns (bool) {
        return users[userAddress].isRegistered;
    }
}