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
    private var cache:Dictionary;
    private var name:String;

    public function BindParser(parser:IParser, cache:Dictionary, name:String)
    {
      this.parser = parser;
      this.cache = cache;
      this.name = name;
    }

    override public function parse(parserState:ParserState):Result
    {
      var result:Result = parser.parse(parserState);
      cache[name] = result.instance;
      return result;
    }
  }
}
