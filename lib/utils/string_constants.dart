// ignore_for_file: constant_identifier_names

// region AppBar title
const String APPBAR_TITLE_DASHBOARD = "Dashboard";
const String APPBAR_TITLE_ENCODING = "Encoding";
const String APPBAR_TITLE_DECODING = "Decoding";
// endregion

// region Encoding Methods
const String EN_CEASER_CIPHER = "Ceaser Cipher";
const String EN_ATBASH_CIPHER = "Atbash Cipher";
const String EN_MONO_ALPHABATIC = "Mono Alphabatic";


const String CEASER_CIPHER_DESC = "Caesar cipher is one of the simplest and most widely known encryption techniques, where each letter is shifted exactly 3 places.";
const String ATBASH_CIPHER_DESC = "The Atbash cipher is a particular type of monoalphabetic cipher formed by taking the alphabet and mapping it to its reverse, so that the first letter becomes the last letter, the second letter becomes the second to last letter, and so on.";
const String MONO_ALPHABATIC_CIPHER_DESC = "A Monoalphabetic cipher uses fixed substitution over the entire message, where each letter is shifted by some number of steps. That number is called key.";
// endregion

// region enum
enum EncodeDecodeTypes {
  Ceaser_Cipher,
  Atbash_Cipher,
  Mono_Alphabatic_Cipher
}
// endregion


// region Routes
const String RT_DASHBOARD = "/dashboard";
const String RT_ENCODING_VIEW = "/encoding_view";
const String RT_DECODING_VIEW = "/decoding_views";
// endregion