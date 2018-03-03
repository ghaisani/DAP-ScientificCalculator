{File : KalkulatorScientific.pas}
{Desc : menghitung bilangan inputan dari user}
{Date : 7 April 2016}

program myCalculator;
uses crt,math;
const
        phi: real = 3.1415926535897932384626433832795;
        e: real =2.718281828459045235360287471352;
type
        tab_int=array[1..50] of real;
        tab_str=array[1..10] of string;
var
        Tab: tab_int;
        TOp: tab_str;
        tmp,idx,konv,j,i,ra,ro,sm1,sm2:integer;
        tmp_p: real;
        radeg,derajat,der,arsin,arcos,artan : real;
        //mesin abstrak
        CI:integer;
        pitachar: string;
        CC: char;


  procedure tampilan();
  {I.S : screen masih kosong
   F.S : screen sudah ada tampilan}
  begin
        writeln;
        for i := 1 to 18 do
          write(' ');
        textcolor(9);write('myCalculator - Kalkulator SCIENTIFIC');
        writeln;

        //kotak margin
        textcolor(lightmagenta);write('É');
        for i:=1 to 75 do
          begin
            write('Í');
          end;
        write('»');
        writeln;
        for j:=1 to 20 do
          begin
            write('º');
            for i:=1 to 75 do
              write(' ');
            writeln('º');
          end;
        write('È');
        for i:=1 to 75 do
          begin
            write('Í');
          end;
        write('¼');
        // end kotak margin

        // kotak operasi
        gotoxy(3,5);
        textcolor(lightblue);write('Ú');
        textcolor(lightmagenta);write(' Operasi yang dapat dilakukan :');
        textcolor(lightblue);
        for i:=1 to 40 do
          begin
            write('Ä');
          end;
        write('¿');
        writeln;
        for j:=1 to 7 do
          begin
            gotoxy(3,j+5);
            write('Ý');
            for i:=1 to 71 do
              write(' ');
            writeln('|');
          end;
        gotoxy(3,j+6);
        write('À');
        for i:=1 to 71 do
          begin
            write('Ä');
          end;
        write('Ù');
        // isi kotak operasi
        gotoxy(5,6);
        textcolor(white);
        writeln('Standar :   Trigonometri :   Invers :       Operasi lain :   Aksi :');
        gotoxy(5,7);
        writeln(' x+y=       sind(x)=        arcsind(x)=    ln(x)=          Keluar');
        gotoxy(5,8);
        writeln(' x-y=       cosd(x)=        arccosd(x)=    log(x)=        ');
        gotoxy(5,9);
        writeln(' x*y=       tand(x)=        arctand(x)=    phi=           ');
        gotoxy(5,10);
        writeln(' x/y=       sinr(x)=        arcsinr(x)=                    ');
        gotoxy(5,11);
        writeln(' x^y=       cosr(x)=        arccosr(x)=');
        gotoxy(5,12);
        writeln('             tanr(x)=        arctanr(x)=');
        // end kotak operasi

        // kotak aksi
        gotoxy(3,20);
        textcolor(lightblue);write('Ú');
        textcolor(lightmagenta);write(' Aksi Selanjutnya :');
        textcolor(lightblue);
        for i:=1 to 52 do
          begin
            write('Ä');
          end;
        write('¿');
        writeln;
        for j:=1 to 3 do
          begin
            gotoxy(3,j+20);
            write('Ý');
            for i:=1 to 71 do
              write(' ');
            writeln('|');
          end;
        gotoxy(3,j+20);
        write('À');
        for i:=1 to 71 do
          begin
            write('Ä');
          end;
        write('Ù');
        // end kotak aksi
  end;

  function jml(a,b:real):real;
  {desc : menjumlahkan bilangan a dengan bilangan b}
  begin
    jml:=a+b;
  end;

  function krg(a,b:real):real;
  {desc : bilangan a dikurangi dengan bilangan b}
  begin
    krg:=a-b;
  end;

  function kali(a,b:real):real;
  {desc : mengalikan bilangan a dengan bilangan b}
  begin
    kali:=a*b;
  end;

  function bagi(a,b:real):real;
  {desc : membagi bilangan a dengan bilangan b}
  begin
    bagi:=a/b;
  end;

  procedure rumus();
  {I.S : rumus dasar trigonometri belum dibentuk
   F.S : rumus dasar trigonometri sudah dibentuk}
  begin
    derajat := 180/Tab[1];
    radeg:=phi/derajat;
    der:=180/phi;
    arsin:=arcsin(Tab[1])*der;
    arcos:=arccos(Tab[1])*der;
    artan:=arctan(Tab[1])*der;
  end;

  procedure move(a:integer);
  {I.S : masih ada baris yang kosong dalam tabel setelah eksekusi operasi
   F.S : mengganti baris yang kosong dalam tabel dengan nilai yang ada di baris berikutnya}
  var
    x: integer;
  begin
    if (ra>ro) then
      x:=ra
    else
      x:=ro;
    for i:=a+1 to x do
     begin
      Tab[i]:=Tab[i+1];
      TOp[i-1]:=TOp[i];
     end;
    ra:=ra-1;
    ro:=ro-1;
  end;

  procedure searchx(T:tab_str;x:string);
  {mencari nilai dalam suatu tabel dengan metode sequential search
   I.S : indeks dari nilai yang dicari dalam tabel belum ditemukan
   F.S : indeks dari nilai yang dicari ditemukan atau 0 jika tidak ditemukan}
  var
        i: integer;
  begin
    i:=1;
    while ((i<ro) and (T[i]<>x)) do
      begin
        i:=i+1;
      end;
    if T[i]=x then
      idx:=i
    else
      idx:=0;
  end;

  procedure cariDerajat();
  {mencari derajat tertinggi dari operasi pangkat, perkalian, pembagian, penjumlahan, pengurangan sekaligus eksekusi bilangan dan konversi
   I.S : derajat tertinggi dalam tabel operasi belum ditemukan
   F.S : derajat tertinggi ditemukan dan langsung dieksekusi}
  begin
      searchx(TOp,'^');
       if (idx=0) then
        begin
         searchx(TOp,'*');
         if (idx=0) then
          begin
           searchx(TOp,'/');
           if (idx=0) then
            begin
             searchx(TOp,'+');
             if (idx=0) then
              begin
               searchx(TOp,'-');
               if (idx=0) then
                begin
                 case TOp[1] of
                   'sind'    : begin rumus();Tab[1]:=sin(radeg);Tab[2]:=0; end;
                   'cosd'    : begin rumus();Tab[1]:=cos(radeg);Tab[2]:=0; end;
                   'tand'    : begin rumus();Tab[1]:=tan(radeg);Tab[2]:=0; end;
                   'sinr'    : begin rumus();Tab[1]:=sin(Tab[1]);Tab[2]:=0; end;
                   'cosr'    : begin rumus();Tab[1]:=cos(Tab[1]);Tab[2]:=0; end;
                   'tanr'    : begin rumus();Tab[1]:=tan(Tab[1]);Tab[2]:=0; end;
                   'arcsind' : begin rumus();Tab[1]:=arsin;Tab[2]:=0; end;
                   'arccosd' : begin rumus();Tab[1]:=arcos;Tab[2]:=0; end;
                   'arctand' : begin rumus();Tab[1]:=artan;Tab[2]:=0; end;
                   'arcsinr' : begin rumus();Tab[1]:=arcsin(Tab[1]);Tab[2]:=0; end;
                   'arccosr' : begin rumus();Tab[1]:=arccos(Tab[1]);Tab[2]:=0; end;
                   'arctanr' : begin rumus();Tab[1]:=arctan(Tab[1]);Tab[2]:=0; end;
                   'ln'  : begin Tab[1]:=logn(e,Tab[1]);Tab[2]:=0; end;
                   'log' : begin Tab[1]:=log10(Tab[1]);Tab[2]:=0; end;
                   'phi' : begin Tab[1]:=phi;Tab[2]:=0;end;
                 end;
                end
               else
                begin
                 Tab[idx]:=krg(Tab[idx],Tab[idx+1]);
                 move(idx);
                end;
              end
             else
              begin
               tmp:=idx;
               searchx(TOp,'-');
               if (idx=0) or (tmp<idx) then
                begin
                 Tab[tmp]:=jml(Tab[tmp],Tab[tmp+1]);
                 move(tmp);
                end
               else
                begin
                 Tab[idx]:=krg(Tab[idx],Tab[idx+1]);
                 move(idx);
                end;
              end;
             end
           else
            begin
             Tab[idx]:=bagi(Tab[idx],Tab[idx+1]);
             move(idx);
            end;
          end
         else
          begin
           tmp:=idx;
           searchx(TOp,'/');
            if (idx=0) or (tmp<idx) then
             begin
              Tab[tmp]:=kali(Tab[tmp],Tab[tmp+1]);
              move(tmp);
             end
            else
             begin
              Tab[idx]:=bagi(Tab[idx],Tab[idx+1]);
              move(idx);
             end;
         end;
        end
       else
        begin
         tmp_p:=Tab[idx];
         for i:=2 to trunc(Tab[idx+1]) do
          Tab[idx]:=kali(Tab[idx],tmp_p);
         move(idx);
        end;
  end;

  procedure start();
  {mesin abstrak khayalan dinyalakan, indikator layar CC berisi karakter pertama dalam pitachar
   I.S : sembarang
   F.S : CC adalah karakter pertama pada pita}
  begin
    CI:=1;
    CC:=pitachar[CI];
  end;

  procedure adv();
  {pitachar digeser ke kanan selangkah, indikator layar CC berisi karakter yang sedang dibaca
   I.S : karakter = CC
   F.S : CC adalah karakter berikutnya dari CC yang lama}
  begin
    CI:=CI+1;
    CC:=pitachar[CI];
  end;

