format PE GUI 4.0
entry inicio

include 'Win32a.inc'

ventana_1	equ		1
salir_btn	equ		1000
btn1_Ok		equ		1003
box1_InputCi	equ	1002
box2_output		equ	1006
box3_output		equ 1007
box4_output		equ 1008
box5_output		equ 1009
box6_output		EQU 1010


section '.data' data readable writeable

Ist  dd 0
pWnd dd 0	;Por defecto, pero podemos crear mas para guardar hWnd de diferentes ventanas([pWnd][sWnd][tWnd]...)


;;;;;;;;;;;;;;;;; HORAS/CLASE ;;;;;;;;;;;;;;;;;
myDate SYSTEMTIME ?
timeSymbolOne	db ':',0
timeSymbolTwo	db '-',0
timeSeis		DB '06:45 - 08:15',0
timeOcho		DB '08:15 - 09:45',0
timeNueve		DB '09:45 - 11:15',0
timeOnce		DB '11:15 - 12:45',0
timeDoce		DB '12:45 - 14:15',0
timeDos			DB '14:15 - 15:45',0
timeTres		DB '15:45 - 17:15',0
timeCinco		DB '17:15 - 18:45',0
timeSeisT		db '18:45 - 20:15',0
timeOchoT		db '20:15 - 21:45',0
;noSubjToday 	db 'No tiene Clases HOY',0
noSubjToday 	db 'NO HAY CLASES EN CURSO',0
;noSubjNow		db 'No tiene Clases AHORA',0
noSubjNow		db 'NO HAY CLASES EN CURSO',0
later			db 'ATRASO',0
bAtraso			dd 0
;;;;;;;;;;;;;;;; AULAS ;;;;;;;;;;;;;;;;;;;;;;;
aula607			db	'607',0
aula612			db	'612',0
aula617			db 	'617',0
aula617A		db 	'617A',0
aula617B		db 	'617B',0
aula617C		db 	'617C',0
aula622			db	'622',0
aula623			db	'623',0
aula624			db	'624',0
aula625			db	'625',0
aula625D		db	'625D',0
aula651			db 	'651',0
aula652			db 	'652',0
aula661			db	'661',0

aulaINFLAB		db 	'INFLAB',0
aulaINFDEP		db	'INFDEP',0
aula690B		db 	'690B',0
aula690C		db	'690C',0
aula690D		db	'690D',0
aula690E		db	'690E',0
aula691A		db 	'691A',0
aula691B		db 	'691B',0
aula691C		db	'691C',0
aula691D		db	'691D',0
aula691E		db	'691E',0
aula691F		db	'691F',0
aula692A		db	'692A',0
aula692B		db	'692B',0
aula692C		db	'692C',0
aula692E		db	'692E',0
aula692H		db	'692H',0
aula692G		db	'692G',0
aula693A		db	'693A',0
aula693D		db	'693D',0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

msgCINoValid 	db 'Ingrese un CI valido',0
ciNoExist		db 'Docente no registrado',0
voidMsg			db '',0
auxMsg			db 100 dup(0)
saltoLinea 		db 10,13

ciOne 			dd 8080808
DocOne 			db 'MONTECINOS CHOQUE MARCO ANTONIO',10,13,0
TPBN			db 'TALLER DE PROGRAMACION EN BAJO NIVEL',0
RedesAvanzadas 	db 'REDES AVANZADAS DE COMPUTADORAS',0
TRA				db 'TECNOLOGIA REDES AVANZADAS',0


ciTwo			dd 7070707
DocTwo 			db 'BLANCO COCA LETICIA',0
IntroProg		db 'INTRODUCCION A LA PROGRAMACION',0
EPED			db 'ELEMENTOS DE PROGRAMACION Y ESTRUCTURA DE DATOS',0
AlgoAva			db 'ALGORITMOS AVANZADOS',0
TIS				db 'TALLER DE INGENIERIA DE SOFTWARE',0

ciThree			dd 6060606
DocThree		db 'APARICIO YUJA TATIANA',0
Funcional		db 'PROGRAMACION FUNCIONAL',0
BASE2			DB 'BASE DE DATOS II',0

ciFour			dd 5050505
DocFour			db 'ORELLANA ARAOZ JORGE WALTER',0
TSO				db 'TALLER DE SISTEMAS OPERATIVOS',0
Redes			db 'REDES DE COMPUTADORAS',0

ciFive			dd 4040404
DocFive			db 'MONTANO QUIROGA VICTOR HUGO',0
TALF			db 'TEORIA DE AUTOMATAS Y LENGUAJES FORMALES',0
TG				db 'TALLER DE GRADO II',0

input1Var dd 0
input2Var dd 0


section '.code' code readable executable

inicio:
	invoke GetModuleHandle,0
	mov [Ist],eax
	invoke DialogBoxParam,eax,ventana_1,0,DlgProc,0 
fin:
	invoke ExitProcess,0

proc DlgProc,hWnd,uMsg,wParam,lParam
	push edi esi ebx
	
	mov eax,[uMsg]
	cmp	eax,WM_COMMAND
	je	jCOMMAND
	cmp	eax,WM_INITDIALOG
	je	jINITDIALOG
	cmp	eax,WM_CLOSE
	je	jCLOSE
	xor eax,eax
	jmp finish

jINITDIALOG:
	mov eax,[hWnd]
	mov [pWnd],eax
	
	;;
	
	mov eax,1
	jmp finish
	
jCOMMAND:
	mov eax,[wParam]
	cmp	eax,salir_btn
	je	salir
	
	cmp eax,btn1_Ok;boton ok 1003
	je verifyCI
	
	xor eax,eax
	jmp finish
	

