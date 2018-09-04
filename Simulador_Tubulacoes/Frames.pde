//total
FrameTotal FRAME_total = new FrameTotal();

//menu superior
FrameMenuSuperior FRAME_menu_superior = new FrameMenuSuperior();
//barra lateral
FrameBarraLateral FRAME_barra_lateral = new FrameBarraLateral();
//barra inferior
FrameBarraInferior FRAME_barra_inferior = new FrameBarraInferior();
//demais quadros

class FrameTotal {

  void Show() {

    image(fundo, 0, 0, 1280, 720);
  }
}
class FrameMenuSuperior {

  Botao editar_ambiente = new Botao("EditarMenuSuperior", 215, 10, "", "Editar Ambiente");
  Botao editar_fluido = new Botao("EditarMenuSuperior", 215, 45, "", "Editar Fluido");
  Botao editar_fluxo = new Botao("EditarMenuSuperior", 215, 80, "", "Editar Vazão");
  Botao editar_material = new Botao("EditarMenuSuperior", 215, 115, "", "Editar Material");
  Botao ferramenta_selecionar = new Botao("FerramentasMenuSuperior", 830, 15, "", "Selecionar");
  Botao ferramenta_calcular = new Botao("FerramentasMenuSuperior", 940, 15, "", "  Calcular");
  Botao ferramenta_simular = new Botao("FerramentasMenuSuperior", 1050, 15, "", "  Simular");
  Botao ferramenta_anotar = new Botao("FerramentasMenuSuperior", 1160, 15, "", "   Anotar");



  boolean calcular = false;

  //dados da telinha
  String pressao = "0.000";
  String potencia = "0.000";
  String temperatura = "0.000";
  String vazao_volumetrica =  "0.000";
  String velocidade_saida = "0.000";
  String vazao_massica = "0.000";
  String delta_h = "0.000";
  String perda_carga = "0.000";


  void Show() {
    
    float tempo;
    //base 

    fill(255, 255, 255);
    beginShape();
    vertex(0, 0);
    vertex(0, 160);
    vertex(800, 160);
    vertex(820, 130);
    vertex(1280, 130);
    vertex(1280, 0);
    endShape(CLOSE);
    line(0, 158, 802, 158);
    line(820, 128, 1280, 128);
    fill(0, 150, 0);
    stroke(0, 250, 0);
    beginShape();
    vertex(804, 155);
    vertex(1235, 155);
    vertex(1250, 130);
    vertex(821, 130);
    endShape(CLOSE);
    stroke(0, 0, 0);

    fill(100, 100, 100);
    image(lacit, 30, 5, 150, 125);
    textSize(16);
    text("Simulador Tubulações", 15, 145);

    //linha
    stroke(150, 150, 150);

    line(200, 5, 200, 150);

    //texto velocidade


    if (this.calcular) {

      this.calcular = false;

      if (controladora.trilha) {
        this.pressao = nfc(calculo.DDPRESSAO_trilha(),3);//
        this.potencia = nfc(calculo.DDPOTENCIA_trilha(),3);//
        this.delta_h = nfc(calculo.DeltaH_trilha(),3);
        this.velocidade_saida = nfc(reservatorios.reservatorio_aberto[FRAME_simulador.indice_local[controladora.objeto_trilha[0]]].Velocidade(FRAME_simulador.vazao_volumetrica),3);
        this.perda_carga = nfc(calculo.RazaoPerdaCarga()*100,3);
      }
      this.temperatura = nfc(FRAME_simulador.temperatura,3);
      this.vazao_massica =  nfc(FRAME_simulador.vazao_volumetrica*FRAME_simulador.massa_especifica,3);
      this.vazao_volumetrica = nfc(FRAME_simulador.vazao_volumetrica,3);
      
      
    } else {
      
      fill(0, 255, 0);
      tempo = millis();
      tempo = (tempo % 20000);
      if(tempo >= 0 && tempo < 5000){
        text("Pressao: "+this.pressao+" Pa | Potencia: "+this.potencia+" W ", 820, 149);
      }
      if(tempo >= 5000 && tempo < 10000){
        text("Vel.Saida: "+this.velocidade_saida+" m/s | Vazão Vol: "+this.vazao_volumetrica+" m3 ", 820, 149);
      }
      if(tempo >= 10000 && tempo < 15000){
        text("Difer. Altura: "+this.delta_h+" m | Perda Carga: "+this.perda_carga+" % ", 820, 149);
      }
      if(tempo >= 15000 && tempo < 20000){
        text("Vazão Mas.: "+this.vazao_massica+" kg/s | Temperatura: "+this.temperatura+" C¨ ", 820, 149);
      }
      
    }

    //botoes
    this.editar_ambiente.Show();
    this.editar_fluido.Show();
    this.editar_fluxo.Show();
    this.editar_material.Show();
    this.ferramenta_selecionar.Show();
    this.ferramenta_calcular.Show();
    this.ferramenta_simular.Show();
    this.ferramenta_anotar.Show();
  }
}

