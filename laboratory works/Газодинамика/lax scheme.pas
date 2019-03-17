program laba;
const
N = 1000;

var
i, j, L, counter: integer;
a, h, tau, r, x, t, h_time: real;
Fi : array[0..N] of real;
u_old, u: array[0..N] of real;
doc:text;

function psi(t: real): real;
begin
psi := 1.0; //Н.У.
end;

begin
  assign(doc,'result_1_a=const_L=10_r=0.1.txt'); //запись в файл
  rewrite(doc);
  L := 10;
  h := L / N;				//шаг по пространству
  r := 0.1;				//число Куранта
  a := 1/3;
  tau := r*h/a; 		//шаг по времени
  x := 0;
  t := 0;
  counter := 1; // счетчик для записи
  h_time := 12; // шаг записи

  //Г.У.
  for j := 0 to N do
    begin
      if x <= 0.2 then
        begin
          Fi[j] := 1 + sin(5*3.14*j*h);
        end;
      if x > 0.2 then
        begin
          Fi[j] := 1;
        end;
      x := x + h;
      u_old[j] := Fi[j];
      writeln(doc,'По оси х[',j,']: ', h * j, '  ', 'U: ', u_old[j],'   ', ' По оси t:', t);
    end;
    writeln(doc, h*(N),' 1');
    writeln(doc,'0',' 1');
    writeln(doc, '  ');

  while (t < tau * 12000) do // t = tau * масштаб - время протекания процесса
    begin
      t := t + tau;
      u[0] := psi(t); // psi[i] = 1 
      for j := 1 to N - 1 do //расчет на новом временном шаге
        begin
          u[j] := 0.5 * (u_old[j + 1] + u_old[j - 1]) - 0.5 * r * (u_old[j + 1] -  u_old[j - 1]); // схема лакса на новом временном слое
          u[N] := u_old[N] - r * (u_old[N] - u_old[N - 1]);//схема правый уголок для расчета крайних точек
        end;
      for j := 0 to N do
        begin
          u_old[j] := u[j];
        end;
      if t > h_time*counter then // запись каждой момент времени h_time
        begin
          for j := 0 to N do
            begin
              writeln(doc,'По оси х[',j,']: ', h * j, '  ', 'U: ', u_old[j],'   ', ' По оси t:', t);
            end;
            writeln (doc,'По оси х[',N,']: ', h*(N),'       ', 'По оси t: ', 1);
            writeln (doc,'По оси х[',0,']: ', h*0,'         ', 'По оси t: ', 1);
            writeln(doc, '');
            counter:=counter+1;
        end;  
    end;
  write('successful recording');
end.