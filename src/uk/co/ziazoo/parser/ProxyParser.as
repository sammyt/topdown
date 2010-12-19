/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 19/12/2010
 * Time: 15:31
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class ProxyParser implements IParser
  {
    public var target:IParser;

    public function ProxyParser(target:IParser)
    {
      this.target = target;
    }

    public function get id():String
    {
      return target.id;
    }

    public function set id(value:String):void
    {
      target.id = value;
    }

    public function parseState(state:IParserState):Result
    {
      return target.parseState(state);
    }

    public function setParseAction(action:Object):IParser
    {
      return target.setParseAction(action);
    }

    public function parse(input:String):Result
    {
      return target.parse(input);
    }
  }
}
