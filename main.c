#include <stdio.h>
#include <avr/io.h>
#include <util/delay.h>

int main()
{
    // Setting LED pin as output
    DDRB |= _BV(PB5);

    while (1) {
        // Toggle led
        PORTB ^= _BV(PB5);
        _delay_ms(500);
    }
}
