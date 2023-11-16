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

section '.data' data readable writeable

Ist  dd 0
pWnd dd 0	;Por defecto, pero podemos crear mas para guardar hWnd de diferentes ventanas([pWnd][sWnd][tWnd]...)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
myDate SYSTEMTIME ?
timeSymbolOne	db ':',0
timeSymbolTwo	db '-',0
timeA			DB '06:45 - 08:15',0
timeB			DB '08:15 - 09:45',0
timeC			DB '09:45 - 11:15',0
timeD			DB '11:15 - 12:45',0
timeE			DB '12:45 - 14:15',0
timeF			DB '14:15 - 15:45',0
timeG			DB '15:45 - 17:15',0
timeH			DB '17:15 - 18:45',0
timeI			db '18:45 - 20:15',0
timeJ			db '20:15 - 21:45',0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

msgCINoValid 	db 'Ingrese un CI valido',0
ciNoExist		db 'Docente no registrado',0
voidMsg			db '',0
auxMsg			db 100 dup(0)
saltoLinea 		db 10,13

ciOne 			dd 8080808
DocOne 			db 'MONTECINOS CHOQUE MARCO ANTONIO',10,13,0
TPBN			db 'TALLER DE PROGRAMACION EN BAJO NIVEL',0
horaTPBNG1		dd 15
minutosTPBNG1	dd 45
horaTPBNG2		dd 21				;;
minutosTPBNG2	dd 15
RedesAvanzadas 	db 'TECNOLOGIA REDES AVANZADAS',0
horTecRedAvaG1	dd 14
minTecRedAvaG1	dd 15


ciTwo			dd 7070707
DocTwo 			db 'BLANCO COCA LETICIA',0
IntroProgra		db 'INTRODUCCION A LA PROGRAMACION',0
EPED			db 'ELEMENTOS DE PROGRAMACION Y ESTRUCTURA DE DATOS',0
AlgoAvanzados	db 'ALGORITMOS AVANZADOS',0

ciThree			dd 6060606
DocThree		db 'APARICIO YUJA TATIANA',0
Funcional		db 'PROGRAMACION FUNCIONAL',0
BASE2			DB 'BASE DE DATOS 2',0

ciFour			dd 5050505
DocFour			db 'ORELLANA ARAOZ JORGE WALTER',0
TSO				db 'TALLER DE SISTEMAS OPERATIVOS',0
Redes			db 'REDES DE COMPUTADORAS',0

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
	
	invoke GetDlgItemInt,[pWnd],box1_InputCi,0,0	;box de entrada de CI
	mov [input1Var],eax
	
	
	showDataCI:
		cmp [input1Var],0
		jne otherCiOne
		;mov eax,[msgCINoValid]
		;invoke SendDlgItemMessage,[pWnd],box2_OutputCi,WM_SETTEXT,100,msgCINoValid;;;;;;
		invoke SetDlgItemText,[pWnd],box2_output,msgCINoValid;;;;;;funciona con sendDlgItemMsg o con setDlgItemText
		invoke SetDlgItemText,[pWnd],box3_output,voidMsg
		invoke SetDlgItemText,[pWnd],box4_output,voidMsg
		jmp endShow
		
		otherCiOne:
		mov eax,[ciOne]
		cmp [input1Var],eax
		jne otherCiTwo
		
		invoke SendDlgItemMessage,[pWnd],box2_output,WM_SETTEXT,100,DocOne
		mov ebx,0
		mov bl,[DocOne]
		
		invoke GetLocalTime,myDate;;;;;guardamos la hora inicial
		xor edx,edx
	
		call setSchedule
		call setSubject
		;;
			;invoke SendDlgItemMessage,[pWnd],box3_output,WM_SETTEXT,100,TPBN
		;;
			;invoke GetLocalTime,myDate
		;xor eax,eax
			;mov ax,[myDate.wHour]
			;invoke SetDlgItemText,[pWnd],box4_output,timeA
		;;
		
		;
		jmp endShow
		
		otherCiTwo:
		
		
		ciNotFound:
		invoke SendDlgItemMessage,[pWnd],box2_output,WM_SETTEXT,100,ciNoExist
		invoke SetDlgItemText,[pWnd],box3_output,voidMsg
	
	endShow:	
	mov eax,1
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
	
	cmp bl,[DocOne]
	jne otherDocTwo
		mov dx,[myDate.wHour]
		
		;mov ax,[myDate.wMinute]
			cmp edx,[horaTPBNG1] ;horaTPBNG1 es timeG
			jne verifyHoraTPBNG2
			invoke SetDlgItemText,[pWnd],box4_output,timeG
			jmp finSetSchedule
		
		verifyHoraTPBNG2:
			cmp edx,[horaTPBNG2] ;horaTPBNG2 es timeD
			jne verifyHoraRedesAv
			invoke SetDlgItemText,[pWnd],box4_output,timeD
			jmp finSetSchedule
			
		verifyHoraRedesAv: 
		
	otherDocTwo:
	
	
	finSetSchedule:
	ret
endp

proc setSubject
	
	
	finSetSubject
	ret

section '.idata' import data readable writeable
  ;importamos solo los procedimientos basicos para abrir una ventana
  
  ;otra forma para importar los procedimientos importando archivos INC
  library kernel32,'KERNEL32.DLL',user32,'USER32.DLL',gdi32,'GDI32.DLL'
  include 'api\kernel32.inc'
  include 'api\user32.inc'
  include 'api\gdi32.inc'

section '.rsrc' resource from 'ControlIngreso.res' data readable
