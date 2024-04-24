package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameFightFighterEntityLightInformation extends GameFightFighterLightInformations implements INetworkType
   {
      
      public static const protocolId:uint = 385;
       
      
      public var entityModelId:uint = 0;
      
      public var masterId:Number = 0;
      
      public function GameFightFighterEntityLightInformation()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 385;
      }
      
      public function initGameFightFighterEntityLightInformation(id:Number = 0, wave:uint = 0, level:uint = 0, breed:int = 0, sex:Boolean = false, alive:Boolean = false, entityModelId:uint = 0, masterId:Number = 0) : GameFightFighterEntityLightInformation
      {
         super.initGameFightFighterLightInformations(id,wave,level,breed,sex,alive);
         this.entityModelId = entityModelId;
         this.masterId = masterId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.entityModelId = 0;
         this.masterId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightFighterEntityLightInformation(output);
      }
      
      public function serializeAs_GameFightFighterEntityLightInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightFighterLightInformations(output);
         if(this.entityModelId < 0)
         {
            throw new Error("Forbidden value (" + this.entityModelId + ") on element entityModelId.");
         }
         output.writeByte(this.entityModelId);
         if(this.masterId < -9007199254740992 || this.masterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.masterId + ") on element masterId.");
         }
         output.writeDouble(this.masterId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightFighterEntityLightInformation(input);
      }
      
      public function deserializeAs_GameFightFighterEntityLightInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._entityModelIdFunc(input);
         this._masterIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightFighterEntityLightInformation(tree);
      }
      
      public function deserializeAsyncAs_GameFightFighterEntityLightInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._entityModelIdFunc);
         tree.addChild(this._masterIdFunc);
      }
      
      private function _entityModelIdFunc(input:ICustomDataInput) : void
      {
         this.entityModelId = input.readByte();
         if(this.entityModelId < 0)
         {
            throw new Error("Forbidden value (" + this.entityModelId + ") on element of GameFightFighterEntityLightInformation.entityModelId.");
         }
      }
      
      private function _masterIdFunc(input:ICustomDataInput) : void
      {
         this.masterId = input.readDouble();
         if(this.masterId < -9007199254740992 || this.masterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.masterId + ") on element of GameFightFighterEntityLightInformation.masterId.");
         }
      }
   }
}
