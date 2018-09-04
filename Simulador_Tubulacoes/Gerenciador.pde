Gerenciador gerenciador = new Gerenciador(0);

class Gerenciador {

  boolean[] frame = new boolean[20];

  Gerenciador(int new_frame) {

    for (int a = 0; a<20; a++) {
      this.frame[a] = false;
    }
  }
  void Atualizar() {

    if (this.frame[0]) {// total

      FRAME_simulador.Show();
    }
    if (this.frame[1]) {

      FRAME_total.Show();
    } 
    if (this.frame[2]) {
      FRAME_barra_lateral.Show();
    } 
    if (this.frame[3]) {
      FRAME_barra_inferior.Show();
    } 
    if (this.frame[4]) {
      FRAME_menu_superior.Show();
    } 
    if (this.frame[5]) {
    } 
    if (this.frame[6]) {
    } 
    if (this.frame[7]) {
    } 
    if (this.frame[8]) {
    } 
    if (this.frame[9]) {
    } 
    if (this.frame[10]) {
    } 
    if (this.frame[11]) {
    } 
    if (this.frame[12]) {
    } 
    if (this.frame[13]) {
    } 
    if (this.frame[14]) {
    } 
    if (this.frame[15]) {
    } 
    if (this.frame[16]) {
    } 
    if (this.frame[17]) {
    } 
    if (this.frame[18]) {
    } 
    if (this.frame[19]) {
    }
  }
  void Tarefa(String tarefa) {
    if (tarefa == "") {
      //tarefa inf\:0 não faz nada
    } else if (tarefa == "Ativa Frame Total") {
      gerenciador.frame[1]=true;
    } else if (tarefa == "Ativa Frame Menu Superior") {
      gerenciador.frame[4]=true;
    } else if (tarefa == "Ativa Frame Barra Lateral") {
      gerenciador.frame[2]=true;
    } else if (tarefa == "Ativa Frame Barra Inferior") {
      gerenciador.frame[3]=true;
    } else if (tarefa == "Sobe Barra Inferior") {
      FRAME_barra_inferior.ShowUp();
    } else if (tarefa == "Desce Barra Inferior") {
      FRAME_barra_inferior.ShowDown();
    } else if (tarefa == "Ativa Frame Simulador") {
      gerenciador.frame[0]=true;
    } else if (tarefa == "Menos no Simulador") {
      FRAME_simulador.escala+=0.1;
    } else if (tarefa == "Mais no Simulador") {
      FRAME_simulador.escala-=0.1;
    } else if (tarefa == "Editar Ambiente") {
      FRAME_barra_inferior.InstalaTemplate("Editar Ambiente");
    } else if (tarefa == "Editar Fluido") {
      FRAME_barra_inferior.InstalaTemplate("Editar Fluido");
    } else if (tarefa == "Editar Vazão") {
      FRAME_barra_inferior.InstalaTemplate("Editar Vazão");
    } else if (tarefa == "Editar Material") {
      FRAME_barra_inferior.InstalaTemplate("Editar Material");
    } else if (tarefa == "Selecionar") {
      FRAME_barra_inferior.InstalaTemplate("Selecionar");
      FRAME_simulador.selecionando = true;
    } else if (tarefa == "  Calcular") {
      FRAME_barra_inferior.InstalaTemplate("Calcular");
      FRAME_simulador.selecionando_dupla = true;
      FRAME_simulador.calculando = true;
    } else if (tarefa == "  Simular") {
      FRAME_barra_inferior.InstalaTemplate("Simular");
    } else if (tarefa == "   Anotar") {
      FRAME_barra_inferior.InstalaTemplate("Anotar");
      FRAME_simulador.anotando = true;
    } else if (tarefa == "Setas +") {
      interfaceX.setas_int++;
    } else if (tarefa == "Setas -") {
      interfaceX.setas_int--;
    } else if (tarefa == "") {
    }
  }
}