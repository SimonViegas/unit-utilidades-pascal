UNIT CRT_FCH; {versão 0.001}

INTERFACE {tudo que é visto pelas "estruturas" que o carregar!!!}

{ ***  CONSTANTES UNIVERSAIS ***}
CONST
  ENTER     = #13;
  BACKSPACE = #08;
  ESC       = #27;

{ ***  Sobre a UNIT ***}
procedure About;
{ *** Ajuda sobre essa Unit ***}
procedure HELP_CRT_FCH;
{ *** Da um pause no programa *** }
procedure Pause;
{ *** Formata o texto e a tela do Pascal *** }
procedure Formatar(corTexto, corFundo:byte);
{ *** ler um password *** }
function ReadPWD(tamanho:byte):string;
{ *** ler um password (e desce uma linha) *** }
function ReadPWDln(tamanho:byte):string;
{ *** dá um delay no pascal em milissegundos *** }
procedure aguardar(t :real);

IMPLEMENTATION {tudo que é visto EXCLUSIVAMENTE pela propria unit (e as
                               implementacoes das units declaradas na interface}
uses
  CRT,
  DOS;

{ ***  Sobre a UNIT ***}
procedure About;
  begin
  WriteLn;
  WriteLn(' Unit obtida no FCH - Forum do Clube do Hardware');
  WriteLn;
  WriteLn(' Name       : CRT_FCH                          ');
  WriteLn(' Author     : Simon Viegas, XXXXXX, XXXXX      ');
  WriteLn(' Description: Unit com algumas funcionalidades ');
  WriteLn(' Date       : 09/08/09 14:46                   ');
  WriteLn(' Copyright  : Forum Clube do Hardware          ');
  WriteLn;
  WriteLn(' EXECUTE O COMANDO HELP_CRT_FCH para abrir o Help da Unit');
  WriteLn;
  end;

{ *** Ajuda sobre essa Unit ***}
procedure HELP_CRT_FCH;
  begin
  WriteLn('{ ***  Sobre a UNIT ***}');
  WriteLn('procedure About;');
  WriteLn('{ *** Ajuda sobre essa Unit ***}');
  WriteLn('procedure HELP_CRT_FCH;');
  WriteLn('{ *** Da um pause no programa *** }');
  WriteLn('procedure Pause;');
  WriteLn('{ *** Formata o texto e a tela do Pascal *** }');
  WriteLn('procedure Formatar(corTexto, corFundo:byte);');
  WriteLn('{ *** ler um password *** }');
  WriteLn('function ReadPWD(tamanho:byte):string;');
  WriteLn('{ *** ler um password (e desce uma linha) *** }');
  WriteLn('function ReadPWDln(tamanho:byte):string;');
  pause;
  end;

{ *** Da um pause no prgrama *** }
procedure pause;
  begin
  WriteLn;
  TextAttr:=TextAttr+Blink;
  Write('Precione qualquer tecla para continuar');
  TextAttr:=TextAttr-Blink;
  ReadKey;
  end;

{ *** Formata o texto e a tela do Pacal *** }
procedure formatar(corTexto, corFundo:byte);
  begin
  TextColor(corTexto);
  TextBackGround(corFundo);
  end;

{ *** ler um password *** }
function readPWD(tamanho:byte):string;
  type
    T_Senha = Array [1..255] of Char;
  var
    caractere :char; {caractere lido pelo usuario}
    cont      :byte; {contador de teclas já lidas}
    senha_tmp :string;
    v_senha   :T_Senha;  {a senha em si}
    i         :byte;  {usado no for}
  begin
  cont:= 0; {zera o contador de caracteres já usados (é necessário)}
  Repeat
    caractere:=readkey; {ler a tecla digitada}
    case UpCase(caractere) of {UpCase retorna o caractere em maiusculo}
      {caso seja um alfanumérico}
      'A' .. 'Z',
      '0' .. '9'  : begin
                    if cont<tamanho then
                      begin
                      inc(cont); {o mesmo que cont:= cont + 1;}
                      v_senha[cont]:= caractere; {armazena o caracteres}
                      write('*'); {imprime um "*" (ocultando a senha)}
                      end;
                    end;
      {caso queira apagar uma linha}
      BACKSPACE   : begin
                    if cont>=1 then
                      begin
                      gotoxy(WhereX -1, WhereY); {posiciona uma coluna atrás}
                      write(' '); {"apaga" um caractere}
                      gotoxy(WhereX -1, WhereY); {posiciona uma coluna atrás}
                      dec(cont); {atualiza o contador} {dec(x) = x:=x-1;}
                      end;
                    end;
    end;{fim case}
  Until(caractere = ENTER){ or (cont > max)};
  {retorna a senha via function}
  senha_tmp:='';
  For i:= 1 to cont do
    senha_tmp:=senha_tmp+v_senha[i];
  readPWD:=senha_tmp;
  end;

{ *** ler um password (e desce uma linha) *** }
function ReadPWDln(tamanho:byte):string;
  begin
  ReadPWDln:=ReadPWD(tamanho);
  WriteLn;
  end;

{ *** dá um delay no pascal em milissegundos *** }
procedure aguardar(t :real);
  function timer :real;
    var
      hour,
      minute,
      second,
      sec100 :word;
    begin
    GetTime(hour, minute, second, sec100);
    {//acho que dá para otimizar essa fórmula abaixo!!!}
    timer := (hour * 3600.0 + minute * 60.0 + second) * 100.0 + 1.0 * sec100;
    end;
  var
    t1 :real;
  begin
  t1 := timer;
  repeat until timer > t1 + (100 * t) /1000;
  end;

begin
  ClrScr; {limpa a tela}
  Formatar(White,Black); {formata a tela}
  About; {exibe o "sobre" da unit}
  Pause; {da uma pause}
  ClrScr; {limpa a tela (logo após o programa que carregar essa UNIT será 'iniciado'}
end.