package com.sulake.habbo.avatar.structure.animation
{
    public class ActionPart 
    {

        private var _frames:Array;

        public function ActionPart(param1:XML)
        {
            var _loc2_:XML;
            super();
            this._frames = new Array();
            for each (_loc2_ in param1.frame)
            {
                this._frames.push(parseInt(_loc2_.@number));
            };
        }

        public function hasFrame(param1:int):Boolean
        {
            return (this._frames.indexOf(param1) > -1);
        }

        public function get frames():Array
        {
            return (this._frames);
        }


    }
}