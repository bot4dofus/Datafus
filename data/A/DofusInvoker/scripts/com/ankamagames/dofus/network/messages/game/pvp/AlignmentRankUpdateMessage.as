package com.ankamagames.dofus.network.messages.game.pvp
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AlignmentRankUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5019;
       
      
      private var _isInitialized:Boolean = false;
      
      public var alignmentRank:uint = 0;
      
      public var verbose:Boolean = false;
      
      public function AlignmentRankUpdateMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5019;
      }
      
      public function initAlignmentRankUpdateMessage(alignmentRank:uint = 0, verbose:Boolean = false) : AlignmentRankUpdateMessage
      {
         this.alignmentRank = alignmentRank;
         this.verbose = verbose;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.alignmentRank = 0;
         this.verbose = false;
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
         this.serializeAs_AlignmentRankUpdateMessage(output);
      }
      
      public function serializeAs_AlignmentRankUpdateMessage(output:ICustomDataOutput) : void
      {
         if(this.alignmentRank < 0)
         {
            throw new Error("Forbidden value (" + this.alignmentRank + ") on element alignmentRank.");
         }
         output.writeByte(this.alignmentRank);
         output.writeBoolean(this.verbose);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AlignmentRankUpdateMessage(input);
      }
      
      public function deserializeAs_AlignmentRankUpdateMessage(input:ICustomDataInput) : void
      {
         this._alignmentRankFunc(input);
         this._verboseFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AlignmentRankUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_AlignmentRankUpdateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._alignmentRankFunc);
         tree.addChild(this._verboseFunc);
      }
      
      private function _alignmentRankFunc(input:ICustomDataInput) : void
      {
         this.alignmentRank = input.readByte();
         if(this.alignmentRank < 0)
         {
            throw new Error("Forbidden value (" + this.alignmentRank + ") on element of AlignmentRankUpdateMessage.alignmentRank.");
         }
      }
      
      private function _verboseFunc(input:ICustomDataInput) : void
      {
         this.verbose = input.readBoolean();
      }
   }
}
