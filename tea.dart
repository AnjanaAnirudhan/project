import 'dart:typed_data';

class TEA {
  final Uint32List _key; // TEA uses a 128-bit key (4x 32-bit integers)

  TEA(List<int> key)
      : assert(key.length == 4),
        _key = Uint32List.fromList(key);

  // Encryption with TEA
  List<int> encrypt(Uint32List data) {
    assert(data.length == 2); // TEA operates on 64-bit blocks (2x 32-bit integers)

    int v0 = data[0], v1 = data[1];
    int sum = 0;
    int delta = 0x9E3779B9; // A key schedule constant for TEA

    for (int i = 0; i < 32; i++) { // TEA uses 32 rounds of encryption
      sum = (sum + delta) & 0xFFFFFFFF;
      v0 = (v0 + (((v1 << 4) + _key[0]) ^ (v1 + sum) ^ ((v1 >> 5) + _key[1]))) & 0xFFFFFFFF;
      v1 = (v1 + (((v0 << 4) + _key[2]) ^ (v0 + sum) ^ ((v0 >> 5) + _key[3]))) & 0xFFFFFFFF;
    }

    return [v0, v1];
  }

  // Decryption with TEA
  List<int> decrypt(Uint32List data) {
    assert(data.length == 2); // TEA operates on 64-bit blocks (2x 32-bit integers)

    int v0 = data[0], v1 = data[1];
    int delta = 0x9E3779B9;
    int sum = (delta * 32) & 0xFFFFFFFF;

    for (int i = 0; i < 32; i++) { // TEA uses 32 rounds of decryption
      v1 = (v1 - (((v0 << 4) + _key[2]) ^ (v0 + sum) ^ ((v0 >> 5) + _key[3]))) & 0xFFFFFFFF;
      v0 = (v0 - (((v1 << 4) + _key[0]) ^ (v1 + sum) ^ ((v1 >> 5) + _key[1]))) & 0xFFFFFFFF;
      sum = (sum - delta) & 0xFFFFFFFF;
    }

    return [v0, v1];
  }
}
