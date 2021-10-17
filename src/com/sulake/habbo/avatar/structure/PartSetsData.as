package com.sulake.habbo.avatar.structure
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.structure.parts.PartDefinition;
    import com.sulake.habbo.avatar.structure.parts.ActivePartSet;
    import com.sulake.habbo.avatar.actions.IActionDefinition;
    import com.sulake.habbo.avatar.actions.ActionDefinition;
    import com.sulake.habbo.avatar.structure.parts.*;

    public class PartSetsData implements IStructureData 
    {

        private var _parts:Dictionary;
        private var var_2993:Dictionary;

        public function PartSetsData()
        {
            this._parts = new Dictionary();
            this.var_2993 = new Dictionary();
        }

        public function parse(param1:XML):Boolean
        {
            var _loc2_:XML;
            var _loc3_:XML;
            if (param1 == null)
            {
                return (false);
            };
            for each (_loc2_ in param1.partSet[0].part)
            {
                this._parts[String(_loc2_.@["set-type"])] = new PartDefinition(_loc2_);
            };
            for each (_loc3_ in param1.activePartSet)
            {
                this.var_2993[String(_loc3_.@id)] = new ActivePartSet(_loc3_);
            };
            return (true);
        }

        public function appendXML(param1:XML):Boolean
        {
            var _loc2_:XML;
            var _loc3_:XML;
            if (param1 == null)
            {
                return (false);
            };
            for each (_loc2_ in param1.partSet[0].part)
            {
                this._parts[String(_loc2_.@["set-type"])] = new PartDefinition(_loc2_);
            };
            for each (_loc3_ in param1.activePartSet)
            {
                this.var_2993[String(_loc3_.@id)] = new ActivePartSet(_loc3_);
            };
            return (false);
        }

        public function getActiveParts(param1:IActionDefinition):Array
        {
            var _loc2_:ActivePartSet = this.var_2993[param1.activePartSet];
            if (_loc2_ != null)
            {
                return (_loc2_.parts);
            };
            return ([]);
        }

        public function getPartDefinition(param1:String):PartDefinition
        {
            return (this._parts[param1] as PartDefinition);
        }

        public function addPartDefinition(param1:XML):PartDefinition
        {
            var _loc2_:String = String(param1.@["set-type"]);
            if (this._parts[_loc2_] == null)
            {
                this._parts[_loc2_] = new PartDefinition(param1);
            };
            return (this._parts[_loc2_]);
        }

        public function get parts():Dictionary
        {
            return (this._parts);
        }

        public function get activePartSets():Dictionary
        {
            return (this.var_2993);
        }

        public function getActivePartSet(param1:ActionDefinition):ActivePartSet
        {
            return (this.var_2993[param1.activePartSet] as ActivePartSet);
        }


    }
}