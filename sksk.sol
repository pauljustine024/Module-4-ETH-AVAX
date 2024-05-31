// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ExtremeToken is ERC20, Ownable {

    mapping(uint256 => uint256) public ShopPrices;

    constructor() ERC20("Extreme", "EXT") Ownable(msg.sender) {
        ShopPrices[1] = 150;
        ShopPrices[2] = 80;
        ShopPrices[3] = 40;
        ShopPrices[4] = 20;
    }

    function mintEXT(address _to, uint256 _amount) public onlyOwner {
        _mint(_to, _amount);
    }

    function transferEXT(address _to, uint256 _amount) public {
        require(balanceOf(msg.sender) >= _amount, "Transfer Failed: Insufficient balance.");
        approve(msg.sender, _amount);
        transferFrom(msg.sender, _to, _amount);
    }

    function showShopItems() external pure returns (string memory) {
        string memory saleOptions = "The items on sale: {1} Extreme NFT (150) {2} Extreme Gear (80) {3} Random Extreme IN-GAME Item (40) {4} Extreme Sticker (20)";
        return saleOptions;
    }

    function redeemEXT(uint256 _item) public {
        require(ShopPrices[_item] > 0, "Item is not available.");
        require(_item <= 4, "Item is not available.");
        require(balanceOf(msg.sender) >= ShopPrices[_item], "Redeem Failed: Insufficient balance.");
        transfer(owner(), ShopPrices[_item]);
    }
    
    function burnEXT(uint256 _amount) public {
        require(balanceOf(msg.sender) >= _amount, "Burn Failed: Insufficient balance.");
        approve(msg.sender, _amount);
        _burn(msg.sender, _amount);
    }

    function getBalance() external view returns (uint256) {
        return this.balanceOf(msg.sender);
    }

    function decimals() override public pure returns (uint8) {
        return 0;
    }

}
