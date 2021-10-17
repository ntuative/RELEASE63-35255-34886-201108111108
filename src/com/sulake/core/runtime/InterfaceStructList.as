package com.sulake.core.runtime
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.getQualifiedClassName;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.runtime.*;

    internal final class InterfaceStructList implements IDisposable 
    {

        private var var_2632:Array = new Array();


        public function get length():uint
        {
            return (this.var_2632.length);
        }

        public function get disposed():Boolean
        {
            return (this.var_2632 == null);
        }

        public function dispose():void
        {
            var _loc2_:InterfaceStruct;
            var _loc1_:uint = this.var_2632.length;
            var _loc3_:uint;
            while (_loc3_ < _loc1_)
            {
                _loc2_ = this.var_2632.pop();
                _loc2_.dispose();
                _loc3_++;
            };
            this.var_2632 = null;
        }

        public function insert(param1:InterfaceStruct):uint
        {
            this.var_2632.push(param1);
            return (this.var_2632.length);
        }

        public function remove(param1:uint):InterfaceStruct
        {
            var _loc2_:InterfaceStruct;
            if (param1 < this.var_2632.length)
            {
                _loc2_ = this.var_2632[param1];
                this.var_2632.splice(param1, 1);
                return (_loc2_);
            };
            throw (new Error("Index out of range!"));
        }

        public function find(param1:IID):IUnknown
        {
            var _loc4_:InterfaceStruct;
            var _loc2_:String = getQualifiedClassName(param1);
            var _loc3_:uint = this.var_2632.length;
            var _loc5_:uint;
            while (_loc5_ < _loc3_)
            {
                _loc4_ = (this.var_2632[_loc5_] as InterfaceStruct);
                if (_loc4_.iis == _loc2_)
                {
                    return (_loc4_.unknown);
                };
                _loc5_++;
            };
            return (null);
        }

        public function getStructByInterface(param1:IID):InterfaceStruct
        {
            var _loc3_:InterfaceStruct;
            var _loc2_:String = getQualifiedClassName(param1);
            var _loc4_:uint = this.var_2632.length;
            var _loc5_:uint;
            while (_loc5_ < _loc4_)
            {
                _loc3_ = (this.var_2632[_loc5_] as InterfaceStruct);
                if (_loc3_.iis == _loc2_)
                {
                    return (_loc3_);
                };
                _loc5_++;
            };
            return (null);
        }

        public function getIndexByInterface(param1:IID):int
        {
            var _loc3_:InterfaceStruct;
            var _loc2_:String = getQualifiedClassName(param1);
            var _loc4_:uint = this.var_2632.length;
            var _loc5_:int;
            while (_loc5_ < _loc4_)
            {
                _loc3_ = (this.var_2632[_loc5_] as InterfaceStruct);
                if (_loc3_.iis == _loc2_)
                {
                    return (_loc5_);
                };
                _loc5_++;
            };
            return (-1);
        }

        public function mapStructsByInterface(param1:IID, param2:Array):uint
        {
            var _loc5_:InterfaceStruct;
            var _loc3_:String = getQualifiedClassName(param1);
            var _loc4_:uint;
            var _loc6_:uint = this.var_2632.length;
            var _loc7_:uint;
            while (_loc7_ < _loc6_)
            {
                _loc5_ = (this.var_2632[_loc7_] as InterfaceStruct);
                if (_loc5_.iis == _loc3_)
                {
                    param2.push(_loc5_);
                    _loc4_++;
                };
                _loc7_++;
            };
            return (_loc4_);
        }

        public function getStructByImplementor(param1:IUnknown):InterfaceStruct
        {
            var _loc2_:InterfaceStruct;
            var _loc3_:uint = this.var_2632.length;
            var _loc4_:uint;
            while (_loc4_ < _loc3_)
            {
                _loc2_ = (this.var_2632[_loc4_] as InterfaceStruct);
                if (_loc2_.unknown == param1)
                {
                    return (_loc2_);
                };
                _loc4_++;
            };
            return (null);
        }

        public function getIndexByImplementor(param1:IUnknown):int
        {
            var _loc2_:InterfaceStruct;
            var _loc3_:uint = this.var_2632.length;
            var _loc4_:uint;
            while (_loc4_ < _loc3_)
            {
                _loc2_ = (this.var_2632[_loc4_] as InterfaceStruct);
                if (_loc2_.unknown == param1)
                {
                    return (_loc4_);
                };
                _loc4_++;
            };
            return (-1);
        }

        public function mapStructsByImplementor(param1:IUnknown, param2:Array):uint
        {
            var _loc4_:InterfaceStruct;
            var _loc3_:uint;
            var _loc5_:uint = this.var_2632.length;
            var _loc6_:uint;
            while (_loc6_ < _loc5_)
            {
                _loc4_ = (this.var_2632[_loc6_] as InterfaceStruct);
                if (_loc4_.unknown == param1)
                {
                    param2.push(_loc4_);
                    _loc3_++;
                };
                _loc6_++;
            };
            return (_loc3_);
        }

        public function getStructByIndex(param1:uint):InterfaceStruct
        {
            return ((param1 < this.var_2632.length) ? this.var_2632[param1] : null);
        }

        public function getTotalReferenceCount():uint
        {
            var _loc2_:InterfaceStruct;
            var _loc1_:uint;
            var _loc3_:uint = this.var_2632.length;
            var _loc4_:uint;
            while (_loc4_ < _loc3_)
            {
                _loc2_ = (this.var_2632[_loc4_] as InterfaceStruct);
                _loc1_ = (_loc1_ + _loc2_.references);
                _loc4_++;
            };
            return (_loc1_);
        }


    }
}