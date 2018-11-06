	 ORG 800H  
	 LXI H,OP1 ;h<-OP1 WYBOR 1 OPERANDU  
	 RST 3 ;wydruk z pami�ci op1  
	 RST 5 ;DE <- nnnn(h) pierwszy operand  
DZIAL 	 LXI H,OPD ;h<-OPD WYBOR DZIALANIA  
	 RST 3 ;wydruk z pamieci opd  
	 RST 2 ;A<-nn(h)  
	 CPI '+' ;jezeli a=='+' z=1 je�eli nie z=0  
	 JZ DODA ;z?==1 id� do dodawania  
	 CPI '-' ;jezeli a=='-' z=1 je�eli nie z=0  
	 JZ ODEJ ;z?==1 id� do odejmowania  
	 CPI 'n' ;jezeli a=='n' z=1 je�eli nie z=0  
	 JZ NEGA ;z?==1 id� do negacji  
	 CMC ;cy<-~cy jezeli niema to cy=1 wiec negujemy cy do 0  
	 JMP DZIAL ;�adne z powyzszych - wroc do wybory dzialania  
DODA 	 LXI H,OP2 ;h<-OP2 WYBOR 2 OPERANDU / DODAWANIE  
	 RST 3 ;wydruk z pamieci op1  
	 XCHG ;HL <-> DE == HL<-DE & DE->HL  
	 RST 5 ;DE <- nnnn(h) drugi operand  
	 MVI A,10 ;A<-10 nowa linia  
	 RST 1 ;wypisanie nowej lini  
	 MVI A,13 ;A<-13 powrot do poczatku  
	 RST 1 ;wpisanie powrot do poczaku  
	 MVI A,'=' ;A<-'='  
	 RST 1 ;wypisanie '='  
	 DAD D ;HL<-HL + DE  
	 MVI A,0 ;A<-0 zerowanie A  
	 ACI 0 ;A<-A+0+CY  
	 RST 4 ;wypisanie a = wypisanie CY (00/01)  
	 MOV A,H ;A<-H  
	 RST 4 ;wypisanie A  
	 MOV A,L ;A<-L  
	 RST 4 ;wypisanie A  
	 HLT ;stop  
NEGA 	 LXI H,OPN ;h<-OPN / NEGACJA  
	 RST 3 ;wydruk z pamieci opn  
	 MOV A,D ;A<-D  
	 CMA ;A<-~A  
	 RST 4 ;wypisanie A  
	 MOV A,E ;A<-E  
	 CMA ;A<-~A  
	 RST 4 ;wypisanie A  
	 HLT ;stop  
ODEJ 	 LXI H,OP2 ;h<-OP2 WYBOR 2 OPERANDU / ODEJMOWANIE  
	 RST 3 ;wydruk z pamieci op2  
	 XCHG ;HL <-> DE == HL<-DE & DE->H  
	 RST 5 ;DE <- nnnn(h) drugi operand  
	 MVI A,10 ;A<-10 nowa linia  
	 RST 1 ;wypisanie nowej lini  
	 MVI A,13 ;A<-13 powrot do poczatku  
	 RST 1 ;wpisanie powrot do poczaku  
	 MVI A,'=' ;A<-'='  
	 RST 1 ;wypisanie '='  
	 MOV A,H ;A<-H  
	 CMP D ;A<D c=1 jak a>=D c=0  
	 JC MINU ;c?==1 id� do MINU  
	 MOV A,L ;A<-L  
	 CMP E ;A<E c=1 jak a>=D c=0  
	 JC MINU ;c?==1 id� do MINU  
ODEJ2 	 MOV A,D ;A<-D  
	 CMA ;A<-~A  
	 MOV D,A ;D<-A  
	 MOV A,E ;A<-E  
	 CMA ;A<-~A  
	 INR A ;A++ / DODANIE 1 poniewa� przepe�nienie  
	 MOV E,A ;E<-A  
	 DAD D ;HL<-HL+DE  
	 MOV A,H ;A<-H  
	 RST 4 ;Wypisanie A  
	 MOV A,L ;A<-L  
	 RST 4 ;Wypisanie A  
	 HLT ;stop  
MINU 	 MVI A,'-' ;A<-'-'  
	 RST 1 ;Wypisanie A  
	 JMP ODEJ2 ;id� do odej2  
OP1 	 DB 'Podaj pierwszy operand 0-ffffh',10,13,'>','@'              
OPD 	 DB 10,13,'Podaj dzialanie <+, -, n>',10,13,'>','@'              
OP2 	 DB 10,13,'Podaj drugi operand 0-ffff',10,13,'>','@'              
OPN 	 DB 10,13,'Wynik negacji to: ',10,13,'@'   
