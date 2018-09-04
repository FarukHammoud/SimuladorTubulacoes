// Relatório de criação

// 16/10 - 3348 linhas de código
// 20/10 - 3969 linhas de código
// 27/10 - 4796 linhas de código

PImage fundo;
PImage lacit;
void setup() {

  data.materiais_lines = loadStrings("materiais.txt");
  data.fluidos_lines = loadStrings("fluidos.txt");

  size(1280, 720); 
  background(255, 0, 0);
  fundo = loadImage("fundo.png");
  lacit = loadImage("lacit.PNG");
  gerenciador.Tarefa("Ativa Frame Total");
  gerenciador.Tarefa("Ativa Frame Menu Superior");
  gerenciador.Tarefa("Ativa Frame Barra Lateral");
  gerenciador.Tarefa("Ativa Frame Barra Inferior");
  gerenciador.Tarefa("Ativa Frame Simulador");

  data.GetFluidos();
  data.GetMateriais();
}
void draw() {
  gerenciador.Atualizar();
  interfaceX.Search();
}