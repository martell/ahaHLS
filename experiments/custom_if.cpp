void custom_if(bit_32& val, bit_32 c, bit_32 a, bit_32 b) {
  if (c) {
    val = a;
  } else {
    val = b;
  }
}