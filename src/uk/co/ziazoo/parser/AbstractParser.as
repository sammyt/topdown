/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 10/12/2010
 * Time: 19:28
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class AbstractParser implements IParser
  {
    private var _parseAction:IParseAction;
    private var _value:Object;
    private var _id:String;
    private var _name:String;

    public function AbstractParser()
    {
    }

    public function parseState(state:IParserState):Result
    {
      return null;
    }

    protected function action():Object
    {
      if (_value != null)
      {
        return _value;
      }
      return parseAction.extract();
    }

    public function setParseAction(action:Object):IParser
    {
      if (action is IParseAction)
      {
        _parseAction = action as IParseAction;
      }
      else
      {
        _value = action;
      }
      return this;
    }

    public function get id():String
    {
      return _id;
    }

    public function set id(value:String):void
    {
      _id = value;
    }

    public function parse(input:String):Result
    {
      return parseState(new ParserState(input));
    }

    protected function get parseAction():IParseAction
    {
      return _parseAction;
    }

    protected function get hasParseAction():Boolean
    {
      return _parseAction != null;
    }

    public function get name():String
    {
      return _name;
    }

    public function set name(value:String):void
    {
      _name = value;
    }
  }
}
