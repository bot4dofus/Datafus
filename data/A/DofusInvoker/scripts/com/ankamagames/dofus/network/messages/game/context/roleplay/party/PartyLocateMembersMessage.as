package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyMemberGeoPosition;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyLocateMembersMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 594;
       
      
      private var _isInitialized:Boolean = false;
      
      public var geopositions:Vector.<PartyMemberGeoPosition>;
      
      private var _geopositionstree:FuncTree;
      
      public function PartyLocateMembersMessage()
      {
         this.geopositions = new Vector.<PartyMemberGeoPosition>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 594;
      }
      
      public function initPartyLocateMembersMessage(partyId:uint = 0, geopositions:Vector.<PartyMemberGeoPosition> = null) : PartyLocateMembersMessage
      {
         super.initAbstractPartyMessage(partyId);
         this.geopositions = geopositions;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.geopositions = new Vector.<PartyMemberGeoPosition>();
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PartyLocateMembersMessage(output);
      }
      
      public function serializeAs_PartyLocateMembersMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyMessage(output);
         output.writeShort(this.geopositions.length);
         for(var _i1:uint = 0; _i1 < this.geopositions.length; _i1++)
         {
            (this.geopositions[_i1] as PartyMemberGeoPosition).serializeAs_PartyMemberGeoPosition(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyLocateMembersMessage(input);
      }
      
      public function deserializeAs_PartyLocateMembersMessage(input:ICustomDataInput) : void
      {
         var _item1:PartyMemberGeoPosition = null;
         super.deserialize(input);
         var _geopositionsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _geopositionsLen; _i1++)
         {
            _item1 = new PartyMemberGeoPosition();
            _item1.deserialize(input);
            this.geopositions.push(_item1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyLocateMembersMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyLocateMembersMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._geopositionstree = tree.addChild(this._geopositionstreeFunc);
      }
      
      private function _geopositionstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._geopositionstree.addChild(this._geopositionsFunc);
         }
      }
      
      private function _geopositionsFunc(input:ICustomDataInput) : void
      {
         var _item:PartyMemberGeoPosition = new PartyMemberGeoPosition();
         _item.deserialize(input);
         this.geopositions.push(_item);
      }
   }
}
