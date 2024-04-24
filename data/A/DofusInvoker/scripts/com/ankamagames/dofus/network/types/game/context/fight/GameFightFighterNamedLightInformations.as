package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameFightFighterNamedLightInformations extends GameFightFighterLightInformations implements INetworkType
   {
      
      public static const protocolId:uint = 292;
       
      
      public var name:String = "";
      
      public function GameFightFighterNamedLightInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 292;
      }
      
      public function initGameFightFighterNamedLightInformations(id:Number = 0, wave:uint = 0, level:uint = 0, breed:int = 0, sex:Boolean = false, alive:Boolean = false, name:String = "") : GameFightFighterNamedLightInformations
      {
         super.initGameFightFighterLightInformations(id,wave,level,breed,sex,alive);
         this.name = name;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.name = "";
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightFighterNamedLightInformations(output);
      }
      
      public function serializeAs_GameFightFighterNamedLightInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightFighterLightInformations(output);
         output.writeUTF(this.name);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightFighterNamedLightInformations(input);
      }
      
      public function deserializeAs_GameFightFighterNamedLightInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._nameFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightFighterNamedLightInformations(tree);
      }
      
      public function deserializeAsyncAs_GameFightFighterNamedLightInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._nameFunc);
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
   }
}
