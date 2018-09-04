Calculos calculo = new Calculos();
class Calculos {
  float DDPRESSAO_trilha() {

    float dPressao =0;

    dPressao = reservatorios.reservatorio_aberto[FRAME_simulador.indice_local[controladora.objeto_trilha[controladora.nOf_objetos_trilha-1]]].Pressao()-reservatorios.reservatorio_aberto[FRAME_simulador.indice_local[controladora.objeto_trilha[0]]].Pressao();//parcela da pressao
    dPressao += this.DeltaH_trilha()*FRAME_simulador.massa_especifica*FRAME_simulador.gravidade;
    for (int a =1; a<controladora.nOf_objetos_trilha-1; a++) {

      if (FRAME_simulador.tipo[controladora.objeto_trilha[a]]=="Tubo Reto") {

        dPressao += this.PerdaDeCargaTubo(FRAME_simulador.massa_especifica, tubos.tubo_reto[FRAME_simulador.indice_local[controladora.objeto_trilha[a]]].Velocidade(), tubos.tubo_reto[FRAME_simulador.indice_local[controladora.objeto_trilha[a]]].diametro/1000, FRAME_simulador.viscosidade_dinamica, tubos.tubo_reto[FRAME_simulador.indice_local[controladora.objeto_trilha[a]]].Rugosidade(), tubos.tubo_reto[FRAME_simulador.indice_local[controladora.objeto_trilha[a]]].Comprimento()/1000, FRAME_simulador.gravidade );
      }
      if (FRAME_simulador.tipo[controladora.objeto_trilha[a]]=="Tubo Inclinado Horizontal") {

        dPressao += this.PerdaDeCargaTubo(FRAME_simulador.massa_especifica, tubos.tubo_inclinado_horizontal[FRAME_simulador.indice_local[controladora.objeto_trilha[a]]].Velocidade(), tubos.tubo_inclinado_horizontal[FRAME_simulador.indice_local[controladora.objeto_trilha[a]]].diametro/1000, FRAME_simulador.viscosidade_dinamica, tubos.tubo_inclinado_horizontal[FRAME_simulador.indice_local[controladora.objeto_trilha[a]]].Rugosidade(), tubos.tubo_inclinado_horizontal[FRAME_simulador.indice_local[controladora.objeto_trilha[a]]].Comprimento()/1000, FRAME_simulador.gravidade );
      }
      if (FRAME_simulador.tipo[controladora.objeto_trilha[a]]=="Tubo Inclinado Vertical") {

        dPressao += this.PerdaDeCargaTubo(FRAME_simulador.massa_especifica, tubos.tubo_inclinado_vertical[FRAME_simulador.indice_local[controladora.objeto_trilha[a]]].Velocidade(), tubos.tubo_inclinado_vertical[FRAME_simulador.indice_local[controladora.objeto_trilha[a]]].diametro/1000, FRAME_simulador.viscosidade_dinamica, tubos.tubo_inclinado_vertical[FRAME_simulador.indice_local[controladora.objeto_trilha[a]]].Rugosidade(), tubos.tubo_inclinado_vertical[FRAME_simulador.indice_local[controladora.objeto_trilha[a]]].Comprimento()/1000, FRAME_simulador.gravidade );
      }
    }
    return dPressao;
  }
  float RazaoPerdaCarga(){
    
    return 1-((calculo.DeltaH_trilha()*FRAME_simulador.massa_especifica*FRAME_simulador.gravidade)+reservatorios.reservatorio_aberto[FRAME_simulador.indice_local[controladora.objeto_trilha[controladora.nOf_objetos_trilha-1]]].Pressao()-reservatorios.reservatorio_aberto[FRAME_simulador.indice_local[controladora.objeto_trilha[0]]].Pressao())/this.DDPRESSAO_trilha();
  }
  float DeltaH_trilha(){
      
      return reservatorios.reservatorio_aberto[FRAME_simulador.indice_local[controladora.objeto_trilha[controladora.nOf_objetos_trilha-1]]].Altura("Cheio")- reservatorios.reservatorio_aberto[FRAME_simulador.indice_local[controladora.objeto_trilha[0]]].Altura("Cheio"); 
    
  }
  float DDPOTENCIA_trilha() {

    return (this.DDPRESSAO_trilha()*FRAME_simulador.vazao_volumetrica);
  }
  float log10 (float x) {
    return (log(x) / log(10));
  }
  float Colebrook(float reynolds, float diametro, float rugosidade) {

    int precisao = 0;
    float jump = 1000;
    float inicial = 0;

    boolean pulou = false;

    while (precisao < 8) {
      pulou = false;
      for (float x = inicial; !pulou; x+=jump ) {
        if (jump>0 && (-2*x*this.log10((rugosidade/(3.7*diametro))+(2.51/(reynolds*x))))>1) {

          pulou = true;
          inicial = x;
          jump = -jump/10;
          precisao++;

        } else if (jump<0 && (-2*x*this.log10((rugosidade/(3.7*diametro))+(2.51/(reynolds*x))))<1) {

          pulou = true;
          inicial = x;
          jump = -jump/10;
          precisao++;
        }
      }
    }
    
    return sqrt(inicial);
  }
  float Reynolds(float massa_especifica, float velocidade, float diametro, float viscosidade_dinamica) {

    return massa_especifica*velocidade*diametro/viscosidade_dinamica;
  }
  float FatorMoody(float massa_especifica, float velocidade, float diametro, float viscosidade_dinamica, float rugosidade) {

    float reynolds = this.Reynolds(massa_especifica, velocidade, diametro, viscosidade_dinamica);

    if (reynolds<=2300) {
      return 64/reynolds;
    } else {
      return this.Colebrook(reynolds, diametro, rugosidade);
    }
  }
  float PerdaDeCargaTubo(float massa_especifica, float velocidade, float diametro, float viscosidade_dinamica, float rugosidade, float comprimento_tubo, float gravidade ) {
    return this.FatorMoody(massa_especifica, velocidade, diametro, viscosidade_dinamica, rugosidade)*comprimento_tubo*pow(velocidade, 2)/(2*gravidade*diametro);
  }
  int DistanciaPP(float x_1, float y_1, float x_2, float y_2) {

    float y = abs(y_1-y_2);
    float x = abs(x_1-x_2);

    return int(sqrt(pow(x, 2) + pow(y, 2)));
  }
  boolean MouseIn(float x1, float y1, float x2, float y2) {

    if (mouseX>=x1&&mouseX<=x2&&mouseY>=y1&&mouseY<=y2) {

      return true;
    } else {

      return false;
    }
  }
  float VirtParaReal(String eixo, float x) {
    if (eixo == "X") {
      return ((x+interfaceX.RetornaXrelativo())*FRAME_simulador.escala)+FRAME_simulador.x_ref;
    } else if (eixo == "Y") {
      return ((x+interfaceX.RetornaYrelativo())*FRAME_simulador.escala)+FRAME_simulador.y_ref;
    } else {
      return 0;
    }
  }
  boolean MouseInSimulador(float x1, float y1, float x2, float y2) {

    x1 = this.VirtParaReal("X", x1);
    x2 = this.VirtParaReal("X", x2);
    y1 = this.VirtParaReal("Y", y1);
    y2 = this.VirtParaReal("Y", y2);

    if (mouseX>=x1&&mouseX<=x2&&mouseY>=y1&&mouseY<=y2) {
      return true;
    } else {
      return false;
    }
  }

}