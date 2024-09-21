// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PaymentSplit {

    // 事件
    event PayeeAdded(address account, uint256 shares); // 增加受益人事件
    event PaymentReleased(address to, uint256 amount); // 受益人提款事件
    event PaymentReceived(address from, uint256 amount); // 合约收款事件
    
    // 属性
    uint256 public totalShares; // 总份额
    uint256 public totalReleased; // 总支付

    mapping(address => uint256) public shares; // 每个受益人的份额
    mapping(address => uint256) public released; // 支付给每个受益人的金额
    address[] public payees; // 受益人数组

    constructor(address[] memory _payees, uint256[] memory _shares) payable {
        // 检查_payees和_shares数组长度相同，且不为0
        require(_payees.length == _shares.length, "PaymentSplitter: payees and shares length mismatch");
        require(_payees.length > 0, "PaymentSplitter: no payees");
        // 调用_addPayee，更新受益人地址payees、受益人份额shares和总份额totalShares
        for (uint256 i = 0; i < _payees.length; i++) {
            _addPayee(_payees[i], _shares[i]);
        }
    }


    fallback() external payable {
        emit PaymentReceived(msg.sender , msg.value);
    }

    receive() external payable {
        emit PaymentReceived(msg.sender , msg.value);
    }

    function _addPayee(address _account , uint256 _share) public {
        // border check
        require( _account != address(0) , "account address cannot be 0" );
        require( _share > 0 , "share should bigger than 0" );
        require( shares[_account] == 0 , "alreay add to the payee" );
        // renew 
        totalShares += _share;
        shares[_account] += _share;
        payees.push(_account);

        emit PayeeAdded(_account,_share);
    }

    // 计算当前账户应当受到的eth
    function pendingPayment(
        address _account,
        uint256 _totalReceived,
        uint256 _alreadyReleased
    ) public view returns (uint256) {
        return ( _totalReceived * shares[_account]  ) / totalShares - _alreadyReleased;
    }

    function releasable(address _account) public view returns (uint256) {
        uint256 total = address(this).balance + totalReleased;
        return pendingPayment(_account , total , released[_account]);
    }

    function release(address payable _account) public virtual {
        
        require( _account != address(0) , "invalid address cannot be 0" );
        uint256 amount = releasable(_account);
        require(amount != 0 ,"amount can not less or equal 0");
        
        // do transfer
        _account.transfer(amount);
        totalReleased += amount;
        released[_account] += amount;

        emit PaymentReleased(_account , amount);
    }


}