// SPDX-License-Identifier: MIT  
pragma solidity >0.6.0 <0.9.0;

import "./Storage.sol";

contract TokenUpdated is Storage{

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    
    constructor() public{

        initialize(msg.sender);
    }

    function initialize(address _owner) public{
        require(!_initialized);
        owner = _owner; 
        _initialized = true; 
    }
    
    function getNumberOfToken() public view returns(uint256){
        return _uintStorage["Token"];
    }

    function setNumberOfToken(uint256 toSet) public onlyOwner {
        _uintStorage["Token"] = toSet;
    }

}