package com.ankamagames.dofus.network.messages.game.character.alignment.war.effort
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AlignmentWarEffortDonatePreviewMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8775;
       
      
      private var _isInitialized:Boolean = false;
      
      public var xp:Number = 0;
      
      public function AlignmentWarEffortDonatePreviewMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8775;
      }
      
      public function initAlignmentWarEffortDonatePreviewMessage(xp:Number = 0) : AlignmentWarEffortDonatePreviewMessage
      {
         this.xp = xp;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.xp = 0;
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
         this.serializeAs_AlignmentWarEffortDonatePreviewMessage(output);
      }
      
      public function serializeAs_AlignmentWarEffortDonatePreviewMessage(output:ICustomDataOutput) : void
      {
         if(this.xp < -9007199254740992 || this.xp > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.xp + ") on element xp.");
         }
         output.writeDouble(this.xp);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AlignmentWarEffortDonatePreviewMessage(input);
      }
      
      public function deserializeAs_AlignmentWarEffortDonatePreviewMessage(input:ICustomDataInput) : void
      {
         this._xpFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AlignmentWarEffortDonatePreviewMessage(tree);
      }
      
      public function deserializeAsyncAs_AlignmentWarEffortDonatePreviewMessage(tree:FuncTree) : void
      {
         tree.addChild(this._xpFunc);
      }
      
      private function _xpFunc(input:ICustomDataInput) : void
      {
         this.xp = input.readDouble();
         if(this.xp < -9007199254740992 || this.xp > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.xp + ") on element of AlignmentWarEffortDonatePreviewMessage.xp.");
         }
      }
   }
}
