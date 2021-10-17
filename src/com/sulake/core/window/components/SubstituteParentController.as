package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.enum.WindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.WindowContext;
    import com.sulake.core.window.graphics.IGraphicContext;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class SubstituteParentController extends WindowController 
    {

        public function SubstituteParentController(param1:WindowContext)
        {
            super("_CONTEXT_SUBSTITUTE_PARENT", 0, 0, WindowParam.var_713, param1, new Rectangle(0, 0, 2000, 2000), null, null, null, null, 0);
            var_2666 = false;
        }

        override public function getGraphicContext(param1:Boolean):IGraphicContext
        {
            return (null);
        }

        override public function setupGraphicsContext():IGraphicContext
        {
            return (null);
        }

        private function childParamUpdated(param1:WindowEvent):void
        {
            var _loc2_:IWindow = param1.window;
            if (getChildIndex(_loc2_) != -1)
            {
                if (!_loc2_.testParamFlag(WindowParam.var_713))
                {
                    _loc2_.desktop.addChild(_loc2_);
                };
            };
        }

        override public function addChild(param1:IWindow):IWindow
        {
            _children.push(param1);
            return (param1);
        }

        override public function addChildAt(param1:IWindow, param2:int):IWindow
        {
            var _loc3_:WindowController = WindowController(param1);
            if (_loc3_.parent != null)
            {
                WindowController(_loc3_.parent).removeChild(_loc3_);
            };
            _children.splice(param2, 0, param1);
            _loc3_.parent = this;
            return (param1);
        }

        override public function removeChild(param1:IWindow):IWindow
        {
            var _loc2_:int = _children.indexOf(param1);
            if (_loc2_ > -1)
            {
                _children.splice(_loc2_, 1);
                param1.parent = null;
                return (param1);
            };
            return (null);
        }

        override public function setChildIndex(param1:IWindow, param2:int):void
        {
            var _loc3_:int = _children.indexOf(param1);
            if (((_loc3_ > -1) && (!(param2 == _loc3_))))
            {
                _children.splice(_loc3_, 1);
                _children.splice(param2, 0, param1);
            };
        }

        override public function swapChildren(param1:IWindow, param2:IWindow):void
        {
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:IWindow;
            var _loc6_:int;
            if ((((!(param1 == null)) && (!(param2 == null))) && (!(param1 == param2))))
            {
                _loc3_ = _children.indexOf(param1);
                if (_loc3_ < 0)
                {
                    return;
                };
                _loc4_ = _children.indexOf(param2);
                if (_loc4_ < 0)
                {
                    return;
                };
                if (_loc4_ < _loc3_)
                {
                    _loc5_ = param1;
                    param1 = param2;
                    param2 = _loc5_;
                    _loc6_ = _loc3_;
                    _loc3_ = _loc4_;
                    _loc4_ = _loc6_;
                };
                _children.splice(_loc4_, 1);
                _children.splice(_loc3_, 1);
                _children.splice(_loc3_, 0, param2);
                _children.splice(_loc4_, 0, param1);
            };
        }

        override public function swapChildrenAt(param1:int, param2:int):void
        {
            this.swapChildren(_children[param1], _children[param2]);
        }


    }
}