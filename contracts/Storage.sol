// SPDX-License-Identifier: MIT  
pragma solidity >0.6.0 <0.9.0;

contract Storage{
    // storage has to remain (we can't change it in future if we update)
    //1. What type of storage will I need? 

    mapping(string => uint256) _uintStorage;
    // Adding new integer: _uintStorage["Number"]=10
    mapping(string => address) _addressStorage;
    mapping(string => bool) _boolStorage;
    mapping(string => string) _stringStorage;
    mapping(string => bytes4) _bytesStorage;

    address public owner; 
    bool public _initialized; 
    
}