class FrameBarraLateral {

  boolean tubulacao_selecionado =false;
  boolean bomba_selecionado =false;
  boolean reservatorio_selecionado =false;
  boolean valvula_selecionado =false;
  boolean tubulacao_mouse =false;
  boolean bomba_mouse =false;
  boolean reservatorio_mouse =false;
  boolean valvula_mouse =false;

  int opcoes_tubulacao = 8;
  int opcoes_valvula = 6;
  int opcoes_bomba = 9;
  int opcoes_reservatorio = 14;

  int opcoes=0;

  boolean[] quadrado_selecionado = new boolean[20];

  int caixa_x = 0;
  int caixa=0;
  void Show() {


    //desenho do menu
    fill(150, 150, 150);
    rect(0, 160, 280, 510);

    fill(50, 50, 50);
    rect(10, 170, 260, 60, 10);
    fill(255, 255, 255);
    rect(10, 240, 260, 420, 10);

    //vistas
    fill(50, 50, 50);
    ellipse(25, 695, 40, 40);
    ellipse(260, 695, 40, 40);
    noStroke();
    rect(25, 675, 235, 40);
    stroke(0, 0, 0);
    line(25, 675, 260, 675);
    line(25, 715, 260, 715);
    //caixinha vistas
    if (mousePressed&&calculo.MouseIn(25, 675, 260, 715)) {

      this.caixa_x = mouseX;
    } else {
      if (this.caixa_x<105) {
        this.caixa_x =65;
        if (this.caixa!=1) {
          FRAME_barra_inferior.linha_1.Apaga();
          FRAME_barra_inferior.linha_1.MudaTexto("Alteração : Vista Frontal");

          this.caixa = 1;
        }
      } else if (this.caixa_x>180) {

        this.caixa_x = 220;
        if (this.caixa!=3) {
          FRAME_barra_inferior.linha_1.Apaga();
          FRAME_barra_inferior.linha_1.MudaTexto("Alteração : Vista Superior");

          this.caixa = 3;
        }
      } else {
        this.caixa_x = 145;
        if (this.caixa!=2) {
          FRAME_barra_inferior.linha_1.Apaga();
          FRAME_barra_inferior.linha_1.MudaTexto("Alteração : Vista Lateral");

          this.caixa = 2;
        }
      }
    }
    if (this.caixa_x<60) {

      this.caixa_x = 60;
    } else if (this.caixa_x>225) {

      this.caixa_x = 225;
    }
    fill(150, 150, 150);
    rect(this.caixa_x-35, 675, 70, 40);
    fill(50, 50, 50);
    rect(this.caixa_x-30, 682, 60, 26);

    textSize(12);
    fill(0, 0, 0);
    text("Frontal", 45, 700);
    text("Lateral", 127, 700);
    text("Superior", 197, 700);

    fill(255, 255, 255);
    if (this.caixa==1) {
      text("Frontal", 45, 700);
    }
    if (this.caixa==2) {
      text("Lateral", 127, 700);
    }
    if (this.caixa==3) {
      text("Superior", 197, 700);
    }


    //teste de mouse em cima do simbolo

    if (calculo.DistanciaPP(mouseX, mouseY, 43, 200)<27) {
      this.tubulacao_mouse = true;
      if (mousePressed) {

        for (int c = 0; c<20; c++) {

          this.quadrado_selecionado[c] = false;
        }
        this.opcoes = this.opcoes_tubulacao;
        this.tubulacao_selecionado = true;
        this.valvula_selecionado = false;
        this.bomba_selecionado = false;
        this.reservatorio_selecionado = false;
      }
    } else {
      this.tubulacao_mouse = false;
    }
    if (calculo.DistanciaPP(mouseX, mouseY, 105, 200)<27) {
      this.valvula_mouse = true;

      if (mousePressed) {

        for (int c = 0; c<20; c++) {

          this.quadrado_selecionado[c] = false;
        }
        this.opcoes = this.opcoes_valvula;
        this.tubulacao_selecionado = false;
        this.valvula_selecionado = true;
        this.bomba_selecionado = false;
        this.reservatorio_selecionado = false;
      }
    } else {
      this.valvula_mouse = false;
    }
    if (calculo.DistanciaPP(mouseX, mouseY, 165, 200)<27) {
      this.bomba_mouse = true;

      if (mousePressed) {

        for (int c = 0; c<20; c++) {

          this.quadrado_selecionado[c] = false;
        }
        this.opcoes = this.opcoes_bomba;
        this.tubulacao_selecionado = false;
        this.valvula_selecionado = false;
        this.bomba_selecionado = true;
        this.reservatorio_selecionado = false;
      }
    } else {
      this.bomba_mouse = false;
    }
    if (calculo.DistanciaPP(mouseX, mouseY, 228, 200)<27) {
      this.reservatorio_mouse = true;

      if (mousePressed) {

        for (int c = 0; c<20; c++) {

          this.quadrado_selecionado[c] = false;
        }
        this.opcoes = this.opcoes_reservatorio;
        this.tubulacao_selecionado = false;
        this.valvula_selecionado = false;
        this.bomba_selecionado = false;
        this.reservatorio_selecionado = true;
      }
    } else {
      this.reservatorio_mouse = false;
    }

    //circulos de seleção
    fill(100, 100, 100);
    noStroke();
    if (this.tubulacao_selecionado||this.tubulacao_mouse) {

      ellipse(43, 200, 54, 54);
    }
    if (this.valvula_selecionado||this.valvula_mouse) {

      ellipse(105, 200, 54, 54);
    }
    if (this.bomba_selecionado||this.bomba_mouse) {

      ellipse(165, 200, 54, 54);
    }
    if (this.reservatorio_selecionado||this.reservatorio_mouse) {

      ellipse(228, 200, 54, 54);
    }

    stroke(0, 0, 0);
    strokeWeight(3);
    fill(60, 110, 110);
    //desenho da tubulação
    rect(25, 185, 5, 30);
    rect(30, 190, 25, 20);
    rect(55, 185, 5, 30);

    //desenho da valvula

    triangle(90, 195, 90, 215, 105, 205);
    triangle(120, 195, 120, 215, 105, 205);


    line(105, 200, 105, 185);
    line(95, 185, 115, 185);


    //desenho da bomba

    triangle(150, 215, 180, 215, 165, 195);
    ellipse(165, 195, 25, 25);

    //desenho do reservatorio

    line(205, 185, 205, 215);
    line(250, 185, 250, 215);
    line(205, 215, 250, 215);
    noStroke();
    rect(207, 185, 42, 29);
    stroke(0, 0, 0);

    strokeWeight(1);

    //quadrados interativos do menu


    stroke(150, 150, 150);
    for (int a = 0; a<this.opcoes; a++) {

      for (int b = 0; b<4&&(a*4+b<this.opcoes); b++) {

        if (mouseX>25+b*60&&mouseX<75+b*60&&mouseY>250+a*60&&mouseY<300+a*60) {
          fill(100, 100, 100);
          if (mousePressed) {
            FRAME_simulador.ProjectModeIn(this.tubulacao_selecionado, this.valvula_selecionado, this.bomba_selecionado, this.reservatorio_selecionado, a, b);
            for (int c = 0; c<20; c++) {

              this.quadrado_selecionado[c] = false;
            }
            quadrado_selecionado[a*4+b] = true;
          }
        } else {
          fill(255, 255, 255);
        }
        if (quadrado_selecionado[a*4+b]==true) {
          fill(100, 100, 100);
          stroke(255, 0, 0);
        }
        rect(25+b*60, 250+a*60, 50, 50);
        stroke(150, 150, 150);
      }
    }

    //imagens nos quadrados ( up to)
    stroke(0, 0, 0);
    strokeWeight(3);
    fill(60, 110, 110);
    if (this.tubulacao_selecionado) {



      //tubo horizontal
      rect(32, 260, 5, 30);
      rect(37, 265, 25, 20);
      rect(62, 260, 5, 30);
      //tubo vertical

      rect(95, 260, 30, 5);
      rect(95, 285, 30, 5);
      rect(100, 265, 20, 20);

      //tubo inclinado IO horizontal

      rect(153, 265, 5, 30);
      beginShape();
      vertex(158, 270);
      vertex(183, 260);
      vertex(183, 280);
      vertex(158, 290);
      endShape(CLOSE);
      rect(183, 255, 5, 30);

      //tubo inclinado IO vertical

      rect(211, 258, 30, 5);
      beginShape();
      vertex(216, 263);
      vertex(236, 263);
      vertex(246, 287);
      vertex(226, 287);
      endShape(CLOSE);
      rect(221, 287, 30, 5);

      //cotovelo sul-oeste

      rect(45, 350, 25, 5);
      rect(30, 315, 5, 25);
      curve(-15, 330, 35, 320, 65, 350, 55, 400);
      noStroke();
      beginShape();
      vertex(37, 322);
      vertex(65, 350);
      vertex(50, 350);
      vertex(37, 335);
      endShape(CLOSE);
      stroke(0, 0, 0);
      line(37, 335, 50, 350);


      //cotovelo leste-sul

      pushMatrix();
      translate(30, 315);
      rotate(radians(270));

      translate(-70, -255);
      rect(45, 350, 25, 5);
      rect(30, 315, 5, 25);
      curve(-15, 330, 35, 320, 65, 350, 55, 400);
      noStroke();
      beginShape();
      vertex(36, 322);
      vertex(65, 350);
      vertex(50, 350);
      vertex(36, 335);
      endShape(CLOSE);
      stroke(0, 0, 0);
      line(37, 335, 50, 350);
      popMatrix();

      //cotovelo norte-leste

      pushMatrix();
      translate(30, 315);
      rotate(radians(180));

      translate(-190, -355);
      rect(45, 350, 25, 5);
      rect(30, 315, 5, 25);
      curve(-15, 330, 35, 320, 65, 350, 55, 400);
      noStroke();
      beginShape();
      vertex(36, 322);
      vertex(65, 350);
      vertex(50, 350);
      vertex(36, 335);
      endShape(CLOSE);
      stroke(0, 0, 0);
      line(37, 335, 50, 350);
      popMatrix();

      //cotovelo oeste-norte

      pushMatrix();
      translate(30, 315);
      rotate(radians(90));

      translate(-30, -535);
      rect(45, 350, 25, 5);
      rect(30, 315, 5, 25);
      curve(-15, 330, 35, 320, 65, 350, 55, 400);
      noStroke();
      beginShape();
      vertex(37, 322);
      vertex(65, 350);
      vertex(50, 350);
      vertex(37, 335);
      endShape(CLOSE);
      stroke(0, 0, 0);
      line(37, 335, 50, 350);
      popMatrix();
    }
    if (this.bomba_selecionado) {

      //bomba centrifuga
      stroke(0, 0, 0);
      fill(60, 110, 110);
      triangle(30, 295, 70, 295, 50, 280);
      ellipse(50, 273, 36, 36);
      line(50, 255, 70, 255);
      line(28, 273, 50, 273);
      triangle(50, 273, 45, 271, 45, 275);
      triangle(70, 255, 65, 257, 65, 253);

      //bomba em linha

      line(90, 275, 130, 275);
      ellipse(110, 275, 32, 32);
    }
    if (this.reservatorio_selecionado) {

      noStroke();
      rect(32, 260, 36, 30);
      stroke(0, 0, 0);
      line(32, 260, 32, 290);
      line(66, 260, 66, 280);
      line(66, 280, 71, 280);
      line(66, 285, 71, 285);
      line(66, 285, 66, 290);
      line(32, 290, 66, 290);
    }

    strokeWeight(1);
  }
}

