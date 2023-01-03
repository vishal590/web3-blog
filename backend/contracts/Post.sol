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

    function LikePost(uint256 _id) external{
        require(didLiked[msg.sender][posts[_id].id] == false, "You have already Liked the post");
        posts[_id].likeCount++;

        uint256 temp = posts[_id].id;

        didLiked[msg.sender][temp] = true;
    }

    function getPost(uint256 _id) public view returns(Post memory){
        return posts[_id];
    }

    function getDidLiked(uint256 _id) public view returns(bool){
        return didLiked[msg.sender][posts[_id].id];
    }

    function writeComment(uint256 _id, string memory content) external{
        comments.push(Comment(_id, msg.sender, content, block.timestamp));
        getComment[_id] = Comment(_id, msg.sender, content, block.timestamp);
    }

    function getPostComments(uint256 _id) public view returns(Comment[] memory){
        Comment[] memory temp = new Comment[](comments.length);
        uint256 count = 0;

        for(uint256 i = 0; i < comments.length; i++){
            if(comments[i].id == _id){
                temp[i] = comments[i];
                count++;
            }else{
                continue;
            }
        }

        Comment[] memory result = new Comment[](count);

        for(uint256 i = 0; i < count; i++){
            result[i] = temp[i];
        }
        return result;
    }


}