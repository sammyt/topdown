/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 10/12/2010
 * Time: 19:15
 * To change this template use File | Settings | File Templates.
 */
package ziazoo.combinators
{
  public class WhitespaceParser extends AbstractParser
  {
    private static const p:RegExParser = new RegExParser(/^\s+/);

    private var parser:IParser;

    public function WhitespaceParser(parser:IParser)
    {
      this.parser = parser;
    }

    override public function parse(parserState:ParserState):IResult
    {
      p.parse(parserState);
      
      return parser.parse(parserState);
    }
  }
}
