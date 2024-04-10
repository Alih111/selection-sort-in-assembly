
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
include 'emu8086.inc'
org 100h 
jmp start
PLAYERS DB 5 DUP (?)  
TIME DB 5 DUP (?) 
N         DW      5                                   
msg1:  db 'enter each player TIME ', 0  
MSG: DB 'ENTER EACH PLAYER NUMBER',0 
MSG3: DB 'PLAYER  TIME   AFTER SORTING ',0
  
start:   
       LEA SI,msg 
       CALL PRINT_STRING
       MOV SI,0 
       MOV AL,1
       GOTOXY 0,AL
LOOP_PLAYERS_NUMBERS:  CALL SCAN_NUM
       add AL,3
       GOTOXY AL,1
       MOV  PLAYERS[SI],CL
       INC SI
       CMP SI,5
       JL  LOOP_PLAYERS_NUMBERS
       MOV SI,msg1 
       GOTOXY 0,3
       CALL PRINT_STRING 
       MOV DI,0 
       MOV AL,0
       GOTOXY 0,4
LOOP_TIME:  CALL SCAN_NUM
       add AL,3
       GOTOXY AL,4
       MOV  TIME[DI],CL
       INC DI
       CMP DI,5
       JL  LOOP_TIME        
       GOTOXY 0,5
       
       ;SELECTION SORT    
       
         
MOV DI,0   ;ITERATOR INNER ARRAY
MOV SI,0  ;MINIMUM INDEX
MOV  AL,TIME[SI]  ;MINIMUM
MOV  CX,0  ;ITERATOR OUTER ARRAY  
mov ah,0
outer: 


GET_MINIMUM: INC  DI
            CMP  TIME[DI],AL ;COMPARE TO NEXT IN ARRAY
            JL   CHANGE_MIN   
            JMP  CONDITION     



CHANGE_MIN:  MOV AL,TIME[DI] ;NEW MINIMUM
             MOV SI,DI      ;NEW MINIMUM INDEX 
CONDITION:   CMP DI,4        ;CHECK IF IN ARRAY
             JL GET_MINIMUM  ; INCLUDE NEXT IN ARRAY
             MOV DI,CX       
             MOV BL,TIME[DI]  ;SWAP IN TIME ARRAY GET MIN OF THIS LOOP TO PLACE OF OUTER LOOP ITERATOR PLACE
             MOV TIME[DI],AL  ;SWAP IN TIME ARRAY GET MIN OF THIS LOOP TO PLACE OF OUTER LOOP ITERATOR PLACE
             MOV TIME[SI],BL  ;SWAP IN TIME ARRAY GET MIN OF THIS LOOP TO PLACE OF OUTER LOOP ITERATOR PLACE
             MOV BH,PLAYERS[SI]  ;SWAP IN PLAYERS ARRAY GET MIN OF THIS LOOP TO PLACE OF OUTER LOOP ITERATOR PLACE
             XCHG PLAYERS[DI],BH ;SWAP IN PLAYERS ARRAY GET MIN OF THIS LOOP TO PLACE OF OUTER LOOP ITERATOR PLACE
             MOV  PLAYERS[SI],BH  ;SWAP IN PLAYERS ARRAY GET MIN OF THIS LOOP TO PLACE OF OUTER LOOP ITERATOR PLACE
             INC CX              ; INCREMENT OUTER ITERATOR
             mov di,cx           ;PUT VARIABLE ON START OF NOT SORTED PART
             mov si,cx           ;PUT VARIABLE ON START OF NOT SORTED PART
             mov al,time[si]     ;START OF NOT SORTED PART
             CMP CX,4            ;CONDITION OF OUTER LOOP
             JL  outer  
            

	    	LEA SI,MSG3
	    	CALL PRINT_STRING 
	    	GOTOXY 0,6 
	    	MOV DH,7
	    	MOV SI, 0   
	    	MOV AH,0 
	    
LOOP_PRINT:  	MOV AL,PLAYERS[SI]     
        	CALL PRINT_NUM    
        	PRINT 09H            
        	MOV AL,TIME[SI]
        	CALL PRINT_NUM
        	GOTOXY 0,DH
        	INC DH  
        	INC SI 
        	CMP SI,5 
        	JL LOOP_PRINT
       
        
DEFINE_SCAN_NUM   
DEFINE_PRINT_NUM      
DEFINE_PRINT_NUM_UNS
DEFINE_PRINT_STRING
ret