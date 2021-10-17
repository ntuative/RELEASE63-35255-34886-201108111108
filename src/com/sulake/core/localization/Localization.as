package com.sulake.core.localization
{
    import flash.utils.Dictionary;

    public class Localization implements ILocalization 
    {

        private var var_2604:String;
        private var var_2605:String;
        private var var_2606:Dictionary;
        private var var_2607:Array;
        private var _isInitialized:Boolean = false;

        public function Localization(param1:String, param2:String=null)
        {
            this.var_2607 = new Array();
            this.var_2606 = new Dictionary();
            this.var_2604 = param1;
            this.var_2605 = param2;
        }

        public function get isInitialized():Boolean
        {
            return (!(this.var_2605 == null));
        }

        public function get key():String
        {
            return (this.var_2604);
        }

        public function get value():String
        {
            return (this.fillParameterValues());
        }

        public function get raw():String
        {
            return (this.var_2605);
        }

        public function setValue(param1:String):void
        {
            this.var_2605 = param1;
            this.updateListeners();
        }

        public function registerListener(param1:ILocalizable):void
        {
            this.var_2607.push(param1);
            param1.localization = this.value;
        }

        public function removeListener(param1:ILocalizable):void
        {
            var _loc2_:int = this.var_2607.indexOf(param1);
            if (_loc2_ >= 0)
            {
                this.var_2607.splice(_loc2_, 1);
            };
        }

        public function registerParameter(param1:String, param2:String, param3:String="%"):void
        {
            param1 = ((param3 + param1) + param3);
            this.var_2606[param1] = param2;
            this.updateListeners();
        }

        public function updateListeners():void
        {
            var _loc1_:ILocalizable;
            for each (_loc1_ in this.var_2607)
            {
                _loc1_.localization = this.value;
            };
        }

        private function fillParameterValues():String
        {
            var _loc2_:String;
            var _loc3_:String;
            var _loc4_:RegExp;
            var _loc1_:String = this.var_2605;
            for (_loc2_ in this.var_2606)
            {
                _loc3_ = this.var_2606[_loc2_];
                _loc4_ = new RegExp(_loc2_, "gim");
                if (_loc1_ != null)
                {
                    _loc1_ = _loc1_.replace(_loc4_, _loc3_);
                };
            };
            return (_loc1_);
        }


    }
}