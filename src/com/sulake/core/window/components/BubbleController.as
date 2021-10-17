package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.Direction;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.utils.PropertyDefaults;

    public class BubbleController extends FrameController implements IBubbleWindow 
    {

        private static const var_2661:String = "_POINTER_UP";
        private static const var_2662:String = "_POINTER_DOWN";
        private static const var_2663:String = "_POINTER_LEFT";
        private static const var_2664:String = "_POINTER_RIGHT";

        private var _direction:String = "down";
        private var var_2665:int = 0;

        public function BubbleController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function=null, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        }

        public function get direction():String
        {
            return (this._direction);
        }

        public function set direction(param1:String):void
        {
            var _loc2_:IWindow;
            if (param1 != this._direction)
            {
                _loc2_ = getChildByName(param1);
                if (!_loc2_)
                {
                    throw (new Error((('Invalid pointer direction: "' + param1) + '"!')));
                };
                getChildByName(this._direction).visible = false;
                _loc2_.visible = true;
                this._direction = param1;
                this.pointerOffset = this.var_2665;
            };
        }

        public function get pointerOffset():int
        {
            return (this.var_2665);
        }

        public function set pointerOffset(param1:int):void
        {
            var _loc2_:IWindow = getChildByName(this._direction);
            if (!_loc2_)
            {
                throw (new Error((('Invalid pointer direction: "' + this._direction) + '"!')));
            };
            if (((this._direction == Direction.UP) || (this._direction == Direction.DOWN)))
            {
                _loc2_.x = ((width / 2) + param1);
            }
            else
            {
                _loc2_.y = ((height / 2) + param1);
            };
            this.var_2665 = param1;
        }

        override public function update(param1:WindowController, param2:WindowEvent):Boolean
        {
            var _loc3_:Boolean = super.update(param1, param2);
            if (this.var_2665 != 0)
            {
                if (param1 == this)
                {
                    if (param2.type == WindowEvent.var_589)
                    {
                        this.pointerOffset = this.var_2665;
                    };
                };
            };
            return (_loc3_);
        }

        override public function get properties():Array
        {
            var _loc1_:Array = super.properties;
            if (this._direction != Direction.DOWN)
            {
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_2008, this._direction, PropertyStruct.var_636, true));
            }
            else
            {
                _loc1_.push(PropertyDefaults.var_2041);
            };
            if (this.var_2665 != 0)
            {
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_2020, this.var_2665, PropertyStruct.var_630, true));
            }
            else
            {
                _loc1_.push(PropertyDefaults.var_2046);
            };
            return (_loc1_);
        }

        override public function set properties(param1:Array):void
        {
            var _loc2_:PropertyStruct;
            for each (_loc2_ in param1)
            {
                switch (_loc2_.key)
                {
                    case PropertyDefaults.var_2008:
                        this.direction = (_loc2_.value as String);
                        break;
                    case PropertyDefaults.var_2020:
                        this.pointerOffset = (_loc2_.value as int);
                        break;
                };
            };
            super.properties = param1;
        }


    }
}