begin
        clrscr;
        tampilan();
        // hasil
        gotoxy(6,17);
        textcolor(lightmagenta);writeln('Hasil :');
        // end hasil

        // perhitungan
        gotoxy(6,14);
        textcolor(lightmagenta);writeln('Perhitungan :');
        gotoxy(5,15);
        textcolor(white);
        //baca pitachar
        readln(pitachar);
        start();
        ra:=1;
        ro:=1;
        sm1:=0;
        sm2:=0;
        while (CC <> '=') do
          begin
            if (ord(CC)>=48) and (ord(CC)<=75) then //jika bilangan
              begin
                if sm1=ra then
                 begin
                  val(CC,konv);
                  Tab[ra]:=Tab[ra]*10+konv;
                 end
                else
                 begin
                  val(CC,konv);
                  Tab[ra]:=konv;
                  sm1:=ra;
                 end;
              end
            else if (CC='+') or (CC='-') or (CC='*') or (CC='/') or (CC='^') then
             begin
              TOp[ro]:=CC;
              ra:=ra+1;
              ro:=ro+1;
             end
            else if ((ord(CC)>=97) and (ord(CC)<=122)) or (CC='(') then //jika huruf atau kurung buka
             begin
                if sm2=ro then
                 begin
                  if (CC='(') then
                   ro:=ro+1
                  else
                   TOp[ro]:=TOp[ro]+CC;
                 end
                else
                 begin
                  TOp[ro]:=CC;
                  sm2:=ro;
                 end;
             end;
            adv();
          end;

        if (Tab[2]=0) then // untuk konversi
          Tab[2]:=1;

        //search derajat operasi
        while (Tab[2]<>0) do
          cariDerajat();
        //end search

        //hasil perhitungan
        gotoxy(5,18);
        writeln(Tab[1]:8:6);
        // end hasil

        // aksi
        gotoxy(5,21);

        readln;
end.
