Tubos tubos = new Tubos();
Reservatorios reservatorios = new Reservatorios();
Bombas bombas = new Bombas();
Anotacoes anotacoes = new Anotacoes();
class ReservatorioAberto {

  float x=0;
  float y=0;
  float z=0;

  float capacidade = 10;//em metros cúbicos
  float diametro_reservatorio = 1;//em metros
  float pressao = 101325;//em pascal

  float diametro = 0;

  String sentidoXY = "Sul";

  boolean selecionado = false;


  void PadDirecao() {
    controladora.ProcuraConeccoes(this.x, this.y, this.z);

    if (controladora.indice > 1) {

      for (int a = 0; a < controladora.indice; a++) {

        if (controladora.connect_x[a] != this.x || controladora.connect_y[a] != this.y || controladora.connect_z[a] != this.z ) {
          if (controladora.connect_x[a]>this.x) {
            this.sentidoXY = "Leste";
          } else if (controladora.connect_x[a]<this.x) {
            this.sentidoXY = "Oeste";
          } else if (controladora.connect_y[a]<this.y) {
            this.sentidoXY = "Sul";
          } else if (controladora.connect_y[a]>this.y) {
            this.sentidoXY = "Norte";
          }
        }
      }
    }
  }
  boolean TestaSelecao() {

    this.PadDirecao();
    if (mousePressed) {
      if (FRAME_simulador.projecao == "ZX") {
        if (this.sentidoXY == "Leste") {
          return calculo.MouseInSimulador(this.x  - 200, -this.z - 100, this.x - 20, -this.z +20);
        } else if (this.sentidoXY == "Oeste") {
          return calculo.MouseInSimulador(this.x  +20, -this.z - 100, this.x +200, -this.z +20);
        } else if (this.sentidoXY == "Norte") {
          return calculo.MouseInSimulador(this.x  - 90, -this.z - 100, this.x +90, -this.z +20);
        } else if (this.sentidoXY == "Sul") {
          return calculo.MouseInSimulador(this.x  - 90, -this.z - 100, this.x + 90, -this.z +20);
        }
      } else if (FRAME_simulador.projecao == "ZY") {
        if (this.sentidoXY == "Leste") {
          return calculo.MouseInSimulador(this.x  - 90, -this.z - 100, this.x +90, -this.z +20);
        } else if (this.sentidoXY == "Oeste") {
          return calculo.MouseInSimulador(this.x  - 90, -this.z - 100, this.x +90, -this.z +20);
        } else if (this.sentidoXY == "Norte") {
          return calculo.MouseInSimulador(this.x  - 200, -this.z - 100, this.x - 20, -this.z +20);
        } else if (this.sentidoXY == "Sul") {
          return calculo.MouseInSimulador(this.x  +20, -this.z - 100, this.x +200, -this.z +20);
        }
      } else if (FRAME_simulador.projecao == "XY") {
        if (this.sentidoXY == "Leste") {
          //ellipse(this.x + interfaceX.RetornaXrelativo()-110, -this.y + interfaceX.RetornaYrelativo(), 180, 180);
        } else if (this.sentidoXY == "Oeste") {
          //ellipse(this.x + interfaceX.RetornaXrelativo()+110, -this.y + interfaceX.RetornaYrelativo(), 180, 180);
        } else if (this.sentidoXY == "Norte") {
          //ellipse(this.x + interfaceX.RetornaXrelativo(), -this.y + interfaceX.RetornaYrelativo()+110, 180, 180);
        } else if (this.sentidoXY == "Sul") {
          //ellipse(this.x + interfaceX.RetornaXrelativo(), -this.y + interfaceX.RetornaYrelativo()-110, 180, 180);
        }
        return true;
      }
      return false;
    } else {
      return false;
    }
  }
  void MudaDiametro(float novo_diametro) {

    this.diametro = novo_diametro;
  }
  void Setup(float novo_x_0, float novo_y_0, float novo_z_0) {

    this.x = novo_x_0;
    this.y = novo_y_0;
    this.z = novo_z_0;
  }
  float Pressao() {
    return this.pressao;
  }
  float Velocidade(float vazao) {

    return vazao/(PI*pow((this.diametro/1000)/2, 2));
  }
  float Altura(float litros) {

    if (litros<this.capacidade*1000) {

      //println("o reservatorio não possui essa capacidade");
      return 0;
    } else {
      return (this.z/1000 + (litros/1000)/(PI*pow(this.diametro_reservatorio/2, 2)));
    }
  }
  float Altura(String estado) {


    if (estado == "Cheio") {
      println("Altura:"+(this.z/1000 + (this.capacidade)/(PI*pow(this.diametro_reservatorio/2, 2))));
      return (this.z/1000 + (this.capacidade)/(PI*pow(this.diametro_reservatorio/2, 2)));
    } else if (estado == "Vazio") {
      return this.z/1000 ;
    } else {

      return 0;
    }
  }
  void Interacao() {
  }
  void Show() {
    this.PadDirecao();
    stroke(0, 0, 0);
    strokeWeight(2);
    fill(60, 110, 110);

    if (FRAME_simulador.projecao == "ZX") {

      if (this.sentidoXY == "Leste") {

        fill(100, 100, 100);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        rect(this.x + interfaceX.RetornaXrelativo() - 200, -this.z + interfaceX.RetornaYrelativo() - 100, 180, 120 );
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        rect(this.x + interfaceX.RetornaXrelativo() - 20, -this.z + interfaceX.RetornaYrelativo() - int(this.diametro/2)+3, 15, +int(this.diametro)-6 );
        rect(this.x + interfaceX.RetornaXrelativo() - 5, -this.z + interfaceX.RetornaYrelativo() - int(this.diametro/2), 5, +int(this.diametro) );
      }
      if (this.sentidoXY == "Oeste") {

        fill(100, 100, 100);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        rect(this.x + interfaceX.RetornaXrelativo() +20, -this.z + interfaceX.RetornaYrelativo() - 100, 180, 120 );
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        rect(this.x + interfaceX.RetornaXrelativo(), -this.z + interfaceX.RetornaYrelativo() - int(this.diametro/2)+3, 20, +int(this.diametro)-6 );
        rect(this.x + interfaceX.RetornaXrelativo(), -this.z + interfaceX.RetornaYrelativo() - int(this.diametro/2), 5, +int(this.diametro) );
      }
      if (this.sentidoXY == "Norte") {

        fill(100, 100, 100);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        rect(this.x + interfaceX.RetornaXrelativo() -90, -this.z + interfaceX.RetornaYrelativo() - 100, 180, 120 );
      }
      if (this.sentidoXY == "Sul") {
        fill(100, 100, 100);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        rect(this.x + interfaceX.RetornaXrelativo() -90, -this.z + interfaceX.RetornaYrelativo() - 100, 180, 120 );
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.x + interfaceX.RetornaXrelativo(), -this.z + interfaceX.RetornaYrelativo(), int(this.diametro), int(this.diametro));
        fill(0, 0, 250);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.x + interfaceX.RetornaXrelativo(), -this.z + interfaceX.RetornaYrelativo(), int(this.diametro-6), int(this.diametro-6));
      }
    }
    if (FRAME_simulador.projecao == "ZY") {

      if (this.sentidoXY == "Leste") {
        fill(100, 100, 100);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        rect(this.y + interfaceX.RetornaXrelativo() -90, -this.z + interfaceX.RetornaYrelativo() - 100, 180, 120 );
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.y + interfaceX.RetornaXrelativo(), -this.z + interfaceX.RetornaYrelativo(), int(this.diametro), int(this.diametro));
        fill(0, 0, 250);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.y + interfaceX.RetornaXrelativo(), -this.z + interfaceX.RetornaYrelativo(), int(this.diametro-6), int(this.diametro-6));
      }
      if (this.sentidoXY == "Oeste") {

        fill(100, 100, 100);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        rect(this.y + interfaceX.RetornaXrelativo() -90, -this.z + interfaceX.RetornaYrelativo() - 100, 180, 120 );
      }
      if (this.sentidoXY == "Norte") {
        fill(100, 100, 100);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        rect(this.y + interfaceX.RetornaXrelativo() - 200, -this.z + interfaceX.RetornaYrelativo() - 100, 180, 120 );
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        rect(this.y + interfaceX.RetornaXrelativo() - 20, -this.z + interfaceX.RetornaYrelativo() - int(this.diametro/2)+3, 15, +int(this.diametro)-6 );
        rect(this.y + interfaceX.RetornaXrelativo() - 5, -this.z + interfaceX.RetornaYrelativo() - int(this.diametro/2), 5, +int(this.diametro) );
      }
      if (this.sentidoXY == "Sul") {
        fill(100, 100, 100);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        rect(this.y + interfaceX.RetornaXrelativo() +20, -this.z + interfaceX.RetornaYrelativo() - 100, 180, 120 );
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        rect(this.y + interfaceX.RetornaXrelativo(), -this.z + interfaceX.RetornaYrelativo() - int(this.diametro/2)+3, 20, +int(this.diametro)-6 );
        rect(this.y + interfaceX.RetornaXrelativo(), -this.z + interfaceX.RetornaYrelativo() - int(this.diametro/2), 5, +int(this.diametro) );
      }
    }
    if (FRAME_simulador.projecao == "XY") {

      if (this.sentidoXY == "Leste") {
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        rect(this.x + interfaceX.RetornaXrelativo() - 25, -this.y + interfaceX.RetornaYrelativo() - int(this.diametro/2)+3, 20, +int(this.diametro)-6 );
        rect(this.x + interfaceX.RetornaXrelativo() - 5, -this.y + interfaceX.RetornaYrelativo() - int(this.diametro/2), 5, +int(this.diametro) );
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.x + interfaceX.RetornaXrelativo()-110, -this.y + interfaceX.RetornaYrelativo(), 180, 180);
        fill(50, 50, 250);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.x + interfaceX.RetornaXrelativo()-110, -this.y + interfaceX.RetornaYrelativo(), 160, 160);
      }
      if (this.sentidoXY == "Oeste") {
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        rect(this.x + interfaceX.RetornaXrelativo(), -this.y + interfaceX.RetornaYrelativo() - int(this.diametro/2)+3, 25, +int(this.diametro)-6 );
        rect(this.x + interfaceX.RetornaXrelativo(), -this.y + interfaceX.RetornaYrelativo() - int(this.diametro/2), 5, +int(this.diametro) );
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.x + interfaceX.RetornaXrelativo()+110, -this.y + interfaceX.RetornaYrelativo(), 180, 180);
        fill(50, 50, 250);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.x + interfaceX.RetornaXrelativo()+110, -this.y + interfaceX.RetornaYrelativo(), 160, 160);
      }
      if (this.sentidoXY == "Norte") {
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        rect(this.x + interfaceX.RetornaXrelativo() - int(this.diametro/2)+3, -this.y + interfaceX.RetornaYrelativo(), +int(this.diametro)-6, 25 );
        rect(this.x + interfaceX.RetornaXrelativo() - int(this.diametro/2), -this.y + interfaceX.RetornaYrelativo(), +int(this.diametro), 5 );
        ellipse(this.x + interfaceX.RetornaXrelativo(), -this.y + interfaceX.RetornaYrelativo()+110, 180, 180);
        fill(50, 50, 250);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.x + interfaceX.RetornaXrelativo(), -this.y + interfaceX.RetornaYrelativo()+110, 160, 160);
      }
      if (this.sentidoXY == "Sul") {
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        rect(this.x + interfaceX.RetornaXrelativo() - int(this.diametro/2)+3, -this.y + interfaceX.RetornaYrelativo()-25, +int(this.diametro)-6, 25 );
        rect(this.x + interfaceX.RetornaXrelativo() - int(this.diametro/2), -this.y + interfaceX.RetornaYrelativo()-5, +int(this.diametro), 5 );
        ellipse(this.x + interfaceX.RetornaXrelativo(), -this.y + interfaceX.RetornaYrelativo()-110, 180, 180);
        fill(50, 50, 250);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.x + interfaceX.RetornaXrelativo(), -this.y + interfaceX.RetornaYrelativo()-110, 160, 160);
      }
    }
  }
}
class TuboInclinadoVertical {

