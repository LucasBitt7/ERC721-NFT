pragma solidity^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
//import "@openzeppelin/contracts@4.2.0/access/Ownable.sol";

contract jubirubaNFT is ERC721{
     constructor() ERC721("SomeItem", "SIM") {}

    uint public tokenId = 0;

    struct Metadata { 
        uint timestamp;
        uint tokenId;
        string tokenURI;
    }

    mapping (address => Metadata[]) public ownership;

    function mintToken() public {
        Metadata memory newToken = Metadata({
            timestamp: block.timestamp,
            tokenId: tokenId,
            tokenURI: tokenURI(tokenId)
            });
        tokenId++;
        _safeMint(msg.sender, newToken.tokenId);
        ownership[msg.sender].push(newToken);
    }

    function burnToken(uint _tokenId) public {
        require(ownership[msg.sender][_tokenId].tokenId == _tokenId,"you havent this token motherfocka");
         _burn(_tokenId);
        for(uint i = 0; i < ownership[msg.sender].length; i++) {
            if(ownership[msg.sender][_tokenId].tokenId == _tokenId ) {
                delete ownership[msg.sender][_tokenId];

            }
        }
    }

    function getYourTokens(uint _tokenId) public view returns (Metadata memory) {
        return ownership[msg.sender][_tokenId];
    }
}