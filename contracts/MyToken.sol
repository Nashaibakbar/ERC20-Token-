pragma solidity 0.7.4;

contract MyToken{
    
    string private name;
    string private symbol;
    uint256 private total_supply;
    uint8 private decimal;
    address owner;
    
    mapping (address => uint) private balances;
    mapping (address => mapping(address => uint)) private allownce;
    
    event Transfer(address indexed, address indexed , uint256 );
    event Approve(address indexed, address indexed, uint256 );
    
    constructor()  {
        name="FarhanCoins";
        symbol="FRX";
        total_supply=10000;
        decimal=18;
        owner=msg.sender;
    }
    
    function getTotalSupply() public view returns(uint256){
        return total_supply;
    }
    
    function getName() public view returns(string memory){
        return name;
    }
    
    function getSymbol() public view returns(string memory){
        return symbol;
    }
    function getDecimal() public view returns(uint8){
        return decimal;
    }
    
    function balanceOf(address _user) public view returns(uint256){
        return balances[_user];
    }
    
    function transfer(address _to, uint256 _value) public returns(bool){
        require(_to!=address(0),"Invalid Address");
        require(_value<=balances[msg.sender]);
        balances[msg.sender]-=_value;
        balances[_to]+=_value;
        emit Transfer(msg.sender,_to,_value);
        return true;
    }
    
    function approve(address spender, uint256 amount) private returns(bool){
        require(spender!=address(0),"Not Valid Address ");
        require(amount<=balances[msg.sender]);
        allownce[msg.sender][spender]=amount;
        emit Approve(msg.sender,spender,amount);
        return true;
    }
    
    function getAllownce(address _owner, address _spender) public view returns(uint256){
        return allownce[_owner][_spender];
    }
    
    function transferFrom(address _sender, address _to, uint256 _value) public returns(bool){
        require(_to!=address(0),"Invalid recipient address");
        uint currentallownce=allownce[_sender][msg.sender];
        balances[_sender]-=_value;
        balances[_to]+=_value;
        approve(msg.sender,(currentallownce-_value));
        return true;
        
    }
    
}
