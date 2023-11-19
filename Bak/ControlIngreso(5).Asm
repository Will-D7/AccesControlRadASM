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
noSubjToday 	db 'No tiene Clases HOY',0
noSubjNow		db 'No tiene Clases AHORA',0
later			db 'ATRASO',0
;;;;;;;;;;;;;;;; AULAS ;;;;;;;;;;;;;;;;;;;;;;;
aula617			db 	'617',0
aula617A		db 	'617A',0
aula617C		db 	'617C',0
aula622			db	'622',0
aula623			db	'623',0
aula624			db	'624',0
aula651			db 	'651',0
aula652			db 	'652',0
aulaINFLAB		db 	'INFLAB',0
aula690B		db 	'690B',0
aula690C		db	'690C',0
aula690D		db	'690D',0
aula691A		db 	'691A',0
aula691B		db 	'691B',0
aula691C		db	'691C',0
aula692H		db	'692H',0
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
RedesAvanzadas 	db 'TECNOLOGIA REDES AVANZADAS',0


ciTwo			dd 7070707
DocTwo 			db 'BLANCO COCA LETICIA',0
IntroProg		db 'INTRODUCCION A LA PROGRAMACION',0
EPED			db 'ELEMENTOS DE PROGRAMACION Y ESTRUCTURA DE DATOS',0
AlgoAva			db 'ALGORITMOS AVANZADOS',0
TIS				db 'TALLER DE INGENIERIA DE SOFTWARE',0

ciThree			dd 6060606
DocThree		db 'APARICIO YUJA TATIANA',0
Funcional		db 'PROGRAMACION FUNCIONAL',0
BASE2			DB 'BASE DE DATOS 2',0

ciFour			dd 5050505
DocFour			db 'ORELLANA ARAOZ JORGE WALTER',0
TSO				db 'TALLER DE SISTEMAS OPERATIVOS',0
Redes			db 'REDES DE COMPUTADORAS',0

