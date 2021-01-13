class Neuron {
  //Value will be calculated in getValue()
  float value = 0;
  float bias;

  float[] weights;
  
  float vari;

  Neuron(int nIn, float variance) {
    vari = variance;
    weights = new float[nIn];
    //Create weights and biases
    for (int i =0; i < nIn; i++) {
      weights[i] = random(-vari, vari);
    }

    bias = random(-vari, vari);
  }
  
  //Value function
  void GetValue(float[] ins) {
    float n = 0;

    for (int i = 0; i < ins.length; i++) {
      n+=ins[i]*weights[i];
    }

    //Run n through activation function
    n = activation(n);

    //assign value
    value = n;
  }
  
  //Activation function
  float activation(float input) {
    //using tanH, since it outputs num between -1 and 1
    return (float) Math.tanh(input+bias);
  }

  
  //Clone function for deep cloning of neuron in mutations
  Neuron CloneNeuron() {
    Neuron clone = new Neuron(weights.length, vari);
    clone.weights = weights.clone();
    
    clone.bias = bias;
    return clone;
  }
}
