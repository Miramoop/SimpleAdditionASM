; 
; CSCI268 - Asgn 4 - Exercise 3 - Simple Addition
; Miranda Morris
; April 8, 2024
; This program clears the screen, locates the cursor near the middle of the screen, prompts the user for two integers,
; adds the integers, and displays their sum. The addition is performed using a procedure called AddNums with the 2 
; numbers that are being added being passed in using the EAX and the EBX registers. Then returns the result in the EAX 
; register while preserving all the other register values


.586
.model flat, stdcall
option casemap : none; case-sensitive

ExitProcess proto,dwExitCode:dword

INCLUDE Irvine32.inc					              ; includes the Irvine32 link library
.data                                                 ; showing this is the start of the data area
    prompt BYTE "Enter two integers : ",0             ; creates a BYTE integer named prompt containing the string "Enter two integers: "
	sumString BYTE "The sum of both integers: ", 0    ; creates a BYTE integer named sumString containing the string "The sum of both integers: "
   

.code                                                 ; showing this is the start of the code area
main proc                                             ; starts the main procedure
    
    call Clrscr                                       ; calls the Clrscr procedure which clears the screen
    mov dh,10                                         ; moves the console's y-coordinate (row) to 10 
    mov dl,30                                         ; moves the console's x-coordinate (column) to 30
    call Gotoxy                                       ; locates the cursor
    mov edx,OFFSET prompt                             ; moves the BYTE integer named prompt to the edx register and loads the edx with the address of the integer
    call WriteString                                  ; calls the WriteString procedure which writes the current string loaded which is the prompt BYTE integer
    call Crlf                                         ; calls the Crlf procedure which moves cursor to next line
    call ReadInt                                      ; calls the ReadInt procedure which reads the first integer inputted by the user
    mov ebx,eax                                       ; moves the value of the ebx register to the eax register
    call ReadInt                                      ; calls the ReadInt procedure which reads the second integer inputted by the user 
    call AddNums                                      ; calls the AddNums procedure (found below)

AddNums proc                                          ; marks the start of the AddNums procedure 
    add eax, ebx                                      ; adds the value of eax and ebx storing the sum in the eax register
    mov edx, OFFSET sumString                         ; moves the BYTE integer named sumString to the edx register and loads the edx with the address of the integer
    call WriteString                                  ; calls the WriteString procedure which writes the current string loaded which is the sumString BYTE integer
    call Crlf                                         ; calls the Crlf procedure which moves cursor to next line
    call WriteInt                                     ; calls the WriteInt procedure which writes the sum of the two integers
    call Crlf                                         ; calls the Crlf procedure which moves cursor to next line
    call WaitMsg                                      ; calls the WaitMsg procedure which displays the message to press any key to continue and waits for the user to 
                                                      ; press a button before it continues
    call Crlf                                         ; calls the Crlf procedure which moves cursor to next line
    call Clrscr                                       ; calls the Clrscr procedure which clears the screen
AddNums endp                                          ; marks the end of the AddNums procedure

	invoke ExitProcess,0                              ; calls a Windows service (also known as a function named ExitProcess that halts the program and returns)
main endp                                             ; is the ending marker of the main procedure.
end main

