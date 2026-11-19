.model small
.stack 100h

.data
msg_entrada db 'Ingresa una cadena y presiona Enter para terminar: $'
msg_total db 13, 10, 'Cantidad de consonantes: $'
msg_fin db 13, 10, 'Fin del programa$'

consonantes dw 0
digitos db 5 dup(0)

.code
main proc
mov ax, @data
mov ds, ax

lea dx, msg_entrada
mov ah, 09h
int 21h

leer_caracter:
mov ah, 01h
int 21h

cmp al, 13
je mostrar_total

; Si es mayuscula, convertirla a minuscula
cmp al, 'A'
jb leer_caracter
cmp al, 'Z'
ja revisar_letra
add al, 32

revisar_letra:
; Ignorar caracteres fuera del rango de a a z
cmp al, 'a'
jb leer_caracter
cmp al, 'z'
ja leer_caracter

; Si es vocal, pasar a la siguiente tecla
cmp al, 'a'
je leer_caracter
cmp al, 'e'
je leer_caracter
cmp al, 'i'
je leer_caracter
cmp al, 'o'
je leer_caracter
cmp al, 'u'
je leer_caracter

inc consonantes
jmp leer_caracter

mostrar_total:
lea dx, msg_total
mov ah, 09h
int 21h

mov ax, consonantes
mov bx, 10
mov si, 4

guardar_digito:
mov dx, 0
div bx
mov digitos[si], dl

cmp ax, 0
je imprimir_digito

dec si
jmp guardar_digito

imprimir_digito:
mov dl, digitos[si]
add dl, '0'
mov ah, 02h
int 21h

inc si
cmp si, 5
jb imprimir_digito

lea dx, msg_fin
mov ah, 09h
int 21h

mov ax, 4C00h
int 21h
main endp
end main