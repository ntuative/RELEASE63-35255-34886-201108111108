package com.sulake.habbo.avatar.structure
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.structure.figure.Palette;
    import com.sulake.habbo.avatar.structure.figure.SetType;
    import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
    import com.sulake.habbo.avatar.structure.figure.ISetType;
    import com.sulake.habbo.avatar.structure.figure.IPalette;
    import com.sulake.habbo.avatar.structure.figure.*;

    public class FigureData implements IStructureData, IFigureData 
    {

        private var var_2934:Dictionary;
        private var var_2992:Dictionary;

        public function FigureData()
        {
            this.var_2934 = new Dictionary();
            this.var_2992 = new Dictionary();
        }

        public function dispose():void
        {
        }

        public function parse(param1:XML):Boolean
        {
            var _loc2_:XML;
            var _loc3_:XML;
            if (param1 == null)
            {
                return (false);
            };
            for each (_loc2_ in param1.colors.palette)
            {
                this.var_2934[String(_loc2_.@id)] = new Palette(_loc2_);
            };
            for each (_loc3_ in param1.sets.settype)
            {
                this.var_2992[String(_loc3_.@type)] = new SetType(_loc3_);
            };
            return (true);
        }

        public function injectXML(param1:XML):void
        {
            var _loc2_:XML;
            var _loc3_:SetType;
            for each (_loc2_ in param1.sets.settype)
            {
                _loc3_ = this.var_2992[String(_loc2_.@type)];
                if (_loc3_ != null)
                {
                    _loc3_.cleanUp(_loc2_);
                }
                else
                {
                    this.var_2992[String(_loc2_.@type)] = new SetType(_loc2_);
                };
            };
            this.appendXML(param1);
        }

        public function appendXML(param1:XML):Boolean
        {
            var _loc2_:XML;
            var _loc3_:XML;
            var _loc4_:Palette;
            var _loc5_:SetType;
            if (param1 == null)
            {
                return (false);
            };
            for each (_loc2_ in param1.colors.palette)
            {
                _loc4_ = this.var_2934[String(_loc2_.@id)];
                if (_loc4_ == null)
                {
                    this.var_2934[String(_loc2_.@id)] = new Palette(_loc2_);
                }
                else
                {
                    _loc4_.append(_loc2_);
                };
            };
            for each (_loc3_ in param1.sets.settype)
            {
                _loc5_ = this.var_2992[String(_loc3_.@type)];
                if (_loc5_ == null)
                {
                    this.var_2992[String(_loc3_.@type)] = new SetType(_loc3_);
                }
                else
                {
                    _loc5_.append(_loc3_);
                };
            };
            return (false);
        }

        public function getMandatorySetTypeIds(param1:String, param2:int):Array
        {
            var _loc4_:SetType;
            var _loc3_:Array = new Array();
            for each (_loc4_ in this.var_2992)
            {
                if (((_loc4_) && (_loc4_.isMandatory(param1, param2))))
                {
                    _loc3_.push(_loc4_.type);
                };
            };
            return (_loc3_);
        }

        public function getDefaultPartSet(param1:String, param2:String):IFigurePartSet
        {
            var _loc3_:SetType = (this.var_2992[param1] as SetType);
            if (_loc3_)
            {
                return (_loc3_.getDefaultPartSet(param2));
            };
            return (null);
        }

        public function getSetType(param1:String):ISetType
        {
            return (this.var_2992[param1]);
        }

        public function getPalette(param1:int):IPalette
        {
            return (this.var_2934[String(param1)]);
        }


    }
}