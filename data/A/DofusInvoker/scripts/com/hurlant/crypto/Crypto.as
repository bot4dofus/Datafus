package com.hurlant.crypto
{
   import com.hurlant.crypto.hash.HMAC;
   import com.hurlant.crypto.hash.IHash;
   import com.hurlant.crypto.hash.MAC;
   import com.hurlant.crypto.hash.MD2;
   import com.hurlant.crypto.hash.MD5;
   import com.hurlant.crypto.hash.SHA1;
   import com.hurlant.crypto.hash.SHA224;
   import com.hurlant.crypto.hash.SHA256;
   import com.hurlant.crypto.prng.ARC4;
   import com.hurlant.crypto.rsa.RSAKey;
   import com.hurlant.crypto.symmetric.AESKey;
   import com.hurlant.crypto.symmetric.BlowFishKey;
   import com.hurlant.crypto.symmetric.CBCMode;
   import com.hurlant.crypto.symmetric.CFB8Mode;
   import com.hurlant.crypto.symmetric.CFBMode;
   import com.hurlant.crypto.symmetric.CTRMode;
   import com.hurlant.crypto.symmetric.DESKey;
   import com.hurlant.crypto.symmetric.ECBMode;
   import com.hurlant.crypto.symmetric.ICipher;
   import com.hurlant.crypto.symmetric.IMode;
   import com.hurlant.crypto.symmetric.IPad;
   import com.hurlant.crypto.symmetric.ISymmetricKey;
   import com.hurlant.crypto.symmetric.IVMode;
   import com.hurlant.crypto.symmetric.NullPad;
   import com.hurlant.crypto.symmetric.OFBMode;
   import com.hurlant.crypto.symmetric.PKCS5;
   import com.hurlant.crypto.symmetric.SimpleIVMode;
   import com.hurlant.crypto.symmetric.TripleDESKey;
   import com.hurlant.crypto.symmetric.XTeaKey;
   import com.hurlant.util.Base64;
   import flash.utils.ByteArray;
   
   public class Crypto
   {
       
      
      private var b64:Base64;
      
      public function Crypto()
      {
         super();
      }
      
      public static function getCipher(name:String, key:ByteArray, pad:IPad = null) : ICipher
      {
         var cipher:ICipher = null;
         var keys:Array = name.split("-");
         switch(keys[0])
         {
            case "simple":
               keys.shift();
               name = keys.join("-");
               cipher = getCipher(name,key,pad);
               if(cipher is IVMode)
               {
                  return new SimpleIVMode(cipher as IVMode);
               }
               return cipher;
               break;
            case "aes":
            case "aes128":
            case "aes192":
            case "aes256":
               keys.shift();
               if(key.length * 8 == keys[0])
               {
                  keys.shift();
               }
               return getMode(keys[0],new AESKey(key),pad);
            case "bf":
            case "blowfish":
               keys.shift();
               return getMode(keys[0],new BlowFishKey(key),pad);
            case "des":
               keys.shift();
               if(keys[0] != "ede" && keys[0] != "ede3")
               {
                  return getMode(keys[0],new DESKey(key),pad);
               }
               if(keys.length == 1)
               {
                  keys.push("ecb");
                  break;
               }
               break;
            case "3des":
            case "des3":
               break;
            case "xtea":
               keys.shift();
               return getMode(keys[0],new XTeaKey(key),pad);
            case "rc4":
               keys.shift();
               return new ARC4(key);
            default:
               return null;
         }
         keys.shift();
         return getMode(keys[0],new TripleDESKey(key),pad);
      }
      
      public static function getKeySize(name:String) : uint
      {
         var keys:Array = name.split("-");
         switch(keys[0])
         {
            case "simple":
               keys.shift();
               return getKeySize(keys.join("-"));
            case "aes128":
               return 16;
            case "aes192":
               return 24;
            case "aes256":
               return 32;
            case "aes":
               keys.shift();
               return parseInt(keys[0]) / 8;
            case "bf":
            case "blowfish":
               return 16;
            case "des":
               keys.shift();
               switch(keys[0])
               {
                  case "ede":
                     return 16;
                  case "ede3":
                     return 24;
                  default:
                     return 8;
               }
               break;
            case "3des":
            case "des3":
               return 24;
            case "xtea":
               return 8;
            case "rc4":
               if(parseInt(keys[1]) > 0)
               {
                  return parseInt(keys[1]) / 8;
               }
               return 16;
               break;
            default:
               return 0;
         }
      }
      
      private static function getMode(name:String, alg:ISymmetricKey, padding:IPad = null) : IMode
      {
         switch(name)
         {
            case "ecb":
               return new ECBMode(alg,padding);
            case "cfb":
               return new CFBMode(alg,padding);
            case "cfb8":
               return new CFB8Mode(alg,padding);
            case "ofb":
               return new OFBMode(alg,padding);
            case "ctr":
               return new CTRMode(alg,padding);
            case "cbc":
         }
         return new CBCMode(alg,padding);
      }
      
      public static function getHash(name:String) : IHash
      {
         switch(name)
         {
            case "md2":
               return new MD2();
            case "md5":
               return new MD5();
            case "sha":
            case "sha1":
               return new SHA1();
            case "sha224":
               return new SHA224();
            case "sha256":
               return new SHA256();
            default:
               return null;
         }
      }
      
      public static function getHMAC(name:String) : HMAC
      {
         var keys:Array = name.split("-");
         if(keys[0] == "hmac")
         {
            keys.shift();
         }
         var bits:uint = 0;
         if(keys.length > 1)
         {
            bits = parseInt(keys[1]);
         }
         return new HMAC(getHash(keys[0]),bits);
      }
      
      public static function getMAC(name:String) : MAC
      {
         var keys:Array = name.split("-");
         if(keys[0] == "mac")
         {
            keys.shift();
         }
         var bits:uint = 0;
         if(keys.length > 1)
         {
            bits = parseInt(keys[1]);
         }
         return new MAC(getHash(keys[0]),bits);
      }
      
      public static function getPad(name:String) : IPad
      {
         switch(name)
         {
            case "null":
               return new NullPad();
            case "pkcs5":
         }
         return new PKCS5();
      }
      
      public static function getRSA(E:String, M:String) : RSAKey
      {
         return RSAKey.parsePublicKey(M,E);
      }
   }
}
