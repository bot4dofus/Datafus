package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.dofus.network.types.game.context.MapCoordinatesExtended;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyMemberInStandardFightMessage extends AbstractPartyMemberInFightMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4564;
       
      
      private var _isInitialized:Boolean = false;
      
      public var fightMap:MapCoordinatesExtended;
      
      private var _fightMaptree:FuncTree;
      
      public function PartyMemberInStandardFightMessage()
      {
         this.fightMap = new MapCoordinatesExtended();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4564;
      }
      
      public function initPartyMemberInStandardFightMessage(partyId:uint = 0, reason:uint = 0, memberId:Number = 0, memberAccountId:uint = 0, memberName:String = "", fightId:uint = 0, timeBeforeFightStart:int = 0, fightMap:MapCoordinatesExtended = null) : PartyMemberInStandardFightMessage
      {
         super.initAbstractPartyMemberInFightMessage(partyId,reason,memberId,memberAccountId,memberName,fightId,timeBeforeFightStart);
         this.fightMap = fightMap;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.fightMap = new MapCoordinatesExtended();
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
         this.serializeAs_PartyMemberInStandardFightMessage(output);
      }
      
      public function serializeAs_PartyMemberInStandardFightMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyMemberInFightMessage(output);
         this.fightMap.serializeAs_MapCoordinatesExtended(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyMemberInStandardFightMessage(input);
      }
      
      public function deserializeAs_PartyMemberInStandardFightMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.fightMap = new MapCoordinatesExtended();
         this.fightMap.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyMemberInStandardFightMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyMemberInStandardFightMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._fightMaptree = tree.addChild(this._fightMaptreeFunc);
      }
      
      private function _fightMaptreeFunc(input:ICustomDataInput) : void
      {
         this.fightMap = new MapCoordinatesExtended();
         this.fightMap.deserializeAsync(this._fightMaptree);
      }
   }
}
