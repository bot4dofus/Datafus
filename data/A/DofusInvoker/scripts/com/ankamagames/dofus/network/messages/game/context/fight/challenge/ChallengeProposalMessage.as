package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
   import com.ankamagames.dofus.network.types.game.context.fight.challenge.ChallengeInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChallengeProposalMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8830;
       
      
      private var _isInitialized:Boolean = false;
      
      public var challengeProposals:Vector.<ChallengeInformation>;
      
      public var timer:Number = 0;
      
      private var _challengeProposalstree:FuncTree;
      
      public function ChallengeProposalMessage()
      {
         this.challengeProposals = new Vector.<ChallengeInformation>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8830;
      }
      
      public function initChallengeProposalMessage(challengeProposals:Vector.<ChallengeInformation> = null, timer:Number = 0) : ChallengeProposalMessage
      {
         this.challengeProposals = challengeProposals;
         this.timer = timer;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.challengeProposals = new Vector.<ChallengeInformation>();
         this.timer = 0;
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
         this.serializeAs_ChallengeProposalMessage(output);
      }
      
      public function serializeAs_ChallengeProposalMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.challengeProposals.length);
         for(var _i1:uint = 0; _i1 < this.challengeProposals.length; _i1++)
         {
            (this.challengeProposals[_i1] as ChallengeInformation).serializeAs_ChallengeInformation(output);
         }
         if(this.timer < 0 || this.timer > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.timer + ") on element timer.");
         }
         output.writeDouble(this.timer);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChallengeProposalMessage(input);
      }
      
      public function deserializeAs_ChallengeProposalMessage(input:ICustomDataInput) : void
      {
         var _item1:ChallengeInformation = null;
         var _challengeProposalsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _challengeProposalsLen; _i1++)
         {
            _item1 = new ChallengeInformation();
            _item1.deserialize(input);
            this.challengeProposals.push(_item1);
         }
         this._timerFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChallengeProposalMessage(tree);
      }
      
      public function deserializeAsyncAs_ChallengeProposalMessage(tree:FuncTree) : void
      {
         this._challengeProposalstree = tree.addChild(this._challengeProposalstreeFunc);
         tree.addChild(this._timerFunc);
      }
      
      private function _challengeProposalstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._challengeProposalstree.addChild(this._challengeProposalsFunc);
         }
      }
      
      private function _challengeProposalsFunc(input:ICustomDataInput) : void
      {
         var _item:ChallengeInformation = new ChallengeInformation();
         _item.deserialize(input);
         this.challengeProposals.push(_item);
      }
      
      private function _timerFunc(input:ICustomDataInput) : void
      {
         this.timer = input.readDouble();
         if(this.timer < 0 || this.timer > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.timer + ") on element of ChallengeProposalMessage.timer.");
         }
      }
   }
}
