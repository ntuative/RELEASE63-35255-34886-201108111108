package com.sulake.habbo.avatar.structure.figure
{
    import com.sulake.core.utils.Map;
    import flash.utils.Dictionary;

    public class SetType implements ISetType 
    {

        private var _partSets:Map;
        private var _type:String;
        private var var_2983:int;
        private var var_2982:Dictionary;

        public function SetType(param1:XML)
        {
            this._type = String(param1.@type);
            this.var_2983 = parseInt(param1.@paletteid);
            this.var_2982 = new Dictionary();
            this.var_2982["F"] = new Dictionary();
            this.var_2982["M"] = new Dictionary();
            this.var_2982["F"][0] = Boolean(parseInt(param1.@mand_f_0));
            this.var_2982["F"][1] = Boolean(parseInt(param1.@mand_f_1));
            this.var_2982["M"][0] = Boolean(parseInt(param1.@mand_m_0));
            this.var_2982["M"][1] = Boolean(parseInt(param1.@mand_m_1));
            this._partSets = new Map();
            this.append(param1);
        }

        public function dispose():void
        {
            var _loc1_:FigurePartSet;
            for each (_loc1_ in this._partSets.getValues())
            {
                _loc1_.dispose();
            };
            this._partSets.dispose();
            this._partSets = null;
        }

        public function cleanUp(param1:XML):void
        {
            var _loc2_:XML;
            var _loc3_:String;
            var _loc4_:FigurePartSet;
            for each (_loc2_ in param1["set"])
            {
                _loc3_ = String(_loc2_.@id);
                _loc4_ = this._partSets.getValue(_loc3_);
                if (_loc4_ != null)
                {
                    _loc4_.dispose();
                    this._partSets.remove(_loc3_);
                };
            };
        }

        public function append(param1:XML):void
        {
            var _loc2_:XML;
            for each (_loc2_ in param1["set"])
            {
                this._partSets.add(String(_loc2_.@id), new FigurePartSet(_loc2_, this._type));
            };
        }

        public function getDefaultPartSet(param1:String):IFigurePartSet
        {
            var _loc4_:IFigurePartSet;
            var _loc2_:Array = this._partSets.getKeys();
            var _loc3_:int = (_loc2_.length - 1);
            while (_loc3_ >= 0)
            {
                _loc4_ = this._partSets.getValue(_loc2_[_loc3_]);
                if ((((_loc4_) && (_loc4_.clubLevel == 0)) && ((_loc4_.gender == param1) || (_loc4_.gender == "U"))))
                {
                    return (_loc4_);
                };
                _loc3_--;
            };
            return (null);
        }

        public function getPartSet(param1:int):IFigurePartSet
        {
            return (this._partSets.getValue(String(param1)));
        }

        public function get type():String
        {
            return (this._type);
        }

        public function get paletteID():int
        {
            return (this.var_2983);
        }

        public function isMandatory(param1:String, param2:int):Boolean
        {
            return (this.var_2982[param1.toUpperCase()][Math.min(param2, 1)]);
        }

        public function get partSets():Map
        {
            return (this._partSets);
        }


    }
}