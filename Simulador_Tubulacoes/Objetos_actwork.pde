class BombaCentrifuga {

  float x_0=0;//entrada
  float y_0=0;//entrada
  float z_0=0;//entrada
  float x_1=0;//saida
  float y_1=0;//saida
  float z_1=0;//saida

  float potencia = 10000;
  float capacidade = 10;
  float corrente_maxima = 50;
  float corrente_utilizada = 0;

  float diametro_in=20;
  float diametro_out=20;

  boolean saida_lateral = true;

  String sentidoXY = "Sul";

  boolean selecionado = false;

  void PadDirecao() {
    controladora.ProcuraConeccoes(this.x_0, this.y_0, this.z_0);

    if (controladora.indice > 1) {

      for (int a = 0; a < controladora.indice; a++) {

        if (controladora.connect_x[a] != this.x_0 || controladora.connect_y[a] != this.y_0 || controladora.connect_z[a] != this.z_0 ) {
          if (controladora.connect_x[a]>this.x_0) {
            this.sentidoXY = "Leste";
          } else if (controladora.connect_x[a]<this.x_0) {
            this.sentidoXY = "Oeste";
          } else if (controladora.connect_y[a]<this.y_0) {
            this.sentidoXY = "Sul";
          } else if (controladora.connect_y[a]>this.y_0) {
            this.sentidoXY = "Norte";
          }
        }
      }
    }
  }
  void AchaCoordSaida() {
    if (this.saida_lateral == true) {
      if (this.sentidoXY == "Norte") {
        this.x_1 = this.x_0;
        this.y_1 = this.y_0+75+this.diametro_out/2+5;
        this.z_1 = this.z_0+90+this.diametro_out/2;
      } else if (this.sentidoXY == "Sul") {
        this.x_1 = this.x_0;
        this.y_1 = this.y_0-75-this.diametro_out/2+5;
        this.z_1 = this.z_0+90+this.diametro_out/2;
      } else if (this.sentidoXY == "Leste") {
        this.x_1 = this.x_0-75-this.diametro_out/2+5;
        this.y_1 = this.y_0;
        this.z_1 = this.z_0+90+this.diametro_out/2;
      } else if (this.sentidoXY == "Oeste") {
        this.x_1 = this.x_0+75+this.diametro_out/2+5;
        this.y_1 = this.y_0;
        this.z_1 = this.z_0+90+this.diametro_out/2;
      }
    } else {
      if (this.sentidoXY == "Norte") {
        this.x_1 = this.x_0;
        this.y_1 = this.y_0+75;
        this.z_1 = this.z_0+90;
      } else if (this.sentidoXY == "Sul") {
        this.x_1 = this.x_0;
        this.y_1 = this.y_0-75;
        this.z_1 = this.z_0+90;
      } else if (this.sentidoXY == "Leste") {
        this.x_1 = this.x_0-75;
        this.y_1 = this.y_0;
        this.z_1 = this.z_0+90;
      } else if (this.sentidoXY == "Oeste") {
        this.x_1 = this.x_0+75;
        this.y_1 = this.y_0;
        this.z_1 = this.z_0+90;
      }
    }
  }
  void MudaDiametroIn(float novo_diametro) {

    this.diametro_in = novo_diametro;
  }
  void MudaDiametroOut(float novo_diametro) {

    this.diametro_out = novo_diametro;
  }
  void Setup(float novo_x_0, float novo_y_0, float novo_z_0) {

    this.x_0 = novo_x_0;
    this.y_0 = novo_y_0;
    this.z_0 = novo_z_0;
  }
  void Interacao() {
  }
  void Show() {
    this.PadDirecao();
    this.AchaCoordSaida();
    if (FRAME_simulador.projecao == "ZX") {
      if (this.sentidoXY == "Norte") {
        //tubos
        rect(this.x_0+interfaceX.RetornaXrelativo()-int(this.diametro_out/2)+3, -this.z_0+interfaceX.RetornaYrelativo()-90, int(this.diametro_out)-6, 20);
        rect(this.x_0+interfaceX.RetornaXrelativo()-int(this.diametro_out/2), -this.z_0+interfaceX.RetornaYrelativo()-90, int(this.diametro_out), 5);
        //suporte
        fill(60, 0, 0);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        rect(this.x_0+interfaceX.RetornaXrelativo()-70, -this.z_0+interfaceX.RetornaYrelativo()+80, 140, 10);
        //carcaça circular
        fill(100, 0, 0);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), 140, 140);
        fill(60, 0, 0);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        triangle(this.x_0+interfaceX.RetornaXrelativo()-60, -this.z_0+interfaceX.RetornaYrelativo()+80, this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.x_0+interfaceX.RetornaXrelativo()+60, -this.z_0+interfaceX.RetornaYrelativo()+80);
        fill(100, 0, 0);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), 120, 120);
        ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), 100, 100);
        //tubo olhar
      } else if (this.sentidoXY == "Sul") {
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        //tubos
        rect(this.x_0+interfaceX.RetornaXrelativo()-int(this.diametro_out/2)+3, -this.z_0+interfaceX.RetornaYrelativo()-90, int(this.diametro_out)-6, 20);
        rect(this.x_0+interfaceX.RetornaXrelativo()-int(this.diametro_out/2), -this.z_0+interfaceX.RetornaYrelativo()-90, int(this.diametro_out), 5);
        //suporte
        fill(60, 0, 0);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        rect(this.x_0+interfaceX.RetornaXrelativo()-70, -this.z_0+interfaceX.RetornaYrelativo()+80, 140, 10);
        triangle(this.x_0+interfaceX.RetornaXrelativo()-60, -this.z_0+interfaceX.RetornaYrelativo()+80, this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.x_0+interfaceX.RetornaXrelativo()+60, -this.z_0+interfaceX.RetornaYrelativo()+80);
        //carcaça circular
        fill(100, 0, 0);
        ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), 140, 140);
        ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), 100, 100);
        //tubo olhar
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro_in, this.diametro_in);
        fill(0, 0, 200);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro_in-6, this.diametro_in-6);
      } else if (this.sentidoXY == "Leste") {
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        //tubos
        rect(this.x_0+interfaceX.RetornaXrelativo()-20, -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro_in/2)+3, 20, int(this.diametro_in)-6);
        rect(this.x_0+interfaceX.RetornaXrelativo()-5, -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro_in/2), 5, int(this.diametro_in));

        rect(this.x_0+interfaceX.RetornaXrelativo()-75-int(this.diametro_out/2)+3, -this.z_0+interfaceX.RetornaYrelativo()-90, int(this.diametro_out)-6, 20);
        rect(this.x_0+interfaceX.RetornaXrelativo()-75-int(this.diametro_out/2), -this.z_0+interfaceX.RetornaYrelativo()-90, int(this.diametro_out), 5);

        if (this.saida_lateral) {

          arc(this.x_0+interfaceX.RetornaXrelativo()-75-int(this.diametro_out/2), -this.z_0+interfaceX.RetornaYrelativo()-90, int(this.diametro_out)*2, int(this.diametro_out)*2, PI+HALF_PI, 2*PI, PIE);
          rect(this.x_0+interfaceX.RetornaXrelativo()-75-int(this.diametro_out/2)-5, -this.z_0+interfaceX.RetornaYrelativo()-90-int(this.diametro_out), 5, int(this.diametro_out));
        }
        //carcaça
        fill(100, 0, 0);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        beginShape();
        vertex(this.x_0+interfaceX.RetornaXrelativo()-20, -this.z_0+interfaceX.RetornaYrelativo()-50);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-40, -this.z_0+interfaceX.RetornaYrelativo()-70);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-100, -this.z_0+interfaceX.RetornaYrelativo()-70);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-100, -this.z_0+interfaceX.RetornaYrelativo()+70);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-40, -this.z_0+interfaceX.RetornaYrelativo()+70);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-20, -this.z_0+interfaceX.RetornaYrelativo()+50);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-20, -this.z_0+interfaceX.RetornaYrelativo()-50);
        endShape();
        beginShape();
        vertex(this.x_0+interfaceX.RetornaXrelativo()-100, -this.z_0+interfaceX.RetornaYrelativo()-50);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-110, -this.z_0+interfaceX.RetornaYrelativo()-50);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-110, -this.z_0+interfaceX.RetornaYrelativo()-60);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-240, -this.z_0+interfaceX.RetornaYrelativo()-60);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-250, -this.z_0+interfaceX.RetornaYrelativo()-50);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-250, -this.z_0+interfaceX.RetornaYrelativo()+50);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-240, -this.z_0+interfaceX.RetornaYrelativo()+60);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-110, -this.z_0+interfaceX.RetornaYrelativo()+60);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-110, -this.z_0+interfaceX.RetornaYrelativo()+50);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-100, -this.z_0+interfaceX.RetornaYrelativo()+50);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-100, -this.z_0+interfaceX.RetornaYrelativo()-50);
        endShape();
        stroke(0, 0, 0);
        line(this.x_0+interfaceX.RetornaXrelativo()-110, -this.z_0+interfaceX.RetornaYrelativo()-60, this.x_0+interfaceX.RetornaXrelativo()-110, -this.z_0+interfaceX.RetornaYrelativo()+60);
        line(this.x_0+interfaceX.RetornaXrelativo()-240, -this.z_0+interfaceX.RetornaYrelativo()-60, this.x_0+interfaceX.RetornaXrelativo()-240, -this.z_0+interfaceX.RetornaYrelativo()+60);
        for (int a =0; a<11; a++) {
          line(this.x_0+interfaceX.RetornaXrelativo()-125, -this.z_0+interfaceX.RetornaYrelativo()-50+a*10, this.x_0+interfaceX.RetornaXrelativo()-240, -this.z_0+interfaceX.RetornaYrelativo()-50+a*10);
        }

        fill(60, 0, 0);
        if (this.selecionado) {
          fill(255, 255, 0);
        }

        beginShape();
        vertex(this.x_0+interfaceX.RetornaXrelativo()-40, -this.z_0+interfaceX.RetornaYrelativo()+80);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-50, -this.z_0+interfaceX.RetornaYrelativo()+80);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-50, -this.z_0+interfaceX.RetornaYrelativo()+70);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-90, -this.z_0+interfaceX.RetornaYrelativo()+70);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-90, -this.z_0+interfaceX.RetornaYrelativo()+80);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-120, -this.z_0+interfaceX.RetornaYrelativo()+80);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-120, -this.z_0+interfaceX.RetornaYrelativo()+60);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-230, -this.z_0+interfaceX.RetornaYrelativo()+60);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-230, -this.z_0+interfaceX.RetornaYrelativo()+75);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-240, -this.z_0+interfaceX.RetornaYrelativo()+75);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-240, -this.z_0+interfaceX.RetornaYrelativo()+90);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-40, -this.z_0+interfaceX.RetornaYrelativo()+90);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-40, -this.z_0+interfaceX.RetornaYrelativo()+80);
        endShape();
      } else if (this.sentidoXY == "Oeste") {
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        //tubos
        rect(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro_in/2)+3, 20, int(this.diametro_in)-6);
        rect(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro_in/2), 5, int(this.diametro_in));

        rect(this.x_0+interfaceX.RetornaXrelativo()+75-int(this.diametro_out/2)+3, -this.z_0+interfaceX.RetornaYrelativo()-90, int(this.diametro_out)-6, 20);
        rect(this.x_0+interfaceX.RetornaXrelativo()+75-int(this.diametro_out/2), -this.z_0+interfaceX.RetornaYrelativo()-90, int(this.diametro_out), 5);

        if (this.saida_lateral) {

          arc(this.x_0+interfaceX.RetornaXrelativo()+75+int(this.diametro_out/2), -this.z_0+interfaceX.RetornaYrelativo()-90, int(this.diametro_out)*2, int(this.diametro_out)*2, PI, PI+HALF_PI, PIE);
          rect(this.x_0+interfaceX.RetornaXrelativo()+75+int(this.diametro_out/2), -this.z_0+interfaceX.RetornaYrelativo()-90-int(this.diametro_out), 5, int(this.diametro_out));
        }
        //carcaça
        fill(100, 0, 0);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        beginShape();
        vertex(this.x_0+interfaceX.RetornaXrelativo()+20, -this.z_0+interfaceX.RetornaYrelativo()-50);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+40, -this.z_0+interfaceX.RetornaYrelativo()-70);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+100, -this.z_0+interfaceX.RetornaYrelativo()-70);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+100, -this.z_0+interfaceX.RetornaYrelativo()+70);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+40, -this.z_0+interfaceX.RetornaYrelativo()+70);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+20, -this.z_0+interfaceX.RetornaYrelativo()+50);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+20, -this.z_0+interfaceX.RetornaYrelativo()-50);
        endShape();
        beginShape();
        vertex(this.x_0+interfaceX.RetornaXrelativo()+100, -this.z_0+interfaceX.RetornaYrelativo()-50);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+110, -this.z_0+interfaceX.RetornaYrelativo()-50);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+110, -this.z_0+interfaceX.RetornaYrelativo()-60);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+240, -this.z_0+interfaceX.RetornaYrelativo()-60);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+250, -this.z_0+interfaceX.RetornaYrelativo()-50);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+250, -this.z_0+interfaceX.RetornaYrelativo()+50);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+240, -this.z_0+interfaceX.RetornaYrelativo()+60);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+110, -this.z_0+interfaceX.RetornaYrelativo()+60);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+110, -this.z_0+interfaceX.RetornaYrelativo()+50);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+100, -this.z_0+interfaceX.RetornaYrelativo()+50);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+100, -this.z_0+interfaceX.RetornaYrelativo()-50);
        endShape();
        stroke(0, 0, 0);
        line(this.x_0+interfaceX.RetornaXrelativo()+110, -this.z_0+interfaceX.RetornaYrelativo()-60, this.x_0+interfaceX.RetornaXrelativo()+110, -this.z_0+interfaceX.RetornaYrelativo()+60);
        line(this.x_0+interfaceX.RetornaXrelativo()+240, -this.z_0+interfaceX.RetornaYrelativo()-60, this.x_0+interfaceX.RetornaXrelativo()+240, -this.z_0+interfaceX.RetornaYrelativo()+60);
        for (int a =0; a<11; a++) {
          line(this.x_0+interfaceX.RetornaXrelativo()+125, -this.z_0+interfaceX.RetornaYrelativo()-50+a*10, this.x_0+interfaceX.RetornaXrelativo()+240, -this.z_0+interfaceX.RetornaYrelativo()-50+a*10);
        }

        fill(60, 0, 0);
        if (this.selecionado) {
          fill(255, 255, 0);
        }

        beginShape();
        vertex(this.x_0+interfaceX.RetornaXrelativo()+40, -this.z_0+interfaceX.RetornaYrelativo()+80);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+50, -this.z_0+interfaceX.RetornaYrelativo()+80);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+50, -this.z_0+interfaceX.RetornaYrelativo()+70);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+90, -this.z_0+interfaceX.RetornaYrelativo()+70);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+90, -this.z_0+interfaceX.RetornaYrelativo()+80);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+120, -this.z_0+interfaceX.RetornaYrelativo()+80);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+120, -this.z_0+interfaceX.RetornaYrelativo()+60);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+230, -this.z_0+interfaceX.RetornaYrelativo()+60);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+230, -this.z_0+interfaceX.RetornaYrelativo()+75);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+240, -this.z_0+interfaceX.RetornaYrelativo()+75);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+240, -this.z_0+interfaceX.RetornaYrelativo()+90);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+40, -this.z_0+interfaceX.RetornaYrelativo()+90);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+40, -this.z_0+interfaceX.RetornaYrelativo()+80);
        endShape();
      }
    } else if (FRAME_simulador.projecao == "ZY") {
      if (this.sentidoXY == "Norte") {

        //tubos
        rect(this.y_0+interfaceX.RetornaXrelativo()-20, -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro_in/2)+3, 20, int(this.diametro_in)-6);
        rect(this.y_0+interfaceX.RetornaXrelativo()-5, -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro_in/2), 5, int(this.diametro_in));

        rect(this.y_0+interfaceX.RetornaXrelativo()-75-int(this.diametro_out/2)+3, -this.z_0+interfaceX.RetornaYrelativo()-90, int(this.diametro_out)-6, 20);
        rect(this.y_0+interfaceX.RetornaXrelativo()-75-int(this.diametro_out/2), -this.z_0+interfaceX.RetornaYrelativo()-90, int(this.diametro_out), 5);

        if (this.saida_lateral) {

          arc(this.y_0+interfaceX.RetornaXrelativo()-75-int(this.diametro_out/2), -this.z_0+interfaceX.RetornaYrelativo()-90, int(this.diametro_out)*2, int(this.diametro_out)*2, PI+HALF_PI, 2*PI, PIE);
          rect(this.y_0+interfaceX.RetornaXrelativo()-75-int(this.diametro_out/2)-5, -this.z_0+interfaceX.RetornaYrelativo()-90-int(this.diametro_out), 5, int(this.diametro_out));
        }
        //carcaça
        fill(100, 0, 0);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        beginShape();
        vertex(this.y_0+interfaceX.RetornaXrelativo()-20, -this.z_0+interfaceX.RetornaYrelativo()-50);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-40, -this.z_0+interfaceX.RetornaYrelativo()-70);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-100, -this.z_0+interfaceX.RetornaYrelativo()-70);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-100, -this.z_0+interfaceX.RetornaYrelativo()+70);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-40, -this.z_0+interfaceX.RetornaYrelativo()+70);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-20, -this.z_0+interfaceX.RetornaYrelativo()+50);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-20, -this.z_0+interfaceX.RetornaYrelativo()-50);
        endShape();
        beginShape();
        vertex(this.y_0+interfaceX.RetornaXrelativo()-100, -this.z_0+interfaceX.RetornaYrelativo()-50);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-110, -this.z_0+interfaceX.RetornaYrelativo()-50);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-110, -this.z_0+interfaceX.RetornaYrelativo()-60);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-240, -this.z_0+interfaceX.RetornaYrelativo()-60);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-250, -this.z_0+interfaceX.RetornaYrelativo()-50);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-250, -this.z_0+interfaceX.RetornaYrelativo()+50);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-240, -this.z_0+interfaceX.RetornaYrelativo()+60);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-110, -this.z_0+interfaceX.RetornaYrelativo()+60);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-110, -this.z_0+interfaceX.RetornaYrelativo()+50);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-100, -this.z_0+interfaceX.RetornaYrelativo()+50);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-100, -this.z_0+interfaceX.RetornaYrelativo()-50);
        endShape();
        stroke(0, 0, 0);
        line(this.y_0+interfaceX.RetornaXrelativo()-110, -this.z_0+interfaceX.RetornaYrelativo()-60, this.y_0+interfaceX.RetornaXrelativo()-110, -this.z_0+interfaceX.RetornaYrelativo()+60);
        line(this.y_0+interfaceX.RetornaXrelativo()-240, -this.z_0+interfaceX.RetornaYrelativo()-60, this.y_0+interfaceX.RetornaXrelativo()-240, -this.z_0+interfaceX.RetornaYrelativo()+60);
        for (int a =0; a<11; a++) {
          line(this.y_0+interfaceX.RetornaXrelativo()-125, -this.z_0+interfaceX.RetornaYrelativo()-50+a*10, this.y_0+interfaceX.RetornaXrelativo()-240, -this.z_0+interfaceX.RetornaYrelativo()-50+a*10);
        }

        fill(60, 0, 0);

        beginShape();
        vertex(this.y_0+interfaceX.RetornaXrelativo()-40, -this.z_0+interfaceX.RetornaYrelativo()+80);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-50, -this.z_0+interfaceX.RetornaYrelativo()+80);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-50, -this.z_0+interfaceX.RetornaYrelativo()+70);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-90, -this.z_0+interfaceX.RetornaYrelativo()+70);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-90, -this.z_0+interfaceX.RetornaYrelativo()+80);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-120, -this.z_0+interfaceX.RetornaYrelativo()+80);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-120, -this.z_0+interfaceX.RetornaYrelativo()+60);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-230, -this.z_0+interfaceX.RetornaYrelativo()+60);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-230, -this.z_0+interfaceX.RetornaYrelativo()+75);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-240, -this.z_0+interfaceX.RetornaYrelativo()+75);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-240, -this.z_0+interfaceX.RetornaYrelativo()+90);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-40, -this.z_0+interfaceX.RetornaYrelativo()+90);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-40, -this.z_0+interfaceX.RetornaYrelativo()+80);
        endShape();
      } else if (this.sentidoXY == "Sul") {
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        //tubos
        rect(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro_in/2)+3, 20, int(this.diametro_in)-6);
        rect(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro_in/2), 5, int(this.diametro_in));

        rect(this.y_0+interfaceX.RetornaXrelativo()+75-int(this.diametro_out/2)+3, -this.z_0+interfaceX.RetornaYrelativo()-90, int(this.diametro_out)-6, 20);
        rect(this.y_0+interfaceX.RetornaXrelativo()+75-int(this.diametro_out/2), -this.z_0+interfaceX.RetornaYrelativo()-90, int(this.diametro_out), 5);

        if (this.saida_lateral) {

          arc(this.y_0+interfaceX.RetornaXrelativo()+75+int(this.diametro_out/2), -this.z_0+interfaceX.RetornaYrelativo()-90, int(this.diametro_out)*2, int(this.diametro_out)*2, PI, PI+HALF_PI, PIE);
          rect(this.y_0+interfaceX.RetornaXrelativo()+75+int(this.diametro_out/2), -this.z_0+interfaceX.RetornaYrelativo()-90-int(this.diametro_out), 5, int(this.diametro_out));
        }
        //carcaça
        fill(100, 0, 0);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        beginShape();
        vertex(this.y_0+interfaceX.RetornaXrelativo()+20, -this.z_0+interfaceX.RetornaYrelativo()-50);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+40, -this.z_0+interfaceX.RetornaYrelativo()-70);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+100, -this.z_0+interfaceX.RetornaYrelativo()-70);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+100, -this.z_0+interfaceX.RetornaYrelativo()+70);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+40, -this.z_0+interfaceX.RetornaYrelativo()+70);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+20, -this.z_0+interfaceX.RetornaYrelativo()+50);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+20, -this.z_0+interfaceX.RetornaYrelativo()-50);
        endShape();
        beginShape();
        vertex(this.y_0+interfaceX.RetornaXrelativo()+100, -this.z_0+interfaceX.RetornaYrelativo()-50);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+110, -this.z_0+interfaceX.RetornaYrelativo()-50);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+110, -this.z_0+interfaceX.RetornaYrelativo()-60);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+240, -this.z_0+interfaceX.RetornaYrelativo()-60);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+250, -this.z_0+interfaceX.RetornaYrelativo()-50);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+250, -this.z_0+interfaceX.RetornaYrelativo()+50);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+240, -this.z_0+interfaceX.RetornaYrelativo()+60);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+110, -this.z_0+interfaceX.RetornaYrelativo()+60);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+110, -this.z_0+interfaceX.RetornaYrelativo()+50);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+100, -this.z_0+interfaceX.RetornaYrelativo()+50);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+100, -this.z_0+interfaceX.RetornaYrelativo()-50);
        endShape();
        stroke(0, 0, 0);
        line(this.y_0+interfaceX.RetornaXrelativo()+110, -this.z_0+interfaceX.RetornaYrelativo()-60, this.y_0+interfaceX.RetornaXrelativo()+110, -this.z_0+interfaceX.RetornaYrelativo()+60);
        line(this.y_0+interfaceX.RetornaXrelativo()+240, -this.z_0+interfaceX.RetornaYrelativo()-60, this.y_0+interfaceX.RetornaXrelativo()+240, -this.z_0+interfaceX.RetornaYrelativo()+60);
        for (int a =0; a<11; a++) {
          line(this.y_0+interfaceX.RetornaXrelativo()+125, -this.z_0+interfaceX.RetornaYrelativo()-50+a*10, this.y_0+interfaceX.RetornaXrelativo()+240, -this.z_0+interfaceX.RetornaYrelativo()-50+a*10);
        }

        fill(60, 0, 0);

        beginShape();
        vertex(this.y_0+interfaceX.RetornaXrelativo()+40, -this.z_0+interfaceX.RetornaYrelativo()+80);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+50, -this.z_0+interfaceX.RetornaYrelativo()+80);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+50, -this.z_0+interfaceX.RetornaYrelativo()+70);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+90, -this.z_0+interfaceX.RetornaYrelativo()+70);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+90, -this.z_0+interfaceX.RetornaYrelativo()+80);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+120, -this.z_0+interfaceX.RetornaYrelativo()+80);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+120, -this.z_0+interfaceX.RetornaYrelativo()+60);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+230, -this.z_0+interfaceX.RetornaYrelativo()+60);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+230, -this.z_0+interfaceX.RetornaYrelativo()+75);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+240, -this.z_0+interfaceX.RetornaYrelativo()+75);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+240, -this.z_0+interfaceX.RetornaYrelativo()+90);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+40, -this.z_0+interfaceX.RetornaYrelativo()+90);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+40, -this.z_0+interfaceX.RetornaYrelativo()+80);
        endShape();
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
      } else if (this.sentidoXY == "Leste") {
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        //tubos
        rect(this.y_0+interfaceX.RetornaXrelativo()-int(this.diametro_out/2)+3, -this.z_0+interfaceX.RetornaYrelativo()-90, int(this.diametro_out)-6, 20);
        rect(this.y_0+interfaceX.RetornaXrelativo()-int(this.diametro_out/2), -this.z_0+interfaceX.RetornaYrelativo()-90, int(this.diametro_out), 5);
        //suporte
        fill(60, 0, 0);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        rect(this.y_0+interfaceX.RetornaXrelativo()-70, -this.z_0+interfaceX.RetornaYrelativo()+80, 140, 10);
        triangle(this.y_0+interfaceX.RetornaXrelativo()-60, -this.z_0+interfaceX.RetornaYrelativo()+80, this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.y_0+interfaceX.RetornaXrelativo()+60, -this.z_0+interfaceX.RetornaYrelativo()+80);
        //carcaça circular
        fill(100, 0, 0);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), 140, 140);
        ellipse(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), 100, 100);
        //tubo olhar
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro_in, this.diametro_in);
        fill(0, 0, 200);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro_in-6, this.diametro_in-6);
      } else if (this.sentidoXY == "Oeste") {
        //tubos
        rect(this.y_0+interfaceX.RetornaXrelativo()-int(this.diametro_out/2)+3, -this.z_0+interfaceX.RetornaYrelativo()-90, int(this.diametro_out)-6, 20);
        rect(this.y_0+interfaceX.RetornaXrelativo()-int(this.diametro_out/2), -this.z_0+interfaceX.RetornaYrelativo()-90, int(this.diametro_out), 5);
        //suporte
        fill(60, 0, 0);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        rect(this.y_0+interfaceX.RetornaXrelativo()-70, -this.z_0+interfaceX.RetornaYrelativo()+80, 140, 10);
        //carcaça circular
        fill(100, 0, 0);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), 140, 140);
        fill(60, 0, 0);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        triangle(this.y_0+interfaceX.RetornaXrelativo()-60, -this.z_0+interfaceX.RetornaYrelativo()+80, this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.y_0+interfaceX.RetornaXrelativo()+60, -this.z_0+interfaceX.RetornaYrelativo()+80);
        fill(100, 0, 0);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), 120, 120);
        ellipse(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), 100, 100);
        //tubo olhar
      }
    } else if (FRAME_simulador.projecao == "XY") {
      if (this.sentidoXY == "Norte") {
      } else if (this.sentidoXY == "Sul") {
      } else if (this.sentidoXY == "Leste") {
      } else if (this.sentidoXY == "Oeste") {
      }
    }
  }
}
class Bombas {

