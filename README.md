# RacerbilEvolution
AI Race cars using a genetic algorithm

This is/was a school project, and as such was written in processing

# How it works
Each car is fitted with an array of sensors. Each sensor measures the direction from the car to the wall in the direction the sensor is facing. This is then used as the input layer in the neural network that drives the cars. When the cars drive around the circuit, they will eventually hit checkpoints. Each checkpoint gives a fitness score used by a genetic algorithm for breeding. For each point a car achieves, one more instance of this car is added to the breeding pool. When the cars breed, half of the weights of one car and half of the other are used to generate a new child. Finally a small random mutation is applied to some of the weights, to avoid the models getting stuck. This process is then repeated such that there is a child car for each parent car. The simulation then runs again, and eventually the cars will drive themselves around the circuit.

<img src="https://github.com/TheLucanus/RacerbilEvolution/blob/main/figures/race_ex.png" width="50%" height="50%">

# Short Demonstration video

https://youtu.be/VzNXeUydMdA
