package com.ankamagames.dofus.network.types.game.havenbag
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class HavenBagRoomPreviewInformation implements INetworkType
   {
      
      public static const protocolId:uint = 3005;
       
      
      public var roomId:uint = 0;
      
      public var themeId:int = 0;
      
      public function HavenBagRoomPreviewInformation()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 3005;
      }
      
      public function initHavenBagRoomPreviewInformation(roomId:uint = 0, themeId:int = 0) : HavenBagRoomPreviewInformation
      {
         this.roomId = roomId;
         this.themeId = themeId;
         return this;
      }
      
      public function reset() : void
      {
         this.roomId = 0;
         this.themeId = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_HavenBagRoomPreviewInformation(output);
      }
      
      public function serializeAs_HavenBagRoomPreviewInformation(output:ICustomDataOutput) : void
      {
         if(this.roomId < 0 || this.roomId > 255)
         {
            throw new Error("Forbidden value (" + this.roomId + ") on element roomId.");
         }
         output.writeByte(this.roomId);
         output.writeByte(this.themeId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HavenBagRoomPreviewInformation(input);
      }
      
      public function deserializeAs_HavenBagRoomPreviewInformation(input:ICustomDataInput) : void
      {
         this._roomIdFunc(input);
         this._themeIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HavenBagRoomPreviewInformation(tree);
      }
      
      public function deserializeAsyncAs_HavenBagRoomPreviewInformation(tree:FuncTree) : void
      {
         tree.addChild(this._roomIdFunc);
         tree.addChild(this._themeIdFunc);
      }
      
      private function _roomIdFunc(input:ICustomDataInput) : void
      {
         this.roomId = input.readUnsignedByte();
         if(this.roomId < 0 || this.roomId > 255)
         {
            throw new Error("Forbidden value (" + this.roomId + ") on element of HavenBagRoomPreviewInformation.roomId.");
         }
      }
      
      private function _themeIdFunc(input:ICustomDataInput) : void
      {
         this.themeId = input.readByte();
      }
   }
}
