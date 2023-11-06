// SPDX-License-Identifier: MIT  
pragma solidity >0.6.0 <0.9.0;

import "./Storage.sol";

contract Token is Storage{

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    constructor() public {
        owner = msg.sender;
    }
    
    function getNumberOfToken() public view returns(uint256){
        return _uintStorage["Token"];
    }

    function setNumberOfToken(uint256 toSet) public {
        _uintStorage["Token"] = toSet;
    }

}