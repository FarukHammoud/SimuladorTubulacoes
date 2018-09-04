FrameSimulador FRAME_simulador = new FrameSimulador();

class FrameSimulador {

  //constante numero de objetos possiveis
  int cte = 100;

  //referencia 2D O(0,0)
  int x_ref = 300;
  int y_ref = 180;
  float escala=1;
  boolean habilita_scroll = true;

  //projeção

  String projecao = "ZX";

  //Project mode pontos 
  boolean project_mode = false;
  float[] project_mode_linha_x1 = new float[this.cte];
  float[] project_mode_linha_y1 = new float[this.cte];
  float[] project_mode_linha_x2 = new float[this.cte];
  float[] project_mode_linha_y2 = new float[this.cte];
  //profundidade do snap
  float[] project_mode_linha_z1 = new float[this.cte];
  float[] project_mode_linha_z2 = new float[this.cte];

  int project_mode_linhas=0;//indice

  //fluidos do sistema

  float gravidade = 9.81;
  float massa_especifica = 1000;//agua padrao
  float viscosidade_dinamica = 0.001;
  float rugosidade = 0.002;
  String fluido = "Agua";
  String material = "Concreto";
  String ambiente = "Residencial";
  float vazao_volumetrica = 0.05;//m cubico por segundo 

  float temperatura = 25.0;

  //modulo de criação
  int contagem_criador;

  String inCode="";
  String outCode="";

  float x_0=0;
  float y_0=0;
  float z_0=0;
  float x_1=0;
  float y_1=0;
  float z_1=0;


  float snap_x;
  float snap_y;
  float snap_z;

  boolean snaped = false;
  boolean snaped_point = false;//snap cartesiano


  //gerenciamento dos objetos

  int nOf_objetos = 0;
  int[] indice_local = new int[this.cte];
  String[] tipo = new String[this.cte];

  int nOf_tubos_retos = 0;
  int nOf_tubos_inclinados_horizontais = 0;
  int nOf_tubos_inclinados_verticais = 0;
  int nOf_reservatorios_abertos = 0;
  int nOf_bombas_centrifugas = 0;
  int nOf_anotacoes_projeto = 0;
  int nOf_anotacoes_simulador = 0;
  int nOf_linhas_projeto = 0;
  int nOf_linhas_simulador = 0;

  //dinamica do botao

  boolean clicado_esq = false;
  boolean clicado_dir = false;
  boolean pressionado_esq = false;
  boolean pressionado_dir = false;

  //anotacao (tmp)

  float x_ant=0;
  float y_ant=0;

  //fios de anotacao 
  float x_ant_1=0;
  float y_ant_1=0;
  float x_ant_2=0;
  float y_ant_2=0;

  int estado = 0;

  //funções
  boolean anotando = false;
  boolean calculando = false;
  //selecao
  boolean selecionando = false;
  boolean selecionando_2 = false;
  int objeto_selecionado = 0;
  //selecao dupla
  boolean selecionando_dupla = false;
  boolean selecionando_dupla_2 = false;
  int objeto_selecionado_1 = 0;
  int objeto_selecionado_2 = 0;

