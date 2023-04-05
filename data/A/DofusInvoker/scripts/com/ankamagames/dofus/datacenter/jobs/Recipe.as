package com.ankamagames.dofus.datacenter.jobs
{
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.misc.utils.GameDataQuery;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.I18nFileAccessor;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Recipe implements IDataCenter
   {
      
      public static const MODULE:String = "Recipes";
      
      private static var _jobRecipes:Array;
      
      public static var idAccessors:IdAccessors = new IdAccessors(null,getAllRecipes);
       
      
      public var resultId:int;
      
      public var resultNameId:uint;
      
      public var resultTypeId:uint;
      
      public var resultLevel:uint;
      
      public var ingredientIds:Vector.<int>;
      
      public var quantities:Vector.<uint>;
      
      public var jobId:int;
      
      public var skillId:int;
      
      public var changeVersion:String;
      
      public var tooltipExpirationDate:Number = NaN;
      
      private var _result:ItemWrapper;
      
      private var _resultName:String;
      
      private var _ingredients:Vector.<ItemWrapper>;
      
      private var _job:Job;
      
      private var _skill:Skill;
      
      private var _words:String;
      
      public function Recipe()
      {
         super();
      }
      
      public static function getRecipeByResultId(resultId:int) : Recipe
      {
         return GameData.getObject(MODULE,resultId) as Recipe;
      }
      
      public static function getAllRecipesForSkillId(pSkillId:uint, jobLevel:uint) : Array
      {
         var recipe:Recipe = null;
         var resultId:int = 0;
         var recipes:Array = new Array();
         var craftables:Vector.<int> = Skill.getSkillById(pSkillId).craftableItemIds;
         for each(resultId in craftables)
         {
            recipe = getRecipeByResultId(resultId);
            if(recipe)
            {
               if(recipe.resultLevel <= jobLevel)
               {
                  recipes.push(recipe);
               }
            }
         }
         return recipes.sortOn("resultLevel",Array.NUMERIC | Array.DESCENDING);
      }
      
      public static function getAllRecipes() : Array
      {
         return GameData.getObjects(MODULE) as Array;
      }
      
      public static function getRecipesByJobId(jobId:uint) : Array
      {
         if(jobId == DataEnum.JOB_ID_BASE)
         {
            return null;
         }
         if(!_jobRecipes)
         {
            _jobRecipes = new Array();
         }
         if(_jobRecipes[jobId])
         {
            return _jobRecipes[jobId];
         }
         var results:Array = new Array();
         var recipeIds:Vector.<uint> = GameDataQuery.queryEquals(Recipe,"jobId",jobId);
         var l:int = recipeIds.length;
         for(var i:int = 0; i < recipeIds.length; i++)
         {
            results.push(GameData.getObject(MODULE,recipeIds[i]) as Recipe);
         }
         _jobRecipes[jobId] = results;
         return results;
      }
      
      public function get result() : ItemWrapper
      {
         if(!this._result)
         {
            this._result = ItemWrapper.create(0,0,this.resultId,0,null,false);
         }
         return this._result;
      }
      
      public function get resultName() : String
      {
         if(!this._resultName)
         {
            this._resultName = I18n.getText(this.resultNameId);
         }
         return this._resultName;
      }
      
      public function get ingredients() : Vector.<ItemWrapper>
      {
         var ingredientsCount:uint = 0;
         var i:uint = 0;
         if(!this._ingredients)
         {
            ingredientsCount = this.ingredientIds.length;
            this._ingredients = new Vector.<ItemWrapper>(ingredientsCount,true);
            for(i = 0; i < ingredientsCount; i++)
            {
               this._ingredients[i] = ItemWrapper.create(0,0,this.ingredientIds[i],this.quantities[i],null,false);
            }
         }
         return this._ingredients;
      }
      
      public function get words() : String
      {
         var ingredient:ItemWrapper = null;
         if(!this._words)
         {
            this._words = I18nFileAccessor.getInstance().getUnDiacriticalText(this.resultNameId);
            for each(ingredient in this.ingredients)
            {
               this._words += " " + I18nFileAccessor.getInstance().getUnDiacriticalText(ingredient.nameId);
            }
            this._words = this._words.toLowerCase();
         }
         return this._words;
      }
      
      public function get job() : Job
      {
         if(!this._job)
         {
            this._job = Job.getJobById(this.jobId);
         }
         return this._job;
      }
      
      public function get skill() : Skill
      {
         if(!this._skill)
         {
            this._skill = Skill.getSkillById(this.skillId);
         }
         return this._skill;
      }
   }
}
