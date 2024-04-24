package com.ankamagames.dofus.network.messages.game.context.dungeon
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class DungeonKeyRingMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2368;
       
      
      private var _isInitialized:Boolean = false;
      
      public var availables:Vector.<uint>;
      
      public var unavailables:Vector.<uint>;
      
      private var _availablestree:FuncTree;
      
      private var _unavailablestree:FuncTree;
      
      public function DungeonKeyRingMessage()
      {
         this.availables = new Vector.<uint>();
         this.unavailables = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2368;
      }
      
      public function initDungeonKeyRingMessage(availables:Vector.<uint> = null, unavailables:Vector.<uint> = null) : DungeonKeyRingMessage
      {
         this.availables = availables;
         this.unavailables = unavailables;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.availables = new Vector.<uint>();
         this.unavailables = new Vector.<uint>();
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
         this.serializeAs_DungeonKeyRingMessage(output);
      }
      
      public function serializeAs_DungeonKeyRingMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.availables.length);
         for(var _i1:uint = 0; _i1 < this.availables.length; _i1++)
         {
            if(this.availables[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.availables[_i1] + ") on element 1 (starting at 1) of availables.");
            }
            output.writeVarShort(this.availables[_i1]);
         }
         output.writeShort(this.unavailables.length);
         for(var _i2:uint = 0; _i2 < this.unavailables.length; _i2++)
         {
            if(this.unavailables[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.unavailables[_i2] + ") on element 2 (starting at 1) of unavailables.");
            }
            output.writeVarShort(this.unavailables[_i2]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_DungeonKeyRingMessage(input);
      }
      
      public function deserializeAs_DungeonKeyRingMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _val2:uint = 0;
         var _availablesLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _availablesLen; _i1++)
         {
            _val1 = input.readVarUhShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of availables.");
            }
            this.availables.push(_val1);
         }
         var _unavailablesLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _unavailablesLen; _i2++)
         {
            _val2 = input.readVarUhShort();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of unavailables.");
            }
            this.unavailables.push(_val2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_DungeonKeyRingMessage(tree);
      }
      
      public function deserializeAsyncAs_DungeonKeyRingMessage(tree:FuncTree) : void
      {
         this._availablestree = tree.addChild(this._availablestreeFunc);
         this._unavailablestree = tree.addChild(this._unavailablestreeFunc);
      }
      
      private function _availablestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._availablestree.addChild(this._availablesFunc);
         }
      }
      
      private function _availablesFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of availables.");
         }
         this.availables.push(_val);
      }
      
      private function _unavailablestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._unavailablestree.addChild(this._unavailablesFunc);
         }
      }
      
      private function _unavailablesFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of unavailables.");
         }
         this.unavailables.push(_val);
      }
   }
}