  void ProjectModeIn(boolean tubo, boolean valv, boolean bomb, boolean resv, int a, int b) {

    this.project_mode = true;
    interfaceX.mouse_click = false;
    //codigo criador(2D): 1P - um ponto; 2P - dois pontos; 2PdX - dois pontos variando x; 2PdY - dois pontos variando Y 
    if (tubo && a==0) {

      if (b==0) {//tubo horizontal

        this.inCode="2PdX";
        this.outCode="Tubo Reto";
        this.contagem_criador = 2;
      }
      if (b==1) {//tubo vertical
        this.inCode="2PdY";
        this.outCode="Tubo Reto";
        this.contagem_criador = 2;
      }
      if (b==2) {//inclinado ligação horizontal
        this.inCode="2P";
        this.outCode="Tubo Inclinado Horizontal";
        this.contagem_criador = 2;
      }
      if (b==3) {//inclinado ligação vertical
        this.inCode="2P";
        this.outCode="Tubo Inclinado Vertical";
        this.contagem_criador = 2;
      }
      if (b==4) {
      }
    }
    if (valv && a==0) {

      if (b==0) {
      }
      if (b==1) {
      }
      if (b==2) {
      }
      if (b==3) {
      }
      if (b==4) {
      }
    }
    if (bomb && a==0) {

      if (b==0) {
        this.inCode="1P";
        this.outCode="Bomba Centrifuga";
        this.contagem_criador = 1;
      }
      if (b==1) {
        this.inCode="1P";
        this.outCode="Bomba Em Linha";
        this.contagem_criador = 1;
      }
      if (b==2) {
      }
      if (b==3) {
      }
      if (b==4) {
      }
    }
    if (resv && a==0) {

      if (b==0) {
        this.inCode="1P";
        this.outCode="Reservatorio Aberto";
        this.contagem_criador = 1;
      }
      if (b==1) {
      }
      if (b==2) {
      }
      if (b==3) {
      }
      if (b==4) {
      }
    }
  }
  void ProjectModeOut(String outCode) {
    if (this.outCode == "Tubo Reto") {

      tubos.tubo_reto[nOf_tubos_retos].Setup(this.x_0, this.y_0, this.z_0, this.x_1, this.y_1, this.z_1);
      tubos.tubo_reto[nOf_tubos_retos].Pad();
      tubos.tubo_reto[nOf_tubos_retos].MudaDiametro(25.4);

      //gerenciamento dos obejtos
      this.indice_local[nOf_objetos] = nOf_tubos_retos;
      this.tipo[nOf_objetos] = "Tubo Reto";      

      this.nOf_tubos_retos++;
      this.nOf_objetos++;
    }
    if (this.outCode == "Tubo Inclinado Horizontal") {

      tubos.tubo_inclinado_horizontal[nOf_tubos_inclinados_horizontais].Setup(this.x_0, this.y_0, this.z_0, this.x_1, this.y_1, this.z_1);
      tubos.tubo_inclinado_horizontal[nOf_tubos_inclinados_horizontais].Pad();
      tubos.tubo_inclinado_horizontal[nOf_tubos_inclinados_horizontais].MudaDiametro(25.4);

      //gerenciamento dos obejtos
      this.indice_local[nOf_objetos] = nOf_tubos_inclinados_horizontais;
      this.tipo[nOf_objetos] = "Tubo Inclinado Horizontal";      

      this.nOf_tubos_inclinados_horizontais++;
      this.nOf_objetos++;
    }
    if (this.outCode == "Tubo Inclinado Vertical") {

      tubos.tubo_inclinado_vertical[nOf_tubos_inclinados_verticais].Setup(this.x_0, this.y_0, this.z_0, this.x_1, this.y_1, this.z_1);
      tubos.tubo_inclinado_vertical[nOf_tubos_inclinados_verticais].Pad();
      tubos.tubo_inclinado_vertical[nOf_tubos_inclinados_verticais].MudaDiametro(25.4);

      //gerenciamento dos obejtos
      this.indice_local[nOf_objetos] = nOf_tubos_inclinados_verticais;
      this.tipo[nOf_objetos] = "Tubo Inclinado Vertical";      

      this.nOf_tubos_inclinados_verticais++;
      this.nOf_objetos++;
    }
    if (this.outCode == "Reservatorio Aberto") {

      reservatorios.reservatorio_aberto[nOf_reservatorios_abertos].Setup(this.x_0, this.y_0, this.z_0);
      reservatorios.reservatorio_aberto[nOf_reservatorios_abertos].MudaDiametro(25.4);

      //gerenciamento dos obejtos
      this.indice_local[nOf_objetos] = nOf_reservatorios_abertos;
      this.tipo[nOf_objetos] = "Reservatorio Aberto";      

      this.nOf_reservatorios_abertos++;
      this.nOf_objetos++;
    }
    if (this.outCode == "Bomba Centrifuga") {

      bombas.bomba_centrifuga[nOf_bombas_centrifugas].Setup(this.x_0, this.y_0, this.z_0);
      bombas.bomba_centrifuga[nOf_bombas_centrifugas].MudaDiametroOut(25.4);
      bombas.bomba_centrifuga[nOf_bombas_centrifugas].MudaDiametroIn(25.4);

      //gerenciamento dos obejtos
      this.indice_local[nOf_objetos] = nOf_bombas_centrifugas;
      this.tipo[nOf_objetos] = "Bomba Centrifuga";      

      this.nOf_bombas_centrifugas++;
      this.nOf_objetos++;
    }
  }
  void GeraLinhas() {
    this.project_mode_linhas = 0;
    //tubos retos
    if (this.projecao == "ZX") {
      for (int a = 0; a<this.nOf_tubos_retos; a++) {
        this.project_mode_linha_x1[this.project_mode_linhas] = tubos.tubo_reto[a].x_0;
        this.project_mode_linha_x2[this.project_mode_linhas] = tubos.tubo_reto[a].x_1;
        this.project_mode_linha_y1[this.project_mode_linhas] = -tubos.tubo_reto[a].z_0;
        this.project_mode_linha_y2[this.project_mode_linhas] = -tubos.tubo_reto[a].z_1;
        //profundidade do snap
        this.project_mode_linha_z1[this.project_mode_linhas] = tubos.tubo_reto[a].y_0;
        this.project_mode_linha_z2[this.project_mode_linhas] = tubos.tubo_reto[a].y_1;
        this.project_mode_linhas++;
      }
      for (int a = 0; a<this.nOf_tubos_inclinados_horizontais; a++) {
        this.project_mode_linha_x1[this.project_mode_linhas] = tubos.tubo_inclinado_horizontal[a].x_0;
        this.project_mode_linha_x2[this.project_mode_linhas] = tubos.tubo_inclinado_horizontal[a].x_1;
        this.project_mode_linha_y1[this.project_mode_linhas] = -tubos.tubo_inclinado_horizontal[a].z_0;
        this.project_mode_linha_y2[this.project_mode_linhas] = -tubos.tubo_inclinado_horizontal[a].z_1;
        //profundidade do snap
        this.project_mode_linha_z1[this.project_mode_linhas] = tubos.tubo_inclinado_horizontal[a].y_0;
        this.project_mode_linha_z2[this.project_mode_linhas] = tubos.tubo_inclinado_horizontal[a].y_1;
        this.project_mode_linhas++;
      }
      for (int a = 0; a<this.nOf_tubos_inclinados_verticais; a++) {
        this.project_mode_linha_x1[this.project_mode_linhas] = tubos.tubo_inclinado_vertical[a].x_0;
        this.project_mode_linha_x2[this.project_mode_linhas] = tubos.tubo_inclinado_vertical[a].x_1;
        this.project_mode_linha_y1[this.project_mode_linhas] = -tubos.tubo_inclinado_vertical[a].z_0;
        this.project_mode_linha_y2[this.project_mode_linhas] = -tubos.tubo_inclinado_vertical[a].z_1;
        //profundidade do snap
        this.project_mode_linha_z1[this.project_mode_linhas] = tubos.tubo_inclinado_vertical[a].y_0;
        this.project_mode_linha_z2[this.project_mode_linhas] = tubos.tubo_inclinado_vertical[a].y_1;
        this.project_mode_linhas++;
      }
      for (int a = 0; a<this.nOf_reservatorios_abertos; a++) {
        this.project_mode_linha_x1[this.project_mode_linhas] = reservatorios.reservatorio_aberto[a].x;
        this.project_mode_linha_x2[this.project_mode_linhas] = reservatorios.reservatorio_aberto[a].x;
        this.project_mode_linha_y1[this.project_mode_linhas] = -reservatorios.reservatorio_aberto[a].z;
        this.project_mode_linha_y2[this.project_mode_linhas] = -reservatorios.reservatorio_aberto[a].z;
        //profundidade do snap
        this.project_mode_linha_z1[this.project_mode_linhas] = reservatorios.reservatorio_aberto[a].y;
        this.project_mode_linha_z2[this.project_mode_linhas] = reservatorios.reservatorio_aberto[a].y;
        this.project_mode_linhas++;
      }
      for (int a = 0; a<this.nOf_bombas_centrifugas; a++) {
        this.project_mode_linha_x1[this.project_mode_linhas] = bombas.bomba_centrifuga[a].x_0;
        this.project_mode_linha_x2[this.project_mode_linhas] = bombas.bomba_centrifuga[a].x_1;
        this.project_mode_linha_y1[this.project_mode_linhas] = -bombas.bomba_centrifuga[a].z_0;
        this.project_mode_linha_y2[this.project_mode_linhas] = -bombas.bomba_centrifuga[a].z_1;
        //profundidade do snap
        this.project_mode_linha_z1[this.project_mode_linhas] = bombas.bomba_centrifuga[a].y_0;
        this.project_mode_linha_z2[this.project_mode_linhas] = bombas.bomba_centrifuga[a].y_1;
        this.project_mode_linhas++;
      }
    }
    if (this.projecao == "ZY") {
      for (int a = 0; a<this.nOf_tubos_retos; a++) {
        this.project_mode_linha_x1[this.project_mode_linhas] = tubos.tubo_reto[a].y_0;
        this.project_mode_linha_x2[this.project_mode_linhas] = tubos.tubo_reto[a].y_1;
        this.project_mode_linha_y1[this.project_mode_linhas] = -tubos.tubo_reto[a].z_0;
        this.project_mode_linha_y2[this.project_mode_linhas] = -tubos.tubo_reto[a].z_1;
        //profundidade do snap
        this.project_mode_linha_z1[this.project_mode_linhas] = tubos.tubo_reto[a].x_0;
        this.project_mode_linha_z2[this.project_mode_linhas] = tubos.tubo_reto[a].x_1;
        this.project_mode_linhas++;
      }
      for (int a = 0; a<this.nOf_tubos_inclinados_horizontais; a++) {
        this.project_mode_linha_x1[this.project_mode_linhas] = tubos.tubo_inclinado_horizontal[a].y_0;
        this.project_mode_linha_x2[this.project_mode_linhas] = tubos.tubo_inclinado_horizontal[a].y_1;
        this.project_mode_linha_y1[this.project_mode_linhas] = -tubos.tubo_inclinado_horizontal[a].z_0;
        this.project_mode_linha_y2[this.project_mode_linhas] = -tubos.tubo_inclinado_horizontal[a].z_1;
        //profundidade do snap
        this.project_mode_linha_z1[this.project_mode_linhas] = tubos.tubo_inclinado_horizontal[a].x_0;
        this.project_mode_linha_z2[this.project_mode_linhas] = tubos.tubo_inclinado_horizontal[a].x_1;
        this.project_mode_linhas++;
      }
      for (int a = 0; a<this.nOf_tubos_inclinados_verticais; a++) {
        this.project_mode_linha_x1[this.project_mode_linhas] = tubos.tubo_inclinado_vertical[a].y_0;
        this.project_mode_linha_x2[this.project_mode_linhas] = tubos.tubo_inclinado_vertical[a].y_1;
        this.project_mode_linha_y1[this.project_mode_linhas] = -tubos.tubo_inclinado_vertical[a].z_0;
        this.project_mode_linha_y2[this.project_mode_linhas] = -tubos.tubo_inclinado_vertical[a].z_1;
        //profundidade do snap
        this.project_mode_linha_z1[this.project_mode_linhas] = tubos.tubo_inclinado_vertical[a].x_0;
        this.project_mode_linha_z2[this.project_mode_linhas] = tubos.tubo_inclinado_vertical[a].x_1;
        this.project_mode_linhas++;
      }
      for (int a = 0; a<this.nOf_reservatorios_abertos; a++) {
        this.project_mode_linha_x1[this.project_mode_linhas] = reservatorios.reservatorio_aberto[a].y;
        this.project_mode_linha_x2[this.project_mode_linhas] = reservatorios.reservatorio_aberto[a].y;
        this.project_mode_linha_y1[this.project_mode_linhas] = -reservatorios.reservatorio_aberto[a].z;
        this.project_mode_linha_y2[this.project_mode_linhas] = -reservatorios.reservatorio_aberto[a].z;
        //profundidade do snap
        this.project_mode_linha_z1[this.project_mode_linhas] = reservatorios.reservatorio_aberto[a].x;
        this.project_mode_linha_z2[this.project_mode_linhas] = reservatorios.reservatorio_aberto[a].x;
        this.project_mode_linhas++;
      }
      for (int a = 0; a<this.nOf_bombas_centrifugas; a++) {
        this.project_mode_linha_x1[this.project_mode_linhas] = bombas.bomba_centrifuga[a].y_0;
        this.project_mode_linha_x2[this.project_mode_linhas] = bombas.bomba_centrifuga[a].y_1;
        this.project_mode_linha_y1[this.project_mode_linhas] = -bombas.bomba_centrifuga[a].z_0;
        this.project_mode_linha_y2[this.project_mode_linhas] = -bombas.bomba_centrifuga[a].z_1;
        //profundidade do snap
        this.project_mode_linha_z1[this.project_mode_linhas] = bombas.bomba_centrifuga[a].x_0;
        this.project_mode_linha_z2[this.project_mode_linhas] = bombas.bomba_centrifuga[a].x_1;
        this.project_mode_linhas++;
      }
    }
    if (this.projecao == "XY") {
      for (int a = 0; a<this.nOf_tubos_retos; a++) {
        this.project_mode_linha_x1[this.project_mode_linhas] = tubos.tubo_reto[a].x_0;
        this.project_mode_linha_x2[this.project_mode_linhas] = tubos.tubo_reto[a].x_1;
        this.project_mode_linha_y1[this.project_mode_linhas] = -tubos.tubo_reto[a].y_0;
        this.project_mode_linha_y2[this.project_mode_linhas] = -tubos.tubo_reto[a].y_1;
        //profundidade do snap
        this.project_mode_linha_z1[this.project_mode_linhas] = tubos.tubo_reto[a].z_0;
        this.project_mode_linha_z2[this.project_mode_linhas] = tubos.tubo_reto[a].z_1;
        this.project_mode_linhas++;
      }
      for (int a = 0; a<this.nOf_tubos_inclinados_horizontais; a++) {
        this.project_mode_linha_x1[this.project_mode_linhas] = tubos.tubo_inclinado_horizontal[a].x_0;
        this.project_mode_linha_x2[this.project_mode_linhas] = tubos.tubo_inclinado_horizontal[a].x_1;
        this.project_mode_linha_y1[this.project_mode_linhas] = -tubos.tubo_inclinado_horizontal[a].y_0;
        this.project_mode_linha_y2[this.project_mode_linhas] = -tubos.tubo_inclinado_horizontal[a].y_1;
        //profundidade do snap
        this.project_mode_linha_z1[this.project_mode_linhas] = tubos.tubo_inclinado_horizontal[a].z_0;
        this.project_mode_linha_z2[this.project_mode_linhas] = tubos.tubo_inclinado_horizontal[a].z_1;
        this.project_mode_linhas++;
      }
      for (int a = 0; a<this.nOf_tubos_inclinados_verticais; a++) {
        this.project_mode_linha_x1[this.project_mode_linhas] = tubos.tubo_inclinado_vertical[a].x_0;
        this.project_mode_linha_x2[this.project_mode_linhas] = tubos.tubo_inclinado_vertical[a].x_1;
        this.project_mode_linha_y1[this.project_mode_linhas] = -tubos.tubo_inclinado_vertical[a].y_0;
        this.project_mode_linha_y2[this.project_mode_linhas] = -tubos.tubo_inclinado_vertical[a].y_1;
        //profundidade do snap
        this.project_mode_linha_z1[this.project_mode_linhas] = tubos.tubo_inclinado_vertical[a].z_0;
        this.project_mode_linha_z2[this.project_mode_linhas] = tubos.tubo_inclinado_vertical[a].z_1;
        this.project_mode_linhas++;
      }
      for (int a = 0; a<this.nOf_reservatorios_abertos; a++) {
        this.project_mode_linha_x1[this.project_mode_linhas] = reservatorios.reservatorio_aberto[a].x;
        this.project_mode_linha_x2[this.project_mode_linhas] = reservatorios.reservatorio_aberto[a].x;
        this.project_mode_linha_y1[this.project_mode_linhas] = -reservatorios.reservatorio_aberto[a].y;
        this.project_mode_linha_y2[this.project_mode_linhas] = -reservatorios.reservatorio_aberto[a].y;
        //profundidade do snap
        this.project_mode_linha_z1[this.project_mode_linhas] = reservatorios.reservatorio_aberto[a].z;
        this.project_mode_linha_z2[this.project_mode_linhas] = reservatorios.reservatorio_aberto[a].z;
        this.project_mode_linhas++;
      }
      for (int a = 0; a<this.nOf_bombas_centrifugas; a++) {
        this.project_mode_linha_x1[this.project_mode_linhas] = bombas.bomba_centrifuga[a].x_0;
        this.project_mode_linha_x2[this.project_mode_linhas] = bombas.bomba_centrifuga[a].x_1;
        this.project_mode_linha_y1[this.project_mode_linhas] = -bombas.bomba_centrifuga[a].y_0;
        this.project_mode_linha_y2[this.project_mode_linhas] = -bombas.bomba_centrifuga[a].y_1;
        //profundidade do snap
        this.project_mode_linha_z1[this.project_mode_linhas] = bombas.bomba_centrifuga[a].z_0;
        this.project_mode_linha_z2[this.project_mode_linhas] = bombas.bomba_centrifuga[a].z_1;
        this.project_mode_linhas++;
      }
    }
  }
  void Criador(String inCode) {

    //testa se ja foi selecionado todos os pontos
    if (this.contagem_criador==0) {
      this.project_mode=false;
    }
    if (inCode == "2PdX") {

      if (interfaceX.mouse_click) {
        interfaceX.mouse_click = false;
        if (this.contagem_criador==2) {
          if (!this.snaped) {
            if (this.snaped_point) {
              if (this.projecao == "ZX") {
                this.x_0 = this.snap_x;
                this.y_0 = 250;
                this.z_0 = this.snap_z;
              }
              if (this.projecao == "ZY") {
                this.x_0 = 250;
                this.y_0 = this.snap_y;
                this.z_0 = this.snap_z;
              }
              if (this.projecao == "XY") {
                this.x_0 = this.snap_x;
                this.y_0 = this.snap_y;
                this.z_0 = 250;
              }
            } else {
              if (this.projecao == "ZX") {
                this.x_0 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
                this.y_0 = 250;
                this.z_0 = -(((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
              }
              if (this.projecao == "ZY") {
                this.x_0 = 250;
                this.y_0 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
                this.z_0 = -(((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
              }
              if (this.projecao == "XY") {
                this.x_0 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
                this.y_0 = -(((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
                this.z_0 = 250;
              }
            }
          } else {
            this.x_0 = this.snap_x; 
            this.y_0 = this.snap_y;
            this.z_0 = this.snap_z;
          }
        }
        if (this.contagem_criador==1) {
          if (!this.snaped) {
            if (this.snaped_point) {
              if (this.projecao == "ZX") {
                this.x_1 = this.snap_x;
                this.y_1 = this.y_0;
                this.z_1 = this.z_0;
              }
              if (this.projecao == "ZY") {
                this.x_1 = this.x_0;
                this.y_1 = this.snap_y;
                this.z_1 = this.z_0;
              }
              if (this.projecao == "XY") {
                this.x_1 = this.snap_x;
                this.y_1 = this.y_0;
                this.z_1 = this.z_0;
              }
            } else {
              if (this.projecao == "ZX") {
                this.x_1 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
                this.y_1 = this.y_0;
                this.z_1 = this.z_0;
              }
              if (this.projecao == "ZY") {
                this.x_1 = this.x_0;
                this.y_1 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
                this.z_1 = this.z_0;
              }
              if (this.projecao == "XY") {
                this.x_1 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
                this.y_1 = this.y_0;
                this.z_1 = this.z_0;
              }
            }
          } else {
            if (this.projecao == "ZX") {
              this.x_1 = this.snap_x; 
              this.y_1 = this.y_0;
              this.z_1 = this.z_0;
            } else if (this.projecao == "ZY") {
              this.x_1 = this.x_0; 
              this.y_1 = this.snap_y;
              this.z_1 = this.z_0;
            } else if (this.projecao == "XY") {
              this.x_1 = this.snap_x; 
              this.y_1 = this.y_0;
              this.z_1 = this.z_0;
            }
          }
        }
        this.contagem_criador--;
        if (this.contagem_criador==0) {
          this.ProjectModeOut(this.outCode);
        }
      }
    }
    if (inCode == "2PdY") {
      if (interfaceX.mouse_click) {
        interfaceX.mouse_click = false;
        if (this.contagem_criador==2) {
          if (!this.snaped) {
            if (this.snaped_point) {
              if (this.projecao == "ZX") {
                this.x_0 = this.snap_x;
                this.y_0 = 250;
                this.z_0 = this.snap_z;
              }
              if (this.projecao == "ZY") {
                this.x_0 = 250;
                this.y_0 = this.snap_y;
                this.z_0 = this.snap_z;
              }
              if (this.projecao == "XY") {
                this.x_0 = this.snap_x;
                this.y_0 = this.snap_y;
                this.z_0 = 250;
              }
            } else {
              if (this.projecao == "ZX") {
                this.x_0 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
                this.y_0 = 250;
                this.z_0 = -(((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
              }
              if (this.projecao == "ZY") {
                this.x_0 = 250;
                this.y_0 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
                this.z_0 = -(((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
              }
              if (this.projecao == "XY") {
                this.x_0 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
                this.y_0 = -(((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
                this.z_0 = 250;
              }
            }
          } else {
            this.x_0 = this.snap_x; 
            this.y_0 = this.snap_y;
            this.z_0 = this.snap_z;
          }
        }
        if (this.contagem_criador==1) {
          if (!this.snaped) {           
            if (this.snaped_point) {
              if (this.projecao == "ZX") {
                this.x_1 = this.x_0;
                this.y_1 = this.y_0;
                this.z_1 = this.snap_z;
              }
              if (this.projecao == "ZY") {
                this.x_1 = this.x_0;
                this.y_1 = this.y_0;
                this.z_1 = this.snap_z;
              }
              if (this.projecao == "XY") {
                this.x_1 = this.x_0;
                this.y_1 = this.snap_y;
                this.z_1 = this.z_0;
              }
            } else {
              if (this.projecao == "ZX") {
                this.x_1 = this.x_0;
                this.y_1 = this.y_0;
                this.z_1 = -(((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
              }
              if (this.projecao == "ZY") {
                this.x_1 = this.x_0;
                this.y_1 = this.y_0;
                this.z_1 = -(((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
              }
              if (this.projecao == "XY") {
                this.x_1 = this.x_0;
                this.y_1 = -(((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
                this.z_1 = this.z_0;
              }
            }
          } else {
            if (this.projecao == "ZX") {
              this.x_1 = this.x_0; 
              this.y_1 = this.y_0;
              this.z_1 = this.snap_z;
            } else if (this.projecao == "ZY") {
              this.x_1 = this.x_0; 
              this.y_1 = this.y_0;
              this.z_1 = this.snap_z;
            } else if (this.projecao == "XY") {
              this.x_1 = this.x_0; 
              this.y_1 = this.snap_y;
              this.z_1 = this.z_0;
            }
          }
        }
        this.contagem_criador--;
        if (this.contagem_criador==0) {
          this.ProjectModeOut(this.outCode);
        }
      }
    }
    if (inCode == "2P") {
      if (interfaceX.mouse_click) {
        interfaceX.mouse_click = false;
        if (this.contagem_criador==2) {
          if (!this.snaped) {
            if (this.snaped_point) {
              if (this.projecao == "ZX") {
                this.x_0 = this.snap_x;
                this.y_0 = 250;
                this.z_0 = this.snap_z;
              }
              if (this.projecao == "ZY") {
                this.x_0 = 250;
                this.y_0 = this.snap_y;
                this.z_0 = this.snap_z;
              }
              if (this.projecao == "XY") {
                this.x_0 = this.snap_x;
                this.y_0 = this.snap_y;
                this.z_0 = 250;
              }
            } else {
              if (this.projecao == "ZX") {
                this.x_0 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
                this.y_0 = 250;
                this.z_0 = -(((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
              }
              if (this.projecao == "ZY") {
                this.x_0 = 250;
                this.y_0 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
                this.z_0 = -(((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
              }
              if (this.projecao == "XY") {
                this.x_0 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
                this.y_0 = -(((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
                this.z_0 = 250;
              }
            }
          } else {
            if (this.projecao == "ZX") {
              this.x_0 = this.snap_x; 
              this.y_0 = this.snap_y;
              this.z_0 = this.snap_z;
            } else if (this.projecao == "ZY") {
              this.x_0 = this.snap_x; 
              this.y_0 = this.snap_y;
              this.z_0 = this.snap_z;
            } else if (this.projecao == "XY") {
              this.x_0 = this.snap_x; 
              this.y_0 = this.snap_y;
              this.z_0 = this.snap_z;
            }
          }
        }
        if (this.contagem_criador==1) {
          if (!this.snaped) {
            if (this.snaped_point) {
              if (this.projecao == "ZX") {
                this.x_1 = this.snap_x;
                this.y_1 = this.y_0;
                this.z_1 = this.snap_z;
              }
              if (this.projecao == "ZY") {
                this.x_1 = this.x_0;
                this.y_1 = this.snap_y;
                this.z_1 = this.snap_z;
              }
              if (this.projecao == "XY") {
                this.x_1 = this.snap_x;
                this.y_1 = this.snap_y;
                this.z_1 = this.z_0;
              }
            } else {
              if (this.projecao == "ZX") {
                this.x_1 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
                this.y_1 = this.y_0;
                this.z_1 = -(((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
              }
              if (this.projecao == "ZY") {
                this.x_1 = this.x_0;
                this.y_1 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
                this.z_1 = -(((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
              }
              if (this.projecao == "XY") {
                this.x_1 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
                this.y_1 = -(((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
                this.z_1 = this.z_0;
              }
            }
          } else {
            if (this.projecao == "ZX") {
              this.x_1 = this.snap_x; 
              this.y_1 = this.y_0;
              this.z_1 = this.snap_z;
            } else if (this.projecao == "ZY") {
              this.x_1 = this.x_0; 
              this.y_1 = this.snap_y;
              this.z_1 = this.snap_z;
            } else if (this.projecao == "XY") {
              this.x_1 = this.snap_x; 
              this.y_1 = this.snap_y;
              this.z_1 = this.z_0;
            }
          }
        }
        this.contagem_criador--;
        if (this.contagem_criador==0) {
          this.ProjectModeOut(this.outCode);
        }
      }
    }
    if (inCode == "1P") {
      if (interfaceX.mouse_click) {
        interfaceX.mouse_click = false;

        if (this.contagem_criador==1) {
          if (!this.snaped) {
            if (this.snaped_point) {
              if (this.projecao == "ZX") {
                this.x_0 = this.snap_x;
                this.y_0 = 250;
                this.z_0 = this.snap_z;
              }
              if (this.projecao == "ZY") {
                this.x_0 = 250;
                this.y_0 = this.snap_y;
                this.z_0 = this.snap_z;
              }
              if (this.projecao == "XY") {
                this.x_0 = this.snap_x;
                this.y_0 = this.snap_y;
                this.z_0 = 250;
              }
            } else {
              if (this.projecao == "ZX") {
                this.x_0 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
                this.y_0 = 250;
                this.z_0 = -(((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
              }
              if (this.projecao == "ZY") {
                this.x_0 = 250;
                this.y_0 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
                this.z_0 = -(((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
              }
              if (this.projecao == "XY") {
                this.x_0 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
                this.y_0 = -(((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
                this.z_0 = 250;
              }
            }
          } else {
            this.x_0 = this.snap_x; 
            this.y_0 = this.snap_y;
            this.z_0 = this.snap_z;
          }
        }
        this.contagem_criador--;
        if (this.contagem_criador==0) {
          this.ProjectModeOut(this.outCode);
        }
      }
    }
    G_Snap();
  }
  void MovePixel(int novo_x, int novo_y) {

    interfaceX.x_relativo = int((-novo_x)/this.escala);
    interfaceX.y_relativo = int((400+novo_y)/this.escala);
  }
  void Anotacao() {
    char letra_final=' ';
    if (this.anotando) {
      if (mousePressed&&mouseButton == LEFT) {
        this.pressionado_esq = true;
      } else if (this.pressionado_esq) {
        this.pressionado_esq = false;
        this.clicado_esq = true;
        this.x_ant = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
        this.y_ant = (((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
        interfaceX.palavra = "";
      }
      if (this.estado == 1) {
        if (FRAME_simulador.project_mode == true) {
          stroke(0, 255, 255);
          line(((mouseX-this.x_ref)/this.escala), ((mouseY-this.y_ref)/this.escala), this.x_ant_1+interfaceX.RetornaXrelativo(), this.y_ant_1+interfaceX.RetornaYrelativo());
        } else {
          stroke(255, 255, 255);
          line(((mouseX-this.x_ref)/this.escala), ((mouseY-this.y_ref)/this.escala), this.x_ant_1+interfaceX.RetornaXrelativo(), this.y_ant_1+interfaceX.RetornaYrelativo());
        }
      }
      if (mousePressed&&mouseButton == RIGHT) {
        this.pressionado_dir = true;
      } else if (this.pressionado_dir) {
        this.pressionado_dir = false;
        if (this.estado == 0) {
          if (FRAME_simulador.project_mode) {  
            this.x_ant_1 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
            this.y_ant_1 = (((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
          } else {
            this.x_ant_1 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
            this.y_ant_1 = (((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
          }
          this.estado=1;
        } else {
          if (FRAME_simulador.project_mode) {  
            this.x_ant_2 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
            this.y_ant_2 = (((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
            anotacoes.linha_x_1_projeto[this.nOf_linhas_projeto] = this.x_ant_1;
            anotacoes.linha_y_1_projeto[this.nOf_linhas_projeto] = this.y_ant_1;
            anotacoes.linha_x_2_projeto[this.nOf_linhas_projeto] = this.x_ant_2;
            anotacoes.linha_y_2_projeto[this.nOf_linhas_projeto] = this.y_ant_2;
            this.nOf_linhas_projeto++;
          } else {
            this.x_ant_2 = ((mouseX-this.x_ref)/this.escala)-interfaceX.RetornaXrelativo();
            this.y_ant_2 = (((mouseY-this.y_ref)/this.escala)-interfaceX.RetornaYrelativo());
            anotacoes.linha_x_1_simulador[this.nOf_linhas_simulador] = this.x_ant_1;
            anotacoes.linha_y_1_simulador[this.nOf_linhas_simulador] = this.y_ant_1;
            anotacoes.linha_x_2_simulador[this.nOf_linhas_simulador] = this.x_ant_2;
            anotacoes.linha_y_2_simulador[this.nOf_linhas_simulador] = this.y_ant_2;
            this.nOf_linhas_simulador++;
          }

          //manda pras anotacoes
          this.estado = 0;
          this.anotando = false;
          FRAME_menu_superior.ferramenta_anotar.clicado = false;
        }
      }
      if (this.clicado_esq == true) {
        if (this.project_mode) {
          fill(0, 255, 255); 
          stroke(0, 255, 255);
        } else {
          fill(255, 255, 255); 
          stroke(255, 255, 255);
        }
        textSize(10);
        text(interfaceX.palavra, this.x_ant+interfaceX.RetornaXrelativo(), this.y_ant+interfaceX.RetornaYrelativo()); 

        strokeWeight(3);
        point(this.x_ant+interfaceX.RetornaXrelativo(), this.y_ant+interfaceX.RetornaYrelativo());
        if (interfaceX.palavra.length()>0) {
          letra_final = interfaceX.palavra.charAt((interfaceX.palavra.length()-1));
        }
        if (letra_final=='.') {
          if (this.project_mode) {
            anotacoes.anotacoes_projetos[this.nOf_anotacoes_projeto] = interfaceX.palavra; 
            anotacoes.anotacoes_projetos_x[this.nOf_anotacoes_projeto] = this.x_ant; 
            anotacoes.anotacoes_projetos_y[this.nOf_anotacoes_projeto]= this.y_ant; 
            anotacoes.anotacoes_projetos_projecao[this.nOf_anotacoes_projeto] = this.projecao; 
            this.nOf_anotacoes_projeto++;
          } else {
            anotacoes.anotacoes_simulador[this.nOf_anotacoes_simulador] = interfaceX.palavra; 
            anotacoes.anotacoes_simulador_x[this.nOf_anotacoes_simulador] = this.x_ant; 
            anotacoes.anotacoes_simulador_y[this.nOf_anotacoes_simulador] = this.y_ant; 
            anotacoes.anotacoes_simulador_projecao[this.nOf_anotacoes_simulador] = this.projecao; 
            this.nOf_anotacoes_simulador++;
          }
          this.clicado_esq = false;
          FRAME_menu_superior.ferramenta_anotar.clicado = false;
          this.anotando = false;
        }
      }
    }
  }
  void AtualizaProjecao() {
    if (FRAME_barra_lateral.caixa==1) {
      this.projecao = "ZX";
    }
    if (FRAME_barra_lateral.caixa==2) {
      this.projecao = "ZY";
    }
    if (FRAME_barra_lateral.caixa==3) {
      this.projecao = "XY";
    }
  }
  void Cores() {

    if (this.project_mode) {
      fill(255, 255, 255);
      stroke(130, 130, 130);
    } else {
      fill(0, 0, 250);
      stroke(0, 0, 0);
    }
  }
  void MatrixLigada() {
    //muda o interfaceX
    interfaceX.tarefa_letra[32]="Menos no Simulador";
    interfaceX.tarefa_letra[33]="Mais no Simulador";
    rect(301, 181, 958, 399);
    pushMatrix();
    translate(x_ref, y_ref);
    if (this.habilita_scroll) {  
      this.escala += interfaceX.RetornaScroll()/10;
      interfaceX.ZeraScroll();
    }
    if (this.escala>0.5) {
      scale(this.escala);
    } else {
      this.escala = 0.5;
      scale(this.escala);
    }
    //linhas de fundo
    for (int a = interfaceX.RetornaXrelativo()%50-50; a<(960/this.escala)+50; a+=50) {
      for (int b= interfaceX.RetornaYrelativo()%50-50; b<(400/this.escala)+50; b+=50) {
        line(float(a), float(b), float(a)+50, float(b));
        line(float(a), float(b), float(a), float(b)+50);
      }
    }

    G_Fora();// the out_side of the infinity box
  }
  void MatrixDesligada() {

    strokeWeight(1);
    stroke(0, 0, 0);
    textSize(12);
    popMatrix();
  }
  void ImprimeObjetos() {
    if (this.project_mode) {
      this.GeraLinhas();
      stroke(0, 0, 0);
      strokeWeight(5);
      for (int a =0; a<this.project_mode_linha_x1.length; a++) {

        line(this.project_mode_linha_x1[a]+interfaceX.RetornaXrelativo(), this.project_mode_linha_y1[a]+interfaceX.RetornaYrelativo(), this.project_mode_linha_x2[a]+interfaceX.RetornaXrelativo(), this.project_mode_linha_y2[a]+interfaceX.RetornaYrelativo());
      }

      this.Criador(this.inCode);
      anotacoes.ImprimeAnotacoes();
    } else {
      for (int a=0; a<this.nOf_objetos; a++) {
        if (this.tipo[a]=="Tubo Reto") {
          tubos.tubo_reto[this.indice_local[a]].Show();
          tubos.tubo_reto[this.indice_local[a]].Interacao();
        } else if (this.tipo[a]=="Tubo Inclinado Horizontal") {
          tubos.tubo_inclinado_horizontal[this.indice_local[a]].Show();
          tubos.tubo_inclinado_horizontal[this.indice_local[a]].Interacao();
        } else if (this.tipo[a]=="Tubo Inclinado Vertical") {
          tubos.tubo_inclinado_vertical[this.indice_local[a]].Show();
          tubos.tubo_inclinado_vertical[this.indice_local[a]].Interacao();
        } else if (this.tipo[a]=="Reservatorio Aberto") {
          reservatorios.reservatorio_aberto[this.indice_local[a]].Show();
          reservatorios.reservatorio_aberto[this.indice_local[a]].Interacao();
        } else if (this.tipo[a]=="Bomba Centrifuga") {
          bombas.bomba_centrifuga[this.indice_local[a]].Show();
          bombas.bomba_centrifuga[this.indice_local[a]].Interacao();
        }
      }
      anotacoes.ImprimeAnotacoes();
    }
  }
  void ImprimeModo() {
    //TEXTINHO NO CANTO
    if (this.project_mode) {
      fill(0, 0, 0);
      stroke(0, 0, 0);
      text("Modo Projeto", 1170, 200 );

      line(1250, 550, 1250, 570);
      line(1250-int(100*escala), 550, 1250-int(100*escala), 570);
      line(1250-int(100*escala), 560, 1250, 560);
      text("0.1 m = ", 1250 - int(100*escala)-55, 565);
    } else {

      fill(255, 255, 255);
      stroke(255, 255, 255);
      text("Modo Visualização", 1130, 200 );

      //escala

      line(1250, 550, 1250, 570);
      line(1250-int(100*escala), 550, 1250-int(100*escala), 570);
      line(1250-int(100*escala), 560, 1250, 560);
      text("0.1 m = ", 1250 - int(100*escala)-55, 565);
    }
    stroke(0,0,0);
  }
  void Selecao() {

    if (this.selecionando) {
      for (int a =0; a<this.nOf_objetos; a++) {

        if (this.tipo[a] == "Reservatorio Aberto") {
          if (reservatorios.reservatorio_aberto[this.indice_local[a]].TestaSelecao()) {

            controladora.Selecionar(-1);
            controladora.Selecionar(a);
            controladora.GeraTrilha(a);
            //controladora.ImprimeTrilha();
            this.selecionando = false;
            this.objeto_selecionado = a;
            this.selecionando_2 = true;
            interfaceX.setas_int = 0;
          }
        }
      }
    } else if (selecionando_2) {
      if (reservatorios.reservatorio_aberto[FRAME_simulador.indice_local[controladora.objeto_trilha[0]]].x <= reservatorios.reservatorio_aberto[FRAME_simulador.indice_local[controladora.objeto_trilha[controladora.nOf_objetos_trilha-1]]].x) {
        interfaceX.tarefa_letra[28] = "Setas -";
        interfaceX.tarefa_letra[29] = "Setas +";
      } else {
        interfaceX.tarefa_letra[28] = "Setas +";
        interfaceX.tarefa_letra[29] = "Setas -";
      }
      controladora.Selecionar(-1);
      if (interfaceX.setas_int<0) {
        interfaceX.setas_int=0;
      }
      if (interfaceX.setas_int>controladora.nOf_objetos_trilha-1) {
        interfaceX.setas_int=controladora.nOf_objetos_trilha-1;
      }
      controladora.Selecionar(controladora.objeto_trilha[interfaceX.setas_int]);
      this.objeto_selecionado = controladora.objeto_trilha[interfaceX.setas_int];
    }
  }
  void SelecaoDupla() {


    if (this.selecionando_dupla) {
      for (int a =0; a<this.nOf_objetos; a++) {

        if (this.tipo[a] == "Reservatorio Aberto") {
          if (reservatorios.reservatorio_aberto[this.indice_local[a]].TestaSelecao()) {

            controladora.Selecionar(-1);
            controladora.Selecionar(a);
            //controladora.ImprimeTrilha();
            this.selecionando_dupla = false;
            this.objeto_selecionado_1 = a;
            this.selecionando_dupla_2 = true;
          }
        }
      }
    } else if (selecionando_dupla_2) {
      for (int a =0; a<this.nOf_objetos; a++) {

        if (this.tipo[a] == "Reservatorio Aberto"&& a!= objeto_selecionado_1) {
          if (reservatorios.reservatorio_aberto[this.indice_local[a]].TestaSelecao()) {

            controladora.Selecionar(a);
            //controladora.ImprimeTrilha();
            this.selecionando_dupla_2 = false;
            this.objeto_selecionado_2 = a;
          }
        }
      }
    }
  }
  void Calcular() {

    if (this.calculando && !this.selecionando_dupla && !this.selecionando_dupla_2) {

      if (this.tipo[this.objeto_selecionado_1]=="Reservatorio Aberto"&&this.tipo[this.objeto_selecionado_2]=="Reservatorio Aberto") {


        controladora.GeraTrilha(this.objeto_selecionado_1);
        if (controladora.objeto_trilha[controladora.nOf_objetos_trilha-1]==this.objeto_selecionado_2) {
          this.calculando = false;  
          FRAME_menu_superior.calcular = true;
        } else {
          FRAME_barra_inferior.InstalaTemplate("Erro: Reservatorios Não Fazem Parte Da Mesma Trilha");
          this.calculando = false;
        }
      } else {
        FRAME_barra_inferior.InstalaTemplate("Erro: Reservatorios Não Selecionados");
        this.calculando = false;
      }
    }
  }
  void Show() {

    this.AtualizaProjecao();
    this.Cores();
    this.MatrixLigada();

    this.ImprimeObjetos();
    this.Anotacao(); 
    this.Selecao();
    this.SelecaoDupla();
    this.Calcular();

    this.MatrixDesligada();
    this.ImprimeModo();
  }
}