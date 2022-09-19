package Ankama_Fight.ui.slaves
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   
   public class SlaveFightUiCachedData
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(SlaveFightUiCachedData));
       
      
      public var isVertical:Boolean = false;
      
      public var positionX:Number = 0;
      
      public var positionY:Number = 0;
      
      public var isVisible:Boolean = true;
      
      public function SlaveFightUiCachedData(isVertical:Boolean = false, positionX:Number = 0, positionY:Number = 0, isVisible:Boolean = true)
      {
         super();
         this.isVertical = isVertical;
         this.positionX = positionX;
         this.positionY = positionY;
         this.isVisible = isVisible;
      }
      
      public static function unpack(packedCachedData:ByteArray) : SlaveFightUiCachedData
      {
         if(packedCachedData === null)
         {
            return null;
         }
         var cachedData:SlaveFightUiCachedData = null;
         try
         {
            packedCachedData.position = 0;
            cachedData = new SlaveFightUiCachedData(packedCachedData.readBoolean(),packedCachedData.readDouble(),packedCachedData.readDouble(),packedCachedData.readBoolean());
            packedCachedData.position = 0;
         }
         catch(error:Error)
         {
            _log.error("Unable to parse packed cached data. Aborting.");
         }
         return cachedData;
      }
      
      public function pack() : ByteArray
      {
         var packedCachedData:ByteArray = new ByteArray();
         packedCachedData.writeBoolean(this.isVertical);
         packedCachedData.writeDouble(this.positionX);
         packedCachedData.writeDouble(this.positionY);
         packedCachedData.writeBoolean(this.isVisible);
         return packedCachedData;
      }
   }
}
