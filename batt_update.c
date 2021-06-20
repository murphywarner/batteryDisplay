#include "batt.h"
int set_batt_from_ports(batt_t* batt) { //sets the fields of the parameter batt
	if (BATT_VOLTAGE_PORT < 0) {  checks if battery is negative
		return 1;
	}
	batt->mlvolts = BATT_VOLTAGE_PORT/2; // sets parameter to the voltage port variable/2
	if (batt->mlvolts >= 3800) { // full battery
	batt->percent = 100; // sets parameter percentage
	}
	else if(batt->mlvolts <= 3000) {// empty battery
		batt->percent = 0;
	}
	else {
		batt->percent = ((batt->mlvolts) - 3000) / 8; // sets parameter percentage based on equation to determine percentage
	}
	if ((BATT_STATUS_PORT >> 2) & 1) { // checks if bit in pos 2 == 1
		batt->mode = 2; // sets parameter mode to percent (2)
	}
	else batt->mode = 1; // sets parameter mode to volts (1)
	return 0;
}

int set_display_from_batt(batt_t batt, int* display) {
	int masks[11] = { 0b0111111, 0b0000110, 0b1011011, 0b1001111, 0b1100110, 0b1101101, 0b1111101, 0b0000111, 0b1111111, 0b1101111, 0b0000000 }; // each index represents bit mask for 0-9 in terms of displaying to screen
	int lft, mddl, rght; // numbers to be displayed: EXAMPLE : 3(lft) 
	if (batt.mode == 1) { // voltage mode
		rght = batt.mlvolts/10 % 10; // last number to be displayed 
		int rghtChk = batt.mlvolts % 10; // checks if last number should be rounded up 
		if (rghtChk >= 5) {
			rght++; // rounds up
		}
		mddl = (batt.mlvolts / 100) % 10; // middle number to be displayed
		lft = (batt.mlvolts / 1000) % 10; // first number to be displayed
	}
	else { // percentage mode
		rght = batt.percent % 10; // last number to be displayed
		mddl = (batt.percent / 10) % 10;// middle number to be displayed
		lft = (batt.percent / 100) % 10; // first number to be displayed
		if (lft == 0) { // blank if first number is 0
			lft = 10;
		}
		if (lft == 10 && mddl == 0) {
			mddl = 10; // makes middle blank if 0 and and left is blank
		}
	}
	int holder = 0;
	holder |= (masks[lft] << 14);// applies the number mask at bits 14-20
	holder |= (masks[mddl] << 7);// applies the number mask at bits 7-13
	holder |= (masks[rght]); // applies the number mask at bits 0-6
	if (batt.mode == 1) {
		holder |= 0b11 << 22; //turns on V symbol and decimal
	}
	else holder |= 1 << 21; // % symbol
	if (batt.percent >= 90) {
		holder |= 0b11111 << 24; //full bars
	}
	else if (batt.percent < 90 && batt.percent >= 70) {
		holder |= 0b01111 << 24; //four bars
	}
	else if (batt.percent < 70 && batt.percent >= 50) {
		holder |= 0b00111 << 24; //three bars
	}
	else if (batt.percent < 50 && batt.percent >= 30) {
		holder |= 0b00011 << 24; //two bars
	}
	else if (batt.percent < 30 && batt.percent >= 5) {
		holder |= 0b00001 << 24; //one bar
	}
	else {
		holder |= 0b00000 << 24; //no bars
	}
	*display = holder;
	return 0;
}

int batt_update() {
	batt_t battery;
	int check;
	check = set_batt_from_ports(&battery);
	if (check == 1) { return 1; }
	set_display_from_batt(battery, &BATT_DISPLAY_PORT);
	return 0;
}