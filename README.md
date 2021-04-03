# gps
A complete model of the Global Positioning System (GPS) consisting of three 
programs: vehicle, satellite, and receiver. The vehicle generates positional 
data, the satellite converts those into data of the kind processed by GPS 
receivers, and the receiver converts these back into positional data.

## Running
Run the satellite and reciever programs with
```sh
julia --project=. src/satellite.jl
```
and
```sh
julia --project=. src/receiver.jl
```
respectively.
