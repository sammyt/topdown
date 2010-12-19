/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 10/12/2010
 * Time: 19:15
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class WhitespaceParser extends AbstractParser
  {
    private static const p:RegExParser = new RegExParser(/^\s+/);

    private var parser:IParser;

    public function WhitespaceParser(parser:IParser)
    {
      this.parser = parser;
    }

    override public function parseState(parserState:IParserState):Result
    {
      p.parseState(parserState);

      return parser.parseState(parserState);
    }
  }
}