verifyCI:	;Boton OK, para leer y mostrar el contenido de box1(1002) en la box2(1004)
	
	mov edx,1
	invoke GetLocalTime,myDate;;;;;guardamos la hora inicial
	xor edx,edx
	
	invoke GetDlgItemInt,[pWnd],box1_InputCi,0,0	;box de entrada de CI
	mov [input1Var],eax
	
	call clearBoxes
	
	showDataCI:
		cmp [input1Var],0
		jne otherCiOne
		;mov eax,[msgCINoValid]
		;invoke SendDlgItemMessage,[pWnd],box2_OutputCi,WM_SETTEXT,100,msgCINoValid;;;;;;
		invoke SetDlgItemText,[pWnd],1005,msgCINoValid;;;;;;funciona con sendDlgItemMsg o con setDlgItemText
		invoke SetDlgItemText,[pWnd],box3_output,voidMsg
		invoke SetDlgItemText,[pWnd],box4_output,voidMsg
		jmp endShow
		
		otherCiOne:
		mov eax,[ciOne]
		cmp [input1Var],eax
		jne otherCiTwo
		
		invoke SendDlgItemMessage,[pWnd],box2_output,WM_SETTEXT,100,DocOne
		mov ebx,0
		mov ebx,[ciOne]
		
		
		call setSchedule
		;call setSubject
		jmp endShow
		
		otherCiTwo:
		mov eax,[ciTwo]
		cmp [input1Var],eax
		jne otherCiThree
		
		invoke SendDlgItemMessage,[pWnd],box2_output,WM_SETTEXT,100,DocTwo
		mov ebx,0
		mov ebx,[ciTwo]		;guardamos en ebx el docente
		
		
		call setSchedule
		;call setSubject
		jmp endShow
		
		otherCiThree:
		mov eax,[ciThree]
		cmp [input1Var],eax
		jne otherCiFour
		
		invoke SendDlgItemMessage,[pWnd],box2_output,WM_SETTEXT,100,DocThree
		mov ebx,0
		mov ebx,[ciThree]		;guardamos en ebx el docente
		
		
		call setSchedule
		;call setSubject
		jmp endShow
		
		otherCiFour:
		mov eax,[ciFour]
		cmp [input1Var],eax
		jne otherCiFive
		
		invoke SendDlgItemMessage,[pWnd],box2_output,WM_SETTEXT,100,DocFour
		mov ebx,0
		mov ebx,[ciFour]		;guardamos en ebx el docente
		
		
		call setSchedule
		;call setSubject
		jmp endShow
		
		otherCiFive:
		mov eax,[ciFive]
		cmp [input1Var],eax
		jne ciNotFound
		invoke SendDlgItemMessage,[pWnd],box2_output,WM_SETTEXT,100,DocFive
		mov ebx,0
		mov ebx,[ciFive]		;guardamos en ebx el docente
		call setSchedule
		jmp endShow
		
		ciNotFound:
		invoke SendDlgItemMessage,[pWnd],1005,WM_SETTEXT,100,ciNoExist
		call clearBoxes;;
	
	endShow:	
	mov eax,1
	mov ebx,1
	mov edx,1
	jmp finish

salir:
	invoke SendMessage,[hWnd],WM_CLOSE,0,0
	mov eax,1
	jmp finish
	
jCLOSE:	
	invoke EndDialog,[hWnd],0
	mov eax,1
	
finish:				;termina solo el proceso repetitivo
	pop ebx esi edi
	ret
endp

