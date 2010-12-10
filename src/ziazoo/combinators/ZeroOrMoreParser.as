/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 16:13
 * To change this template use File | Settings | File Templates.
 */
package ziazoo.combinators
{
  public class ZeroOrMoreParser extends AbstractParser
  {
    private var parser:IParser;

    public function ZeroOrMoreParser(parser:IParser)
    {
      this.parser = parser;
    }

    override public function parse(parserState:ParserState):IResult
    {
      var startIndex:int = parserState.index;
      var all:Array = [];
      var result:IResult = parser.parse(parserState);

      while (result is Success)
      {
        all.push(result);
        result = parser.parse(parserState);
      }

      // TODO: Failure is lost

      return new Success(all, parserState.subStrFrom(startIndex, parserState.index));
    }
  }
}
