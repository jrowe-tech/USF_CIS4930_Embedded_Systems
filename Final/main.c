#include <msp430.h>

#include "LiquidCrystal_I2C.h"

#include <stdio.h>

#include <string.h>

#include <ctype.h>

// We are using P3 for the keypad. The columns are inputs and rows are outputs.

#define keyport P3OUT



unsigned char key_press; unsigned i, k, key = 0;

unsigned int motor_speed;

unsigned int length = 0;

// ' ' is empty, index 0 is dummy; does not return anything.

unsigned char Key_Val[] = {' ','1','2','3','A','4','5','6','B','7','8','9','C','*','0','#','D'};

// User-defined functions prototypes:

void DelayMs(unsigned int Ms);

void main(void) {

WDTCTL = WDTPW | WDTHOLD; // Stop WDT

// Configure UART
UCA0CTLW0 |= UCSWRST;   // Put eUSCI in reset
UCA0CTLW0 |= UCSSEL__SMCLK;

// Baud Rate calculation (1000000 / 9600 = 104.17)
UCA0BR0 = 6;
UCA0MCTLW = 0x2081; // config baud rate


//configure p1dir


// Configure Tx
P1SEL1 &= ~BIT7;
P1SEL0 |= BIT7;

// Configure Rx
P1SEL1 &= ~BIT6;
P1SEL0 |= BIT6;

MCTL0 &= ~LOCKLPM5;       // Disable high-impedance mode.

UCA0CTLW0 &= ~UCSWRST; //stop reset

UCA0IE |= UCRXIE;

// LCD function call and setups:
I2C_Init(0x27);  // 0x27 signifies the slave address (address of the LCD with the I/O expander).
LCD_Setup();

LCD_SetCursor(0, 0);        // Initial position for the cursor at row 1, column 1.

P2DIR |= BIT0;
P2OUT &= ~BIT0;
TB0CTL = TBSSEL__ACLK | MC__UP | TBCLR;

// SET THE MAXIMUM TIMER VALUE HERE !!!
TB0CCR0 = 100;
TB0CCTL0 = CCIE;
TB0CCTL0 &= ~(CCIFG);

TB0CCR1 = 0;
TB0CCTL1 = CCIE;
TB0CCTL1 &= ~(CCIFG);

__enable_interrupt();

while(1) {}

return 0; // Return the unsigned char to main.
} // End of main.



void DelayMs(unsigned int Ms) { while(Ms) { __delay_cycles(1000); Ms--; } } // End of DelayMs user-defined function.

#pragma vector=TIMER0_B0_VECTOR
__interrupt void TMR0() { P2OUT |= BIT0; TB0CCTL0 &= ~(CCIFG); }

#pragma vector=TIMER0_B1_VECTOR
__interrupt void TMR1() { P2OUT &= ~BIT0; TB0CCTL1 &= ~(CCIFG); }

#pragma vector=USCI_A0_VECTOR
__interrupt void USCI_A0_ISR()
{
    if( UCA0RXBUF == 't'){
        int a = 1;
    }
}