proc setSchedule
	
	mov eax,0
	call takeDayWeekA
	
	cmp ebx,[ciOne]
	je DocOneSchedule
	cmp [ciTwo],ebx
	je DocTwoSchedule
	cmp [ciThree],ebx
	je DocThreeSchedule
	cmp [ciFour],ebx
	je DocFourSchedule
	cmp [ciFive],ebx
	je DocFiveSchedule
	jmp finSetSchedule
	
	DocOneSchedule:
		cmp edx,2
		jb noSubjectsToday
		je marDocOne
		cmp edx,3
		je mieDocOne
		cmp edx,4
		je jueDocOne
		ja noSubjectsToday
		
		marDocOne:
			call takeHorA
			cmp edx,11		;;;;;;;;;;;;
			jb noSubjectsNow
			je marOnceDocOne
			cmp edx,12
			je marDoceDocOne
			cmp edx,13
			je marUnaDocOne
			cmp edx,14
			je marDosDocOne
			cmp edx,15
			je marTresDocOne
			cmp edx,16
			je marCuatroDocOne
			cmp edx,17
			je marCincoDocOne
			ja noSubjectsToday
			
			marOnceDocOne:
				call takeMinA
				cmp edx,15
				jb noSubjectsNow
				cmp edx,30
				jb marTPBNA
				mov [bAtraso],1
				jmp marTPBNA
			marDoceDocOne:
				call takeMinA
				cmp edx,45
				jae marRedesA
				mov [bAtraso],1
				jmp marTPBNA
			marUnaDocOne:
				mov [bAtraso],1
				jmp marRedesA
			marDosDocOne:
				call takeMinA
				cmp edx,15
				jb marUnaDocOne
				cmp edx,30
				jb marTRA
				mov [bAtraso],1
				jmp marTRA
			marTresDocOne:
				call takeMinA
				cmp edx,45
				jae marTPBNB
				mov [bAtraso],1
				jmp marTRA
			marCuatroDocOne:
				mov [bAtraso],1
				jmp marTPBNB
			marCincoDocOne:
				call takeMinA
				cmp edx,15
				jae noSubjectsToday
				mov [bAtraso],1
				jmp marTPBNB
			
			marTPBNA:
				invoke SetDlgItemText,[pWnd],box3_output,TPBN
				invoke SetDlgItemText,[pWnd],box4_output,timeOnce
				invoke SetDlgItemText,[pWnd],box5_output,aula652
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			marRedesA:
				invoke SetDlgItemText,[pWnd],box3_output,RedesAvanzadas
				invoke SetDlgItemText,[pWnd],box4_output,timeDoce
				invoke SetDlgItemText,[pWnd],box5_output,aula607
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			marTRA:
				invoke SetDlgItemText,[pWnd],box3_output,TRA
				invoke SetDlgItemText,[pWnd],box4_output,timeDos
				invoke SetDlgItemText,[pWnd],box5_output,aula691D
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			marTPBNB:
				invoke SetDlgItemText,[pWnd],box3_output,TPBN
				invoke SetDlgItemText,[pWnd],box4_output,timeTres
				invoke SetDlgItemText,[pWnd],box5_output,aula691B
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule	
		
		mieDocOne:
			call takeHorA
			cmp edx,11
			jb noSubjectsNow
			je mieOnce
			cmp edx,12
			je mieDoce
			cmp edx,13
			je noSubjectsNow
			cmp edx,14
			je mieDos
			cmp edx,15
			je mieTres
			cmp edx,16
			je mieCuatro
			cmp edx,17
			je mieCinco
			ja noSubjectsToday
			
			mieOnce:
				call takeMinA
				cmp edx,15
				jb noSubjectsNow
				cmp edx,30
				jb TPBNOnce
				mov [bAtraso],1
				jmp TPBNOnce
			mieDoce:
				call takeMinA
				cmp edx,45
				jae noSubjectsNow
				mov [bAtraso],1
				jmp TPBNOnce
			mieDos:
				call takeMinA
				cmp edx,15
				jb noSubjectsNow
				cmp edx,30
				jb TRADos
				mov [bAtraso],1
				jmp TRADos
				
			mieTres:
				call takeMinA
				cmp edx,45
				jae TPBNTres
				mov [bAtraso],1
				jmp TRADos
			mieCuatro:
				mov [bAtraso],1
				jmp TPBNTres
			mieCinco:
				call takeMinA
				cmp edx,15
				jae noSubjectsToday
				mov [bAtraso],1
				jmp TPBNTres
			
			TPBNOnce:
				invoke SetDlgItemText,[pWnd],box3_output,TPBN
				invoke SetDlgItemText,[pWnd],box4_output,timeOnce
				invoke SetDlgItemText,[pWnd],box5_output,aula692B
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			
			TRADos:
				invoke SetDlgItemText,[pWnd],box3_output,TRA
				invoke SetDlgItemText,[pWnd],box4_output,timeDos
				invoke SetDlgItemText,[pWnd],box5_output,aula661
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			
			TPBNTres:
				invoke SetDlgItemText,[pWnd],box3_output,TPBN
				invoke SetDlgItemText,[pWnd],box4_output,timeTres
				invoke SetDlgItemText,[pWnd],box5_output,aula661
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			
		jueDocOne:
			call takeHorA
			cmp edx,11
			jb noSubjectsNow
			je jueOnceDocOne
			cmp edx,12
			je jueDoceDocOne
			cmp edx,13
			je jueUnaDocOne
			cmp edx,14
			je jueDosDocOne
			cmp edx,15
			je jueTresDocOne
			cmp edx,16
			je jueCuatroDocOne
			cmp edx,17
			je jueCincoDocOne
			ja noSubjectsToday
			
			
			jueOnceDocOne:
				call takeMinA
				cmp edx,15
				jb noSubjectsNow
				cmp edx,30
				jb jueTPBNA
				mov [bAtraso],1
				jmp jueTPBNA
			jueDoceDocOne:
				call takeMinA
				cmp edx,45
				jae jueRedesA
				mov [bAtraso],1
				jmp jueTPBNA
			jueUnaDocOne:
				mov [bAtraso],1
				jmp jueRedesA
			jueDosDocOne:
				call takeMinA
				cmp edx,15
				jb jueUnaDocOne
				cmp edx,30
				jb jueTRA
				mov [bAtraso],1
				jmp jueTRA
			jueTresDocOne:
				call takeMinA
				cmp edx,45
				jae jueTPBNB
				mov [bAtraso],1
				jmp jueTRA
			jueCuatroDocOne:
				mov [bAtraso],1
				jmp jueTPBNB
			jueCincoDocOne:
				call takeMinA
				cmp edx,15
				jae noSubjectsToday
				mov [bAtraso],1
				jmp jueTPBNB
			
			jueTPBNA:
				invoke SetDlgItemText,[pWnd],box3_output,TPBN
				invoke SetDlgItemText,[pWnd],box4_output,timeOnce
				invoke SetDlgItemText,[pWnd],box5_output,aula692E
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			jueRedesA:
				invoke SetDlgItemText,[pWnd],box3_output,RedesAvanzadas
				invoke SetDlgItemText,[pWnd],box4_output,timeDoce
				invoke SetDlgItemText,[pWnd],box5_output,aula692A
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			jueTRA:
				invoke SetDlgItemText,[pWnd],box3_output,TRA
				invoke SetDlgItemText,[pWnd],box4_output,timeDos
				invoke SetDlgItemText,[pWnd],box5_output,aula691E
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			jueTPBNB:
				invoke SetDlgItemText,[pWnd],box3_output,TPBN
				invoke SetDlgItemText,[pWnd],box4_output,timeTres
				invoke SetDlgItemText,[pWnd],box5_output,aula691E
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule	
		
	DocTwoSchedule:						;;DOC 2, BLANCO COCA LETICIA, 4 Materias, 5Grupos
	call takeDayWeekA	
		cmp edx,1
		je lunDocTwo
		cmp edx,2
		je marDocTwo
		cmp edx,3
		je mieDocTwo
		cmp edx,4
		je jueDocTwo
		cmp edx,5
		je vieDocTwo
		jmp noSubjectsToday
		
		lunDocTwo:
			call takeHorA
			cmp edx,12
			jb noSubjectsNow
			je lunDocTwoDoce
			cmp edx,13
			je lunDocTwoUna
			cmp edx,14
			je lunDocTwoDos
			jmp noSubjectsToday
			lunDocTwoDoce:
				call takeMinA
				cmp edx,45
				jae lunEPEDDocTwo
				mov [bAtraso],1
				jmp lunEPEDDocTwo
			lunDocTwoUna:
				mov [bAtraso],1
				jmp lunEPEDDocTwo
			lunDocTwoDos:
				call takeMinA
				cmp edx,15
				jb lunDocTwoUna
				jmp noSubjectsToday
			
			lunEPEDDocTwo:
				invoke SetDlgItemText,[pWnd],box3_output,EPED
				invoke SetDlgItemText,[pWnd],box4_output,timeDoce
				invoke SetDlgItemText,[pWnd],box5_output,aula623
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
		
		marDocTwo:
			call takeHorA
			cmp edx,6
			jb noSubjectsNow
			je marDocTwoSeis
			cmp edx,7
			je marDocTwoSiete
			cmp edx,8
			je marDocTwoOcho
			cmp edx,9
			je marDocTwoNueve
			cmp edx,17
			jb noSubjectsNow
			je marDocTwoCinco
			cmp edx,18
			je marDocTwoSeisT
			cmp edx,19
			je marDocTwoSieteT
			cmp edx,20
			je marDocTwoOchoT
			jmp noSubjectsToday
			
			marDocTwoSeis:
				call takeMinA
				cmp edx,45
				jae marAlgoAd
				jmp noSubjectsNow
			marDocTwoSiete:
				mov [bAtraso],1
				jmp marAlgoAd
			marDocTwoOcho:
				call takeMinA
				cmp edx,15
				jae marTIS
				jmp marDocTwoSiete
			marDocTwoNueve:
				call takeMinA
				cmp edx,45
				jae noSubjectsNow
				mov [bAtraso],1
				jmp marTIS
			marDocTwoCinco:
				call takeMinA
				cmp edx,15
				jb noSubjectsNow
				cmp edx,30
				jb marIntroProgDocTwo
				mov [bAtraso],1
				jmp	marIntroProgDocTwo
			marDocTwoSeisT:
				call takeMinA
				cmp edx,45
				jae marEPED
				mov [bAtraso],1
				jmp marIntroProgDocTwo
			marDocTwoSieteT:
				mov [bAtraso],1
				jmp marEPED
			marDocTwoOchoT:
				call takeMinA
				cmp edx,15
				jae noSubjectsNow
				jmp marDocTwoSieteT
			
			marAlgoAd:
				invoke SetDlgItemText,[pWnd],box3_output,AlgoAva
				invoke SetDlgItemText,[pWnd],box4_output,timeSeis
				invoke SetDlgItemText,[pWnd],box5_output,aula691C
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			marTIS:
				invoke SetDlgItemText,[pWnd],box3_output,TIS
				invoke SetDlgItemText,[pWnd],box4_output,timeOcho
				invoke SetDlgItemText,[pWnd],box5_output,aula651
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			marIntroProgDocTwo:
				invoke SetDlgItemText,[pWnd],box3_output,IntroProg
				invoke SetDlgItemText,[pWnd],box4_output,timeDoce
				invoke SetDlgItemText,[pWnd],box5_output,aula617
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			marEPED:
				invoke SetDlgItemText,[pWnd],box3_output,EPED
				invoke SetDlgItemText,[pWnd],box4_output,timeDoce
				invoke SetDlgItemText,[pWnd],box5_output,aula622
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			
		mieDocTwo:
			call takeHorA
			cmp edx,6
			jb noSubjectsNow
			je mieDocTwoSeis
			cmp edx,7
			je mieDocTwoSiete
			cmp edx,8
			je mieDocTwoOcho
			cmp edx,9
			je mieDocTwoNueve
			cmp edx,15
			jb noSubjectsNow
			je mieDocTwoTres
			cmp edx,17
			je mieDocTwoCinco
			cmp edx,18
			je mieDocTwoSeisT
			jmp noSubjectsToday
			
			mieDocTwoSeis:
				call takeMinA
				cmp edx,45
				jae mieEPED
				jmp noSubjectsNow
			mieDocTwoSiete:
				mov [bAtraso],1
				jmp mieEPED
			mieDocTwoOcho:
				call takeMinA
				cmp edx,15
				jb mieDocTwoSiete
				cmp edx,30
				jb mieTIS
				mov [bAtraso],1
				jmp mieTIS
			mieDocTwoNueve:
				call takeMinA
				cmp edx,45
				jae noSubjectsNow
				mov [bAtraso],1
				jmp mieTIS
			mieDocTwoTres:
				call takeMinA
				cmp edx,45
				jae mieEPEDB
				jmp noSubjectsNow
			mieDocTwoCuatro:
				mov [bAtraso],1
				jmp mieEPEDB
			mieDocTwoCinco:
				call takeMinA
				cmp edx,15
				jb mieDocTwoCuatro
				cmp edx,30
				jb mieIntro
				mov [bAtraso],1
				jmp mieIntroDocTwo
			mieDocTwoSeisT:
				call takeMinA
				cmp edx,45
				jae noSubjectsToday
				mov [bAtraso],1
				jmp mieIntroDocTwo
			;;;;;;;;;;;;;;;;;;;;;;;;;
			mieEPED:
				invoke SetDlgItemText,[pWnd],box3_output,EPED
				invoke SetDlgItemText,[pWnd],box4_output,timeSeis
				invoke SetDlgItemText,[pWnd],box5_output,aula691C
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			mieTIS:
				invoke SetDlgItemText,[pWnd],box3_output,TIS
				invoke SetDlgItemText,[pWnd],box4_output,timeOcho
				invoke SetDlgItemText,[pWnd],box5_output,aulaINFLAB
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			mieEPEDB:
				invoke SetDlgItemText,[pWnd],box3_output,EPED
				invoke SetDlgItemText,[pWnd],box4_output,timeTres
				invoke SetDlgItemText,[pWnd],box5_output,aula623
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			mieIntroDocTwo:
				invoke SetDlgItemText,[pWnd],box3_output,IntroProg
				invoke SetDlgItemText,[pWnd],box4_output,timeCinco
				invoke SetDlgItemText,[pWnd],box5_output,aula691B
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
		jueDocTwo:
			call takeHorA
			cmp edx,6
			jb noSubjectsNow
			je jueDocTwoSeis
			cmp edx,7
			je jueDocTwoSiete
			cmp edx,8
			je jueDocTwoOcho
			cmp edx,12
			jb noSubjectsNow
			je jueDocTwoDoce
			cmp edx,13
			je jueDocTwoUna
			cmp edx,14
			je jueDocTwoDos
			cmp edx,15
			je jueDocTwoTres
			cmp edx,16
			je jueDocTwoCuatro
			cmp edx,17
			je jueDocTwoCinco
			jmp noSubjectsToday;;;;
			
			jueDocTwoSeis:
				call takeMinA
				cmp edx,45
				jae jueAlgoAd
				jmp noSubjectsNow
			jueDocTwoSiete:
				mov [bAtraso],1
				jmp jueAlgoAd
			jueDocTwoOcho:
				call takeMinA
				cmp edx,15
				jae noSubjectsNow
				jmp jueDocTwoSiete
			jueDocTwoDoce:
				call takeMinA
				cmp edx,45
				jae jueEPED
				jmp noSubjectsNow
			jueDocTwoUna:
				mov [bAtraso],1
				jmp jueEPED
			jueDocTwoDos:
				call takeMinA
				cmp edx,15
				jae noSubjectsNow
				jmp jueDocTwoUna
			jueDocTwoTres:
				call takeMinA
				cmp edx,45
				jae jueIntroDocTwo
				jmp noSubjectsNow
			jueDocTwoCuatro:
				mov [bAtraso],1
				jmp jueIntroDocTwo
			jueDocTwoCinco:
				call takeMinA
				cmp edx,15
				jae noSubjectsToday
				jmp jueDocTwoCuatro
			
			jueAlgoAd:
				invoke SetDlgItemText,[pWnd],box3_output,AlgoAva
				invoke SetDlgItemText,[pWnd],box4_output,timeSeis
				invoke SetDlgItemText,[pWnd],box5_output,aula690D
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			jueEPED:
				invoke SetDlgItemText,[pWnd],box3_output,EPED
				invoke SetDlgItemText,[pWnd],box4_output,timeDoce
				invoke SetDlgItemText,[pWnd],box5_output,aula624
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			jueIntroDocTwo:
				invoke SetDlgItemText,[pWnd],box3_output,IntroProg
				invoke SetDlgItemText,[pWnd],box4_output,timeTres
				invoke SetDlgItemText,[pWnd],box5_output,aula624
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
		
		vieDocTwo:
			;;;;;;;;;;;;;
			call takeHorA		
			cmp edx,6
			jb noSubjectsNow
			je vieDocTwoSeis
			cmp edx,7
			je vieDocTwoSiete
			cmp edx,8
			je vieDocTwoOcho
			ja noSubjectsToday
			
			vieDocTwoSeis:
				call takeMinA
				cmp edx,45
				jae vieAlgoAd
				jmp noSubjectsNow
			vieDocTwoSiete:
				mov [bAtraso],1
				jmp vieAlgoAd
			vieDocTwoOcho:
				call takeMinA
				cmp edx,15
				jb vieDocTwoSiete
				jmp noSubjectsToday
			
			vieAlgoAd:
				invoke SetDlgItemText,[pWnd],box3_output,AlgoAva
				invoke SetDlgItemText,[pWnd],box4_output,timeSeis
				invoke SetDlgItemText,[pWnd],box5_output,aula693D
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			
	DocThreeSchedule:
		cmp edx,1
		je	lunDocThree
		cmp edx,2
		je	marDocThree
		cmp edx,3
		je	mieDocThree
		jne noSubjectsToday
		
		lunDocThree:
			call takeHorA
			cmp edx,6
			jb noSubjectsNow
			je lunSeisDocThree
			cmp edx,7
			je lunSieteDocThree
			cmp edx,8
			je lunOchoDocThree
			cmp edx,9
			je lunNueveDocThree
			cmp edx,10
			je noSubjectsNow
			cmp edx,11
			je noSubjectsNow
			cmp edx,12
			je lunDoceDocThree
			cmp edx,13
			je lunUnaDocThree
			cmp edx,14
			je lunDosDocThree
			ja noSubjectsToday
			
			
			lunSeisDocThree:
				call takeMinA
				cmp edx,45
				jb noSubjectsNow
				jmp lunBASE2A
			lunSieteDocThree:
				mov [bAtraso],1
				jmp lunBASE2A
			lunOchoDocThree:
				call takeMinA
				cmp edx,15
				jb lunSieteDocThree
				cmp edx,30
				jb lunFunct
				mov [bAtraso],1
				jmp lunFunct
			lunNueveDocThree:
				call takeMinA
				cmp edx,45
				jae noSubjectsNow
				mov [bAtraso],1
				jmp lunFunct
			lunDoceDocThree:
				call takeMinA
				cmp edx,45
				je noSubjectsNow
				jmp lunBASE2B
			lunUnaDocThree:
				mov [bAtraso],1
				jmp lunBASE2B
			lunDosDocThree:
				call takeMinA
				cmp edx,15
				jae noSubjectsNow
				jmp lunUnaDocThree
			
			lunBASE2A:
				invoke SetDlgItemText,[pWnd],box3_output,BASE2
				invoke SetDlgItemText,[pWnd],box4_output,timeSeis
				invoke SetDlgItemText,[pWnd],box5_output,aula617B
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			lunFunct:
				invoke SetDlgItemText,[pWnd],box3_output,Funcional
				invoke SetDlgItemText,[pWnd],box4_output,timeOcho
				invoke SetDlgItemText,[pWnd],box5_output,aula625D
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			lunBASE2B:
				invoke SetDlgItemText,[pWnd],box3_output,BASE2
				invoke SetDlgItemText,[pWnd],box4_output,timeDoce
				invoke SetDlgItemText,[pWnd],box5_output,aula692B
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
		
		marDocThree:
			call takeHorA
			cmp edx,6
			jb noSubjectsNow
			je marSeisDocThree
			cmp edx,7
			je marSieteDocThree
			cmp edx,8
			je marOchoDocThree
			cmp edx,9
			je marNueveDocThree
			cmp edx,14
			jb noSubjectsNow
			je marDosDocThree
			cmp edx,15
			je marTresDocThree
			ja noSubjectsToday
			
			
			marSeisDocThree:
				call takeMinA
				cmp edx,45
				jb noSubjectsNow
				jmp marBASE2A
			marSieteDocThree:
				mov [bAtraso],1
				jmp marBASE2A
			marOchoDocThree:
				call takeMinA
				cmp edx,15
				jb marSieteDocThree
				cmp edx,30
				jb marBASE2B	;;marFunct
				mov [bAtraso],1
				jmp marBASE2B
			marNueveDocThree:
				call takeMinA
				cmp edx,45
				jae noSubjectsNow
				mov [bAtraso],1
				jmp marBASE2B
			marDosDocThree:
				call takeMinA
				cmp edx,15
				jb noSubjectsNow
				cmp edx,30
				jb marFunct
				mov [bAtraso],1
				jmp marFunct
			marTresDocThree:
				call takeMinA
				cmp edx,45
				jae noSubjectsToday
				mov [bAtraso],1
				jmp marFunct
			
			
			marBASE2A:
				invoke SetDlgItemText,[pWnd],box3_output,BASE2
				invoke SetDlgItemText,[pWnd],box4_output,timeSeis
				invoke SetDlgItemText,[pWnd],box5_output,aula691F
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			marFunct:
				invoke SetDlgItemText,[pWnd],box3_output,Funcional
				invoke SetDlgItemText,[pWnd],box4_output,timeDos
				invoke SetDlgItemText,[pWnd],box5_output,aula690D
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			marBASE2B:
				invoke SetDlgItemText,[pWnd],box3_output,BASE2
				invoke SetDlgItemText,[pWnd],box4_output,timeOcho
				invoke SetDlgItemText,[pWnd],box5_output,aulaINFLAB
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			
		mieDocThree:
			call takeHorA
			cmp edx,6
			jb noSubjectsNow
			je mieSeisDocThree
			cmp edx,7
			je mieSieteDocThree
			cmp edx,8
			je mieOchoDocThree
			cmp edx,9
			je mieNueveDocThree
			cmp edx,10
			je mieDiezDocThree
			cmp edx,11
			je mieOnceDocThree
			ja noSubjectsToday
			
			
			mieSeisDocThree:
				call takeMinA
				cmp edx,45
				jb noSubjectsNow
				jmp mieFunct
			mieSieteDocThree:
				mov [bAtraso],1
				jmp mieBASE2A
			mieOchoDocThree:
				call takeMinA
				cmp edx,15
				jb marSieteDocThree
				cmp edx,30
				jb mieBASE2A
				mov [bAtraso],1
				jmp mieBASE2A
			mieNueveDocThree:
				call takeMinA
				cmp edx,45
				jae mieBASE2B
				mov [bAtraso],1
				jmp marBASE2A
			mieDiezDocThree:
				mov [bAtraso],1
				jmp mieBASE2B
			mieOnceDocThree:
				call takeMinA
				cmp edx,15
				jae noSubjectsToday
				jmp mieDiezDocThree
			
			
			mieBASE2A:
				invoke SetDlgItemText,[pWnd],box3_output,BASE2
				invoke SetDlgItemText,[pWnd],box4_output,timeOcho
				invoke SetDlgItemText,[pWnd],box5_output,aula617
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			mieFunct:
				invoke SetDlgItemText,[pWnd],box3_output,Funcional
				invoke SetDlgItemText,[pWnd],box4_output,timeSeis
				invoke SetDlgItemText,[pWnd],box5_output,aula612
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			mieBASE2B:
				invoke SetDlgItemText,[pWnd],box3_output,BASE2
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aula612
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			
			
		
	
	DocFourSchedule:
		cmp edx,1
		je lunDocFour
		cmp edx,2
		je marDocFour
		cmp edx,3
		je mieDocFour
		cmp edx,4
		je jueDocFour
		cmp edx,5
		je vieDocFour
		jmp noSubjectsToday
		
		lunDocFour:
			call takeHorA
			cmp edx,8
			jb noSubjectsNow
			je lunTSO
			cmp edx,9
			je lunTSOLaterOrNets
			cmp edx,10
			je lunNetsLater
			cmp edx,11
			je lunNetsLaterB
			cmp edx,14
			jb noSubjectsNow
			je lunNetsB
			cmp edx,15
			je lunNetsBLaterOrTSOB
			cmp edx,16
			je lunTSOBLater
			cmp edx,17
			je lunTSOBLaterOrNo
			ja noSubjectsToday
		
			lunTSO:
				call takeMinA
				cmp edx,15
				jb noSubjectsNow
				invoke SetDlgItemText,[pWnd],box3_output,TSO
				invoke SetDlgItemText,[pWnd],box4_output,timeOcho
				invoke SetDlgItemText,[pWnd],box5_output,aula690E
				cmp edx,30
				jae msgLater
				jmp finSetSchedule
			lunTSOLaterOrNets:
				call takeMinA
				cmp edx,45
				jb lunTSOLater
				invoke SetDlgItemText,[pWnd],box3_output,Redes
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aula691B
				jmp finSetSchedule
				lunTSOLater:
					invoke SetDlgItemText,[pWnd],box3_output,TSO
					invoke SetDlgItemText,[pWnd],box4_output,timeOcho
					invoke SetDlgItemText,[pWnd],box5_output,aula690E
					jmp msgLater
				
			lunNetsLater:
				invoke SetDlgItemText,[pWnd],box3_output,Redes
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aula691B
				jmp msgLater
				
			lunNetsLaterB:
				call takeMinA
				cmp edx,15
				jae noSubjectsNow
				jmp lunNetsLater
				
			lunNetsB:
				call takeMinA
				cmp edx,15
				jb noSubjectsNow
				invoke SetDlgItemText,[pWnd],box3_output,Redes
				invoke SetDlgItemText,[pWnd],box4_output,timeDos
				invoke SetDlgItemText,[pWnd],box5_output,aula692B
				cmp edx,30
				jae msgLater
				jmp finSetSchedule
			
			lunNetsBLaterOrTSOB:
				call takeMinA
				cmp edx,45
				jb lunNetsBLater
				invoke SetDlgItemText,[pWnd],box3_output,TSO
				invoke SetDlgItemText,[pWnd],box4_output,timeTres
				invoke SetDlgItemText,[pWnd],box5_output,aula692C
				jmp finSetSchedule
				
				lunNetsBLater:
				invoke SetDlgItemText,[pWnd],box3_output,Redes
				invoke SetDlgItemText,[pWnd],box4_output,timeDos
				invoke SetDlgItemText,[pWnd],box5_output,aula692B
				jmp msgLater
				
			lunTSOBLater:
				invoke SetDlgItemText,[pWnd],box3_output,TSO
				invoke SetDlgItemText,[pWnd],box4_output,timeTres
				invoke SetDlgItemText,[pWnd],box5_output,aula692C
				jmp msgLater
			lunTSOBLaterOrNo:
				call takeMinA
				cmp edx,15
				jb lunTSOBLater
				jae noSubjectsToday 
		
		marDocFour:
			call takeHorA
			cmp edx,9
			jb noSubjectsNow
			je marNets
			cmp edx,10
			je marNetsLater
			cmp edx,11
			je marNetsLaterB
			ja noSubjectsToday
			marNets:
				call takeMinA
				cmp edx,45
				jb noSubjectsNow
				invoke SetDlgItemText,[pWnd],box3_output,Redes
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aula693A
				jmp finSetSchedule
			marNetsLater:
				invoke SetDlgItemText,[pWnd],box3_output,Redes
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aula693A
				jmp msgLater
			marNetsLaterB:
				call takeMinA
				cmp edx,15
				jb marNetsLater
				jmp noSubjectsToday
		
		mieDocFour:
			call takeHorA
			cmp edx,9
			jb noSubjectsNow
			je mieNets
			cmp edx,10
			je	mieNetsLater
			cmp edx,11
			je mieNetsLaterB
			cmp edx,12
			je noSubjectsNow
			cmp edx,13
			je noSubjectsNow
			cmp edx,14
			je mieTSOA
			cmp edx,15
			je	mieTSOALaterOrB
			cmp edx,16
			je 	mieTSOBLater
			cmp edx,17
			je	mieTSOBLaterB
			ja noSubjectsToday
			
			mieNets:
				call takeMinA
				cmp edx,45
				jb noSubjectsNow
				invoke SetDlgItemText,[pWnd],box3_output,Redes
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aula693A
				jmp finSetSchedule
				
			mieNetsLater:
				invoke SetDlgItemText,[pWnd],box3_output,Redes
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aula693A
				jmp msgLater
			
			mieNetsLaterB:
				call takeMinA
				cmp edx,15
				jb mieNetsLater
				jmp noSubjectsNow
				
			mieTSOA:
				call takeMinA
				cmp edx,15
				jb noSubjectsNow
				invoke SetDlgItemText,[pWnd],box3_output,TSO
				invoke SetDlgItemText,[pWnd],box4_output,timeDos
				invoke SetDlgItemText,[pWnd],box5_output,aula691A
				cmp edx,30
				jae msgLater
				jmp finSetSchedule
			mieTSOALaterOrB:
				call takeMinA
				cmp edx,45
				jb mieTSOALater
				invoke SetDlgItemText,[pWnd],box3_output,TSO
				invoke SetDlgItemText,[pWnd],box4_output,timeTres
				invoke SetDlgItemText,[pWnd],box5_output,aula617C
			mieTSOALater:
				invoke SetDlgItemText,[pWnd],box3_output,TSO
				invoke SetDlgItemText,[pWnd],box4_output,timeDos
				invoke SetDlgItemText,[pWnd],box5_output,aula691A
				jmp msgLater
			mieTSOBLater:
				invoke SetDlgItemText,[pWnd],box3_output,TSO
				invoke SetDlgItemText,[pWnd],box4_output,timeTres
				invoke SetDlgItemText,[pWnd],box5_output,aula617C
				jmp msgLater
			mieTSOBLaterB:
				call takeHorA
				cmp edx,15
				jae noSubjectsToday
				jmp mieTSOBLater
				
		jueDocFour:
			call takeHorA
			cmp edx,9
			jb noSubjectsNow
			je jueNets
			cmp edx,10
			je jueNetsLater
			cmp edx,11
			je jueNetsLaterB
			ja noSubjectsToday
			jueNets:
				call takeMinA
				cmp edx,45
				jb noSubjectsNow
				invoke SetDlgItemText,[pWnd],box3_output,Redes
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aula693A
				jmp finSetSchedule
			jueNetsLater:
				invoke SetDlgItemText,[pWnd],box3_output,Redes
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aula693A
				jmp msgLater
			jueNetsLaterB:
				call takeMinA
				cmp edx,15
				jb jueNetsLater
				jmp noSubjectsToday
		
		vieDocFour:
			call takeHorA
			cmp edx,8
			jb noSubjectsNow
			je vieTSO
			cmp edx,9
			je vieTSOLaterOrNets
			cmp edx,10
			je vieNetsLater
			cmp edx,11
			je vieNetsLaterB
			cmp edx,14
			jb noSubjectsNow
			je vieNetsB
			cmp edx,15
			je vieNetsBLaterOrNO
			ja noSubjectsToday
		
			vieTSO:
				call takeMinA
				cmp edx,15
				jb noSubjectsNow
				invoke SetDlgItemText,[pWnd],box3_output,TSO
				invoke SetDlgItemText,[pWnd],box4_output,timeOcho
				invoke SetDlgItemText,[pWnd],box5_output,aula624
				cmp edx,30
				jae msgLater
				jmp finSetSchedule
			vieTSOLaterOrNets:
				call takeMinA
				cmp edx,45
				jb vieTSOLater
				invoke SetDlgItemText,[pWnd],box3_output,Redes
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aula692C
				jmp finSetSchedule
				vieTSOLater:
					invoke SetDlgItemText,[pWnd],box3_output,TSO
					invoke SetDlgItemText,[pWnd],box4_output,timeOcho
					invoke SetDlgItemText,[pWnd],box5_output,aula624
					jmp msgLater
				
			vieNetsLater:
				invoke SetDlgItemText,[pWnd],box3_output,Redes
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aula692C
				jmp msgLater
				
			vieNetsLaterB:
				call takeMinA
				cmp edx,15
				jae noSubjectsNow
				jmp vieNetsLater
				
			vieNetsB:
				call takeMinA
				cmp edx,15
				jb noSubjectsNow
				invoke SetDlgItemText,[pWnd],box3_output,Redes
				invoke SetDlgItemText,[pWnd],box4_output,timeDos
				invoke SetDlgItemText,[pWnd],box5_output,aula691C
				cmp edx,30
				jae msgLater
				jmp finSetSchedule
			
			vieNetsBLaterOrNO:
				call takeMinA
				cmp edx,45
				jae noSubjectsToday
				invoke SetDlgItemText,[pWnd],box3_output,TSO
				invoke SetDlgItemText,[pWnd],box4_output,timeTres
				invoke SetDlgItemText,[pWnd],box5_output,aula692C
				jmp msgLater	
	
	DocFiveSchedule:
		cmp edx,1
		;;;;;jb noSubjectsToday
		je lunDocFive
		cmp edx,2
		je marDocFive
		cmp edx,3
		je mieDocFive
		cmp edx,4
		je jueDocFive
		cmp edx,5
		je vieDocFive
		cmp edx,6
		je sabDocFive
		jmp noSubjectsToday
		
		lunDocFive:
			call takeHorA
			cmp edx,9
			jb noSubjectsNow
			je lunNueveDocFive
			cmp edx,10
			je lunDiezDocFive
			cmp edx,11
			je lunOnceDocFive
			ja noSubjectsToday
			lunNueveDocFive:
				call takeMinA
				cmp edx,45
				jb noSubjectsNow
				jmp lunTALF
			lunDiezDocFive:
				mov [bAtraso],1
				jmp lunTALF
			lunOnceDocFive:
				call takeMinA
				cmp edx,15
				je lunDiezDocFive
				jmp noSubjectsToday
			
			lunTALF:
				invoke SetDlgItemText,[pWnd],box3_output,TALF
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aula692H
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
				
		marDocFive:
			call takeHorA
			cmp edx,9
			jb noSubjectsNow
			je marNueveDocFive
			cmp edx,10
			je marDiezDocFive
			cmp edx,11
			je marOnceDocFive
			ja noSubjectsToday
			marNueveDocFive:
				call takeMinA
				cmp edx,45
				jb noSubjectsNow
				jmp marTALF
			marDiezDocFive:
				mov [bAtraso],1
				jmp marTALF
			marOnceDocFive:
				call takeMinA
				cmp edx,15
				je marDiezDocFive
				jmp noSubjectsToday
			
			marTALF:
				invoke SetDlgItemText,[pWnd],box3_output,TALF
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aula617C
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			
		mieDocFive:
			call takeHorA
			cmp edx,9
			jb noSubjectsNow
			je mieNueveDocFive
			cmp edx,10
			je mieDiezDocFive
			cmp edx,11
			je mieOnceDocFive
			ja noSubjectsToday
			mieNueveDocFive:
				call takeMinA
				cmp edx,45
				jb noSubjectsNow
				jmp mieIntro
			mieDiezDocFive:
				mov [bAtraso],1
				jmp mieIntro
			mieOnceDocFive:
				call takeMinA
				cmp edx,15
				je mieDiezDocFive
				jmp noSubjectsToday
			
			mieIntro:
				invoke SetDlgItemText,[pWnd],box3_output,IntroProg
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aula690B
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
		
		jueDocFive:
			call takeHorA
			cmp edx,8
			jb noSubjectsNow
			je jueOchoDocFive
			cmp edx,9
			je jueNueveDocFive
			cmp edx,10
			je jueDiezDocFive
			cmp edx,11
			je jueOnceDocFive
			ja noSubjectsToday
			
			jueOchoDocFive:
				call takeMinA
				cmp edx,15
				jb noSubjectsNow
				cmp edx,30
				jb jueTG
				mov [bAtraso],1
				jmp jueTG
			jueNueveDocFive:
				call takeMinA
				cmp edx,45
				jae jueIntro
				mov [bAtraso],1
				jmp jueTG
			jueDiezDocFive:
				mov [bAtraso],1
				jmp jueIntro
			jueOnceDocFive:
				call takeMinA
				cmp edx,15
				jae noSubjectsToday
				jmp jueDiezDocFive
			jueTG:
				invoke SetDlgItemText,[pWnd],box3_output,TG
				invoke SetDlgItemText,[pWnd],box4_output,timeOcho
				invoke SetDlgItemText,[pWnd],box5_output,aulaINFDEP
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			jueIntro:
				invoke SetDlgItemText,[pWnd],box3_output,IntroProg
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aula623
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
		vieDocFive:
			call takeHorA
			cmp edx,8
			jb noSubjectsNow
			je vieOchoDocFive
			cmp edx,9
			je vieNueveDocFive
			cmp edx,10
			je vieDiezDocFive
			cmp edx,11
			je vieOnceDocFive
			jmp noSubjectsToday
			
			vieOchoDocFive:
				call takeMinA
				cmp edx,15
				jb noSubjectsNow
				cmp edx,30
				jb vieTALF
				mov [bAtraso],1
				jmp vieTALF
			vieNueveDocFive:
				call takeMinA
				cmp edx,45
				jae vieTG
				mov [bAtraso],1
				jmp vieTALF
			vieDiezDocFive:
				mov [bAtraso],1
				jmp vieTG
			vieOnceDocFive:
				call takeMinA
				cmp edx,15
				jae noSubjectsToday
				jmp vieDiezDocFive
			vieTALF:
				invoke SetDlgItemText,[pWnd],box3_output,TALF
				invoke SetDlgItemText,[pWnd],box4_output,timeOcho
				invoke SetDlgItemText,[pWnd],box5_output,aula652
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			vieTG:
				invoke SetDlgItemText,[pWnd],box3_output,TG
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aulaINFLAB
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
			
		sabDocFive:
			call takeHorA
			cmp edx,9
			jb noSubjectsNow
			je sabNueveDocFive
			cmp edx,10
			je sabDiezDocFive
			cmp edx,11
			je sabOnceDocFive
			ja noSubjectsToday
			sabNueveDocFive:
				call takeMinA
				cmp edx,45
				jb noSubjectsNow
				jmp sabIntroDocFive
			sabDiezDocFive:
				mov [bAtraso],1
				jmp sabIntroDocFive
			sabOnceDocFive:
				call takeMinA
				cmp edx,15
				je sabDiezDocFive
				jmp noSubjectsToday
			
			sabIntroDocFive:
				invoke SetDlgItemText,[pWnd],box3_output,IntroProg
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aula691C
				cmp [bAtraso],1
				je msgLater
				jmp finSetSchedule
		
			
	noSubjectsNow:
		invoke SetDlgItemText,[pWnd],box6_output,noSubjNow
		jmp finSetSchedule
	noSubjectsToday:
		invoke SetDlgItemText,[pWnd],box6_output,noSubjToday
		jmp finSetSchedule
	msgLater:
		invoke SetDlgItemText,[pWnd],box6_output,later
		mov [bAtraso],0
	
	finSetSchedule:
	ret
