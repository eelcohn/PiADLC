unsigned char cr1;
unsigned char cr2;
unsigned char cr3;
unsigned char cr4;
unsigned char sr1;
unsigned char sr2;
econet::Frame rx_buff;	// Buffer for frames sent from the (AUN) econet to the beeb
econet::Frame tx_buff;	// Buffer for frames sent from the beeb to the (AUN) Econet
unsigned short rx_len;	// Number of bytes in the rx buffer
unsigned short tx_len;	// Number of bytes in the tx buffer
unsigned short rx_ptr;	// Pointer to the current byte received from the beeb
unsigned short tx_ptr;	// Pointer to the current byte to be transmitted to the beeb



void mc68b54::CSHandler (void) {
	unsigned char register;

	register = (RS1 << 1) | RS0;
	switch register {
		case 0x00 :
			if (RW) {
				PB = sr1;
			} else {
				cr1 = PB;
			}
			break;

		case 0x01 :
			if (RW) {
				PB = sr2;
			} else {
				cr2 = PB;
			}
			break;

		case 0x02 :
			if (RW) {
				PB = received;
			} else {
				cr3 = PB;
			}
			break;

		case 0x03 :
			if (RW) {
				puts "mc68b54.cpp: Invalid register selection"
			} else {
				cr4 = PB;
			}
			break;
	}
}
