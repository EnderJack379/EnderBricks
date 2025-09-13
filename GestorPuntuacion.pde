class GestorPuntuacion {
  int puntaje = 0;
  int vidas   = 3;

  void incrementar(int pts) {
    puntaje += pts;
  }

  void decrementar() {
    vidas--;
  }

  void reset() {
    puntaje = 0;
    vidas   = 3;
  }

  void mostrar() {
    fill(255);
    textSize(16);
    textAlign(LEFT, TOP);
    text("Puntaje: " + puntaje, 10, 10);
    textAlign(RIGHT, TOP);
    text("Vidas: "   + vidas,   width - 10, 10);
  }
}
