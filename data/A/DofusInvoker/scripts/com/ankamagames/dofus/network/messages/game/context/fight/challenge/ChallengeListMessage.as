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
   
   public class ChallengeListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1098;
       
      
      private var _isInitialized:Boolean = false;
      
      public var challengesInformation:Vector.<ChallengeInformation>;
      
      private var _challengesInformationtree:FuncTree;
      
      public function ChallengeListMessage()
      {
         this.challengesInformation = new Vector.<ChallengeInformation>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1098;
      }
      
      public function initChallengeListMessage(challengesInformation:Vector.<ChallengeInformation> = null) : ChallengeListMessage
      {
         this.challengesInformation = challengesInformation;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.challengesInformation = new Vector.<ChallengeInformation>();
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
         this.serializeAs_ChallengeListMessage(output);
      }
      
      public function serializeAs_ChallengeListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.challengesInformation.length);
         for(var _i1:uint = 0; _i1 < this.challengesInformation.length; _i1++)
         {
            (this.challengesInformation[_i1] as ChallengeInformation).serializeAs_ChallengeInformation(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChallengeListMessage(input);
      }
      
      public function deserializeAs_ChallengeListMessage(input:ICustomDataInput) : void
      {
         var _item1:ChallengeInformation = null;
         var _challengesInformationLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _challengesInformationLen; _i1++)
         {
            _item1 = new ChallengeInformation();
            _item1.deserialize(input);
            this.challengesInformation.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChallengeListMessage(tree);
      }
      
      public function deserializeAsyncAs_ChallengeListMessage(tree:FuncTree) : void
      {
         this._challengesInformationtree = tree.addChild(this._challengesInformationtreeFunc);
      }
      
      private function _challengesInformationtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._challengesInformationtree.addChild(this._challengesInformationFunc);
         }
      }
      
      private function _challengesInformationFunc(input:ICustomDataInput) : void
      {
         var _item:ChallengeInformation = new ChallengeInformation();
         _item.deserialize(input);
         this.challengesInformation.push(_item);
      }
   }
}
