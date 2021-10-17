package com.sulake.habbo.communication.messages.outgoing.facebook
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class FaceBookIsLoggedOffMessageComposer implements IMessageComposer 
    {


        public function getMessageArray():Array
        {
            return ([]);
        }

        public function dispose():void
        {
        }


    }
}