package com.ankamagames.dofus.network.messages.game.initialization
{
   import com.ankamagames.dofus.network.types.game.character.restriction.ActorRestrictionsInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SetCharacterRestrictionsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7204;
       
      
      private var _isInitialized:Boolean = false;
      
      public var actorId:Number = 0;
      
      public var restrictions:ActorRestrictionsInformations;
      
      private var _restrictionstree:FuncTree;
      
      public function SetCharacterRestrictionsMessage()
      {
         this.restrictions = new ActorRestrictionsInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7204;
      }
      
      public function initSetCharacterRestrictionsMessage(actorId:Number = 0, restrictions:ActorRestrictionsInformations = null) : SetCharacterRestrictionsMessage
      {
         this.actorId = actorId;
         this.restrictions = restrictions;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.actorId = 0;
         this.restrictions = new ActorRestrictionsInformations();
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
         this.serializeAs_SetCharacterRestrictionsMessage(output);
      }
      
      public function serializeAs_SetCharacterRestrictionsMessage(output:ICustomDataOutput) : void
      {
         if(this.actorId < -9007199254740992 || this.actorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.actorId + ") on element actorId.");
         }
         output.writeDouble(this.actorId);
         this.restrictions.serializeAs_ActorRestrictionsInformations(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SetCharacterRestrictionsMessage(input);
      }
      
      public function deserializeAs_SetCharacterRestrictionsMessage(input:ICustomDataInput) : void
      {
         this._actorIdFunc(input);
         this.restrictions = new ActorRestrictionsInformations();
         this.restrictions.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SetCharacterRestrictionsMessage(tree);
      }
      
      public function deserializeAsyncAs_SetCharacterRestrictionsMessage(tree:FuncTree) : void
      {
         tree.addChild(this._actorIdFunc);
         this._restrictionstree = tree.addChild(this._restrictionstreeFunc);
      }
      
      private function _actorIdFunc(input:ICustomDataInput) : void
      {
         this.actorId = input.readDouble();
         if(this.actorId < -9007199254740992 || this.actorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.actorId + ") on element of SetCharacterRestrictionsMessage.actorId.");
         }
      }
      
      private function _restrictionstreeFunc(input:ICustomDataInput) : void
      {
         this.restrictions = new ActorRestrictionsInformations();
         this.restrictions.deserializeAsync(this._restrictionstree);
      }
   }
}
