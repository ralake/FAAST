FASST
=====
Makers Academy Week 1 Challenge

Brief
-----
The mayor of London has been really impressed by your work on the boris bikes project.

He has contacted the Greater London Authority to access the Transport for London Software Development and Deployment specifications for the new FAAST Tube System ( Fast And Accessible Super Tube). Your task, if you choose() to accept it is to implement the **FAAST* system so that it can be deployed into the London underground network.

The FAAST system will cater for the following:

There will be a number of trains inside the system.
Trains will travel from station to station.
Inside of a station, when the train stops, passengers will alight and enter the carriages of the train.
A Passenger will touch in at the station and touch out at the destination station.
Each coach of a train can hold up to 40 passengers.
Each train is made of a number of coaches.

Classes - passenger, train, station

Passenger
---------
Responsibilities  | Collaborators
------------- | -------------
board & alight trains | station
enter and exit stations | train
touch in & out |
pay for the service |

Train
-----
Responsibilities  | Collaborators
------------- | -------------
have passengers | passenger
enter and exit stations | train
vary its capacity | 

Station
-------
Responsibilities  | Collaborators
------------- | -------------
have passengers | passenger
have trains | train
vary its capacity for trains and passengers | 

Technologies
------------
rspec
