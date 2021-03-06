/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 11/12/2010
 * Time: 14:09
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  import flash.utils.Dictionary;

  public class BindParser extends AbstractParser
  {
    private var parser:IParser;
    private var key:Object;
    public var cache:Dictionary;

    public function BindParser(parser:IParser, key:Object)
    {
      this.parser = parser;
      this.key = key;
    }

    override public function parseState(parserState:IParserState):Result
    {
      var result:Result = parser.parseState(parserState);
      if (result.success)
      {
        cache[key] = result.instance;
      }
      return result;
    }
  }
}
