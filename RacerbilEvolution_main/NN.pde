class NN {

  Car p;
  //Hidden layer neuron
  Neuron[] l1Neurons = new Neuron[16];
  Neuron[] l2Neurons = new Neuron[8];
  Neuron[] l3Neurons = new Neuron[4];
  Neuron[] l4Neurons = new Neuron[2];

  Sensor[] sensors;

  NN(Sensor[] nSensors) {

    //Create neuron based on sensor length
    sensors = nSensors;

    for (int i = 0; i < l1Neurons.length; i++) {
      l1Neurons[i] = new Neuron(sensors.length, 5);
    }
    for (int i = 0; i < l2Neurons.length; i++) {
      l2Neurons[i] = new Neuron(l1Neurons.length, 5);
    }
    for (int i = 0; i < l3Neurons.length; i++) {
      l3Neurons[i] = new Neuron(l2Neurons.length, 5);
    }
    for (int i = 0; i < l4Neurons.length; i++) {
      l4Neurons[i] = new Neuron(l3Neurons.length, 5);
    }
  }

  //Using vector as 2d output
  PVector Output() {
    //Hidden layer logic
    //layer 1
    for (int i = 0; i < l1Neurons.length; i++) {

      float[] n = new float[sensors.length];

      for (int j =0; j < n.length; j++) {
        n[j]=sensors[j].CalcDis();
      }
      //Generate neuron output by input list
      l1Neurons[i].GetValue(n);
    }

    //layer 2
    for (int i = 0; i < l2Neurons.length; i++) {
      float[] n = new float[l1Neurons.length];

      for (int j =0; j < l1Neurons.length; j++) {
        n[j]=l1Neurons[j].value;
      }
      l2Neurons[i].GetValue(n);
    }

    //layer 3
    for (int i = 0; i < l3Neurons.length; i++) {
      float[] n = new float[l2Neurons.length];

      for (int j =0; j < l2Neurons.length; j++) {
        n[j]=l2Neurons[j].value;
      }
      l3Neurons[i].GetValue(n);
    }

    //Layer 4
    for (int i = 0; i < l4Neurons.length; i++) {
      float[] n = new float[l3Neurons.length];

      for (int j =0; j < l3Neurons.length; j++) {
        n[j]=l3Neurons[j].value;
      }

      l4Neurons[i].GetValue(n);
    }
    //Output layer, preassigned since two is needed
    return new PVector(l4Neurons[0].value, l4Neurons[1].value);
  }

  Car Reproduce(Car mate) {

    Car child = new Car();
    child.brain.l1Neurons = CalcGenes(l1Neurons, mate.brain.l1Neurons);
    child.brain.l2Neurons = CalcGenes(l2Neurons, mate.brain.l2Neurons);
    child.brain.l3Neurons = CalcGenes(l3Neurons, mate.brain.l3Neurons);
    child.brain.l4Neurons = CalcGenes(l4Neurons, mate.brain.l4Neurons);

    return child;
  }
}
