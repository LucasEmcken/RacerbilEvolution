class Sensor {

  //step is accuracy, rot is car rotation, dir is rotation relative to car
  float step, rot, dir;
  PVector pos = new PVector(0, 0);
  int sensX, sensY;

  Sensor(float stepC, float direction) {
    step = stepC;
    dir = direction;
  }

  float CalcDis() {
    fill(255);

    PVector dirVect = new PVector (cos(rot + dir), sin(rot + dir));
    dirVect = dirVect.normalize();

    for (int i = 0; i < width/step; i++) {
      sensX = int(pos.x + dirVect.x*i * step);
      sensY = int(pos.y + dirVect.y*i * step);

      color c = get(sensX, sensY);
      if (red(c) == 255 && green(c) == 255 && blue(c) == 255) {
        return i;
      }
    }

    return width;
  }

  void Display() {
    fill(0,0,255);
    ellipse(sensX, sensY, 5, 5);
  }
}
