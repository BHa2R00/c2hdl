
unsigned int isqrt(unsigned int value) {
    unsigned int res = 0;
    unsigned int bit = 1U << 30; // The second-to-top bit is the starting point

    // "bit" starts at the highest power of four <= the argument.
    while (bit > value) {
        bit >>= 2;
    }

    while (bit != 0) {
        if (value >= res + bit) {
            value -= res + bit;
            res = (res >> 1) + bit;
        } else {
            res >>= 1;
        }
        bit >>= 2;
    }
    return res;
}

