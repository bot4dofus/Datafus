package com.ankamagames.dofus.network.messages.game.character.alignment.war.effort
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AlignmentWarEffortDonateRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5431;
       
      
      private var _isInitialized:Boolean = false;
      
      public var donation:Number = 0;
      
      public function AlignmentWarEffortDonateRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5431;
      }
      
      public function initAlignmentWarEffortDonateRequestMessage(donation:Number = 0) : AlignmentWarEffortDonateRequestMessage
      {
         this.donation = donation;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.donation = 0;
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
         this.serializeAs_AlignmentWarEffortDonateRequestMessage(output);
      }
      
      public function serializeAs_AlignmentWarEffortDonateRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.donation < 0 || this.donation > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.donation + ") on element donation.");
         }
         output.writeVarLong(this.donation);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AlignmentWarEffortDonateRequestMessage(input);
      }
      
      public function deserializeAs_AlignmentWarEffortDonateRequestMessage(input:ICustomDataInput) : void
      {
         this._donationFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AlignmentWarEffortDonateRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_AlignmentWarEffortDonateRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._donationFunc);
      }
      
      private function _donationFunc(input:ICustomDataInput) : void
      {
         this.donation = input.readVarUhLong();
         if(this.donation < 0 || this.donation > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.donation + ") on element of AlignmentWarEffortDonateRequestMessage.donation.");
         }
      }
   }
}
