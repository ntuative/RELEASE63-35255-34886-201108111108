package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.graphics.GraphicContext;
    import com.sulake.core.window.graphics.IGraphicContext;
    import com.sulake.core.window.graphics.IGraphicContextHost;
    import flash.display.DisplayObject;

    public class DisplayObjectWrapperController extends WindowController implements IDisplayObjectWrapper 
    {

        public function DisplayObjectWrapperController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            param4 = (param4 & (~(WindowParam.var_713)));
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
            var_2666 = false;
        }

        override public function getGraphicContext(param1:Boolean):IGraphicContext
        {
            if (((param1) && (!(var_1252))))
            {
                var_1252 = new GraphicContext((("GC {" + _name) + "}"), GraphicContext.GC_TYPE_CONTAINER, var_1202);
            };
            return (var_1252);
        }

        public function getDisplayObject():DisplayObject
        {
            return (IGraphicContextHost(this).getGraphicContext(true).getDisplayObject());
        }

        public function setDisplayObject(param1:DisplayObject):void
        {
            IGraphicContextHost(this).getGraphicContext(true).setDisplayObject(param1);
        }


    }
}