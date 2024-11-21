// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

// 1️⃣ Create a Twitter Contract 
// 2️⃣ Create a mapping between user and tweet 
// 3️⃣ Add function to create a tweet and save it in mapping
// 4️⃣ Create a function to get Tweet 
// 5️⃣ Add array of tweets 

contract Twitter {

    struct Tweet {
        uint256 id;
        string content;
        address user_address;
        uint16 likes;
        uint256 timestamp;
    }

    // Key -> Value
    // Username => List of tweets
    mapping(address => Tweet[]) public tweets;
    address public owner;
    uint16 public MAX_TWEET_LENGTH = 256;

    event tweetCreated (uint256 id, address author, string content, uint256 timestamp);
    event tweetLiked (address liker, address tweetAuthor, uint256 tweetId, uint256 newLikeCount);
    event tweetUnliked (address unliker, address tweetAuthor, uint256 tweetId, uint256 newLikeCount);
    
    constructor() {
        owner = msg.sender;
    }

    modifier OnlyOwner() {
        require(msg.sender == owner, "YOU ARE NOT THE OWNER!");
        _;
    }

    function changeTweetLength(uint16 newTweetLength) public OnlyOwner {
        MAX_TWEET_LENGTH = newTweetLength;
    }

    function createTweet(string memory _tweet) public {
        // Ittiphat => ["Hello, World". "Have a nice day...", ...]
        //
        // Java:
        // Tweet t1 = new Tweet();

        // byte(string_var).length => The length of the string.
        // Length of _tweet <= 256 characters
        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "The length of your tweet exceeds the limit bro!");

        Tweet memory newTweet = Tweet({
            // mapping (address -> Tweet[])
            id: tweets[msg.sender].length,
            content: _tweet,
            user_address: msg.sender,
            likes: 0,
            timestamp: block.timestamp
        });

        tweets[msg.sender].push(newTweet);
        // Tell every mobile application to update UI to show a new tweet.
        emit tweetCreated(newTweet.id, newTweet.user_address, newTweet.content, newTweet.timestamp);
    }

    function likeTweet(address author, uint256 id) public {
        // mapping (address -> Tweet[])
        // user1 -> [Tweet1, Tweet2, Tweet3]
        // user2 -> [Tweet4, Tweet5, Tweet6]
        require(tweets[author][id].id == id, "This ID is not existing");

        tweets[author][id].likes++;

        emit tweetLiked(msg.sender, author, id, tweets[author][id].likes);
    }

    function unlikeTweet(address author, uint256 id) public {
        require(tweets[author][id].id == id, "This ID is not existing");
        require(tweets[author][id].likes > 0, "This tweet has no like");
        tweets[author][id].likes--;
        emit tweetUnliked(msg.sender, author, id, tweets[author][id].likes);
    }

    function getTotalLikes(address _author) {
        code
    }

    function getTweet(address _addr, uint256 _i) public view returns (Tweet memory) {
        return tweets[_addr][_i];
    }

    function getAllTweets(address _addr) public view returns (Tweet[] memory){
        return tweets[_addr];
    }
}
