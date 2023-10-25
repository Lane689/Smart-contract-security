// SPDX-License-Identifier: MIT  
pragma solidity >0.6.0 <0.9.0;

import "./Storage.sol";

contract Dogs is Storage{

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    constructor() public {
        owner = msg.sender;
    }
    
    function getNumberOfDogs() public view returns(uint256){
        return _uintStorage["Dogs"];
    }

    function setNumberOfDogs(uint256 toSet) public {
        _uintStorage["Dogs"] = toSet;
    }

    // This will work like a adding new variables: 
    // function setNumberOfCats(uint256 toSet) public {
    //     _uintStorage["Cats"] = toSet;
    // }
    // function setNumberOfLions(uint256 toSet) public {
    //     _uintStorage["Lions"] = toSet;
    // }



}