endp

proc takeHorA
	mov edx,1
	mov dx,[myDate.wHour]
	;mov dx,6
	ret
endp
proc takeMinA
	mov edx,1
	mov dx,[myDate.wMinute]
	;mov dx,44
	ret
endp

proc takeDayWeekA
	mov edx,1
	mov dx,[myDate.wDayOfWeek]
	;mov dx,5
	ret
endp

proc clearBoxes
	invoke SetDlgItemText,[pWnd],box2_output,voidMsg
	invoke SetDlgItemText,[pWnd],box3_output,voidMsg
	invoke SetDlgItemText,[pWnd],box4_output,voidMsg
	invoke SetDlgItemText,[pWnd],box5_output,voidMsg
	invoke SetDlgItemText,[pWnd],box6_output,voidMsg
	ret
endp

proc setSubject
	
	cmp bl,[DocOne]					;;;;;;;;;DOCENTE 1, MARCO MONTECINOS....
	jne otherDoc2Subj						;;;;;;;;HORARIO 1, BAJO NIVEL
	ret
endp
section '.idata' import data readable writeable
  ;importamos solo los procedimientos basicos para abrir una ventana
  
  ;otra forma para importar los procedimientos importando archivos INC
  library kernel32,'KERNEL32.DLL',user32,'USER32.DLL',gdi32,'GDI32.DLL'
  include 'api\kernel32.inc'
  include 'api\user32.inc'
  include 'api\gdi32.inc'

section '.rsrc' resource from 'ControlIngreso.res' data readable
