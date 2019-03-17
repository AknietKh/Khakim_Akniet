program yavnaya_shema;
const 
n=11;
l=1; //длина стержня
//Rad=1; //толщина стержня
//alpha=1; //коэффициент теплообмена
//lamda=0.698; //коэффициент теплопроводности для стекла (оконного) = 0,698-0,814
//ro=2500; //плотность стекла (оконного)
//c=0.840; //удельная теплоемкость стекла (оконного)
Q1=1; //интенсивонсть источников теплообмена

var
 i,counter:integer;
 teta,teta1 : array[1..n] of real;
 teta2, time,teta0,r,delta_tau,Bi,h,z,h_time,ksi,aaa : real;
 doc:text;

begin
 assign(doc,'calculation results.txt');
 rewrite(doc);
 aaa:=0.0;
 counter:=1; 
 h_time:=0.02; 
 r:=0.4; 
 h:=l/(n-1); 
 delta_tau:=r*h*h;  
 teta0:=1 ; 
 Bi:=10; {(alpha*l)/lamda;}
 z:=0;{(2*alpha*l*l)/(Rad*lamda);}
 
 
 for i:=1 to n do
  begin
   teta[i]:=teta0;
   writeln(doc,h*(i-1),'     ',teta[i]:6:4,'');
  end;
 writeln(doc,h*(n-1),' 1');
 writeln(doc,'0',' 1');
 
 teta[1]:=teta[2]/(Bi*h+1);
 teta[n]:=teta[n-1];
 time:=0;

while (time<=delta_tau*5000) do 
 begin
  time:=time+delta_tau;
  
  for i:=2 to n-1 do 
   begin
    teta1[i]:=r*teta[i+1]+(1-2*r-z*delta_tau)*teta[i]+r*teta[i-1]+Q1*delta_tau;
   end;
   
  teta1[1]:=teta1[2]/(Bi*h+1);
  teta1[n]:=teta1[n-1];
  
  teta:=teta1;
  
  if time>counter*h_time then
    begin
     for i:=1 to n do
      begin
       writeln(doc,h*(i-1),'  ', teta[i]:1:8, '     ', time);
       //writeln(doc,h*(i-1),'  teta[',i,']=', teta[i]:1:8, '             ', counter);
      end;
     writeln (doc,h*(n-1),' ',aaa);
     writeln (doc,h*0,' ',aaa);
     counter:=counter+1;
     writeln(counter);
    end;
  end; 
  for i:=1 to n-1 do
    begin
     ksi:=h*i;
     teta2 := -(ksi*ksi)/2 +ksi +1/Bi;
     writeln(doc,ksi,'  ',teta2);
    end;
 close(doc);
end.