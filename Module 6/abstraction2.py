from abc import ABC, abstractmethod

class PaymentProcessor(ABC):

    @abstractmethod
    def pay(self, amount):
        pass

class CreditCardPayment(PaymentProcessor):

    def pay(self, amount):
        print(f"Paid ₹{amount} using Credit Card.")

class UpiPayment(PaymentProcessor):

    def pay(self, amount):
        print(f"Paid ₹{amount} using UPI.")

# Usage
payment = UpiPayment()
payment.pay(500)
