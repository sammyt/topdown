/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 16:27
 * To change this template use File | Settings | File Templates.
 */
package ziazoo.combinators
{
  public class OneOrMoreParser extends AbstractParser
  {
    private var parser:IParser;

    public function OneOrMoreParser(parser:IParser)
    {
      this.parser = parser;
    }

    override public function parse(parserState:ParserState):IResult
    {

      var startIndex:int = parserState.index;
      var all:Array = [];

      var result:IResult = parser.parse(parserState);

      if(result is Failure)
      {
        return result;
      }

      while(result is Success)
      {
        all.push(result);
        result = parser.parse(parserState);
      }

      return new Success(all, parserState.subStrFrom(startIndex, parserState.index));
    }
  }
}
