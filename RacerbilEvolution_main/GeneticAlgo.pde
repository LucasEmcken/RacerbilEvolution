//Logic behind the genetic algorithm

//Checkpoints to determine car distance from start and therefore fitness

class Checkpoint {

  int x, y, s, n;

  Checkpoint(int xPos, int yPos, int size) {
    x = xPos;
    y = yPos;
    s = size;
  }

  void Display() {
    fill(255, 255, 0);
    ellipse(x, y, s, s);
  }
}

//Next generation function
void NextGen() {
  
  gen++;
  fit=0;
  //Set mating array
  ArrayList<Car> mateCars = new ArrayList<Car>();

  for (int i = 0; i < car.length; i++) {
    if (car[i].fitness > 0) {
      for (int j = 0; j < car[i].fitness; j++) {
        //Add a car to arraylist for each fitness score earned
        fit++;
        mateCars.add(car[i]);
      }
    }
  }

  //Repopulate if matecars is 0
  if (mateCars.size() == 0) {
    for (int i = 0; i < car.length; i++) {
      mateCars.add(new Car());
    }
  }

  //Add completely random car for further variation
  //mateCars.add(new Car());
  println(mateCars.size());
  Car[] nextGen = new Car[car.length];

  for (int i = 0; i < car.length; i++) {
    int parentASel = round(random(mateCars.size()-1));
    int parentBSel = round(random(mateCars.size()-1));

    nextGen[i] = new Car();
    nextGen[i].brain.l1Neurons = CalcGenes(mateCars.get(parentASel).brain.l1Neurons, 
      mateCars.get(parentBSel).brain.l1Neurons);

    nextGen[i].brain.l2Neurons = CalcGenes(mateCars.get(parentASel).brain.l2Neurons, 
      mateCars.get(parentBSel).brain.l2Neurons);

    nextGen[i].brain.l3Neurons = CalcGenes(mateCars.get(parentASel).brain.l3Neurons, 
      mateCars.get(parentBSel).brain.l3Neurons);

    nextGen[i].brain.l4Neurons = CalcGenes(mateCars.get(parentASel).brain.l4Neurons, 
      mateCars.get(parentBSel).brain.l4Neurons);
  }

  car = nextGen;
}


//Generate child genes
Neuron[] CalcGenes(Neuron[] parentA, Neuron[] parentB) {

  int splitPoint = round(random(parentA.length));

  Neuron[] splitA = new Neuron[splitPoint];
  Neuron[] splitB = new Neuron[parentA.length-splitPoint];

  for (int i = 0; i < splitA.length; i++) {
    splitA[i] = parentA[i];
  }
  for (int i = 0; i < splitB.length; i++) {
    splitB[i] = parentB[i+splitPoint];
  }

  Neuron[] childGenes = (Neuron[])concat(splitA, splitB);
  
  childGenes = Mutate(childGenes, 0.5);
  
  return childGenes;
}

//mutate genes
Neuron[] Mutate(Neuron[] genes, float chance) {
  Neuron[] mGenes = new Neuron[genes.length];

  //Deep clone of neurons
  for (int i = 0; i < mGenes.length; i++) {
    mGenes[i] = genes[i].CloneNeuron();
  }
  
  //perform mutation
  for (int i = 0; i < mGenes.length; i++) {
    if (chance > random(100)) {
      mGenes[i].bias = random(-mGenes[i].vari, mGenes[i].vari);
    }
    for (int j = 0; j < mGenes[i].weights.length; j++) {
      if (chance > random(100)) {
        mGenes[i].weights[j] = random(-mGenes[i].vari, mGenes[i].vari);
        println("mutated");
      }
    }
  }

  return mGenes;
}
