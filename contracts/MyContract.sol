pragma solidity 0.5.1;
//pragma solidity ^0.8.0;

//SPDX-License-Identifier: <SPDX-License>

import "./Math.sol";
//import "./SafeMath.sol"; // https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol

contract LibraryContract{
    //using SafeMath for uint256;
    uint256 public value; 

    function calculate(uint _value1, uint _value2) public{
       value = Math.divide(_value1, _value2);
        //value = _value1.div(_value2); //SafeMath
    }
}


//inheritance
contract ERC20Token{
    string public name;
    mapping(address => uint256) public balances;

    constructor (string memory _name) public{
        name = _name;
    }

    function  mint() public{
        balances[tx.origin]++;
    }
}

contract MyToken is ERC20Token{
    //string public name = "My Token";
    string public symbol;
    address[] public owners;
    uint256 ownerCount;

    constructor(string memory _name, string memory _symbol) ERC20Token(_name) public {
        symbol = _symbol;
    }

    function mint() public{
        super.mint();
        ownerCount++;
        owners.push(msg.sender);
    }
}


contract MyContract3{
    address payable wallet;
    address public token;

    event Purchase(address indexed _buyer, uint256 _amount);

    constructor(address payable _wallet, address _token) public{
        wallet = _wallet;
        token = _token;
    }
    function() external payable{
        buyToken();
    } 

    function buyToken () public payable{
        ERC20Token(address(token)).mint();
        wallet.transfer(msg.value);
        //balances[msg.sender]++;
        emit Purchase(msg.sender, 1);
    }
}


contract MyContract2 {
    Person[] public peopleArr;

    uint256 public peopleCount = 0;
    mapping(uint => Person) public peopleMap;

    address owner;
     modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
 
    uint256 openingTime = 1661515884;
    modifier onlyWhileOpen(){
        require(block.timestamp >= openingTime);
        _;
    }

    constructor() public {
        owner = msg.sender;
    }

    struct Person {
        uint _id;
        string _firstName;
        string _lastName;
    }

    function addPerson(string memory _firstName, string memory _lastName) public onlyOwner onlyWhileOpen {
        peopleMap[peopleCount] = Person(peopleCount, _firstName, _lastName); //mapping
        incrementCount();
        //peopleArr.push(Person(_firstName,_lastName)); //array
    }

    function incrementCount() internal{
        peopleCount +=1;
    }
}



contract MyContract1{
   
    enum State {Waiting, Active}
    State public state;

    constructor() public {
        state = State.Waiting;
    }

    function activate() public {
        state = State.Active;
    }

    function isActive() public view returns (bool) {
        return state == State.Active;
    }
}


contract MyContract0{
    string public stringValue = "myString";
    bool public myBool = true;
    int public myInt = -1;
    uint256 public myUinit256 = 9999;

    constructor () public {
        stringValue = "myValue";
    }
    function get() public view returns(string memory){
        return stringValue;
    }
    function set(string memory _value) public {
        stringValue = _value;
    }     
}


