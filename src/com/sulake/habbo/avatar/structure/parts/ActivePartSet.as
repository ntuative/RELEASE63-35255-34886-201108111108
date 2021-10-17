package com.sulake.habbo.avatar.structure.parts
{
    public class ActivePartSet 
    {

        private var _id:String;
        private var _parts:Array;

        public function ActivePartSet(param1:XML)
        {
            var _loc2_:XML;
            super();
            this._id = String(param1.@id);
            this._parts = new Array();
            for each (_loc2_ in param1.activePart)
            {
                this._parts.push(String(_loc2_.@["set-type"]));
            };
        }

        public function get parts():Array
        {
            return (this._parts);
        }


    }
}