package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.dofus.network.types.game.social.AllianceFactSheetInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9280;
       
      
      private var _isInitialized:Boolean = false;
      
      public var alliances:Vector.<AllianceFactSheetInformations>;
      
      private var _alliancestree:FuncTree;
      
      public function AllianceListMessage()
      {
         this.alliances = new Vector.<AllianceFactSheetInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9280;
      }
      
      public function initAllianceListMessage(alliances:Vector.<AllianceFactSheetInformations> = null) : AllianceListMessage
      {
         this.alliances = alliances;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.alliances = new Vector.<AllianceFactSheetInformations>();
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
         this.serializeAs_AllianceListMessage(output);
      }
      
      public function serializeAs_AllianceListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.alliances.length);
         for(var _i1:uint = 0; _i1 < this.alliances.length; _i1++)
         {
            (this.alliances[_i1] as AllianceFactSheetInformations).serializeAs_AllianceFactSheetInformations(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceListMessage(input);
      }
      
      public function deserializeAs_AllianceListMessage(input:ICustomDataInput) : void
      {
         var _item1:AllianceFactSheetInformations = null;
         var _alliancesLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _alliancesLen; _i1++)
         {
            _item1 = new AllianceFactSheetInformations();
            _item1.deserialize(input);
            this.alliances.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceListMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceListMessage(tree:FuncTree) : void
      {
         this._alliancestree = tree.addChild(this._alliancestreeFunc);
      }
      
      private function _alliancestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._alliancestree.addChild(this._alliancesFunc);
         }
      }
      
      private function _alliancesFunc(input:ICustomDataInput) : void
      {
         var _item:AllianceFactSheetInformations = new AllianceFactSheetInformations();
         _item.deserialize(input);
         this.alliances.push(_item);
      }
   }
}
