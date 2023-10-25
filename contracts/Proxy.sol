// SPDX-License-Identifier: MIT  
pragma solidity >0.6.0 <0.9.0;

import "./Storage.sol";

contract Proxy is Storage{

    address currentAddress;

    constructor(address _currentAddress) public{
        currentAddress = _currentAddress;
    }

    function upgrade(address _newAddress) public {
       // require(msg.sender == owner);
        currentAddress = _newAddress; 
    }

    // Take all info and delive it to currentAddress
    // Fallback function it will trigger if someone sends functional call to this contract and here is no functions that are corresponds
    // with names that person try to call
    fallback() payable external {
        // REDIREDT TO currentAddress
        address implementation = currentAddress;  // this line tells where are we going to make calls
        require(currentAddress != address(0)); // security reason
        bytes memory data = msg.data;
        // msg.data is all information about function call itself (it will contain all parameters that we sending to the function)

        // This assembly code takes entire function call and entire data that is comming in and sending it forward, formating right way, calling 
        // implementation address with all data
        //DELEGATECALL EVERY FUNCTION CALL
        assembly {
            let result := delegatecall(gas(), implementation, add(data, 0x20), mload(data), 0, 0)
            let size := returndatasize()
            let ptr := mload(0x40)
            returndatacopy(ptr, 0, size)
            switch result
            case 0 {revert(ptr, size)}
            default {return(ptr, size)}
        }
    }
}