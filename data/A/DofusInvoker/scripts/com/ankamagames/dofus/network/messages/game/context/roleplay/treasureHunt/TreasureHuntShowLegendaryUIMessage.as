package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TreasureHuntShowLegendaryUIMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8368;
       
      
      private var _isInitialized:Boolean = false;
      
      public var availableLegendaryIds:Vector.<uint>;
      
      private var _availableLegendaryIdstree:FuncTree;
      
      public function TreasureHuntShowLegendaryUIMessage()
      {
         this.availableLegendaryIds = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8368;
      }
      
      public function initTreasureHuntShowLegendaryUIMessage(availableLegendaryIds:Vector.<uint> = null) : TreasureHuntShowLegendaryUIMessage
      {
         this.availableLegendaryIds = availableLegendaryIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.availableLegendaryIds = new Vector.<uint>();
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
         this.serializeAs_TreasureHuntShowLegendaryUIMessage(output);
      }
      
      public function serializeAs_TreasureHuntShowLegendaryUIMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.availableLegendaryIds.length);
         for(var _i1:uint = 0; _i1 < this.availableLegendaryIds.length; _i1++)
         {
            if(this.availableLegendaryIds[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.availableLegendaryIds[_i1] + ") on element 1 (starting at 1) of availableLegendaryIds.");
            }
            output.writeVarShort(this.availableLegendaryIds[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TreasureHuntShowLegendaryUIMessage(input);
      }
      
      public function deserializeAs_TreasureHuntShowLegendaryUIMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _availableLegendaryIdsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _availableLegendaryIdsLen; _i1++)
         {
            _val1 = input.readVarUhShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of availableLegendaryIds.");
            }
            this.availableLegendaryIds.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TreasureHuntShowLegendaryUIMessage(tree);
      }
      
      public function deserializeAsyncAs_TreasureHuntShowLegendaryUIMessage(tree:FuncTree) : void
      {
         this._availableLegendaryIdstree = tree.addChild(this._availableLegendaryIdstreeFunc);
      }
      
      private function _availableLegendaryIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._availableLegendaryIdstree.addChild(this._availableLegendaryIdsFunc);
         }
      }
      
      private function _availableLegendaryIdsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of availableLegendaryIds.");
         }
         this.availableLegendaryIds.push(_val);
      }
   }
}
