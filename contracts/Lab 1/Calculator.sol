// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract Calculator {

    uint256 public result = 0;

    function add(uint256 num) public {
        result += num;
    }

    function subtract(uint256 num) public {
        result -= num;
    }

    function multply(uint256 num) public {
        result *= num;
    }

    function division(uint256 num) public {
        result /= num;
    }

}