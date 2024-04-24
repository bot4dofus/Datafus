package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SetUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7951;
       
      
      private var _isInitialized:Boolean = false;
      
      public var setId:uint = 0;
      
      public var setObjects:Vector.<uint>;
      
      public var setEffects:Vector.<ObjectEffect>;
      
      private var _setObjectstree:FuncTree;
      
      private var _setEffectstree:FuncTree;
      
      public function SetUpdateMessage()
      {
         this.setObjects = new Vector.<uint>();
         this.setEffects = new Vector.<ObjectEffect>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7951;
      }
      
      public function initSetUpdateMessage(setId:uint = 0, setObjects:Vector.<uint> = null, setEffects:Vector.<ObjectEffect> = null) : SetUpdateMessage
      {
         this.setId = setId;
         this.setObjects = setObjects;
         this.setEffects = setEffects;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.setId = 0;
         this.setObjects = new Vector.<uint>();
         this.setEffects = new Vector.<ObjectEffect>();
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SetUpdateMessage(output);
      }
      
      public function serializeAs_SetUpdateMessage(output:ICustomDataOutput) : void
      {
         if(this.setId < 0)
         {
            throw new Error("Forbidden value (" + this.setId + ") on element setId.");
         }
         output.writeVarShort(this.setId);
         output.writeShort(this.setObjects.length);
         for(var _i2:uint = 0; _i2 < this.setObjects.length; _i2++)
         {
            if(this.setObjects[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.setObjects[_i2] + ") on element 2 (starting at 1) of setObjects.");
            }
            output.writeVarInt(this.setObjects[_i2]);
         }
         output.writeShort(this.setEffects.length);
         for(var _i3:uint = 0; _i3 < this.setEffects.length; _i3++)
         {
            output.writeShort((this.setEffects[_i3] as ObjectEffect).getTypeId());
            (this.setEffects[_i3] as ObjectEffect).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SetUpdateMessage(input);
      }
      
      public function deserializeAs_SetUpdateMessage(input:ICustomDataInput) : void
      {
         var _val2:uint = 0;
         var _id3:uint = 0;
         var _item3:ObjectEffect = null;
         this._setIdFunc(input);
         var _setObjectsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _setObjectsLen; _i2++)
         {
            _val2 = input.readVarUhInt();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of setObjects.");
            }
            this.setObjects.push(_val2);
         }
         var _setEffectsLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _setEffectsLen; _i3++)
         {
            _id3 = input.readUnsignedShort();
            _item3 = ProtocolTypeManager.getInstance(ObjectEffect,_id3);
            _item3.deserialize(input);
            this.setEffects.push(_item3);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SetUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_SetUpdateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._setIdFunc);
         this._setObjectstree = tree.addChild(this._setObjectstreeFunc);
         this._setEffectstree = tree.addChild(this._setEffectstreeFunc);
      }
      
      private function _setIdFunc(input:ICustomDataInput) : void
      {
         this.setId = input.readVarUhShort();
         if(this.setId < 0)
         {
            throw new Error("Forbidden value (" + this.setId + ") on element of SetUpdateMessage.setId.");
         }
      }
      
      private function _setObjectstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._setObjectstree.addChild(this._setObjectsFunc);
         }
      }
      
      private function _setObjectsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of setObjects.");
         }
         this.setObjects.push(_val);
      }
      
      private function _setEffectstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._setEffectstree.addChild(this._setEffectsFunc);
         }
      }
      
      private function _setEffectsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:ObjectEffect = ProtocolTypeManager.getInstance(ObjectEffect,_id);
         _item.deserialize(input);
         this.setEffects.push(_item);
      }
   }
}
