Controladora controladora = new Controladora();

class Controladora {

  float connect_x[] = new float[100];
  float connect_y[] = new float[100];
  float connect_z[] = new float[100];

  //pontos dos objetos
  float ponto_x_0[] = new float[100];
  float ponto_y_0[] = new float[100];
  float ponto_z_0[] = new float[100];
  float ponto_x_1[] = new float[100];
  float ponto_y_1[] = new float[100];
  float ponto_z_1[] = new float[100];
  int nOf_pontos[] = new int[100];

  int objeto_conectado[] = new int[10];
  int objetos_encontrados = 0;
  
  boolean trilha = false;
  int objeto_trilha[] = new int[100];
  int nOf_objetos_trilha = 0;

  int indice=0;
  void ImprimeTrilha() {
    print("Trilha Obtida: ");
    for (int a =0; a<this.nOf_objetos_trilha; a++) {

      print(this.objeto_trilha[a]+" ");
    }
    println(" .");
  }
  void GeraTrilha(int n_reservatorio) {

    objeto_trilha[0] = n_reservatorio;
    nOf_objetos_trilha = 1;

    boolean terminou = false;
    boolean ja_esta_na_trilha = false;
    int n_objeto = n_reservatorio;

    while (terminou == false) {
      this.ProcuraObjetosConectados(n_objeto);
      terminou = true;
      ja_esta_na_trilha = false;
      for (int a =0; a<objetos_encontrados; a++) {

        ja_esta_na_trilha = false;
        for (int b=0; b<nOf_objetos_trilha; b++) {

          if (objeto_conectado[a]==objeto_trilha[b]) {
            ja_esta_na_trilha = true;
          }
        }
        if (ja_esta_na_trilha == false) {

          terminou = false;
          n_objeto = objeto_conectado[a];
          this.objeto_trilha[this.nOf_objetos_trilha] = this.objeto_conectado[a];
          this.nOf_objetos_trilha++;
        }
      }
    }
    this.trilha = true;
  }
  void Selecionar(int n_objeto) {

    if (n_objeto==-1) {
      for (int a =0; a<FRAME_simulador.nOf_objetos; a++) {
        if (FRAME_simulador.tipo[a] == "Tubo Reto") {
          tubos.tubo_reto[FRAME_simulador.indice_local[a]].selecionado = false;
        } else if (FRAME_simulador.tipo[a] == "Tubo Inclinado Horizontal") {
          tubos.tubo_inclinado_horizontal[FRAME_simulador.indice_local[a]].selecionado = false;
        } else if (FRAME_simulador.tipo[a] == "Tubo Inclinado Vertical") {
          tubos.tubo_inclinado_vertical[FRAME_simulador.indice_local[a]].selecionado = false;
        } else if (FRAME_simulador.tipo[a] == "Reservatorio Aberto") {
          reservatorios.reservatorio_aberto[FRAME_simulador.indice_local[a]].selecionado = false;
        } else if (FRAME_simulador.tipo[a] == "Bomba Centrifuga") {
          bombas.bomba_centrifuga[FRAME_simulador.indice_local[a]].selecionado = false;
        }
      }
    } else if (n_objeto<FRAME_simulador.nOf_objetos) {
      if (FRAME_simulador.tipo[n_objeto] == "Tubo Reto") {
        tubos.tubo_reto[FRAME_simulador.indice_local[n_objeto]].selecionado = true;
      } else if (FRAME_simulador.tipo[n_objeto] == "Tubo Inclinado Horizontal") {
        tubos.tubo_inclinado_horizontal[FRAME_simulador.indice_local[n_objeto]].selecionado = true;
      } else if (FRAME_simulador.tipo[n_objeto] == "Tubo Inclinado Vertical") {
        tubos.tubo_inclinado_vertical[FRAME_simulador.indice_local[n_objeto]].selecionado = true;
      } else if (FRAME_simulador.tipo[n_objeto] == "Reservatorio Aberto") {
        reservatorios.reservatorio_aberto[FRAME_simulador.indice_local[n_objeto]].selecionado = true;
      } else if (FRAME_simulador.tipo[n_objeto] == "Bomba Centrifuga") {
        bombas.bomba_centrifuga[FRAME_simulador.indice_local[n_objeto]].selecionado = true;
      }
    }
  }
  void ProcuraObjetosConectados(int n_objeto) {
    float x;
    float y;
    float z;
    this.CompilaPontos();//atualiza compilação
    this.objetos_encontrados = 0;

    x = this.ponto_x_0[n_objeto];
    y = this.ponto_y_0[n_objeto];
    z = this.ponto_z_0[n_objeto];

    for (int a=0; a<FRAME_simulador.nOf_objetos; a++) {

      if (nOf_pontos[a]==1) {
        if (x==this.ponto_x_0[a]&&y==this.ponto_y_0[a]&&z==this.ponto_z_0[a]&&a!=n_objeto) {
          this.objeto_conectado[objetos_encontrados] = a;
          objetos_encontrados++;
        }
      }
      if (nOf_pontos[a]==2) {
        if (x==this.ponto_x_0[a]&&y==this.ponto_y_0[a]&&z==this.ponto_z_0[a]&&a!=n_objeto||x==this.ponto_x_1[a]&&y==this.ponto_y_1[a]&&z==this.ponto_z_1[a]&&a!=n_objeto) {
          this.objeto_conectado[objetos_encontrados] = a;
          objetos_encontrados++;
        }
      }
    }
    if (this.nOf_pontos[n_objeto] >= 2) {
      x = this.ponto_x_1[n_objeto];
      y = this.ponto_y_1[n_objeto];
      z = this.ponto_z_1[n_objeto];

      for (int a=0; a<FRAME_simulador.nOf_objetos; a++) {

        if (nOf_pontos[a]==1) {
          if (x==this.ponto_x_0[a]&&y==this.ponto_y_0[a]&&z==this.ponto_z_0[a]&&a!=n_objeto) {
            this.objeto_conectado[objetos_encontrados] = a;
            objetos_encontrados++;
          }
        }
        if (nOf_pontos[a]==2) {
          if (x==this.ponto_x_0[a]&&y==this.ponto_y_0[a]&&z==this.ponto_z_0[a]&&a!=n_objeto||x==this.ponto_x_1[a]&&y==this.ponto_y_1[a]&&z==this.ponto_z_1[a]&&a!=n_objeto) {
            this.objeto_conectado[objetos_encontrados] = a;
            objetos_encontrados++;
          }
        }
      }
    }
  }
  void CompilaPontos() {
    float x_0=0;
    float y_0=0;
    float z_0=0;
    float x_1=0;
    float y_1=0;
    float z_1=0;

    int nOfPontos = 0;

    for (int a = 0; a< FRAME_simulador.nOf_objetos; a++) {
      if (FRAME_simulador.tipo[a] == "Tubo Reto") {
        x_0 = tubos.tubo_reto[FRAME_simulador.indice_local[a]].x_0;
        x_1 = tubos.tubo_reto[FRAME_simulador.indice_local[a]].x_1;
        y_0 = tubos.tubo_reto[FRAME_simulador.indice_local[a]].y_0;
        y_1 = tubos.tubo_reto[FRAME_simulador.indice_local[a]].y_1;
        z_0 = tubos.tubo_reto[FRAME_simulador.indice_local[a]].z_0;
        z_1 = tubos.tubo_reto[FRAME_simulador.indice_local[a]].z_1;
        nOfPontos=2;
      } else if (FRAME_simulador.tipo[a] == "Tubo Inclinado Horizontal") {
        x_0 = tubos.tubo_inclinado_horizontal[FRAME_simulador.indice_local[a]].x_0;
        x_1 = tubos.tubo_inclinado_horizontal[FRAME_simulador.indice_local[a]].x_1;
        y_0 = tubos.tubo_inclinado_horizontal[FRAME_simulador.indice_local[a]].y_0;
        y_1 = tubos.tubo_inclinado_horizontal[FRAME_simulador.indice_local[a]].y_1;
        z_0 = tubos.tubo_inclinado_horizontal[FRAME_simulador.indice_local[a]].z_0;
        z_1 = tubos.tubo_inclinado_horizontal[FRAME_simulador.indice_local[a]].z_1;
        nOfPontos=2;
      } else if (FRAME_simulador.tipo[a] == "Tubo Inclinado Vertical") {
        x_0 = tubos.tubo_inclinado_vertical[FRAME_simulador.indice_local[a]].x_0;
        x_1 = tubos.tubo_inclinado_vertical[FRAME_simulador.indice_local[a]].x_1;
        y_0 = tubos.tubo_inclinado_vertical[FRAME_simulador.indice_local[a]].y_0;
        y_1 = tubos.tubo_inclinado_vertical[FRAME_simulador.indice_local[a]].y_1;
        z_0 = tubos.tubo_inclinado_vertical[FRAME_simulador.indice_local[a]].z_0;
        z_1 = tubos.tubo_inclinado_vertical[FRAME_simulador.indice_local[a]].z_1;
        nOfPontos=2;
      } else if (FRAME_simulador.tipo[a] == "Reservatorio Aberto") {
        x_0 = reservatorios.reservatorio_aberto[FRAME_simulador.indice_local[a]].x;
        y_0 = reservatorios.reservatorio_aberto[FRAME_simulador.indice_local[a]].y;
        z_0 = reservatorios.reservatorio_aberto[FRAME_simulador.indice_local[a]].z;
        nOfPontos=1;
      } else if (FRAME_simulador.tipo[a] == "Bomba Centrifuga") {
        x_0 = bombas.bomba_centrifuga[FRAME_simulador.indice_local[a]].x_0;
        x_1 = bombas.bomba_centrifuga[FRAME_simulador.indice_local[a]].x_1;
        y_0 = bombas.bomba_centrifuga[FRAME_simulador.indice_local[a]].y_0;
        y_1 = bombas.bomba_centrifuga[FRAME_simulador.indice_local[a]].y_1;
        z_0 = bombas.bomba_centrifuga[FRAME_simulador.indice_local[a]].z_0;
        z_1 = bombas.bomba_centrifuga[FRAME_simulador.indice_local[a]].z_1;
        nOfPontos=2;
      }

      this.ponto_x_0[a] = x_0;
      this.ponto_y_0[a] = y_0;
      this.ponto_z_0[a] = z_0;
      this.ponto_x_1[a] = x_1;
      this.ponto_y_1[a] = y_1;
      this.ponto_z_1[a] = z_1;

      this.nOf_pontos[a] = nOfPontos;
    }
  }
  void ProcuraConeccoes(float x, float y, float z) {

    this.indice =0;
    for (int a = 0; a<FRAME_simulador.nOf_tubos_retos; a++) {
      if (x==tubos.tubo_reto[a].x_0 && y==tubos.tubo_reto[a].y_0 && z==tubos.tubo_reto[a].z_0) {
        this.connect_x[this.indice] = tubos.tubo_reto[a].x_1;
        this.connect_y[this.indice] = tubos.tubo_reto[a].y_1;
        this.connect_z[this.indice] = tubos.tubo_reto[a].z_1;

        this.indice++;
      }
      if (x==tubos.tubo_reto[a].x_1 && y==tubos.tubo_reto[a].y_1 && z==tubos.tubo_reto[a].z_1) {
        this.connect_x[this.indice] = tubos.tubo_reto[a].x_0;
        this.connect_y[this.indice] = tubos.tubo_reto[a].y_0;
        this.connect_z[this.indice] = tubos.tubo_reto[a].z_0;

        this.indice++;
      }
    }
    for (int a = 0; a<FRAME_simulador.nOf_tubos_inclinados_horizontais; a++) {
      if (x==tubos.tubo_inclinado_horizontal[a].x_0 && y==tubos.tubo_inclinado_horizontal[a].y_0 && z==tubos.tubo_inclinado_horizontal[a].z_0) {
        this.connect_x[this.indice] = tubos.tubo_inclinado_horizontal[a].x_1;
        this.connect_y[this.indice] = tubos.tubo_inclinado_horizontal[a].y_1;
        this.connect_z[this.indice] = tubos.tubo_inclinado_horizontal[a].z_1;

        this.indice++;
      }
      if (x==tubos.tubo_inclinado_horizontal[a].x_1 && y==tubos.tubo_inclinado_horizontal[a].y_1 && z==tubos.tubo_inclinado_horizontal[a].z_1) {
        this.connect_x[this.indice] = tubos.tubo_inclinado_horizontal[a].x_0;
        this.connect_y[this.indice] = tubos.tubo_inclinado_horizontal[a].y_0;
        this.connect_z[this.indice] = tubos.tubo_inclinado_horizontal[a].z_0;

        this.indice++;
      }
    }
    for (int a = 0; a<FRAME_simulador.nOf_tubos_inclinados_verticais; a++) {
      if (x==tubos.tubo_inclinado_vertical[a].x_0 && y==tubos.tubo_inclinado_vertical[a].y_0 && z==tubos.tubo_inclinado_vertical[a].z_0) {
        this.connect_x[this.indice] = tubos.tubo_inclinado_vertical[a].x_1;
        this.connect_y[this.indice] = tubos.tubo_inclinado_vertical[a].y_1;
        this.connect_z[this.indice] = tubos.tubo_inclinado_vertical[a].z_1;

        this.indice++;
      }
      if (x==tubos.tubo_inclinado_vertical[a].x_1 && y==tubos.tubo_inclinado_vertical[a].y_1 && z==tubos.tubo_inclinado_vertical[a].z_1) {
        this.connect_x[this.indice] = tubos.tubo_inclinado_vertical[a].x_0;
        this.connect_y[this.indice] = tubos.tubo_inclinado_vertical[a].y_0;
        this.connect_z[this.indice] = tubos.tubo_inclinado_vertical[a].z_0;

        this.indice++;
      }
    }
    for (int a = 0; a<FRAME_simulador.nOf_reservatorios_abertos; a++) {
      if (x==reservatorios.reservatorio_aberto[a].x && y==reservatorios.reservatorio_aberto[a].y && z==reservatorios.reservatorio_aberto[a].z) {
        this.connect_x[this.indice] = reservatorios.reservatorio_aberto[a].x;
        this.connect_y[this.indice] = reservatorios.reservatorio_aberto[a].y;
        this.connect_z[this.indice] = reservatorios.reservatorio_aberto[a].z;

        this.indice++;
      }
    }
    for (int a = 0; a<FRAME_simulador.nOf_bombas_centrifugas; a++) {
      if (x==bombas.bomba_centrifuga[a].x_0 && y==bombas.bomba_centrifuga[a].y_0 && z==bombas.bomba_centrifuga[a].z_0) {
        this.connect_x[this.indice] = bombas.bomba_centrifuga[a].x_0;
        this.connect_y[this.indice] = bombas.bomba_centrifuga[a].y_0;
        this.connect_z[this.indice] = bombas.bomba_centrifuga[a].z_0;

        this.indice++;
      }
    }
    for (int a = 0; a<FRAME_simulador.nOf_bombas_centrifugas; a++) {
      if (x==bombas.bomba_centrifuga[a].x_1 && y==bombas.bomba_centrifuga[a].y_1 && z==bombas.bomba_centrifuga[a].z_1) {
        this.connect_x[this.indice] = bombas.bomba_centrifuga[a].x_1;
        this.connect_y[this.indice] = bombas.bomba_centrifuga[a].y_1;
        this.connect_z[this.indice] = bombas.bomba_centrifuga[a].z_1;

        this.indice++;
      }
    }
  }
}