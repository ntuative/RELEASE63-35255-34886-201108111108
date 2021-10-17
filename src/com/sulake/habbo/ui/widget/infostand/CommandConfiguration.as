package com.sulake.habbo.ui.widget.infostand
{
    import flash.utils.Dictionary;

    public class CommandConfiguration 
    {

        private var var_4969:Array;
        private var var_3833:Dictionary = new Dictionary();

        public function CommandConfiguration(param1:Array, param2:Array)
        {
            var _loc3_:int;
            var _loc4_:int;
            super();
            this.var_4969 = param1;
            while (_loc3_ < param2.length)
            {
                _loc4_ = param2[_loc3_];
                this.var_3833[_loc4_] = true;
                _loc3_++;
            };
        }

        public function get allCommandIds():Array
        {
            return (this.var_4969);
        }

        public function isEnabled(param1:int):Boolean
        {
            return (!(this.var_3833[param1] == null));
        }


    }
}