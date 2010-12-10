/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 16:20
 * To change this template use File | Settings | File Templates.
 */
package ziazoo.combinators
{
  public class EitherParser extends AbstractParser
  {
    private var second:IParser;
    private var first:IParser;

    public function EitherParser(first:IParser, second:IParser)
    {
      this.first = first;
      this.second = second;
    }

    override public function parse(parserState:ParserState):IResult
    {
      var result:IResult = first.parse(parserState);
      if(result is Success)
      {
        return result;
      }
      else
      {
        return second.parse(parserState);
      }
    }
  }
}