class FrameBarraInferior {

  int y = 600;
  int tempo;
  int tempo_relativo;

  boolean show_up = false;
  boolean show_down = false;

  Template template = new Template();

  LinhaDinamica linha_1 = new LinhaDinamica(33);
  LinhaDinamica linha_2 = new LinhaDinamica(58);
  LinhaDinamica linha_3 = new LinhaDinamica(83);
  LinhaDinamica linha_4 = new LinhaDinamica(108);

  FrameBarraInferior() {

    this.InstalaTemplate("Vazio");
  }
  void InstalaTemplate(String n_template) {

    this.linha_1.Apaga();
    this.linha_2.Apaga();
    this.linha_3.Apaga();
    this.linha_4.Apaga();
    this.template.Setup(n_template);
  }
  void ShowUp() {

    this.show_up = true;
  }
  void ShowDown() {

    this.show_down = true;
  }
  void Show() {


    fill(150, 150, 150);
    rect(300, this.y, 960, 200, 20);

    fill(255, 255, 255);
    stroke(100, 100, 100);
    line(500, this.y+5, 1060, this.y+5);

    rect(310, this.y+15, 940, 100);
    stroke(0, 0, 0);

    this.template.Show();

    this.linha_1.Show(this.y);
    this.linha_2.Show(this.y);
    this.linha_3.Show(this.y);
    this.linha_4.Show(this.y);



    //SHOW UP

    if (this.show_up) {
      if (this.y<=600) {
        this.y = 600;
        this.show_up = false;
      } else {

        this.y-=5;
      }
    }
    //SHOW DOWN
    if (this.show_down) {
      if (this.y>=720) {
        this.y = 720;
        this.show_down = false;
      } else {

        this.y+=5;
      }
    }
  }
}