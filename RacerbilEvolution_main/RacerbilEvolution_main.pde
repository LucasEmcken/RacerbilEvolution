Car[] car = new Car[10];

Checkpoint[] cp = new Checkpoint[13];

int gen;
int fit;

PImage trackImg;
void setup() {
  size(880, 763);
  imageMode(CENTER);
  ellipseMode(CENTER);
  noStroke();

  //Checkpoints
  cp[0] = new Checkpoint(630, 660, 75);
  cp[1] = new Checkpoint(780, 647, 75);
  cp[2] = new Checkpoint(760, 530, 75);
  cp[3] = new Checkpoint(661, 455, 75);
  cp[4] = new Checkpoint(611, 345, 75);
  cp[5] = new Checkpoint(518, 264, 75);
  cp[6] = new Checkpoint(425, 355, 75);
  cp[7] = new Checkpoint(320, 460, 75);
  cp[8] = new Checkpoint(250, 305, 75);
  cp[9] = new Checkpoint(160, 74, 75);
  cp[10] = new Checkpoint(75, 305, 75);
  cp[11] = new Checkpoint(80, 500, 75);
  cp[12] = new Checkpoint(240, 660, 75);

  for (int i = 0; i < car.length; i++) {
    car[i] = new Car();
  }
  trackImg = loadImage("Track.png");
}

float y;
void draw() {
  image(trackImg, width/2, height/2);

  //Car - split in two so graphics dont interfere with course detection
  for (Car c : car) {
    c.ControlCar();
  }
  for (Checkpoint c : cp) {
    if (showCP)
      c.Display();
  }

  for (Car c : car) {
    c.Display();
  }

  fill(0);
  textSize(32);
  text("Gen: " + gen, 500, 100);
  text("Fit: " + fit, 500, 132);

  textSize(16);
  text("Continous (q) : " + cont, 500, 150);
  text("Show Details (w) " + showCP, 500, 166);


  int crashedCars = 0;
  for (int i = 0; i < car.length; i++) {
    if (car[i].crashed) {
      crashedCars++;
    }
    if (car[i].hasFinished) {
      NextGen();
    }
  }
  if (crashedCars == car.length) {
    NextGen();
  }
}



boolean cont;
boolean showCP;
void keyPressed() {
  if (key=='q') {
    if (cont)
      cont = false;
    else
      cont = true;
  }

  if (key=='w') {
    if (showCP)
      showCP = false;
    else
      showCP = true;
  }
}
