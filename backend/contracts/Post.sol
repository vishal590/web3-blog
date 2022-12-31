//SPDX-License-Identifier: MIT

pragma solidity >= 0.4.22 < 0.9.0;

contract Blog{
    struct Post{
        uint256 id;
        address author;
        string title;
        string content;
        uint likeCount;
        string tag;
        uint256 timestamp;
    }

    struct Comment{
        uint256 id;
        address commentor;
        string main;
        uint256 time;
    }

    Post[] public posts;
    Comment[] public comments;

    mapping(uint256 => Comment) public getComment;

    mapping(address => mapping(uint => bool)) public didLiked;

    function createPost(string memory title, string memory content, string memory tag) external {
        uint _id = posts.length;
        
        Post memory newPost = Post(_id, msg.sender, title, content, 0, tag, block.timestamp);

        posts.push(newPost);

        emit CreatePost(msg.sender, _id);

    }

    event CreatePost(address creator, uint PostId);

    function getPosts() public view returns(Post[] memory){
        return posts;
    }

    




}