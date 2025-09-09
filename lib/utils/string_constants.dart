// ignore_for_file: constant_identifier_names

const String APPLICATION_NAME = "SherlockCode";

// region AppBar title
const String APPBAR_TITLE_DASHBOARD = "Dashboard";
const String APPBAR_TITLE_ENCRYPTION = "Encryption";
const String APPBAR_TITLE_DECRYPTION = "DECRYPTION";
const String APPBAR_TITLE_ENCODING = "Encoding";
const String APPBAR_TITLE_DECODING = "Decoding";
// endregion

// region Encryption Methods
const String EN_CEASER_CIPHER = "Ceaser Cipher";
const String EN_ATBASH_CIPHER = "Atbash Cipher";
const String EN_MONO_ALPHABATIC = "Mono Alphabatic";
const String EN_RAIL_FENCE = "Rail Fence";

const String CEASER_CIPHER_DESC = "Caesar cipher is one of the simplest and most widely known encryption techniques, where each letter is shifted exactly 3 places.";
const String ATBASH_CIPHER_DESC = "The Atbash cipher is a particular type of monoalphabetic cipher formed by taking the alphabet and mapping it to its reverse, so that the first letter becomes the last letter, the second letter becomes the second to last letter, and so on.";
const String MONO_ALPHABATIC_CIPHER_DESC = "A Monoalphabetic cipher uses fixed substitution over the entire message, where each letter is shifted by some number of steps. That number is called key.";
const String RAIL_FENCE_DESC = "This is Rail Fence Cipher";
// endregion

// region enum
enum EncryptionDecryptionTypes {
  Ceaser_Cipher,
  Atbash_Cipher,
  Mono_Alphabatic_Cipher,
  Rail_Fence_Cipher
}

enum EncodeDecodeTypes{
  Base64,
  Base32,
}


List<EncryptionDecryptionTypes> encryptionDecryptionMethods = EncryptionDecryptionTypes.values;

List<EncodeDecodeTypes> encodeDecodeMethods = EncodeDecodeTypes.values;

// endregion

// region Encode Methods
const String EN_BASE64 = "Base64";
const String EN_BASE32 = "Base32";

const String BASE64_DESC = "Each Base64 character represents 6 bits (2^6 = 64).\nBase64 makes the data size ~33% larger.";
const String BASE32_DESC = "Each Base32 character represents 5 bits (2^5 = 32).\nBase32 makes the data size ~60% larger.";
// endregion

// region Routes
const String RT_SPLASH_SCREEN = "/splash_screen";
const String RT_DASHBOARD = "/dashboard";
const String RT_MAIN_SCREEN = "/main_screen";
const String RT_FEEDBACK_SCREEN = "/feedback_screen";
const String RT_DASHBOARD_ENCRYPT_DECRYPT = "/dashboard_encrypt_decrypt";
const String RT_DASHBOARD_ENCODE_DECODE = "/dashboard_encode_decode";

const String RT_ENCODING_VIEW = "/encoding_view";
const String RT_DECODING_VIEW = "/decoding_views";

const String RT_ENCRYPTION_VIEW = "/encryption_view";
const String RT_DECRYPTION_VIEW = "/decryption_views";
// endregion

// region Get Tags
const String TAG_ENCRYPT = "encrypt";
const String TAG_DECRYPT = "decrypt";

const String TAG_ENCODE = "encode";
const String TAG_DECODE = "decode";
// endregion

// region Exception
const String DECODE_LENGTH_ERROR = "A single remaining encoded character in the last quadruple or a padding of 3 characters is not allowed";
//endregion

// region RegExp

var base64RegExp = RegExp(r'^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?$');
var base32RegExp = RegExp(r'^(?:[A-Z2-7]{8})*(?:[A-Z2-7]{2}======|[A-Z2-7]{4}====|[A-Z2-7]{5}===|[A-Z2-7]{7}=)?$' );

// endregion

// region Api
const String BASE_URL = "http://api.aswdc.in/Api/MST_AppVersions/PostAppFeedback/AppPostFeedback";
// endregion