  BombaCentrifuga[] bomba_centrifuga = new BombaCentrifuga[50];

  Bombas() {
    for (int i = 0; i < bomba_centrifuga.length; i++) {
      bomba_centrifuga[i] = new BombaCentrifuga();
    }
  }
}

class Tubos {

  TuboReto[] tubo_reto = new TuboReto[50];
  TuboInclinadoHorizontal[] tubo_inclinado_horizontal = new TuboInclinadoHorizontal[50];
  TuboInclinadoVertical[] tubo_inclinado_vertical = new TuboInclinadoVertical[50];


  Tubos() {
    for (int i = 0; i < tubo_reto.length; i++) {
      tubo_reto[i] = new TuboReto();
    }
    for (int i = 0; i < tubo_inclinado_horizontal.length; i++) {
      tubo_inclinado_horizontal[i] = new TuboInclinadoHorizontal();
    }
    for (int i = 0; i < tubo_inclinado_vertical.length; i++) {
      tubo_inclinado_vertical[i] = new TuboInclinadoVertical();
    }
  }
}
class Reservatorios {

  ReservatorioAberto[] reservatorio_aberto = new ReservatorioAberto[50];

  Reservatorios() {
    for (int i = 0; i < reservatorio_aberto.length; i++) {
      reservatorio_aberto[i] = new ReservatorioAberto();
    }
  }
}
class Anotacoes {

