// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

contract GetSet {
    uint256 public x;

    event SetX(uint256 x);

    constructor() {}

    function set(uint256 _x) public {
        x = _x;

        emit SetX(_x);
    }
}