  float x_0=0;
  float y_0=0;
  float z_0=0;
  float x_1=0;
  float y_1=0;
  float z_1=0;
  float diametro=10;
  float rugosidade = 0.002;

  boolean flag = false;

  boolean selecionado = false;


  float Comprimento() {

    return sqrt(pow(abs(x_0-x_1), 2)+pow(abs(y_0-y_1), 2)+pow(abs(z_0-z_1), 2))/1000;
  }
  float Velocidade() {

    return FRAME_simulador.vazao_volumetrica/(PI*pow(this.diametro/1000, 2)/4);
  }
  float Rugosidade(){
     
     return FRAME_simulador.rugosidade;
    
  }
  String RetornaPlano() {

    if (this.x_0==this.x_1) {
      return ("ZY");
    } else if (this.y_0==this.y_1) {
      return ("ZX");
    } else if (this.z_0==this.z_1) {
      return ("XY");
    } else {

      return "";
    }
  }
  boolean RetornaFlag(String projecao) {

    if (projecao == "ZX") {
      if (this.y_0<this.y_1) {
        return true;
      } else {
        return false;
      }
    } else if (projecao == "ZY") {
      if (this.x_0<this.x_1) {
        return true;
      } else {
        return false;
      }
    } else if (projecao == "XY") {
      if (this.z_0<this.z_1) {
        return true;
      } else {
        return false;
      }
    } else {

      return false;
    }
  }
  void MudaDiametro(float novo_diametro) {

    this.diametro = novo_diametro;
  }
  void Setup(float novo_x_0, float novo_y_0, float novo_z_0, float novo_x_1, float novo_y_1, float novo_z_1) {

    this.x_0 = novo_x_0;
    this.y_0 = novo_y_0;
    this.z_0 = novo_z_0;

    this.x_1 = novo_x_1;
    this.y_1 = novo_y_1;
    this.z_1 = novo_z_1;
  }
  void Pad() {

    String plano = this.RetornaPlano();
    float tmp;

    if (plano == "ZX"&&this.z_0 < z_1) {         
      tmp = this.z_0;
      this.z_0 = this.z_1;
      this.z_1 = tmp;    
      tmp = this.x_0;
      this.x_0 = this.x_1;
      this.x_1 = tmp;
    }
    if (plano == "ZY"&&this.z_0 < z_1) {              
      tmp = this.z_0;
      this.z_0 = this.z_1;
      this.z_1 = tmp;
      tmp = this.y_0;
      this.y_0 = this.y_1;
      this.y_1 = tmp;
    }
    if (plano == "XY"&&this.y_0 < y_1) {           
      tmp = this.y_0;
      this.y_0 = this.y_1;
      this.y_1 = tmp; 
      tmp = this.x_0;
      this.x_0 = this.x_1;
      this.x_1 = tmp;
    }
  }
  void Interacao() {
  }
  void Show() {

    stroke(0, 0, 0);
    strokeWeight(2);
    fill(60, 110, 110);
    if (this.selecionado) {
      fill(255, 255, 0);
    }

    if (FRAME_simulador.projecao == "ZX") {
      if (this.RetornaPlano()=="ZX") {

        rect(this.x_0+interfaceX.RetornaXrelativo()-int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo(), int(this.diametro), 5);
        rect(this.x_1+interfaceX.RetornaXrelativo()-int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo()-5, int(this.diametro), 5);
        beginShape();
        vertex(this.x_0+interfaceX.RetornaXrelativo()-int(this.diametro/2)+3, -this.z_0+interfaceX.RetornaYrelativo()+5);
        vertex(this.x_1+interfaceX.RetornaXrelativo()-int(this.diametro/2)+3, -this.z_1+interfaceX.RetornaYrelativo()-5);
        vertex(this.x_1+interfaceX.RetornaXrelativo()+int(this.diametro/2)-3, -this.z_1+interfaceX.RetornaYrelativo()-5);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+int(this.diametro/2)-3, -this.z_0+interfaceX.RetornaYrelativo()+5);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-int(this.diametro/2)+3, -this.z_0+interfaceX.RetornaYrelativo()+5);
        endShape();
      }
      if (this.RetornaPlano()=="XY") {

        if (this.RetornaFlag(FRAME_simulador.projecao)) {

          ellipse(this.x_1+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          ellipse(this.x_1+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          noStroke();
          rect(this.x_1+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo(), int(this.diametro)-6, this.z_1-this.z_0);
          stroke(0, 0, 0);
          line(this.x_1+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo(), this.x_1+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo());
          line(this.x_1+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo(), this.x_1+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo());
          ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          fill(0, 0, 250);
          if (this.selecionado) {
            fill(255, 255, 0);
          }
          ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          fill(60, 110, 110);
          if (this.selecionado) {
            fill(255, 255, 0);
          }
        } else {
          ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          noStroke();
          rect(this.x_0+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo(), int(this.diametro)-6, this.z_0-this.z_1);
          stroke(0, 0, 0);
          line(this.x_0+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo(), this.x_0+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo());
          line(this.x_0+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo(), this.x_0+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo());
          ellipse(this.x_1+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          fill(0, 0, 250);
          if (this.selecionado) {
            fill(255, 255, 0);
          }
          ellipse(this.x_1+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          fill(60, 110, 110);
          if (this.selecionado) {
            fill(255, 255, 0);
          }
        }
      }
      if (this.RetornaPlano()=="ZY") {
        rect(this.x_0+interfaceX.RetornaXrelativo()-int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo(), int(this.diametro), 5);
        rect(this.x_1+interfaceX.RetornaXrelativo()-int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo()-5, int(this.diametro), 5);
        rect(this.x_0+interfaceX.RetornaXrelativo()-int(this.diametro/2)+3, -this.z_0+interfaceX.RetornaYrelativo()+5, int(this.diametro)-6, this.z_0-this.z_1-10);
      }
    }
    if (FRAME_simulador.projecao == "ZY") {
      if (this.RetornaPlano()=="XY") {
        if (this.RetornaFlag(FRAME_simulador.projecao)) {

          ellipse(this.y_1+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          ellipse(this.y_1+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          noStroke();
          rect(this.y_1+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo(), int(this.diametro)-6, this.z_1-this.z_0);
          stroke(0, 0, 0);
          line(this.y_1+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo(), this.y_1+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo());
          line(this.y_1+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo(), this.y_1+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo());
          ellipse(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          fill(0, 0, 250);
          if (this.selecionado) {
            fill(255, 255, 0);
          }
          ellipse(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          fill(60, 110, 110);
          if (this.selecionado) {
            fill(255, 255, 0);
          }
        } else {
          ellipse(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          ellipse(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          noStroke();
          rect(this.y_0+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo(), int(this.diametro)-6, this.z_0-this.z_1);
          stroke(0, 0, 0);
          line(this.y_0+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo(), this.y_0+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo());
          line(this.y_0+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo(), this.y_0+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo());
          ellipse(this.y_1+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          fill(0, 0, 250);
          if (this.selecionado) {
            fill(255, 255, 0);
          }
          ellipse(this.y_1+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          fill(60, 110, 110);
          if (this.selecionado) {
            fill(255, 255, 0);
          }
        }
      }
      if (this.RetornaPlano()=="ZY") {
        rect(this.y_0+interfaceX.RetornaXrelativo()-int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo(), int(this.diametro), 5);
        rect(this.y_1+interfaceX.RetornaXrelativo()-int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo()-5, int(this.diametro), 5);
        beginShape();
        vertex(this.y_0+interfaceX.RetornaXrelativo()-int(this.diametro/2)+3, -this.z_0+interfaceX.RetornaYrelativo()+5);
        vertex(this.y_1+interfaceX.RetornaXrelativo()-int(this.diametro/2)+3, -this.z_1+interfaceX.RetornaYrelativo()-5);
        vertex(this.y_1+interfaceX.RetornaXrelativo()+int(this.diametro/2)-3, -this.z_1+interfaceX.RetornaYrelativo()-5);
        vertex(this.y_0+interfaceX.RetornaXrelativo()+int(this.diametro/2)-3, -this.z_0+interfaceX.RetornaYrelativo()+5);
        vertex(this.y_0+interfaceX.RetornaXrelativo()-int(this.diametro/2)+3, -this.z_0+interfaceX.RetornaYrelativo()+5);
        endShape();
      }
      if (this.RetornaPlano()=="ZX") {
        rect(this.y_0+interfaceX.RetornaXrelativo()-int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo(), int(this.diametro), 5);
        rect(this.y_1+interfaceX.RetornaXrelativo()-int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo()-5, int(this.diametro), 5);
        rect(this.y_0+interfaceX.RetornaXrelativo()-int(this.diametro/2)+3, -this.z_0+interfaceX.RetornaYrelativo()+5, int(this.diametro)-6, this.z_0-this.z_1-10);
      }
    }
    if (FRAME_simulador.projecao == "XY") {
      if (this.RetornaPlano()=="ZY") {
        if (this.RetornaFlag(FRAME_simulador.projecao)) {

          ellipse(this.x_1+interfaceX.RetornaXrelativo(), -this.y_1+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          ellipse(this.x_1+interfaceX.RetornaXrelativo(), -this.y_1+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          noStroke();
          rect(this.x_1+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.y_1+interfaceX.RetornaYrelativo(), int(this.diametro)-6, this.y_1-this.y_0);
          stroke(0, 0, 0);
          line(this.x_1+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.y_1+interfaceX.RetornaYrelativo(), this.x_1+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.y_0+interfaceX.RetornaYrelativo());
          line(this.x_1+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.y_1+interfaceX.RetornaYrelativo(), this.x_1+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.y_0+interfaceX.RetornaYrelativo());
          ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.y_0+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          fill(0, 0, 250);
          if (this.selecionado) {
            fill(255, 255, 0);
          }
          ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.y_0+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          fill(60, 110, 110);
          if (this.selecionado) {
            fill(255, 255, 0);
          }
        } else {
          ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.y_0+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.y_0+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          noStroke();
          rect(this.x_0+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.y_0+interfaceX.RetornaYrelativo(), int(this.diametro)-6, this.y_0-this.y_1);
          stroke(0, 0, 0);
          line(this.x_0+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.y_0+interfaceX.RetornaYrelativo(), this.x_0+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.y_1+interfaceX.RetornaYrelativo());
          line(this.x_0+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.y_0+interfaceX.RetornaYrelativo(), this.x_0+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.y_1+interfaceX.RetornaYrelativo());
          ellipse(this.x_1+interfaceX.RetornaXrelativo(), -this.y_1+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          fill(0, 0, 250);
          if (this.selecionado) {
            fill(255, 255, 0);
          }
          ellipse(this.x_1+interfaceX.RetornaXrelativo(), -this.y_1+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          fill(60, 110, 110);
          if (this.selecionado) {
            fill(255, 255, 0);
          }
        }
      }
      if (this.RetornaPlano()=="ZX") {
        if (this.RetornaFlag(FRAME_simulador.projecao)) {

          ellipse(this.x_1+interfaceX.RetornaXrelativo(), -this.y_1+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          ellipse(this.x_1+interfaceX.RetornaXrelativo(), -this.y_1+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          noStroke();
          rect(this.x_1+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.y_1+interfaceX.RetornaYrelativo(), int(this.diametro)-6, this.y_1-this.y_0);
          stroke(0, 0, 0);
          line(this.x_1+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.y_1+interfaceX.RetornaYrelativo(), this.x_1+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.y_0+interfaceX.RetornaYrelativo());
          line(this.x_1+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.y_1+interfaceX.RetornaYrelativo(), this.x_1+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.y_0+interfaceX.RetornaYrelativo());
          ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.y_0+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          fill(0, 0, 250);
          if (this.selecionado) {
            fill(255, 255, 0);
          }
          ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.y_0+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          fill(60, 110, 110);
          if (this.selecionado) {
            fill(255, 255, 0);
          }
        } else {
          ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.y_0+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.y_0+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          noStroke();
          rect(this.x_0+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.y_0+interfaceX.RetornaYrelativo(), int(this.diametro)-6, this.y_0-this.y_1);
          stroke(0, 0, 0);
          line(this.x_0+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.y_0+interfaceX.RetornaYrelativo(), this.x_0+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.y_1+interfaceX.RetornaYrelativo());
          line(this.x_0+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.y_0+interfaceX.RetornaYrelativo(), this.x_0+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.y_1+interfaceX.RetornaYrelativo());
          ellipse(this.x_1+interfaceX.RetornaXrelativo(), -this.y_1+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          fill(0, 0, 250);
          if (this.selecionado) {
            fill(255, 255, 0);
          }
          ellipse(this.x_1+interfaceX.RetornaXrelativo(), -this.y_1+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          fill(60, 110, 110);
          if (this.selecionado) {
            fill(255, 255, 0);
          }
        }
      }
      if (this.RetornaPlano()=="XY") {
        rect(this.x_0+interfaceX.RetornaXrelativo()-int(this.diametro/2), -this.y_0+interfaceX.RetornaYrelativo(), int(this.diametro), 5);
        rect(this.x_1+interfaceX.RetornaXrelativo()-int(this.diametro/2), -this.y_1+interfaceX.RetornaYrelativo()-5, int(this.diametro), 5);
        beginShape();
        vertex(this.x_0+interfaceX.RetornaXrelativo()-int(this.diametro/2)+3, -this.y_0+interfaceX.RetornaYrelativo()+5);
        vertex(this.x_1+interfaceX.RetornaXrelativo()-int(this.diametro/2)+3, -this.y_1+interfaceX.RetornaYrelativo()-5);
        vertex(this.x_1+interfaceX.RetornaXrelativo()+int(this.diametro/2)-3, -this.y_1+interfaceX.RetornaYrelativo()-5);
        vertex(this.x_0+interfaceX.RetornaXrelativo()+int(this.diametro/2)-3, -this.y_0+interfaceX.RetornaYrelativo()+5);
        vertex(this.x_0+interfaceX.RetornaXrelativo()-int(this.diametro/2)+3, -this.y_0+interfaceX.RetornaYrelativo()+5);
        endShape();
      }
    }
  }
}


class TuboInclinadoHorizontal {

  float x_0=0;
  float y_0=0;
  float z_0=0;
  float x_1=0;
  float y_1=0;
  float z_1=0;
  float diametro=10;
  float rugosidade = 0.002;

  boolean flag = false;
  boolean selecionado = false;

  float Velocidade() {

    return FRAME_simulador.vazao_volumetrica/(PI*pow(this.diametro/1000, 2)/4);
  }
  float Rugosidade(){
     
     return FRAME_simulador.rugosidade;
    
  }
  float Comprimento() {

    return sqrt(pow(abs(x_0-x_1), 2)+pow(abs(y_0-y_1), 2)+pow(abs(z_0-z_1), 2))/1000;
  }
  String RetornaPlano() {

    if (this.x_0==this.x_1) {
      return ("ZY");
    } else if (this.y_0==this.y_1) {
      return ("ZX");
    } else if (this.z_0==this.z_1) {
      return ("XY");
    } else {
      return "";
    }
  }
  boolean RetornaFlag(String projecao) {

    if (projecao == "ZX") {
      if (this.y_0<this.y_1) {
        return true;
      } else {
        return false;
      }
    } else if (projecao == "ZY") {
      if (this.x_0<this.x_1) {
        return true;
      } else {
        return false;
      }
    } else if (projecao == "XY") {
      if (this.z_0<this.z_1) {
        return true;
      } else {
        return false;
      }
    } else {

      return false;
    }
  }
  void MudaDiametro(float novo_diametro) {

    this.diametro = novo_diametro;
  }
  void Setup(float novo_x_0, float novo_y_0, float novo_z_0, float novo_x_1, float novo_y_1, float novo_z_1) {

    this.x_0 = novo_x_0;
    this.y_0 = novo_y_0;
    this.z_0 = novo_z_0;

    this.x_1 = novo_x_1;
    this.y_1 = novo_y_1;
    this.z_1 = novo_z_1;
  }
  void Pad() {

    String plano = this.RetornaPlano();
    float tmp;

    if (plano == "ZX"&&this.x_0 > x_1) {         
      tmp = this.x_0;
      this.x_0 = this.x_1;
      this.x_1 = tmp;    
      tmp = this.z_0;
      this.z_0 = this.z_1;
      this.z_1 = tmp;
    }
    if (plano == "ZY"&&this.y_0 > y_1) {              
      tmp = this.y_0;
      this.y_0 = this.y_1;
      this.y_1 = tmp;
      tmp = this.z_0;
      this.z_0 = this.z_1;
      this.z_1 = tmp;
    }
    if (plano == "XY"&&this.x_0 > x_1) {           
      tmp = this.x_0;
      this.x_0 = this.x_1;
      this.x_1 = tmp; 
      tmp = this.y_0;
      this.y_0 = this.y_1;
      this.y_1 = tmp;
    }
  }
  void Interacao() {
  }
  void Show() {

    stroke(0, 0, 0);
    strokeWeight(2);
    fill(60, 110, 110);
    if (this.selecionado) {
      fill(255, 255, 0);
    }

    if (FRAME_simulador.projecao == "ZX") {
      if (this.RetornaPlano()=="ZX") {

        rect(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro/2), 5, int(this.diametro));
        rect(this.x_1-5+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo()-int(this.diametro/2), 5, int(this.diametro));
        beginShape();
        vertex(this.x_0+6+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro/2)+3);
        vertex(this.x_1-5+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo()-int(this.diametro/2)+3);
        vertex(this.x_1-5+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo()+int(this.diametro/2)-3);
        vertex(this.x_0+6+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()+int(this.diametro/2)-3);
        endShape();
      }
      if (this.RetornaPlano()=="ZY") {

        if (this.RetornaFlag(FRAME_simulador.projecao)) {

          ellipse(this.x_1+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          ellipse(this.x_1+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          noStroke();
          rect(this.x_1+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo(), int(this.diametro)-6, this.z_1-this.z_0);
          stroke(0, 0, 0);
          line(this.x_1+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo(), this.x_1+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo());
          line(this.x_1+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo(), this.x_1+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo());
          ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          fill(0, 0, 250);
          if (this.selecionado) {
            fill(255, 255, 0);
          }
          ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          fill(60, 110, 110);  
          if (this.selecionado) {
            fill(255, 255, 0);
          }
        } else {
          ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          noStroke();
          rect(this.x_0+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo(), int(this.diametro)-6, this.z_0-this.z_1);
          stroke(0, 0, 0);
          line(this.x_0+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo(), this.x_0+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo());
          line(this.x_0+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo(), this.x_0+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo());
          ellipse(this.x_1+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          fill(0, 0, 250);
          if (this.selecionado) {
            fill(255, 255, 0);
          }
          ellipse(this.x_1+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          fill(60, 110, 110);  
          if (this.selecionado) {
            fill(255, 255, 0);
          }
        }
      }
      if (this.RetornaPlano()=="XY") {
        rect(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro/2), 5, int(this.diametro));
        rect(this.x_1-5+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro/2), 5, int(this.diametro));
        rect(this.x_0+5+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro/2)+3, this.x_1-this.x_0-10, int(this.diametro)-6);
      }
    }
    if (FRAME_simulador.projecao == "ZY") {
      if (this.RetornaPlano()=="ZX") {
        if (this.RetornaFlag(FRAME_simulador.projecao)) {

          ellipse(this.y_1+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          ellipse(this.y_1+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          noStroke();
          rect(this.y_1+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo(), int(this.diametro)-6, this.z_1-this.z_0);
          stroke(0, 0, 0);
          line(this.y_1+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo(), this.y_1+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo());
          line(this.y_1+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo(), this.y_1+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo());
          ellipse(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          fill(0, 0, 250);
          if (this.selecionado) {
            fill(255, 255, 0);
          }
          ellipse(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          fill(60, 110, 110);  
          if (this.selecionado) {
            fill(255, 255, 0);
          }
        } else {
          ellipse(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          ellipse(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          noStroke();
          rect(this.y_0+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo(), int(this.diametro)-6, this.z_0-this.z_1);
          stroke(0, 0, 0);
          line(this.y_0+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo(), this.y_0+interfaceX.RetornaXrelativo()+3-int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo());
          line(this.y_0+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.z_0+interfaceX.RetornaYrelativo(), this.y_0+interfaceX.RetornaXrelativo()-3+int(this.diametro/2), -this.z_1+interfaceX.RetornaYrelativo());
          ellipse(this.y_1+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
          fill(0, 0, 250);
          if (this.selecionado) {
            fill(255, 255, 0);
          }
          ellipse(this.y_1+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
          fill(60, 110, 110); 
          if (this.selecionado) {
            fill(255, 255, 0);
          }
        }
      }
      if (this.RetornaPlano()=="ZY") {
        rect(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro/2), 5, int(this.diametro));
        rect(this.y_1-5+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo()-int(this.diametro/2), 5, int(this.diametro));
        beginShape();
        vertex(this.y_0+6+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro/2)+3);
        vertex(this.y_1-5+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo()-int(this.diametro/2)+3);
        vertex(this.y_1-5+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo()+int(this.diametro/2)-3);
        vertex(this.y_0+6+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()+int(this.diametro/2)-3);
        endShape();
      }
      if (this.RetornaPlano()=="XY") {
        rect(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro/2), 5, int(this.diametro));
        rect(this.y_1-5+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro/2), 5, int(this.diametro));
        rect(this.y_0+5+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro/2)+3, this.y_1-this.y_0-10, int(this.diametro)-6);
      }
    }
    if (FRAME_simulador.projecao == "XY") {
      if (this.RetornaPlano()=="ZX") {
        rect(this.x_0+interfaceX.RetornaXrelativo(), -this.y_0+interfaceX.RetornaYrelativo()-int(this.diametro/2), 5, int(this.diametro));
        rect(this.x_1-5+interfaceX.RetornaXrelativo(), -this.y_0+interfaceX.RetornaYrelativo()-int(this.diametro/2), 5, int(this.diametro));
        rect(this.x_0+5+interfaceX.RetornaXrelativo(), -this.y_0+interfaceX.RetornaYrelativo()-int(this.diametro/2)+3, this.x_1-this.x_0-10, int(this.diametro)-6);
      }
      if (this.RetornaPlano()=="ZY") {
        rect(this.x_0+interfaceX.RetornaXrelativo()-int(this.diametro/2), -this.y_0+interfaceX.RetornaYrelativo()-5, int(this.diametro), 5);
        rect(this.x_1+interfaceX.RetornaXrelativo()-int(this.diametro/2), -this.y_1+interfaceX.RetornaYrelativo(), int(this.diametro), 5);
        rect(this.x_1+interfaceX.RetornaXrelativo()-int(this.diametro/2)+3, -this.y_1+interfaceX.RetornaYrelativo()+5, int(this.diametro)-6, this.y_1-this.y_0-10);
      }
      if (this.RetornaPlano()=="XY") {
        rect(this.x_0+interfaceX.RetornaXrelativo(), -this.y_0+interfaceX.RetornaYrelativo()-int(this.diametro/2), 5, int(this.diametro));
        rect(this.x_1-5+interfaceX.RetornaXrelativo(), -this.y_1+interfaceX.RetornaYrelativo()-int(this.diametro/2), 5, int(this.diametro));
        beginShape();
        vertex(this.x_0+6+interfaceX.RetornaXrelativo(), -this.y_0+interfaceX.RetornaYrelativo()-int(this.diametro/2)+3);
        vertex(this.x_1-5+interfaceX.RetornaXrelativo(), -this.y_1+interfaceX.RetornaYrelativo()-int(this.diametro/2)+3);
        vertex(this.x_1-5+interfaceX.RetornaXrelativo(), -this.y_1+interfaceX.RetornaYrelativo()+int(this.diametro/2)-3);
        vertex(this.x_0+6+interfaceX.RetornaXrelativo(), -this.y_0+interfaceX.RetornaYrelativo()+int(this.diametro/2)-3);
        endShape();
      }
    }
  }
}



class TuboReto {

  float x_0=0;
  float y_0=0;
  float z_0=0;
  float x_1=0;
  float y_1=0;
  float z_1=0;
  float diametro=10;
  float rugosidade = 0.002;

  boolean selecionado = false;
  float Velocidade() {

    return FRAME_simulador.vazao_volumetrica/(PI*pow(this.diametro/1000, 2)/4);
  }
  float Comprimento() {

    return sqrt(pow(abs(x_0-x_1), 2)+pow(abs(y_0-y_1), 2)+pow(abs(z_0-z_1), 2))/1000;
  }
  float Rugosidade(){
     
     return FRAME_simulador.rugosidade;
    
  }
  String RetornaEixo() {

    if (this.x_0!=this.x_1) {
      return ("X");
    } else if (this.y_0!=this.y_1) {
      return ("Y");
    } else if (this.z_0!=this.z_1) {
      return ("Z");
    } else {

      return "";
    }
  }
  void MudaDiametro(float novo_diametro) {

    this.diametro = novo_diametro;
  }
  void Setup(float novo_x_0, float novo_y_0, float novo_z_0, float novo_x_1, float novo_y_1, float novo_z_1) {

    this.x_0 = novo_x_0;
    this.y_0 = novo_y_0;
    this.z_0 = novo_z_0;

    this.x_1 = novo_x_1;
    this.y_1 = novo_y_1;
    this.z_1 = novo_z_1;
  }
  void Pad() {

    String eixo = this.RetornaEixo();
    float tmp;
    if (eixo == "X"&&this.x_0 > x_1) {         
      tmp = this.x_0;
      this.x_0 = this.x_1;
      this.x_1 = tmp;
    }
    if (eixo == "Y"&&this.y_0 > y_1) {              
      tmp = this.y_0;
      this.y_0 = this.y_1;
      this.y_1 = tmp;
    }
    if (eixo == "Z"&&this.z_0 > z_1) {           
      tmp = this.z_0;
      this.z_0 = this.z_1;
      this.z_1 = tmp;
    }
  }
  void Interacao() {
  }
  void Show() {

    stroke(0, 0, 0);
    strokeWeight(2);
    fill(60, 110, 110);
    if (this.selecionado) {
      fill(255, 255, 0);
    }

    if (FRAME_simulador.projecao == "ZX") {
      if (this.RetornaEixo()=="X") {

        rect(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro/2), 5, int(this.diametro));
        rect(this.x_1-5+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro/2), 5, int(this.diametro));
        rect(this.x_0+5+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro/2)+3, this.x_1-this.x_0-10, int(this.diametro)-6);
      }
      if (this.RetornaEixo()=="Y") {
        ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
        fill(0, 0, 250);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
      }
      if (this.RetornaEixo()=="Z") {

        rect(this.x_0-int(this.diametro/2)+interfaceX.RetornaXrelativo(), -this.z_0-5+interfaceX.RetornaYrelativo(), int(this.diametro), 5);
        rect(this.x_0-int(this.diametro/2)+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo(), int(this.diametro), 5);
        rect(this.x_0+3-int(this.diametro/2)+interfaceX.RetornaXrelativo(), -this.z_1+5+interfaceX.RetornaYrelativo(), int(this.diametro)-6, this.z_1-this.z_0-10);
      }
    }
    if (FRAME_simulador.projecao == "ZY") {
      if (this.RetornaEixo()=="X") {
        ellipse(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
        fill(0, 0, 250);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
      }
      if (this.RetornaEixo()=="Y") {

        rect(this.y_0+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro/2), 5, int(this.diametro));
        rect(this.y_1-5+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro/2), 5, int(this.diametro));
        rect(this.y_0+5+interfaceX.RetornaXrelativo(), -this.z_0+interfaceX.RetornaYrelativo()-int(this.diametro/2)+3, this.y_1-this.y_0-10, int(this.diametro)-6);
      }
      if (this.RetornaEixo()=="Z") {
        rect(this.y_0-int(this.diametro/2)+interfaceX.RetornaXrelativo(), -this.z_0-5+interfaceX.RetornaYrelativo(), int(this.diametro), 5);
        rect(this.y_0-int(this.diametro/2)+interfaceX.RetornaXrelativo(), -this.z_1+interfaceX.RetornaYrelativo(), int(this.diametro), 5);
        rect(this.y_0+3-int(this.diametro/2)+interfaceX.RetornaXrelativo(), -this.z_1+5+interfaceX.RetornaYrelativo(), int(this.diametro)-6, this.z_1-this.z_0-10);
      }
    }
    if (FRAME_simulador.projecao == "XY") {
      if (this.RetornaEixo()=="X") {

        rect(this.x_0+interfaceX.RetornaXrelativo(), -this.y_0+interfaceX.RetornaYrelativo()-int(this.diametro/2), 5, int(this.diametro));
        rect(this.x_1-5+interfaceX.RetornaXrelativo(), -this.y_0+interfaceX.RetornaYrelativo()-int(this.diametro/2), 5, int(this.diametro));
        rect(this.x_0+5+interfaceX.RetornaXrelativo(), -this.y_0+interfaceX.RetornaYrelativo()-int(this.diametro/2)+3, this.x_1-this.x_0-10, int(this.diametro)-6);
      }
      if (this.RetornaEixo()=="Y") {
        rect(this.x_0-int(this.diametro/2)+interfaceX.RetornaXrelativo(), -this.y_0-5+interfaceX.RetornaYrelativo(), int(this.diametro), 5);
        rect(this.x_0-int(this.diametro/2)+interfaceX.RetornaXrelativo(), -this.y_1+interfaceX.RetornaYrelativo(), int(this.diametro), 5);
        rect(this.x_0+3-int(this.diametro/2)+interfaceX.RetornaXrelativo(), -this.y_1+5+interfaceX.RetornaYrelativo(), int(this.diametro)-6, this.y_1-this.y_0-10);
      }
      if (this.RetornaEixo()=="Z") {
        ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.y_0+interfaceX.RetornaYrelativo(), this.diametro, this.diametro);
        fill(0, 0, 250);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
        ellipse(this.x_0+interfaceX.RetornaXrelativo(), -this.y_0+interfaceX.RetornaYrelativo(), this.diametro-8, this.diametro-8);
        fill(60, 110, 110);
        if (this.selecionado) {
          fill(255, 255, 0);
        }
      }
    }
  }
}