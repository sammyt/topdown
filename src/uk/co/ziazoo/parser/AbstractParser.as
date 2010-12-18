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
    private var _extractor:Extractor;
    private var _value:Object;
    private var _callback:Function;

    public function AbstractParser()
    {
    }

    public function parse(parserState:ParserState):Result
    {
      return null;
    }

    protected function apply(args:Object):Object
    {
      if (_value != null)
      {
        return _value;
      }
      else if (_callback != null)
      {
        return _callback(args)
      }
      else if (_extractor != null)
      {
        return _extractor.extract(args);
      }
      return args;
    }

    public function extractor(extractor:Object):IParser
    {
      if (extractor is Extractor)
      {
        _extractor = extractor as Extractor;
      }
      else if (extractor is Function)
      {
        _callback = extractor as Function;
      }
      else
      {
        _value = extractor;
      }
      return this;
    }

    public function get id():String
    {
      return null;
    }
  }
}
