program neyavnaya_shema;
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
 teta,a,b,c,f,alfa,beta : array[1..n] of real;
 teta0,r,delta_tau,Bi,h,z,time,h_time,ksi,teta2,aaa : real;
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
   writeln(doc,h*(i-1),'     ',teta[i]:12:9,'');
  end;
 writeln(doc,h*(n-1),' 1');
 writeln(doc,'0',' 1');
 time:=0;

while time<=delta_tau*5000 do  
 begin
  time:=time+delta_tau; 
  
  for i:=1 to n do
   begin
    a[i]:=r;
    b[i]:=-1-2*r-z*delta_tau;
    c[i]:=r;
    f[i]:=-teta[i]-Q1*delta_tau;
   end;
  alfa[1]:= 1/(1+Bi*h);
  beta[1]:=0;
 
  for i:=2 to n do
   begin
    alfa[i]:=-a[i]/(b[i]+c[i]*alfa[i-1]);
    beta[i]:=(f[i]-c[i]*beta[i-1])/(b[i]+c[i]*alfa[i-1]);
   end;
  
  teta[n]:=beta[n-1]/(1-alfa[n-1]);
  
  for i:=n-1 downto 1 do
   begin
    teta[i]:=alfa[i]*teta[i+1]+beta[i];
   end;
   if time>counter*h_time then 
    begin
     for i:=1 to n do
      begin
      writeln(doc,h*(i-1),'  ', teta[i]:1:8, '     ', time );
       //writeln(doc,h*(i-1),'  teta[',i,']=', teta[i]:1:8, '  alfa[',i,']=', alfa[i]:1:8,'  beta[',i,']=', beta[i]:1:8,'  ', counter);
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