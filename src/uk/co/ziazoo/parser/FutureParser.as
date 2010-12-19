/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 16:30
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class FutureParser extends AbstractParser
  {
    public var parser:IParser;

    public function FutureParser()
    {
    }

    override public function parseState(parserState:IParserState):Result
    {
      return parser.parseState(parserState);
    }
  }
}
