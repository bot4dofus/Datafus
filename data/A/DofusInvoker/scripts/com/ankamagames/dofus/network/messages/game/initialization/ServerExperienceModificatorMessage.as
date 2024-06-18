package com.ankamagames.dofus.network.messages.game.initialization
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ServerExperienceModificatorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9259;
       
      
      private var _isInitialized:Boolean = false;
      
      public var experiencePercent:uint = 0;
      
      public function ServerExperienceModificatorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9259;
      }
      
      public function initServerExperienceModificatorMessage(experiencePercent:uint = 0) : ServerExperienceModificatorMessage
      {
         this.experiencePercent = experiencePercent;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.experiencePercent = 0;
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
         this.serializeAs_ServerExperienceModificatorMessage(output);
      }
      
      public function serializeAs_ServerExperienceModificatorMessage(output:ICustomDataOutput) : void
      {
         if(this.experiencePercent < 0)
         {
            throw new Error("Forbidden value (" + this.experiencePercent + ") on element experiencePercent.");
         }
         output.writeVarShort(this.experiencePercent);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ServerExperienceModificatorMessage(input);
      }
      
      public function deserializeAs_ServerExperienceModificatorMessage(input:ICustomDataInput) : void
      {
         this._experiencePercentFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ServerExperienceModificatorMessage(tree);
      }
      
      public function deserializeAsyncAs_ServerExperienceModificatorMessage(tree:FuncTree) : void
      {
         tree.addChild(this._experiencePercentFunc);
      }
      
      private function _experiencePercentFunc(input:ICustomDataInput) : void
      {
         this.experiencePercent = input.readVarUhShort();
         if(this.experiencePercent < 0)
         {
            throw new Error("Forbidden value (" + this.experiencePercent + ") on element of ServerExperienceModificatorMessage.experiencePercent.");
         }
      }
   }
}
