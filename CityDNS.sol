//SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

contract City_DNS {

    address public owner;

    mapping (bytes32 => bool) internal dao_name;
    mapping (address => bytes32) internal accountOwner;
    
    event txLog (address indexed _newOwner, string message);


    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Access Denied: Unauthorized account");
        _;
    }

    function node5(string memory _name) private pure returns(bytes32){
        return keccak256(abi.encode(_name));
    }

    function assignName(string memory _name) external {
        require(!dao_name[node5(_name)],"Name already assigned to an account");
        dao_name[node5(_name)] = true;
        accountOwner[owner] = node5(_name);
        emit txLog(owner, "Name assigned to account successfully");
    }

    function transferNameOwnership(address _address) external onlyOwner{
        owner = _address;
        emit txLog(_address, "Name transferred to new account successfully");
    }   

    function checkName(string memory _name) public view returns (bool) {
        return (dao_name[node5(_name)]);          
    }    

}
