// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

// 1️⃣ Create a Twitter Contract 
// 2️⃣ Create a mapping between user and tweet 
// 3️⃣ Add function to create a tweet and save it in mapping
// 4️⃣ Create a function to get Tweet 
// 5️⃣ Add array of tweets 

contract Twitter {
    // Key -> Value
    //Username => List of tweets
    mapping(address => string[]) public tweets;

    function createTweet(string memory _tweet) public {
        //Focus => "Hello, World"
        //Focus => ["Hello, World". "Have a nice day...", ...
        tweets[msg.sender].push(_tweet);
    }

    function getTweet(address _addr, uint256 _i) public view returns (string memory) {
        return tweets[_addr][_i];
    }

    function getAllTweets(address _addr) public view returns (string[] memory){
        return tweets[_addr];

    }
 }