  int cte = 100;//variavel
  String[] anotacoes_projetos = new String[this.cte];
  String[] anotacoes_simulador = new String[this.cte];
  String[] anotacoes_projetos_projecao = new String[this.cte];
  String[] anotacoes_simulador_projecao = new String[this.cte];
  float[] anotacoes_projetos_x = new float[this.cte];
  float[] anotacoes_projetos_y = new float[this.cte];
  float[] anotacoes_simulador_x = new float[this.cte];  
  float[] anotacoes_simulador_y = new float[this.cte];
  float[] linha_x_1_projeto = new float[this.cte];  
  float[] linha_x_2_projeto = new float[this.cte];
  float[] linha_y_1_projeto = new float[this.cte];  
  float[] linha_y_2_projeto = new float[this.cte];
  float[] linha_x_1_simulador = new float[this.cte];  
  float[] linha_x_2_simulador = new float[this.cte];
  float[] linha_y_1_simulador = new float[this.cte];  
  float[] linha_y_2_simulador = new float[this.cte];


  void ImprimeAnotacoes() {
    textSize(10);
    if (FRAME_simulador.project_mode) {
      fill(0, 255, 255);
      stroke(0, 255, 255);
      if (FRAME_simulador.projecao == "ZX") {
        for (int a = 0; a<FRAME_simulador.nOf_anotacoes_projeto; a++) {
          if (this.anotacoes_projetos_projecao[a] == "ZX") {
            text(this.anotacoes_projetos[a], this.anotacoes_projetos_x[a]+interfaceX.RetornaXrelativo(), this.anotacoes_projetos_y[a]+interfaceX.RetornaYrelativo());
          }
        }
      } else if (FRAME_simulador.projecao == "ZY") {
        for (int a = 0; a<FRAME_simulador.nOf_anotacoes_projeto; a++) {
          if (this.anotacoes_projetos_projecao[a] == "ZY") {
            text(this.anotacoes_projetos[a], this.anotacoes_projetos_x[a]+interfaceX.RetornaXrelativo(), this.anotacoes_projetos_y[a]+interfaceX.RetornaYrelativo());
          }
        }
      } else if (FRAME_simulador.projecao == "XY") {
        for (int a = 0; a<FRAME_simulador.nOf_anotacoes_projeto; a++) {
          if (this.anotacoes_projetos_projecao[a] == "XY") {
            text(this.anotacoes_projetos[a], this.anotacoes_projetos_x[a]+interfaceX.RetornaXrelativo(), this.anotacoes_projetos_y[a]+interfaceX.RetornaYrelativo());
          }
        }
      }
      for (int a = 0; a< FRAME_simulador.nOf_linhas_projeto; a++) {
        strokeWeight(1);
        line(linha_x_1_projeto[a]+interfaceX.RetornaXrelativo(), linha_y_1_projeto[a]+interfaceX.RetornaYrelativo(), linha_x_2_projeto[a]+interfaceX.RetornaXrelativo(), linha_y_2_projeto[a]+interfaceX.RetornaYrelativo());
      }
    } else {
      fill(255, 255, 255);
      stroke(255, 255, 255);
      if (FRAME_simulador.projecao == "ZX") {
        for (int a = 0; a<FRAME_simulador.nOf_anotacoes_simulador; a++) {
          if (this.anotacoes_simulador_projecao[a] == "ZX") {
            text(this.anotacoes_simulador[a], this.anotacoes_simulador_x[a]+interfaceX.RetornaXrelativo(), this.anotacoes_simulador_y[a]+interfaceX.RetornaYrelativo());
          }
        }
      } else if (FRAME_simulador.projecao == "ZY") {
        for (int a = 0; a<FRAME_simulador.nOf_anotacoes_simulador; a++) {
          if (this.anotacoes_simulador_projecao[a] == "ZY") {
            text(this.anotacoes_simulador[a], this.anotacoes_simulador_x[a]+interfaceX.RetornaXrelativo(), this.anotacoes_simulador_y[a]+interfaceX.RetornaYrelativo());
          }
        }
      } else if (FRAME_simulador.projecao == "XY") {
        for (int a = 0; a<FRAME_simulador.nOf_anotacoes_simulador; a++) {
          if (this.anotacoes_simulador_projecao[a] == "XY") {
            text(this.anotacoes_simulador[a], this.anotacoes_simulador_x[a]+interfaceX.RetornaXrelativo(), this.anotacoes_simulador_y[a]+interfaceX.RetornaYrelativo());
          }
        }
      }
      for (int a = 0; a< FRAME_simulador.nOf_linhas_simulador; a++) {
        strokeWeight(1);
        line(linha_x_1_simulador[a]+interfaceX.RetornaXrelativo(), linha_y_1_simulador[a]+interfaceX.RetornaYrelativo(), linha_x_2_simulador[a]+interfaceX.RetornaXrelativo(), linha_y_2_simulador[a]+interfaceX.RetornaYrelativo());
      }
    }
  }
}