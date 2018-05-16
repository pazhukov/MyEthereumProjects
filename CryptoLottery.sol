pragma solidity ^0.4.23;

contract CryptoLottery {
    
    address public owner;
    event TheGame(uint winAmount, uint8 youNumber);
    
    constructor() public{
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function() payable public {

    }
    
    function playGame() public payable {
        require(msg.value == 0.01 ether);
        uint8 rnd = random();
        if(rnd % 2 == 0) {
            msg.sender.transfer(msg.value * 2);
            emit TheGame(msg.value * 2, rnd);
        } else {
            emit TheGame(0, rnd);
        }        
    }
    
    function random() private view returns (uint8) {
        return uint8(uint256(keccak256(block.timestamp, block.difficulty))%251);
    }    

    function withDraw() public onlyOwner {
        uint amount = getBalance();
        owner.transfer(amount);
    }
    
    function getBalance() public view returns (uint){
        return address(this).balance;
    }
    
}
