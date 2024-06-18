package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class HumanOptionEmote extends HumanOption implements INetworkType
   {
      
      public static const protocolId:uint = 7646;
       
      
      public var emoteId:uint = 0;
      
      public var emoteStartTime:Number = 0;
      
      public function HumanOptionEmote()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7646;
      }
      
      public function initHumanOptionEmote(emoteId:uint = 0, emoteStartTime:Number = 0) : HumanOptionEmote
      {
         this.emoteId = emoteId;
         this.emoteStartTime = emoteStartTime;
         return this;
      }
      
      override public function reset() : void
      {
         this.emoteId = 0;
         this.emoteStartTime = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_HumanOptionEmote(output);
      }
      
      public function serializeAs_HumanOptionEmote(output:ICustomDataOutput) : void
      {
         super.serializeAs_HumanOption(output);
         if(this.emoteId < 0 || this.emoteId > 65535)
         {
            throw new Error("Forbidden value (" + this.emoteId + ") on element emoteId.");
         }
         output.writeShort(this.emoteId);
         if(this.emoteStartTime < -9007199254740992 || this.emoteStartTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.emoteStartTime + ") on element emoteStartTime.");
         }
         output.writeDouble(this.emoteStartTime);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HumanOptionEmote(input);
      }
      
      public function deserializeAs_HumanOptionEmote(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._emoteIdFunc(input);
         this._emoteStartTimeFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HumanOptionEmote(tree);
      }
      
      public function deserializeAsyncAs_HumanOptionEmote(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._emoteIdFunc);
         tree.addChild(this._emoteStartTimeFunc);
      }
      
      private function _emoteIdFunc(input:ICustomDataInput) : void
      {
         this.emoteId = input.readUnsignedShort();
         if(this.emoteId < 0 || this.emoteId > 65535)
         {
            throw new Error("Forbidden value (" + this.emoteId + ") on element of HumanOptionEmote.emoteId.");
         }
      }
      
      private function _emoteStartTimeFunc(input:ICustomDataInput) : void
      {
         this.emoteStartTime = input.readDouble();
         if(this.emoteStartTime < -9007199254740992 || this.emoteStartTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.emoteStartTime + ") on element of HumanOptionEmote.emoteStartTime.");
         }
      }
   }
}
