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
    ladrillos = new Ladrillo[filas*columnas];
    float anchoB = (width - (columnas+1)*paddingX) / columnas;
    float altoB  = 20;
    for (int i = 0; i < filas; i++) {
      for (int j = 0; j < columnas; j++) {
        float x = paddingX + j*(anchoB+paddingX);
        float y = paddingY + i*(altoB+paddingY) + 50;
        ladrillos[i*columnas + j] =
          new Ladrillo(new PVector(x,y), anchoB, altoB);
      }
    }
  }

  void actualizar(float dt, Bola b, GestorPuntuacion p) {
    for (Ladrillo L : ladrillos) {
      if (L.activo && L.golpear(b)) {
        p.incrementar(10);   // +10 por ladrillo
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
