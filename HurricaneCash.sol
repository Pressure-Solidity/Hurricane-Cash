pragma solidity ^0.8.11;

contract HurricaneCash {

    mapping(uint => uint) public encryptedDeposits;


   function encrypt() private view returns(uint){
       return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,msg.sender,msg.value,"5")));
   }

   function deposit() public payable returns(uint){
       //require(msg.value > 0.01 ether);
       uint encryptValue = encrypt();
        encryptedDeposits[encryptValue] = msg.value;
        return encryptValue;
   }

   function withdraw(uint _encryptedValue) public {
       uint amount = encryptedDeposits[_encryptedValue];
       payable(msg.sender).transfer(amount);
       encryptedDeposits[_encryptedValue] = 0;
   }


}

