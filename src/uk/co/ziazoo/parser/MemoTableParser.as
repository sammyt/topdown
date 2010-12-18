/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 18/12/2010
 * Time: 15:36
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class MemoTableParser implements IParser
  {
    private var parser:IParser;

    public function MemoTableParser(parser:IParser)
    {
      this.parser = parser;
    }

    public function parse(parseState:ParserState):Result
    {
      return parser.parse(parseState);
    }

    public function extractor(extractor:Object):IParser
    {
      return parser.extractor(extractor);
    }

    public function get id():String
    {
      return parser.id;
    }
  }
}
