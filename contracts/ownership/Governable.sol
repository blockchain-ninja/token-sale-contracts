pragma solidity ^0.4.18;


contract Governable {

    // list of admins, council at first spot
    address[] public admins;

    modifier onlyAdmins() {
        var(adminStatus, ) = isAdmin(msg.sender);
        require(adminStatus == true);
        _;
    }

    function Governable() public {
        admins.length = 1;
        admins[0] = msg.sender;
    }

    function addAdmin(address _admin) public onlyAdmins {
        var(adminStatus, ) = isAdmin(_admin);
        require(!adminStatus);
        require(admins.length < 10);
        admins[admins.length++] = _admin;
    }

    function removeAdmin(address _admin) public onlyAdmins {
        var(adminStatus, pos) = isAdmin(_admin);
        require(adminStatus);
        require(pos < admins.length);
        // if not last element, switch with last
        if (pos < admins.length - 1) {
            admins[pos] = admins[admins.length - 1];
        }
        // then cut off the tail
        admins.length--;
    }

    function isAdmin(address _addr) internal returns (bool isAdmin, uint256 pos) {
        isAdmin = false;
        for (uint256 i = 0; i < admins.length; i++) {
            if (_addr == admins[i]) {
            isAdmin = true;
            pos = i;
            }
        }
    }
}
