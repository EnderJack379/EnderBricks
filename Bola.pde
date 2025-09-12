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

    // Rebote en paredes
    if (pos.x < radio || pos.x > width - radio) {
      vel.x *= -1;
      pos.x = constrain(pos.x, radio, width - radio);
    }
    if (pos.y < radio) {
      vel.y *= -1;
      pos.y = radio;
    }

    // Rebote con paleta
    if (pos.y + radio >= p.pos.y &&
        pos.x > p.pos.x && pos.x < p.pos.x + p.ancho) {
      vel.y *= -1;
      pos.y = p.pos.y - radio;
      // Ajuste de ángulo según impacto
      float diff = pos.x - (p.pos.x + p.ancho/2);
      vel.x = map(diff, -p.ancho/2, p.ancho/2, -400, 400);
    }

    // Si cae al fondo, resetea
    if (pos.y > height + radio) {
      reset();
      // puntuacion.decrementar();
    }
  }

  void mostrar() {
    fill(255, 100, 100);
    ellipse(pos.x, pos.y, radio*2, radio*2);
  }
}
