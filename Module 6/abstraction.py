from abc import ABC, abstractmethod

# Abstract class
class Vehicle(ABC):

    @abstractmethod
    def start(self):
        pass

    @abstractmethod
    def stop(self):
        pass

# Concrete class
class Car(Vehicle):

    def start(self):
        print("Car is starting...")

    def stop(self):
        print("Car is stopping...")

# Usage
my_car = Car()
my_car.start()
my_car.stop()
