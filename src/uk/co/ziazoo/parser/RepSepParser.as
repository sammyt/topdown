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
    private var separator:IParser;
    private var parser:IParser;

    public function RepSepParser(parser:IParser, seperator:IParser)
    {
      this.parser = parser;
      this.separator = seperator;
    }

    override public function parseState(parserState:IParserState):Result
    {
      var composite:IParser = getComposite();
      return composite.parseState(parserState);
    }

    private function getComposite():IParser
    {
      return new SequenceParser([parser,
        new ZeroOrMoreParser(
          new SequenceParser([separator,
            parser]))]);
    }
  }
}
