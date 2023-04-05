package com.ankamagames.jerakine.utils.crypto
{
   import com.hurlant.crypto.rsa.RSAKey;
   import com.hurlant.math.BigInteger;
   import flash.utils.IDataInput;
   
   public class SignatureKey extends RSAKey
   {
      
      private static const PUBLIC_KEY_HEADER:String = "DofusPublicKey";
      
      private static const PRIVATE_KEY_HEADER:String = "DofusPrivateKey";
       
      
      private var _canSign:Boolean;
      
      public function SignatureKey(N:BigInteger, E:int, D:BigInteger = null, P:BigInteger = null, Q:BigInteger = null, DP:BigInteger = null, DQ:BigInteger = null, C:BigInteger = null)
      {
         super(N,E,D,P,Q,DP,DQ,C);
      }
      
      public static function fromByte(input:IDataInput) : SignatureKey
      {
         var k:RSAKey = null;
         var header:String = input.readUTF();
         if(header != PUBLIC_KEY_HEADER && header != PRIVATE_KEY_HEADER)
         {
            throw Error("Invalid public or private header");
         }
         if(header == PUBLIC_KEY_HEADER)
         {
            k = RSAKey.parsePublicKey(input.readUTF(),input.readUTF());
         }
         else
         {
            k = RSAKey.parsePrivateKey(input.readUTF(),input.readUTF(),input.readUTF(),input.readUTF(),input.readUTF(),input.readUTF(),input.readUTF(),input.readUTF());
         }
         return new SignatureKey(k.n,k.e,k.d,k.p,k.q,k.dmp1,k.dmq1,k.coeff);
      }
      
      public function get canSign() : Boolean
      {
         return canEncrypt;
      }
   }
}
