.text
.global  set_batt_from_ports
        
## ENTRY POINT FOR REQUIRED FUNCTION
set_batt_from_ports:
        movw    BATT_VOLTAGE_PORT(%rip), %cx # moving global variable to reg %rcx
	    testw   %cx, %cx # test for the sign
        jns     .POSBATT # battery is not negative
        movl	$1, %eax # returns 1 
        jmp .FINISH # to return
.POSBATT:
        sarw    $1, %cx # shift 1 bit
        movw    %cx ,0(%rdi) # batt->m1volts
        cmpw    $3799, %cx # batt->mlvolts >= 3800
        jle .NOTFULL 
        movb    $100, 2(%rdi) # batt->percent = 100
        jmp .STATUS
.NOTFULL: 
        cmpw    $3000, %cx
        jg  .MIDBATT # empty if falls through
        movb    $0, 2(%rdi) # batt->percent = 0;
        jmp .STATUS
.MIDBATT:
        subl    $3000, %ecx # ((batt->mlvolts) - 3000)
        sarl    $3, %ecx # / 8
        movb    %cl, 2(%rdi) # batt->percent = %cl
.STATUS:
        movl    BATT_STATUS_PORT(%rip), %edx # gloabal variable to %edx
        shrb    $2, %dl # (BATT_STATUS_PORT >> 2)
        andl    $1, %edx # checks if bit == 1
        testl   %edx, %edx
        je  .SETVOLTS 
        movb    $2, 3(%rdi) # batt->mode = 2
        jmp .MODESET
.SETVOLTS:
        movb    $1,3(%rdi) # batt->mode = 1
.MODESET:
        movl    $0, %eax # success return
.FINISH: 
        ret

.section .data
mask_array:                 # an array of 11 ints
            .int 0b0111111  # mask_array[0]
            .int 0b0000110  # mask_array[1]
            .int 0b1011011  # mask_array[2]
            .int 0b1001111  # ...
            .int 0b1100110
            .int 0b1101101
            .int 0b1111101
            .int 0b0000111
            .int 0b1111111
            .int 0b1101111
            .int 0b0000000
.section .text
.global set_display_from_batt

set_display_from_batt:
        pushq   %r12 # register from stack (must restore before returning)
        movq     %rdi, %r9 # r9 holds the mode
        sar     $24, %r9 # shifts right by 24 bits to access batt.mode
        cmp     $1, %r9b # checks if voltage
        jne .NOTVOLTS # not voltage
        movw    %di, %ax # set dividend to m1votes
        cwtl # sign extend ax to long word
        cltq # sign extend eax to quad word
        cqto # sign extend ax to dx
        movl    $10, %r12d # sets 10 as divisor
        idivl   %r12d # %eax/10
        movl    %edx, %ecx # move remainder to %ecx = rghtchck
        cwtl
        cltq
        jmp .SETDIGITS
.NOTVOLTS:
        cmp     $2, %r9b # checks if percentage
        je  .PERCENTAGE
        movl    $1, %eax # neither percentage nor voltage, sets 0 and returns
        popq    %r12 # restore register
        ret
.PERCENTAGE:
        movq    %rdi, %rax 
        sar     $16, %rax # shift to batt.percent
        andq    $0xFF, %rax # set mask
.SETDIGITS:
        cqto
        movl    $10, %r12d # divisor = 10
        idivl   %r12d # quo (mlvolts/percent)/10
        movl    %edx, %r10d # quo%10 = %r10d is rightD
        cwtl
        cltq
        cqto
        idivl   %r12d # %edx is midD, %eax is leftD
        cmpb     $2, %r9b # check if percent mode (to check if first 2 numbers need to be cleared)
        je  .PERCENTCLEAR
        cmpl     $5, %ecx # check if mlvolts need to be rounded up
        jl .APPLYMASKS
        incl    %r10d # round up right
        jmp .APPLYMASKS 
.PERCENTCLEAR:
        cmpl     $0, %eax
        jne  .APPLYMASKS
.CLEARFIRST:
        movl    $10, %eax # clears out leftD
        cmpl     $0, %edx # checks middle
        jne .APPLYMASKS
        movl    $10, %edx # clears out middleD
.APPLYMASKS:
        leaq mask_array(%rip),%r8 # sets batt in %r8
        movl    $0, (%rsi) # clears current *display
        movl    (%r8, %rax, 4), %r11d # masks[lft] in %r11d
        sal     $14, %r11d # shift 14 bits left
        orl     %r11d, (%rsi) # apply mask to set left bits
        movl    (%r8, %rdx, 4), %r11d # masks[middle] in %r11d
        sal     $7, %r11d # shift 7 bits left
        orl     %r11d, (%rsi) # apply mask to set middle bits
        movl    (%r8, %r10, 4), %r11d # masks[rght] in %r11d
        orl     %r11d, (%rsi) # apply mask to set right bits
        cmpb     $1, %r9b # check if voltage
        jne .PSYMBOL
        movl    $3, %r11d # 0b11
        sal     $22, %r11d # shift 22 bits
        orl     %r11d, (%rsi) # apply mask to turn on V and .
        jmp .BATTBAR
.PSYMBOL:
        movl    $1, %r11d # 0b01
        sal     $21, %r11d # shift 21 bit
        orl     %r11d, (%rsi) # apply mask and turn on % symbol
.BATTBAR:
        movq     %rdi, %rax # %rax = bit rep
        sar     $16, %rax # shift left 16 to access batt.percent
        cmpb     $90, %al # batt.percent >= 90
        jl  .LESS90 # batt.percent < 90
        movl    $0b11111, %r11d # mask = full bars
        jmp .shift
.LESS90:   
        cmpb     $70, %al
        jl  .LESS70 # batt.percent < 70
        movl    $0b01111, %r11d # mask = four bars
        jmp .shift
.LESS70:
        cmpb     $50, %al
        jl  .LESS50 # batt.percent < 50
        movl    $0b00111, %r11d # mask = three bars
        jmp .shift
.LESS50:
        cmpb     $30, %al
        jl  .LESS30 # batt.percent < 30
        movl    $0b00011, %r11d # mask = two bars
        jmp .shift
.LESS30:
        cmpb     $5, %al
        jl  .NOBAR # batt.percent < 5
        movl    $0b00001, %r11d # mask = one bars
        jmp .shift
.NOBAR:
        movl    $0b00000, %r11d # mask = no bars
.shift:
        sal     $24, %r11d # shift left 24 bits to the appropriate battery display
        orl     %r11d, (%rsi) # apply mask onto the *display
        movl    $0, %eax # successful return
        popq    %r12 # restore register
        ret

.text
.global batt_update

batt_update:
	    pushq   $0 # allocate space on the stack for a batt_t
        movq    %rsp, %rdi # set arg1 %rdi to batt_t
        call    set_batt_from_ports # pass pointer into function 
        cmpl    $1, %eax # checks unexpected statement
        je  .UNEXPECTED
.DISPLAY: 
        movl    (%rsp), %edi # move battery to arg1
        movq    %rsp, %rsi # move display pointer to arg2
        call    set_display_from_batt # call function
        cmpl    $1, %eax # checks unexpected statement
        je  .UNEXPECTED
        popq    %rdx # remove batt_t from stack
        movl    %edx, BATT_DISPLAY_PORT(%rip) # sets global variable display
        movl    $0, %eax # successful return
        ret
.UNEXPECTED:
        popq    %rdx # remove batt_t from stack
        movl    $1, %eax # unseccessful return
        ret