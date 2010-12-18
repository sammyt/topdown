/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 08/12/2010
 * Time: 22:20
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class RepSepParser extends AbstractParser
  {
    private var seperator:IParser;
    private var parser:IParser;

    public function RepSepParser(parser:IParser, seperator:IParser)
    {
      this.parser = parser;
      this.seperator = seperator;
    }

    override public function parse(parserState:IParserState):Result
    {
      return new SequenceParser([parser,
        new ZeroOrMoreParser(
          new SequenceParser([seperator,
            parser]))]).parse(parserState);
    }
  }
}
