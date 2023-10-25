// SPDX-License-Identifier: MIT  
pragma solidity >0.6.0 <0.9.0;

import "./Storage.sol";

contract DogsUpdated is Storage{

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    
    constructor() public{
        // owner = msg.sender;

        // ako nemamo ovu liniju ispod tada bi svatko izvana mogao pozvati initialize() function to dogsUpdated contract
        initialize(msg.sender);
    }

    // initialize all variables from constructor kako bi proxy znao for those states
    // should be able to only call ONES
    function initialize(address _owner) public{
        require(!_initialized);
        owner = _owner; 
        _initialized = true; 
    }
    
    function getNumberOfDogs() public view returns(uint256){
        return _uintStorage["Dogs"];
    }

    function setNumberOfDogs(uint256 toSet) public onlyOwner {
        _uintStorage["Dogs"] = toSet;
    }

}