/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 15:57
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public interface IParser
  {
    function get id():String;

    function set id(value:String):void;

    function get name():String;

    function set name(value:String):void;

    function parseState(state:IParserState):Result;

    function setParseAction(action:Object):IParser;

    function parse(input:String):Result;
  }
}
