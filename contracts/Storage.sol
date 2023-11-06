// SPDX-License-Identifier: MIT  
pragma solidity >0.6.0 <0.9.0;

contract Storage{

    mapping(string => uint256) _uintStorage;
    mapping(string => address) _addressStorage;
    mapping(string => bool) _boolStorage;
    mapping(string => string) _stringStorage;
    mapping(string => bytes4) _bytesStorage;

    address public owner; 
    bool public _initialized; 
    
}