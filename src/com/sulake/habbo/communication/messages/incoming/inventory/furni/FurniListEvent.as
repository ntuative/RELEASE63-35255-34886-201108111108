﻿package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListParser;

    public class FurniListEvent extends MessageEvent implements IMessageEvent 
    {

        public function FurniListEvent(param1:Function)
        {
            super(param1, FurniListParser);
        }

        public function getParser():FurniListParser
        {
            return (this.var_334 as FurniListParser);
        }


    }
}