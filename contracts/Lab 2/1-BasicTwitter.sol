// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

// 1️⃣ Create a Twitter Contract 
// 2️⃣ Create a mapping between user and tweet 
// 3️⃣ Add function to create a tweet and save it in mapping
// 4️⃣ Create a function to get Tweet 
// 5️⃣ Add array of tweets 

contract Twitter {

    struct Tweet {
        string content;
        address user_address;
        uint16 likes;
        uint256 timestamp;
    }

    // Key -> Value
    // Username => List of tweets
    mapping(address => Tweet[]) public tweets;

    function createTweet(string memory _tweet) public {
        // Ittiphat => ["Hello, World". "Have a nice day...", ...]
        //
        // Java:
        // Tweet t1 = new Tweet();

        // byte(string_var).length => The length of the string.
        require(bytes(_tweet).length <= 255, "The length of your tweet exceeds the limit bro!");

        Tweet memory newTweet = Tweet({
            content: _tweet,
            user_address: msg.sender,
            likes: 0,
            timestamp: block.timestamp
        });

        tweets[msg.sender].push(newTweet);
    }

    function getTweet(address _addr, uint256 _i) public view returns (Tweet memory) {
        return tweets[_addr][_i];
    }

    function getAllTweets(address _addr) public view returns (Tweet[] memory){
        return tweets[_addr];
    }
}
