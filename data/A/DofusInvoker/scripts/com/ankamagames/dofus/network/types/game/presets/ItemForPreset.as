package com.ankamagames.dofus.network.types.game.presets
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ItemForPreset implements INetworkType
   {
      
      public static const protocolId:uint = 5291;
       
      
      public var position:uint = 63;
      
      public var objGid:uint = 0;
      
      public var objUid:uint = 0;
      
      public function ItemForPreset()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 5291;
      }
      
      public function initItemForPreset(position:uint = 63, objGid:uint = 0, objUid:uint = 0) : ItemForPreset
      {
         this.position = position;
         this.objGid = objGid;
         this.objUid = objUid;
         return this;
      }
      
      public function reset() : void
      {
         this.position = 63;
         this.objGid = 0;
         this.objUid = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ItemForPreset(output);
      }
      
      public function serializeAs_ItemForPreset(output:ICustomDataOutput) : void
      {
         output.writeShort(this.position);
         if(this.objGid < 0)
         {
            throw new Error("Forbidden value (" + this.objGid + ") on element objGid.");
         }
         output.writeVarInt(this.objGid);
         if(this.objUid < 0)
         {
            throw new Error("Forbidden value (" + this.objUid + ") on element objUid.");
         }
         output.writeVarInt(this.objUid);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ItemForPreset(input);
      }
      
      public function deserializeAs_ItemForPreset(input:ICustomDataInput) : void
      {
         this._positionFunc(input);
         this._objGidFunc(input);
         this._objUidFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ItemForPreset(tree);
      }
      
      public function deserializeAsyncAs_ItemForPreset(tree:FuncTree) : void
      {
         tree.addChild(this._positionFunc);
         tree.addChild(this._objGidFunc);
         tree.addChild(this._objUidFunc);
      }
      
      private function _positionFunc(input:ICustomDataInput) : void
      {
         this.position = input.readShort();
         if(this.position < 0)
         {
            throw new Error("Forbidden value (" + this.position + ") on element of ItemForPreset.position.");
         }
      }
      
      private function _objGidFunc(input:ICustomDataInput) : void
      {
         this.objGid = input.readVarUhInt();
         if(this.objGid < 0)
         {
            throw new Error("Forbidden value (" + this.objGid + ") on element of ItemForPreset.objGid.");
         }
      }
      
      private function _objUidFunc(input:ICustomDataInput) : void
      {
         this.objUid = input.readVarUhInt();
         if(this.objUid < 0)
         {
            throw new Error("Forbidden value (" + this.objUid + ") on element of ItemForPreset.objUid.");
         }
      }
   }
}
