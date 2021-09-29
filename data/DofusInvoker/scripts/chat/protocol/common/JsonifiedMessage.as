package chat.protocol.common
{
   import com.ankamagames.jerakine.json.JSON;
   import com.ankamagames.jerakine.pools.PoolableJSONDecoder;
   import com.ankamagames.jerakine.pools.PoolableJSONEncoder;
   import com.ankamagames.jerakine.pools.PoolsManager;
   
   public class JsonifiedMessage
   {
       
      
      public function JsonifiedMessage()
      {
         super();
      }
      
      public static function decodePooled(json:String, strict:Boolean = false) : *
      {
         var poolableJSONDecoder:PoolableJSONDecoder = PoolsManager.getInstance().getJSONDecoderPool().checkOut() as PoolableJSONDecoder;
         poolableJSONDecoder = poolableJSONDecoder.renew(json,strict);
         var result:* = poolableJSONDecoder.getValue();
         PoolsManager.getInstance().getJSONDecoderPool().checkIn(poolableJSONDecoder);
         return result;
      }
      
      public function encode() : String
      {
         return com.ankamagames.jerakine.json.JSON.encode(this,0,false,true);
      }
      
      public function encodePooled() : String
      {
         var poolableJSONEncoder:PoolableJSONEncoder = PoolsManager.getInstance().getJSONEncoderPool().checkOut() as PoolableJSONEncoder;
         poolableJSONEncoder.renew(this,0,false,true);
         var s:String = poolableJSONEncoder.getString();
         PoolsManager.getInstance().getJSONEncoderPool().checkIn(poolableJSONEncoder);
         return s;
      }
   }
}
