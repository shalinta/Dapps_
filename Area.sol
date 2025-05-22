pragma solidity ^0.8.0;
contract Shapes {
    function calculateArea() public virtual view returns (uint) {
        return 0;
    }
}
contract Circle is Shapes {
    uint private r;
    constructor(uint _radius) {
        r = _radius;
    }
    function calculateArea() public view override returns (uint) {
        return (314 * r * r) / 1000; }
}
contract Rectangle is Shapes{
    uint length;
    uint breadth;
    constructor(uint _l,uint _b){
        length=_l;
        breadth=_b;
    }
    function calculateArea() public view override returns (uint){
        return (length*breadth);
    }
}
contract Square is Shapes{
    uint side;
    constructor(uint _a)
    {
        side=_a;
    }
    function calculateArea() public view override returns (uint){
        return (side**2);
    }
}

