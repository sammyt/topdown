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

    public function AbstractParser()
    {
    }

    public function parse(parserState:ParserState):Result
    {
      return null;
    }

    protected function apply(args:Object):Object
    {
      if (_extractor)
      {
        return _extractor.extract(args);
      }
      return args;
    }

    public function set extractor(extractor:Extractor):void
    {
      _extractor = extractor;
    }
  }
}
