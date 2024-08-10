// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

/// @custom:security-contact security@example.com
contract MockERC20 is ERC20, ERC20Burnable, AccessControl, ERC20Permit {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BRIDGE_OPERATOR_ROLE = keccak256("BRIDGE_OPERATOR_ROLE");

    // Events
    event TokensMinted(address indexed to, uint256 amount);
    event TokensBurned(address indexed from, uint256 amount);


    constructor() ERC20("MockERC20", "MCK-ERC20") ERC20Permit("MockERC20") {
        _mint(msg.sender, 100 * 10 ** decimals());
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    // Admin functions
    function mintTokensForTesting(uint256 amount) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _mint(msg.sender, amount);
        emit TokensMinted(msg.sender, amount);
    }

    // Bridge operator functions
    function bridgeMintTokens(address to, uint256 amount) public onlyRole(BRIDGE_OPERATOR_ROLE) {
        _mint(to, amount);
        emit TokensMinted(to, amount);
    }

    function bridgeBurnTokens(address from, uint256 amount) public onlyRole(BRIDGE_OPERATOR_ROLE) {
        _burn(from, amount);
        emit TokensBurned(from, amount);
    }

    // Role management functions
    function assignMinterRole(address account) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _grantRole(MINTER_ROLE, account);
    }

    function assignBridgeOperatorRole(address account) public onlyRole(DEFAULT_ADMIN_ROLE) {
        require(hasRole(MINTER_ROLE, account), "Bridge operator must have minter role");
        _grantRole(BRIDGE_OPERATOR_ROLE, account);
    }

    function revokeMinterRole(address account) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _revokeRole(MINTER_ROLE, account);
    }

    function revokeBridgeOperatorRole(address account) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _revokeRole(BRIDGE_OPERATOR_ROLE, account);
    }
}
