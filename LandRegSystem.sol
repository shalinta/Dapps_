
pragma solidity ^0.8.0;
contract LandRegSystem
{
    address public owner;
    constructor()
    {
        owner=msg.sender;
    }
    struct Land
    {
        address owner;
        uint area;
        uint price;


    }
    Land[] lands;
    event LandRegistered(address indexed owner, uint area, uint price);
    event landSold(address indexed owner);

    modifier onlyOwner()
    {
        require(msg.sender==owner);
        _;

    }

    function registerLand(uint area,uint price)public onlyOwner {
        lands.push(Land(msg.sender,area,price));
        emit LandRegistered(msg.sender,area,price);

    }

    function sellLand(uint landId)public onlyOwner
    {
        require(lands[landId].owner==msg.sender);
        emit landSold(msg.sender);

    }


    

    

    
}
