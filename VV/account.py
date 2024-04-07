import  datetime
class Account:
    def __init__(self, initial_balance=0, transaction_limit_hour=15):
        self.balance = initial_balance
        self.transaction_limit_hour = transaction_limit_hour

    def _bank_policy(self):
        now = datetime.datetime.now()
        if now.hour >= 15:
            raise ValueError("As transações só podem ser realizadas até as 15:00")

    def deposit(self, amount):
        self._bank_policy()
        self.balance += amount

    def withdraw(self, amount):
        self._bank_policy()
        if amount > self.balance:
            raise ValueError("Saldo insuficiente")
        self.balance -= amount
