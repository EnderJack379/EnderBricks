class Bola {
  PVector pos, vel;
  float radio = 10;

  Bola() {
    reset();
  }

  void reset() {
    pos = new PVector(width/2, height/2);
    vel = PVector.random2D().mult(300);
    vel.y = abs(vel.y);
  }

  void actualizar(float dt, Paleta p) {
    pos.add(PVector.mult(vel, dt));

    // Rebote en muros...
    if (pos.x < radio || pos.x > width-radio) { vel.x *= -1; }
    if (pos.y < radio) { vel.y *= -1; }

    // Rebote con paleta...
    if (pos.y + radio >= p.pos.y &&
        pos.x > p.pos.x && pos.x < p.pos.x + p.ancho) {
      vel.y *= -1;
      pos.y = p.pos.y - radio;
    }

    // Si cae al fondo, perder vida y reset bola
    if (pos.y > height + radio) {
      juego.puntuacion.decrementar();  // ojo: accede al controlador
      reset();
    }
  }

  void mostrar() {
    fill(255, 100, 100);
    ellipse(pos.x, pos.y, radio*2, radio*2);
  }
}
