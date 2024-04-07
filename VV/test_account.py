import pytest
import datetime
from account import Account

#Test Unitary
def test_deposit():
    account = Account(initial_balance=100)
    account.deposit(50)
    assert account.balance == 150

#Test Unitary
def test_withdraw():
    account = Account(initial_balance=100)
    account.withdraw(50)
    assert account.balance == 50


#Integration Test
def test_deposit_and_withdraw():
    account = Account(initial_balance=100)
    account.deposit(50)
    account.withdraw(30)
    assert account.balance == 50

#Integration Test
def bank_policy():
    account = Account(initial_balance=100)
    current_time = datetime.datetime.now()

    with pytest.raises(ValueError):
        account.deposit(50)

    with pytest.raises(ValueError):
        account.withdraw(30)