ciFive			dd 4040404
DocFive			db 'MONTANO QUIROGA VICTOR HUGO',0
TALF			db 'TEORIA DE AUTOMATAS Y LENGUAJES FORMALES',0

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
		call takeDayWeekA
		cmp edx,2	;[dia1TPBNG1]		;;DOCENTE 1, MARCO MONTECINOS, 2 MATERIAS,total 3G
		JB noSubjectsToday			; hay clase del dia 2=martes al dia 4=jueves
		cmp edx,4
		ja noSubjectsToday
			mov edx,1
			mov dx,[myDate.wHour]	;Verificar hora para el docente que tiene clases martes,miercoles y jueves
				cmp edx,11
				ja verifyDoce
				mov edx,1
				mov dx,[myDate.wMinute]
				cmp edx,15
				jb noSubjectsNow
				invoke SetDlgItemText,[pWnd],box3_output,TPBN
				invoke SetDlgItemText,[pWnd],box4_output,timeOnce
				cmp edx,30
				jae msgLater
				jmp finSetSchedule
				
				verifyDoce:
					cmp edx,12
					jne verifyDos		;;
					mov edx,1
					mov dx,[myDate.wMinute]
					cmp edx,45
					jb noSubjectsNow
					invoke SetDlgItemText,[pWnd],box3_output,RedesAvanzadas
					invoke SetDlgItemText,[pWnd],box4_output,timeDoce
					jmp finSetSchedule
					
				verifyDos:
					cmp edx,14
					ja verifyTres
					mov edx,1
					mov dx,[myDate.wMinute]
					cmp edx,15
					jae setDosDocOne
					invoke SetDlgItemText,[pWnd],box3_output,RedesAvanzadas
					invoke SetDlgItemText,[pWnd],box4_output,timeDoce
					jmp msgLater
					setDosDocOne:
						invoke SetDlgItemText,[pWnd],box3_output,RedesAvanzadas
						invoke SetDlgItemText,[pWnd],box4_output,timeDos
						cmp edx,30
						jae msgLater
						jmp finSetSchedule
				
				verifyTres:
					cmp edx,15
					ja verifyLaterTPBN
					mov edx,1
					mov dx,[myDate.wMinute]
					cmp edx,45
					jb noSubjectsNow
					invoke SetDlgItemText,[pWnd],box3_output,TPBN
					invoke SetDlgItemText,[pWnd],box4_output,timeTres
					jmp finSetSchedule
					
				verifyLaterTPBN:
					cmp edx,17
					ja noSubjectsNow
					mov edx,1
					mov dx,[myDate.wMinute]
					cmp edx,15
					jae noSubjectsNow
					invoke SetDlgItemText,[pWnd],box3_output,TPBN
					invoke SetDlgItemText,[pWnd],box4_output,timeTres
					jmp msgLater
					
					;
				
	
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
			ja verifyLaterEPEDG2
			jb noSubjectsNow
				call takeMinA
				cmp edx,45
				jb noSubjectsNow
				invoke SetDlgItemText,[pWnd],box3_output,EPED
				invoke SetDlgItemText,[pWnd],box4_output,timeDoce
				invoke SetDlgItemText,[pWnd],box5_output,aula623
				jmp finSetSchedule
			verifyLaterEPEDG2:
				cmp edx,14
				ja noSubjectsNow
				invoke SetDlgItemText,[pWnd],box3_output,EPED
				invoke SetDlgItemText,[pWnd],box4_output,timeDoce
				invoke SetDlgItemText,[pWnd],box5_output,aula623
				jmp msgLater
				;;
		
		marDocTwo:
			call takeHorA
			cmp edx,6
			ja verifyLaterAA
			jb noSubjectsNow
				call takeMinA
				cmp edx,45
				jb noSubjectsNow
				invoke SetDlgItemText,[pWnd],box3_output,AlgoAva
				invoke SetDlgItemText,[pWnd],box4_output,timeSeis
				invoke SetDlgItemText,[pWnd],box5_output,aula691A
				jmp finSetSchedule
			verifyLaterAA:
				cmp edx,8
				ja verifyLaterTIS
				call takeMinA
				cmp edx,15
				jae verifyTIS
				invoke SetDlgItemText,[pWnd],box3_output,AlgoAva
				invoke SetDlgItemText,[pWnd],box4_output,timeSeis
				invoke SetDlgItemText,[pWnd],box5_output,aula691A
				jmp msgLater
				
			verifyTIS:
				invoke SetDlgItemText,[pWnd],box3_output,TIS
				invoke SetDlgItemText,[pWnd],box4_output,timeOcho
				invoke SetDlgItemText,[pWnd],box5_output,aula651
				cmp edx,30
				jae msgLater
				jmp finSetSchedule
			
			verifyLaterTIS:
				cmp edx,9
				ja setIntroProg
				invoke SetDlgItemText,[pWnd],box3_output,TIS
				invoke SetDlgItemText,[pWnd],box4_output,timeOcho
				invoke SetDlgItemText,[pWnd],box5_output,aula651
				jmp msgLater
				
			setIntroProg:
				cmp edx,17
				jne verifyLaterIntro	
				call takeMinA
				cmp edx,15
				jb noSubjectsNow
				invoke SetDlgItemText,[pWnd],box3_output,IntroProg
				invoke SetDlgItemText,[pWnd],box4_output,timeCinco
				invoke SetDlgItemText,[pWnd],box5_output,aula617
				cmp edx,30
				jae msgLater
				jmp finSetSchedule
				
				verifyLaterIntro:
					cmp edx,18
					ja verifyLaterEPEDG3
					call takeMinA
					cmp edx,45
					jae verifyEPEDG3
					invoke SetDlgItemText,[pWnd],box3_output,IntroProg
					invoke SetDlgItemText,[pWnd],box4_output,timeCinco
					invoke SetDlgItemText,[pWnd],box5_output,aula617
					jmp msgLater
			
			verifyEPEDG3:
				invoke SetDlgItemText,[pWnd],box3_output,EPED
				invoke SetDlgItemText,[pWnd],box4_output,timeSeisT
				invoke SetDlgItemText,[pWnd],box5_output,aula622
				jmp finSetSchedule
				
			verifyLaterEPEDG3:
				cmp edx,20
				ja noSubjectsToday
				call takeMinA
				cmp edx,15
				ja noSubjectsToday
				invoke SetDlgItemText,[pWnd],box3_output,EPED
				invoke SetDlgItemText,[pWnd],box4_output,timeSeisT
				invoke SetDlgItemText,[pWnd],box5_output,aula622
				jmp msgLater
			
		mieDocTwo:
			call takeHorA
			cmp edx,6
			ja verifyLater3EPEDG3
			call takeMinA
			cmp edx,45
			jb noSubjectsNow
			invoke SetDlgItemText,[pWnd],box3_output,EPED
			invoke SetDlgItemText,[pWnd],box4_output,timeSeis
			invoke SetDlgItemText,[pWnd],box5_output,aula691C
			JMP finSetSchedule
			verifyLater3EPEDG3:
				cmp edx,8
				ja verify3TIS
				call takeMinA
				cmp edx,15
				jae verify3TIS
				invoke SetDlgItemText,[pWnd],box3_output,EPED
				invoke SetDlgItemText,[pWnd],box4_output,timeSeis
				invoke SetDlgItemText,[pWnd],box5_output,aula691C
				jmp msgLater
						
			verify3TIS:
				call takeHorA
				cmp edx,8
				ja verify3EPEDG2
				invoke SetDlgItemText,[pWnd],box3_output,TIS
				invoke SetDlgItemText,[pWnd],box4_output,timeOcho
				invoke SetDlgItemText,[pWnd],box5_output,aulaINFLAB
				call takeMinA
				cmp edx,30
				ja msgLater
				jmp finSetSchedule
			verify3EPEDG2:
				cmp edx,15
				jne verifyLater3EPEDG2
				call takeMinA
				cmp edx,45
				jb noSubjectsNow
				invoke SetDlgItemText,[pWnd],box3_output,EPED
				invoke SetDlgItemText,[pWnd],box4_output,timeTres
				invoke SetDlgItemText,[pWnd],box5_output,aula623
				jmp finSetSchedule
				verifyLater3EPEDG2:
					invoke SetDlgItemText,[pWnd],box3_output,EPED
					invoke SetDlgItemText,[pWnd],box4_output,timeTres
					invoke SetDlgItemText,[pWnd],box5_output,aula623
					cmp edx,17
					jne verifyLater3IntroProg
					call takeMinA
					cmp edx,15
					jae verify3IntroProg
					jmp msgLater
					
				verify3IntroProg:
					call takeMinA
					cmp edx,30
					ja verifyLater3IntroProg
					invoke SetDlgItemText,[pWnd],box3_output,EPED
					invoke SetDlgItemText,[pWnd],box4_output,timeCinco
					invoke SetDlgItemText,[pWnd],box5_output,aula691B
					jmp finSetSchedule
					
				verifyLater3IntroProg:
					call takeHorA
					cmp edx,18
					jne noSubjectsToday
					call takeMinA
					cmp edx,45
					ja noSubjectsToday
					invoke SetDlgItemText,[pWnd],box3_output,EPED
					invoke SetDlgItemText,[pWnd],box4_output,timeCinco
					invoke SetDlgItemText,[pWnd],box5_output,aula691B
					jmp msgLater
		jueDocTwo:					;;;;;;;;;;;:::::::::::::::::
			call takeHorA
			cmp edx,6
			jb noSubjectsNow
			ja verifyLater4AV
			call takeMinA
			cmp edx,45
			jb noSubjectsNow
			invoke SetDlgItemText,[pWnd],box3_output,AlgoAva
			invoke SetDlgItemText,[pWnd],box4_output,timeSeis
			invoke SetDlgItemText,[pWnd],box5_output,aula690D
			jmp finSetSchedule
			verifyLater4AV:
				cmp edx,7
				ja verifyLater4AVb
				invoke SetDlgItemText,[pWnd],box3_output,AlgoAva
				invoke SetDlgItemText,[pWnd],box4_output,timeSeis
				invoke SetDlgItemText,[pWnd],box5_output,aula690D
				jmp msgLater
				verifyLater4AVb:
				cmp edx,8
				ja verify4EPED
				call takeMinA
				cmp edx,15
				jae noSubjectsNow
				invoke SetDlgItemText,[pWnd],box3_output,AlgoAva
				invoke SetDlgItemText,[pWnd],box4_output,timeSeis
				invoke SetDlgItemText,[pWnd],box5_output,aula690D
				jmp msgLater
			verify4EPED:
			cmp edx,12
			jb noSubjectsNow
			ja verifyLater4EPED
			call takeMinA
			cmp edx,45
			jb noSubjectsNow
			invoke SetDlgItemText,[pWnd],box3_output,EPED
			invoke SetDlgItemText,[pWnd],box4_output,timeDoce
			invoke SetDlgItemText,[pWnd],box5_output,aula690C
			jmp finSetSchedule
			
			verifyLater4EPED:
				cmp edx,13
				ja verifyLater4EPEDb
				invoke SetDlgItemText,[pWnd],box3_output,EPED
				invoke SetDlgItemText,[pWnd],box4_output,timeDoce
				invoke SetDlgItemText,[pWnd],box5_output,aula690C
				jmp msgLater
				verifyLater4EPEDb:
					cmp edx,14
					ja verify4IntroProgra
					call takeMinA
					cmp edx,15
					jae noSubjectsNow
					invoke SetDlgItemText,[pWnd],box3_output,EPED
					invoke SetDlgItemText,[pWnd],box4_output,timeDoce
					invoke SetDlgItemText,[pWnd],box5_output,aula690C
					jmp msgLater
			verify4IntroProgra:
				cmp edx,15
				jb noSubjectsNow
				ja verifyLater4IntroProgra
				call takeMinA
				cmp edx,45
				jb noSubjectsNow
				invoke SetDlgItemText,[pWnd],box3_output,IntroProg
				invoke SetDlgItemText,[pWnd],box4_output,timeTres
				invoke SetDlgItemText,[pWnd],box5_output,aula624
				jmp finSetSchedule
				verifyLater4IntroProgra:
					cmp edx,16
					ja verifyLater4IntroPrograB
					invoke SetDlgItemText,[pWnd],box3_output,IntroProg
					invoke SetDlgItemText,[pWnd],box4_output,timeTres
					invoke SetDlgItemText,[pWnd],box5_output,aula624
					jmp msgLater
					verifyLater4IntroPrograB:
						cmp edx,17
						ja noSubjectsNow
						call takeMinA
						cmp edx,15
						jae noSubjectsNow
						invoke SetDlgItemText,[pWnd],box3_output,IntroProg
						invoke SetDlgItemText,[pWnd],box4_output,timeTres
						invoke SetDlgItemText,[pWnd],box5_output,aula624
						jmp msgLater
		vieDocTwo:
			call takeHorA
			cmp edx,6
			jb noSubjectsNow
			cmp edx,7
			ja verifyLater5AV
			invoke SetDlgItemText,[pWnd],box3_output,AlgoAva
			invoke SetDlgItemText,[pWnd],box4_output,timeSeis
			invoke SetDlgItemText,[pWnd],box5_output,aula693D
			jmp msgLater
			verifyLater5AV:
				cmp edx,8
				ja noSubjectsNow
				call takeMinA
				cmp edx,15
				jae noSubjectsNow
				invoke SetDlgItemText,[pWnd],box3_output,AlgoAva
				invoke SetDlgItemText,[pWnd],box4_output,timeTres
				invoke SetDlgItemText,[pWnd],box5_output,aula693D
				
				jmp msgLater
	
	DocThreeSchedule:
		jmp finSetSchedule
	DocFourSchedule:
		jmp finSetSchedule
	DocFiveSchedule:
		cmp edx,1
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
			ja lunDocFiveLater
			call takeMinA
			cmp edx,45
			jb noSubjectsNow
			invoke SetDlgItemText,[pWnd],box3_output,TALF
			invoke SetDlgItemText,[pWnd],box4_output,timeNueve
			invoke SetDlgItemText,[pWnd],box5_output,aula692H
			jmp finSetSchedule
			lunDocFiveLater:
				cmp edx,10
				ja lunDocFiveLaterB
				invoke SetDlgItemText,[pWnd],box3_output,TALF
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aula692H
				jmp msgLater
				lunDocFiveLaterB:
					cmp edx,11
					ja noSubjectsToday
					call takeMinA
					cmp edx,15
					jae noSubjectsToday
					invoke SetDlgItemText,[pWnd],box3_output,TALF
					invoke SetDlgItemText,[pWnd],box4_output,timeNueve
					invoke SetDlgItemText,[pWnd],box5_output,aula692H
					jmp msgLater
			
		marDocFive:
			call takeHorA
			cmp edx,9
			jb noSubjectsNow
			ja marDocFiveLater
			call takeMinA
			cmp edx,45
			jb noSubjectsNow
			invoke SetDlgItemText,[pWnd],box3_output,TALF
			invoke SetDlgItemText,[pWnd],box4_output,timeNueve
			invoke SetDlgItemText,[pWnd],box5_output,aula617C
			jmp finSetSchedule
			marDocFiveLater:
				cmp edx,10
				ja marDocFiveLaterB
				invoke SetDlgItemText,[pWnd],box3_output,TALF
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aula617C
				jmp msgLater
				marDocFiveLaterB:
					cmp edx,11
					ja noSubjectsToday
					call takeMinA
					cmp edx,15
					jae noSubjectsToday
					invoke SetDlgItemText,[pWnd],box3_output,TALF
					invoke SetDlgItemText,[pWnd],box4_output,timeNueve
					invoke SetDlgItemText,[pWnd],box5_output,aula617C
					jmp msgLater
		mieDocFive:
			call takeHorA
			cmp edx,9
			jb noSubjectsNow
			ja mieDocFiveLater
			call takeMinA
			cmp edx,45
			jb noSubjectsNow
			invoke SetDlgItemText,[pWnd],box3_output,IntroProg
			invoke SetDlgItemText,[pWnd],box4_output,timeNueve
			invoke SetDlgItemText,[pWnd],box5_output,aula690B
			jmp finSetSchedule
			mieDocFiveLater:
				cmp edx,10
				ja mieDocFiveLaterB
				invoke SetDlgItemText,[pWnd],box3_output,IntroProg
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aula690B
				jmp msgLater
				mieDocFiveLaterB:
					cmp edx,11
					ja noSubjectsToday
					call takeMinA
					cmp edx,15
					jae noSubjectsToday
					invoke SetDlgItemText,[pWnd],box3_output,IntroProg
					invoke SetDlgItemText,[pWnd],box4_output,timeNueve
					invoke SetDlgItemText,[pWnd],box5_output,aula690B
					jmp msgLater
		
		jueDocFive:
			call takeHorA
			cmp edx,9
			jb noSubjectsNow
			ja jueDocFiveLater
			call takeMinA
			cmp edx,45
			jb noSubjectsNow
			invoke SetDlgItemText,[pWnd],box3_output,IntroProg
			invoke SetDlgItemText,[pWnd],box4_output,timeNueve
			invoke SetDlgItemText,[pWnd],box5_output,aula623
			jmp finSetSchedule
			jueDocFiveLater:
				cmp edx,10
				ja jueDocFiveLaterB
				invoke SetDlgItemText,[pWnd],box3_output,IntroProg
				invoke SetDlgItemText,[pWnd],box4_output,timeNueve
				invoke SetDlgItemText,[pWnd],box5_output,aula623
				jmp msgLater
				jueDocFiveLaterB:
					cmp edx,11
					ja noSubjectsToday
					call takeMinA
					cmp edx,15
					jae noSubjectsToday
					invoke SetDlgItemText,[pWnd],box3_output,IntroProg
					invoke SetDlgItemText,[pWnd],box4_output,timeNueve
					invoke SetDlgItemText,[pWnd],box5_output,aula623
					jmp msgLater
			
		vieDocFive:
			call takeHorA
			cmp edx,8
			jb noSubjectsNow
			cmp edx,9
			ja noSubjectsToday
			cmp edx,8
			jne vieDocFiveLater
			call takeMinA
			cmp edx,15
			jb noSubjectsNow
			cmp edx,30
			jae vieDocFiveLater			
			invoke SetDlgItemText,[pWnd],box3_output,TALF
			invoke SetDlgItemText,[pWnd],box4_output,timeOcho
			invoke SetDlgItemText,[pWnd],box5_output,aula652
			jmp finSetSchedule
			vieDocFiveLater:
				call takeMinA
				cmp edx,45
				jae noSubjectsToday
				invoke SetDlgItemText,[pWnd],box3_output,TALF
				invoke SetDlgItemText,[pWnd],box4_output,timeOcho
				invoke SetDlgItemText,[pWnd],box5_output,aula652
				jmp msgLater
		sabDocFive:
		

	noSubjectsNow:
		invoke SetDlgItemText,[pWnd],box6_output,noSubjNow
		jmp finSetSchedule
	noSubjectsToday:
		invoke SetDlgItemText,[pWnd],box6_output,noSubjToday
		jmp finSetSchedule
	msgLater:
	invoke SetDlgItemText,[pWnd],box6_output,later
	finSetSchedule:
	ret
endp

proc takeHorA
	mov edx,1
	;mov dx,[myDate.wHour]
	mov dx,9
	ret
endp
proc takeMinA
	mov edx,1
	;mov dx,[myDate.wMinute]
	mov dx,44
	ret
endp

proc takeDayWeekA
	mov edx,1
	;mov dx,[myDate.wDayOfWeek]
	mov dx,5
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
		cmp edx,[hor1TPBNG1] ;horaTPBNG1 es timeG = 15:45 - 17:15, ESO ES BAJO NIVEL G1
		jne otherSubjDocOne
			invoke SetDlgItemText,[pWnd],box3_output,TPBN
			jmp finSetSubject
		otherSubjDocOne:
		
	otherDoc2Subj:
	
	
	
	finSetSubject:
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
