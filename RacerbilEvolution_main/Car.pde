class Car {
  //NEURAL NETWORK
  //================================
  Sensor[] sensors = new Sensor[15];
  NN brain;

  int fitness;
  int nCp;
  float checkpointCD=3;

  boolean crashed = false;
  boolean hasFinished;

  //CAR STATS
  //================================
  //Static and dynamic tire friction
  float CoF, CoFS, CoFK;

  //mass
  float m;

  //Power
  float engineP;

  //Orientation
  PVector pos;
  PVector vel;

  float rVel;

  float rot;

  //Graphics
  PImage carImg;
  //================================

  Car() {

    CoFS = 0.8;
    CoFK = 0.4;

    CoF = CoFK;

    m=1500;
    engineP = 500;

    //Orientation
    pos = new PVector (width/2, height-101.5);
    vel = new PVector (0, 0);

    //Assign sensors and brain
    for (int i = 0; i < sensors.length; i++) {
      //Distribute sensors in front of car
      sensors[i] = new Sensor(1, -PI/2.0 + PI/sensors.length*i + PI/(2*sensors.length));
    }

    brain = new NN(sensors);

    //Graphics
    carImg = loadImage("Car.png");
    carImg.resize(0, 25);
  }

  float DistributeFunc(int i) {
    return i;
  }

  void ControlCar() {
    if (!crashed) {
      PVector carIn = brain.Output();
      Drive(carIn.x, carIn.y/10);
      //      Drive(0, 0);
    }
  }

  //Drive function with throttle and rotation;
  void Drive(float t, float r) {
    //throttle input
    vel.add(new PVector(t*cos(rot)*engineP/m, t*sin(rot)*engineP/m));
    pos.add(vel);

    //rotation input
    rot += r;

    //Calc lateral force
    float angle = PVector.angleBetween(vel, new PVector(cos(rot), sin(rot)));
    float fLat = sin(angle)*vel.mag()/10;
    if (abs(fLat) < CoF) {
      //Rounds to 6 decimal due to error in cos and sin values not being 0
      vel.add(new PVector(float(nf(cos(angle)*fLat * CoFS, 0, 6)), float(nf(sin(angle)*fLat * CoFS, 0, 6))));
      CoF = CoFS;
    } else {
      vel.add(new PVector(float(nf(cos(angle)*fLat*CoFK, 0, 6)), float(nf(sin(angle)*fLat*CoFK, 0, 6))));
    }

    rVel = cos(angle)*vel.mag()/10;
    //Drag
    vel.mult(0.9);

    //outside bounds
    color c = get((int)pos.x, (int)pos.y);
    if (red(c) == 255 && green(c) == 255 && blue(c) == 255) {
      crashed = true;
    }

    //Checkpoint
    GetCheckpoint();

    //Finish Line
    if (red(c) == 0 && green(c) == 255 && blue(c) == 0 && nCp > cp.length-1) {
      fitness += 5;
      if (!cont)
        hasFinished = true;
      println("Finishline");
    }

    if (checkpointCD < 0 && !cont) {
      crashed = true;
    }

    checkpointCD -= 1/frameRate;

    //Move sensors with car
    for (Sensor s : sensors) {
      s.pos = pos;
      s.rot = rot;
    }
  }

  void GetCheckpoint() {
    if (nCp < cp.length) {
      if (pos.dist(new PVector(cp[nCp].x, cp[nCp].y)) < cp[nCp].s/2) {
        nCp++;
        fitness++;
        checkpointCD = 3;
      }
    }
  }

  void Display() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rot);
    image(carImg, 0, 0);
    popMatrix();

    for (Sensor s : sensors) {
      if (showCP)
        s.Display();
    }
  }
}
