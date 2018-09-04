Interface interfaceX = new Interface();
class Interface {

  String palavra="";
  float scroll = 10.0;
  int setas_int = 0;

  int x_ref = 0;
  int y_ref = 0;
  int x_relativo =35;
  int y_relativo =165;

  String[] tarefa_letra = new String[40];

  boolean mouse_click = false;

  Interface() {
    for (int a =0; a<40; a++) {
      this.tarefa_letra[a]="";
    }
  }
  void ScrollPlus() {
    scroll++;
  }
  void ScrollMinus() {
    scroll--;
  }
  void DeletaString() {
    this.palavra="";
  }
  int RetornaXrelativo() {
    return this.x_relativo;
  }  
  int RetornaYrelativo() {
    return this.y_relativo;
  }
  String RetornaString() {
    return this.palavra;
  }
  float RetornaScroll() {
    return this.scroll;
  }
  void ZeraScroll() {
    this.scroll = 0;
  }
  void Search() {
    if (keyPressed) {
      keyPressed = false;
      if ((key>='a'&&key<='z')||key==' '||key=='.'||(key>='A'&&key<='Z')||(key>='0'&&key<='9')) {
        this.palavra += str(key);
      }
      if ((key>='0'&&key<='9')) {
        if (int(key)-48<=FRAME_simulador.nOf_objetos) {
          controladora.ProcuraObjetosConectados(int(key)-48);
          if (controladora.objetos_encontrados==1) {
            println("Objeto Encontrado :"+controladora.objeto_conectado[0]);
          }
          if (controladora.objetos_encontrados==2) {
            println("Objeto Encontrado :"+controladora.objeto_conectado[0]); 
            println("Objeto Encontrado :"+controladora.objeto_conectado[1]);
          }
        }
      }
      if (key == ' ') {
        gerenciador.Tarefa(this.tarefa_letra[0]);
      } else if (key == 'a'||key == 'A') {
        gerenciador.Tarefa(this.tarefa_letra[1]);
      } else if (key == 'b'||key == 'B') {
        gerenciador.Tarefa(this.tarefa_letra[2]);
      } else if (key == 'c'||key == 'C') {
        gerenciador.Tarefa(this.tarefa_letra[3]);
      } else if (key == 'd'||key == 'D') {
        gerenciador.Tarefa(this.tarefa_letra[4]);
      } else if (key == 'e'||key == 'E') {
        gerenciador.Tarefa(this.tarefa_letra[5]);
      } else if (key == 'f'||key == 'F') {
        gerenciador.Tarefa(this.tarefa_letra[6]);
      } else if (key == 'g'||key == 'G') {
        gerenciador.Tarefa(this.tarefa_letra[7]);
      } else if (key == 'h'||key == 'H') {
        gerenciador.Tarefa(this.tarefa_letra[8]);
      } else if (key == 'i'||key == 'I') {
        gerenciador.Tarefa(this.tarefa_letra[9]);
      } else if (key == 'j'||key == 'J') {
        gerenciador.Tarefa(this.tarefa_letra[10]);
      } else if (key == 'k'||key == 'K') {
        gerenciador.Tarefa(this.tarefa_letra[11]);
      } else if (key == 'l'||key == 'L') {
        gerenciador.Tarefa(this.tarefa_letra[12]);
      } else if (key == 'm'||key == 'M') {
        FRAME_simulador.MovePixel(-70, -70);
        gerenciador.Tarefa(this.tarefa_letra[13]);
      } else if (key == 'n'||key == 'N') {
        gerenciador.Tarefa(this.tarefa_letra[14]);
      } else if (key == 'o'||key == 'O') {
        gerenciador.Tarefa(this.tarefa_letra[15]);
      } else if (key == 'p'||key == 'P') {
        gerenciador.Tarefa(this.tarefa_letra[16]);
      } else if (key == 'q'||key == 'Q') {
        gerenciador.Tarefa(this.tarefa_letra[17]);
      } else if (key == 'r'||key == 'R') {
        gerenciador.Tarefa(this.tarefa_letra[18]);
      } else if (key == 's'||key == 'S') {
        gerenciador.Tarefa(this.tarefa_letra[19]);
      } else if (key == 't'||key == 'T') {
        gerenciador.Tarefa(this.tarefa_letra[20]);
      } else if (key == 'u'||key == 'U') {
        gerenciador.Tarefa(this.tarefa_letra[21]);
      } else if (key == 'v'||key == 'V') {
        gerenciador.Tarefa(this.tarefa_letra[22]);
      } else if (key == 'x'||key == 'X') {
        gerenciador.Tarefa(this.tarefa_letra[23]);
      } else if (key == 'w'||key == 'W') {
        gerenciador.Tarefa(this.tarefa_letra[24]);
      } else if (key == 'y'||key == 'Y') {
        gerenciador.Tarefa(this.tarefa_letra[25]);
      } else if (key == 'z'||key == 'Z') {
        gerenciador.Tarefa(this.tarefa_letra[26]);
      } 
      if (keyCode == DOWN) {
        gerenciador.Tarefa(this.tarefa_letra[27]);
      } else if (keyCode == LEFT) {
        gerenciador.Tarefa(this.tarefa_letra[28]);
      } else if (keyCode == RIGHT) {
        gerenciador.Tarefa(this.tarefa_letra[29]);
      } else if (keyCode == UP) {
        gerenciador.Tarefa(this.tarefa_letra[30]);
      } else if (keyCode == ENTER) {
        gerenciador.Tarefa(this.tarefa_letra[31]);
      } else if (key == '+') {
        gerenciador.Tarefa(this.tarefa_letra[32]);
      } else if (key == '-') {
        gerenciador.Tarefa(this.tarefa_letra[33]);
      }
      if (key==DELETE) {
        gerenciador.Tarefa(this.tarefa_letra[34]);
        this.palavra="";
      }
      if (key==BACKSPACE) {
        gerenciador.Tarefa(this.tarefa_letra[35]);
        if (this.palavra.length() > 0) {
          this.palavra = this.palavra.substring(0, this.palavra.length() - 1);
        }
      }
      if (this.palavra.equals("sobe")||this.palavra.equals("SOBE")) {
        gerenciador.Tarefa("Sobe Barra Inferior");
        this.palavra = "";
      }
      if (this.palavra.equals("desce")||this.palavra.equals("DESCE")) {
        gerenciador.Tarefa("Desce Barra Inferior");
        this.palavra = "";
      }
      if (key=='a') {
        //FRAME_simulador.project_mode = false;//temporariamente desativado
      }
    }
  }
}

void mousePressed() {
  if (calculo.MouseIn(301, 181, 301+958, 181+399)) {
    interfaceX.x_ref=mouseX;
    interfaceX.y_ref=mouseY;
  }
}
void mouseDragged() {

  if (calculo.MouseIn(301, 181, 301+958, 181+399)) {
    interfaceX.x_relativo+=(mouseX-interfaceX.x_ref);
    interfaceX.y_relativo+=(mouseY-interfaceX.y_ref);
    interfaceX.x_ref=mouseX;
    interfaceX.y_ref=mouseY;
  }
}
void mouseClicked() {

  if (calculo.MouseIn(301, 181, 301+958, 181+399)) {
    interfaceX.mouse_click = true;
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e>0) {
    interfaceX.ScrollPlus();
  } else {
    interfaceX.ScrollMinus();
  }
}