// SPDX-License-Identifier: MIT
pragma solidity 0.7.4;

import "./IERC20.sol";

contract MyToken is IERC20{
    
    string private name;
    string private symbol;
    uint256 private total_supply;
    uint8 private decimal;
    address public owner;
    
    mapping (address => uint) private balances;
    mapping (address => mapping(address => uint)) private allownce;
    

    constructor()  {
        name="FarhanCoins";
        symbol="FRX";
        total_supply=10000;
        decimal=18;
        owner=msg.sender;
        balances[owner]+=total_supply;
    }
    
    function totalSupply() external virtual override view returns(uint256){
        return total_supply;
    }
    
    function getName() external view returns(string memory){
        return name;
    }
    
    function getSymbol() external view returns(string memory){
        return symbol;
    }
    function getDecimal() external view returns(uint8){
        return decimal;
    }
    
    function balanceOf(address _user) public virtual override view returns(uint256){
        return balances[_user];
    }
    
    function transfer(address _to, uint256 _value) external virtual override returns(bool){
        require(_to!=address(0),"Invalid Address");
        require(_value<=balances[msg.sender]);
        balances[msg.sender]-=_value;
        balances[_to]+=_value;
        emit Transfer(msg.sender,_to,_value);
        return true;
    }
    
    function approve(address spender, uint256 amount) external virtual override returns(bool){
        require(spender!=address(0),"Not Valid Address ");
        require(amount<=balances[msg.sender]);
        allownce[msg.sender][spender]+=amount;
        emit Approval(owner, spender, amount);(msg.sender,spender,amount);
        return true;
    }
    
    function allowance(address _owner, address _spender) external virtual override view returns(uint256){
        return allownce[_owner][_spender];
    }
    
    function transferFrom(address _sender, address _to, uint256 _value) external virtual override returns(bool){
        require(_to!=address(0),"Invalid recipient address");
        require(allownce[_sender][msg.sender]<= _value , "_sender have not enough balance");
        balances[_sender]-=_value;
        balances[_to]+=_value;
        allownce[_sender][msg.sender]-=_value;
        return true;
        
    }
    
}

