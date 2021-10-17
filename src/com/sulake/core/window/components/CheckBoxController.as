package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.events.WindowEvent;

    public class CheckBoxController extends SelectableController implements ICheckBoxWindow 
    {

        public function CheckBoxController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function=null, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        }

        override public function update(param1:WindowController, param2:WindowEvent):Boolean
        {
            if (param1 == this)
            {
                switch (param2.type)
                {
                    case WindowMouseEvent.var_655:
                        if (isSelected)
                        {
                            unselect();
                        }
                        else
                        {
                            select();
                        };
                        break;
                };
            };
            return (super.update(param1, param2));
        }


    }
}