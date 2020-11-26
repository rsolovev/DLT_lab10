// simple rock paper scissors game on ethereum in a very naive implementation, just to showcase some basic features of Solidity
pragma solidity  ^0.5.1;
contract rps{
    mapping (string => mapping(string => int)) payoffMatrix;
    address payable player1;
    address payable player2;
    string public player1Choice;
    string public player2Choice;
    int public winn;
    constructor () public {   // constructor
    payoffMatrix["rock"]["rock"] = 0;
    payoffMatrix["rock"]["paper"] = 2;
    payoffMatrix["rock"]["scissors"] = 1;
    payoffMatrix["paper"]["rock"] = 1;
    payoffMatrix["paper"]["paper"] = 0;
    payoffMatrix["paper"]["scissors"] = 2;
    payoffMatrix["scissors"]["rock"] = 2;
    payoffMatrix["scissors"]["paper"] = 1;
    payoffMatrix["scissors"]["scissors"] = 0;

    }
    function play() public returns (int w)    {
        if (bytes(player1Choice).length != 0 && bytes(player2Choice).length != 0)        {
            int winner = payoffMatrix[player1Choice][player2Choice];
            if (winner == 1)
            player1.transfer(address(this).balance);
            else if (winner == 2)
                player2.transfer(address(this).balance);
            else {
                player1.transfer(address(this).balance/2);
                player2.transfer(address(this).balance/2);

            }
            // unregister players and choices
            player1Choice = "";
            player2Choice = "";
            player1 =address(0);
            player2=address(0);
            winn=winner;
            return winner;

        }
        else
        return -1;

    }
    function Choicer1(string memory choice) public payable  {
        require( msg.value > .01 ether);
        player1=msg.sender;
        player1Choice=choice;

    }
    function Choicer2(string memory choice) public payable  {
        require( msg.value > .01 ether);
        player2=msg.sender;
        player2Choice=choice;

    }

}