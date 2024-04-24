package com.ankamagames.dofus.network.types.game.social.fight
{
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightPhase;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SocialFight implements INetworkType
   {
      
      public static const protocolId:uint = 596;
       
      
      public var socialFightInfo:SocialFightInfo;
      
      public var attackers:Vector.<CharacterMinimalPlusLookInformations>;
      
      public var defenders:Vector.<CharacterMinimalPlusLookInformations>;
      
      public var phase:FightPhase;
      
      private var _socialFightInfotree:FuncTree;
      
      private var _attackerstree:FuncTree;
      
      private var _defenderstree:FuncTree;
      
      private var _phasetree:FuncTree;
      
      public function SocialFight()
      {
         this.socialFightInfo = new SocialFightInfo();
         this.attackers = new Vector.<CharacterMinimalPlusLookInformations>();
         this.defenders = new Vector.<CharacterMinimalPlusLookInformations>();
         this.phase = new FightPhase();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 596;
      }
      
      public function initSocialFight(socialFightInfo:SocialFightInfo = null, attackers:Vector.<CharacterMinimalPlusLookInformations> = null, defenders:Vector.<CharacterMinimalPlusLookInformations> = null, phase:FightPhase = null) : SocialFight
      {
         this.socialFightInfo = socialFightInfo;
         this.attackers = attackers;
         this.defenders = defenders;
         this.phase = phase;
         return this;
      }
      
      public function reset() : void
      {
         this.socialFightInfo = new SocialFightInfo();
         this.defenders = new Vector.<CharacterMinimalPlusLookInformations>();
         this.phase = new FightPhase();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SocialFight(output);
      }
      
      public function serializeAs_SocialFight(output:ICustomDataOutput) : void
      {
         this.socialFightInfo.serializeAs_SocialFightInfo(output);
         output.writeShort(this.attackers.length);
         for(var _i2:uint = 0; _i2 < this.attackers.length; _i2++)
         {
            (this.attackers[_i2] as CharacterMinimalPlusLookInformations).serializeAs_CharacterMinimalPlusLookInformations(output);
         }
         output.writeShort(this.defenders.length);
         for(var _i3:uint = 0; _i3 < this.defenders.length; _i3++)
         {
            (this.defenders[_i3] as CharacterMinimalPlusLookInformations).serializeAs_CharacterMinimalPlusLookInformations(output);
         }
         this.phase.serializeAs_FightPhase(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SocialFight(input);
      }
      
      public function deserializeAs_SocialFight(input:ICustomDataInput) : void
      {
         var _item2:CharacterMinimalPlusLookInformations = null;
         var _item3:CharacterMinimalPlusLookInformations = null;
         this.socialFightInfo = new SocialFightInfo();
         this.socialFightInfo.deserialize(input);
         var _attackersLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _attackersLen; _i2++)
         {
            _item2 = new CharacterMinimalPlusLookInformations();
            _item2.deserialize(input);
            this.attackers.push(_item2);
         }
         var _defendersLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _defendersLen; _i3++)
         {
            _item3 = new CharacterMinimalPlusLookInformations();
            _item3.deserialize(input);
            this.defenders.push(_item3);
         }
         this.phase = new FightPhase();
         this.phase.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SocialFight(tree);
      }
      
      public function deserializeAsyncAs_SocialFight(tree:FuncTree) : void
      {
         this._socialFightInfotree = tree.addChild(this._socialFightInfotreeFunc);
         this._attackerstree = tree.addChild(this._attackerstreeFunc);
         this._defenderstree = tree.addChild(this._defenderstreeFunc);
         this._phasetree = tree.addChild(this._phasetreeFunc);
      }
      
      private function _socialFightInfotreeFunc(input:ICustomDataInput) : void
      {
         this.socialFightInfo = new SocialFightInfo();
         this.socialFightInfo.deserializeAsync(this._socialFightInfotree);
      }
      
      private function _attackerstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._attackerstree.addChild(this._attackersFunc);
         }
      }
      
      private function _attackersFunc(input:ICustomDataInput) : void
      {
         var _item:CharacterMinimalPlusLookInformations = new CharacterMinimalPlusLookInformations();
         _item.deserialize(input);
         this.attackers.push(_item);
      }
      
      private function _defenderstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._defenderstree.addChild(this._defendersFunc);
         }
      }
      
      private function _defendersFunc(input:ICustomDataInput) : void
      {
         var _item:CharacterMinimalPlusLookInformations = new CharacterMinimalPlusLookInformations();
         _item.deserialize(input);
         this.defenders.push(_item);
      }
      
      private function _phasetreeFunc(input:ICustomDataInput) : void
      {
         this.phase = new FightPhase();
         this.phase.deserializeAsync(this._phasetree);
      }
   }
}
