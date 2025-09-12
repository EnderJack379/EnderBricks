class GestorNivel {
  Ladrillo[] ladrillos;
  int filas, columnas;
  float paddingX = 5, paddingY = 5;

  GestorNivel(int filas, int columnas) {
    this.filas = filas;
    this.columnas = columnas;
    iniciarNivel();
  }

  void iniciarNivel() {
    ladrillos = new Ladrillo[filas * columnas];
    float anchoBrick = (width - (columnas+1)*paddingX) / columnas;
    float altoBrick  = 20;
    for (int i = 0; i < filas; i++) {
      for (int j = 0; j < columnas; j++) {
        float x = paddingX + j * (anchoBrick + paddingX);
        float y = paddingY + i * (altoBrick + paddingY) + 50;
        ladrillos[i*columnas + j] = new Ladrillo(new PVector(x,y), anchoBrick, altoBrick);
      }
    }
  }

  void actualizar(float dt, Bola b) {
    for (Ladrillo L : ladrillos) {
      if (L.activo && L.golpear(b)) {
        // puntuacion.incrementar();
        b.vel.y *= -1;
      }
    }
  }

  void dibujarLadrillos() {
    for (Ladrillo L : ladrillos) {
      L.mostrar();
    }
  }
}
